import 'dart:convert';
import 'package:PraticFitBackend/src/core/services/jwt/jwtService.dart';
import 'package:PraticFitBackend/src/core/services/requestExtractor/requestExtractor.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

// Classe responsável por verificar se o token de autenticação fornecido na requisição é válido e se o usuário que está tentando acessar o recurso tem as permissões necessárias.
class AuthGuard extends ModularMiddleware {
  final List<String> roles;
  final bool isRefreshToken;

  AuthGuard({this.roles = const [], this.isRefreshToken = false});

  @override
  Handler call(Handler handler, [ModularRoute? route]) {
    final extrator = Modular.get<RequestExtractor>();
    final jwt = Modular.get<JwtService>();

    return (request) {
      if (!request.headers.containsKey('authorization')) {
        return Response.forbidden(
            jsonEncode({'error': 'not authorization header'}));
      }

      final token = extrator.getAuthorizationBearer(request);
      try {
        jwt.verifyToken(token, isRefreshToken ? 'refreshToken' : 'accessToken');
        final payload = jwt.getPayload(token);
        final role = payload['role'] ?? 'user';

        if (roles.isEmpty || roles.contains(role)) {
          return handler(request);
        }

        return Response.forbidden(
            jsonEncode({'error': 'role ($role) not allowed'}));
      } catch (e) {
        return Response.forbidden(jsonEncode({'error': e.toString()}));
      }
    };
  }
}
