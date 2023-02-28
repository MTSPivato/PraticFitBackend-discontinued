import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:orm/configure.dart';

// Função responsável por configurar o ORM
void configurePrisma(PrismaEnvironment environment) {
  environment['DATABASE_URL'] = '${DotEnvService()['DATABASE_URL']}';
}
