import 'package:PraticFitBackend/src/core/services/database/remoteDatabase.dart';
import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:PraticFitBackend/src/features/user/userResouce.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import '../core/services/bcrypt/bcryptService.dart';
import '../core/services/bcrypt/bcryptServiceImpl.dart';
import '../core/services/database/postgres/postgresDatabase.dart';
import 'swagger/swaggerHandler.dart';

// Classe responsável por gerenciar os módulos do projeto
class AppModule extends Module {
  // Classe responsável por gerenciar as dependências do projeto
  @override
  List<Bind> get binds => [
        Bind.singleton<DotEnvService>((i) => DotEnvService()),
        Bind.singleton<RemoteDatabase>((i) => PostgresDatabase(i())),
        Bind.singleton<BCryptService>((i) => BCryptServiceImpl()),
      ];

  // Classe responsável por gerenciar as rotas do projeto
  @override
  List<ModularRoute> get routes => [
        Route.get('/', (Request request) => Response.ok('Home')),
        Route.get('/documentation/**', swaggerHandler),
        Route.resource(UserResource())
      ];
}
