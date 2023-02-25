import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:orm/configure.dart';

void configurePrisma(PrismaEnvironment environment) {
  environment['DATABASE_URL'] = '${DotEnvService.instance['DATABASE_URL']}';
}
