import 'dart:async';
import 'package:shelf/shelf.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

// Função responsável por gerenciar a documentação da API
FutureOr<Response> swaggerHandler(Request request) {
  final path = 'specs/swagger.yaml';
  final handler = SwaggerUI(
    path,
    title: 'Pratic Fit Backend',
    deepLink: true,
  );
  return handler(request);
}
