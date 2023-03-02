import 'dart:async';
import 'dart:convert';

import 'package:PraticFitBackend/src/core/services/requestExtractor/requestExtractor.dart';
import 'package:PraticFitBackend/src/features/auth/errors/errors.dart';
import 'package:PraticFitBackend/src/features/auth/repositories/authRepository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import '../guard/authGuard.dart';

// Classe responsável por gerenciar as rotas de autenticação
class AuthResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/login', _login),
        Route.get('/refresh_token', _refreshToken, middlewares: [
          AuthGuard(isRefreshToken: true),
        ]),
        Route.get('/check_token', _checkToken, middlewares: [AuthGuard()]),
        Route.put('/update_password', _updatePassword,
            middlewares: [AuthGuard()]),
      ];

  // Método responsável por efetuar o login
  FutureOr<Response> _login(Request request, Injector injector) async {
    final authRepository = injector.get<AuthRepository>();
    final extractor = injector.get<RequestExtractor>();
    final credential = extractor.getAuthorizationBasic(request);

    try {
      final tokenization = await authRepository.login(credential);
      return Response.ok(tokenization.toJson());
    } on AuthException catch (e) {
      return Response(e.statusCode, body: e.toJson());
    }
  }

  // Método responsável por atualizar o token
  FutureOr<Response> _refreshToken(Injector injector, Request request) async {
    final extractor = injector.get<RequestExtractor>();
    final authRepository = injector.get<AuthRepository>();
    final token = extractor.getAuthorizationBearer(request);

    final tokenization = await authRepository.refreshToken(token);
    return Response.ok(tokenization.toJson());
  }

  FutureOr<Response> _checkToken() {
    return Response.ok(jsonEncode({'message': 'ok'}));
  }

  // Método responsável por atualizar a senha
  FutureOr<Response> _updatePassword(
    Injector injector,
    Request request,
    ModularArguments arguments,
  ) async {
    final extractor = injector.get<RequestExtractor>();
    final authRepository = injector.get<AuthRepository>();
    final data = arguments.data as Map;

    final token = extractor.getAuthorizationBearer(request);

    try {
      await authRepository.updatePassword(
        token,
        data['password'],
        data['newPassword'],
      );
      return Response.ok(jsonEncode({'message': 'ok'}));
    } on AuthException catch (e) {
      return Response(e.statusCode, body: e.toJson());
    }
  }
}
