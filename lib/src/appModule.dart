import 'package:PraticFitBackend/src/modules/user/userResouce.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class AppModule extends Module {
  List<ModularRoute> get routes => [
        Route.get('/', (Request request) => Response.ok('Hello World')),
        Route.resource(UserResource())
      ];
}
