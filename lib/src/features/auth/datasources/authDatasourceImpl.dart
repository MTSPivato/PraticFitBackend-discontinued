import 'package:PraticFitBackend/src/core/services/database/remoteDatabase.dart';
import 'package:PraticFitBackend/src/features/auth/repositories/authRepository.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final RemoteDatabase database;

  AuthDatasourceImpl(this.database);

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

  @override
  Future<String> getRoleById(id) async {
    final result = await database.query(
      'SELECT role FROM "User" WHERE id = @id;',
      variables: {
        'id': id,
      },
    );

    return result.map((element) => element['User']).first!['role'];
  }

  @override
  Future<String> getPasswordById(id) async {
    final result = await database.query(
      'SELECT password FROM "User" WHERE id = @id;',
      variables: {
        'id': id,
      },
    );
    return result.map((element) => element['User']).first!['password'];
  }

  @override
  Future<void> updatePasswordById(id, String password) async {
    final queryUpdate = 'UPDATE "User" SET password=@password WHERE id=@id;';

    await database.query(queryUpdate, variables: {
      'id': id,
      'password': password,
    });
  }
}
