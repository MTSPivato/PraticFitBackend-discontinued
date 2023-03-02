import 'dart:async';
import 'package:shelf/shelf.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

// Método responsável por gerenciar as rotas do Swagger
FutureOr<Response> swaggerHandler(Request request) {
  final path = 'specs/swagger.yaml';
  final handler = SwaggerUI(
    path,
    title: 'Pratic Fit',
    deepLink: true,
  );
  return handler(request);
}
