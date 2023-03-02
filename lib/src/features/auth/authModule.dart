import 'package:PraticFitBackend/src/features/auth/datasources/authDatasourceImpl.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'repositories/authRepository.dart';
import 'resources/authResource.dart';

// Classe responsável por gerenciar as rotas de autenticação
class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<AuthDatasource>((i) => AuthDatasourceImpl(i())),
        Bind.singleton((i) => AuthRepository(i(), i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.resource(AuthResource()),
      ];
}
