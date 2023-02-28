import 'package:shelf_modular/shelf_modular.dart';
import 'services/bcrypt/bcryptService.dart';
import 'services/bcrypt/bcryptServiceImpl.dart';
import 'services/database/postgres/postgres_database.dart';
import 'services/database/remoteDatabase.dart';
import 'services/dotEnv/dotEnvService.dart';
import 'services/jwt/dartJsonwebtoken/jwtServiceImpl.dart';
import 'services/jwt/jwtService.dart';
import 'services/requestExtractor/requestExtractor.dart';

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
