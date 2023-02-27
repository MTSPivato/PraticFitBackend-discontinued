import 'package:PraticFitBackend/src/core/services/database/remoteDatabase.dart';
import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:PraticFitBackend/src/modules/user/userResouce.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'core/services/database/postgres/postgresDatabase.dart';
import 'modules/user/swagger/swaggerHandler.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance<DotEnvService>(DotEnvService.instance),
        Bind.singleton<RemoteDatabase>((i) => PostgresDatabase(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/', (Request request) => Response.ok('Home')),
        Route.get('/documentation/**', swaggerHandler),
        Route.resource(UserResource())
      ];
}
