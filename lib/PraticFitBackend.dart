import 'package:PraticFitBackend/src/features/appModule.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

// Função responsável por iniciar o servidor
Future<Handler> startShelfModular() async {
  final handler = Modular(
    module: AppModule(),
    middlewares: [
      logRequests(),
      jsonResponse(),
    ],
  );
  return handler;
}

// Função responsável por garantir que todas as respostas sejam em JSON
Middleware jsonResponse() {
  return (handler) {
    return (request) async {
      var response = await handler(request);
      response = response.change(headers: {
        'content-type': 'application/json',
        ...response.headers,
      });
      return response;
    };
  };
}
