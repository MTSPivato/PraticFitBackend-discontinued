import 'package:PraticFitBackend/src/features/auth/errors/errors.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'src/appModule.dart';

Future<Handler> startShelfModular() async {
  final handler = Modular(module: AppModule(), middlewares: [
    logRequests(),
    jsonResponse(),
  ]);
  return handler;
}

Middleware jsonResponse() {
  return (handler) {
    return (request) async {
      try {
        var response = await handler(request);

        response = response.change(headers: {
          'content-type': 'application/json',
          ...response.headers,
        });

        return response;
      } catch (e) {
        if (e is AuthException) {
          return Response(e.statusCode, body: e.toJson());
        } else {
          // Tratar outras exceções aqui, se necessário
          rethrow;
        }
      }
    };
  };
}
