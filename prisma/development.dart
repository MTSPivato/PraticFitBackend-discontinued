import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:orm/configure.dart';

// Função responsável por configurar o ORM
void configurator(PrismaDevelopment development) {
  development.override(
      'DATABASE_URL', '${DotEnvService()['DATABASE_URL']}');
}

// Função responsável por iniciar o servidor de desenvolvimento
void main() => PrismaDevelopment.server(configurator);
