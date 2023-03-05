import 'package:PraticFitBackend/src/core/services/database/remoteDatabase.dart';
import 'package:PraticFitBackend/src/features/auth/repositories/authRepository.dart';
import 'package:PraticFitBackend/src/features/user/repositories/userRepository.dart';

class UserDatasourceImpl implements UserDatasource{
  final RemoteDatabase database;

  UserDatasourceImpl(this.database);

  @override
  Future<Map> getIdAndRoleByEmail(String email) async {
    final result = await database.query(
      'SELECT id, role, password FROM "User" WHERE email = @email;',
      variables: {
        'email': email,
      },
    );

    if (result.isEmpty) {
      return {};
    }

    return result.map((element) => element['User']).first!;
  }
}