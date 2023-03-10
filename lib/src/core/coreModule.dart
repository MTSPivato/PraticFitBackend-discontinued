import 'package:PraticFitBackend/src/core/services/bcrypt/bcryptService.dart';
import 'package:PraticFitBackend/src/core/services/bcrypt/bcryptServiceImpl.dart';
import 'package:PraticFitBackend/src/core/services/database/postgres/postgres_database.dart';
import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:PraticFitBackend/src/core/services/jwt/dartJsonwebtoken/jwtServiceImpl.dart';
import 'package:PraticFitBackend/src/core/services/jwt/jwtService.dart';
import 'package:PraticFitBackend/src/core/services/requestExtractor/requestExtractor.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'services/database/remoteDatabase.dart';

// Classe responsável por gerenciar os módulos do projeto
class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<DotEnvService>((i) => DotEnvService(), export: true),
        Bind.singleton<RemoteDatabase>((i) => PostgresDatabase(i()),
            export: true),
        Bind.singleton<JwtService>((i) => JwtServiceImpl(i()), export: true),
        Bind.singleton<BCryptService>((i) => BCryptServiceImpl(), export: true),
        Bind.singleton((i) => RequestExtractor(), export: true),
      ];
}
