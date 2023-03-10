import 'package:PraticFitBackend/src/features/user/datasources/userDatasourceimpl.dart';
import 'package:PraticFitBackend/src/features/user/repositories/userRepository.dart';
import 'package:PraticFitBackend/src/features/user/resources/userResource.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<UserDatasource>((i) => UserDatasourceImpl(i())),
        Bind.singleton((i) => UserRepository(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.resource(UserResource()),
      ];
}
