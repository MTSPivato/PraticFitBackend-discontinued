import 'package:PraticFitBackend/src/appModule.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Handler> startShelfModular() async {
  final handler = Modular(
    module: AppModule(),
    middlewares: [
      logRequests(),
    ],
  );
  return handler;
}
