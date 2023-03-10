import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'core/coreModule.dart';
import 'features/auth/authModule.dart';
import 'features/swagger/swaggerHandler.dart';
import 'features/user/userResource.dart';

// Classe responsável por gerenciar as rotas da aplicação
class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/', (Request request) => Response.ok('Inicial')),
        Route.get('/documentation/**', swaggerHandler),
        Route.resource(UserResource()),
        Route.module('/auth', module: AuthModule()),
      ];
}
