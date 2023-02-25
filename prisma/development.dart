import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:orm/configure.dart';

void configurator(PrismaDevelopment development) {
  development.override(
      'DATABASE_URL', '${DotEnvService.instance['DATABASE_URL']}');
}

void main() => PrismaDevelopment.server(configurator);
