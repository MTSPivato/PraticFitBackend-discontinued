import 'package:PraticFitBackend/src/core/services/database/remoteDatabase.dart';
import 'package:PraticFitBackend/src/features/user/repositories/userRepository.dart';

class UserDatasourceImpl implements UserDatasource {
  final RemoteDatabase database;

  UserDatasourceImpl(this.database);

  @override
  Future<Map> getAllUser() async {
    final result =
        await database.query('SELECT id, name, email, role FROM "User";');
    final listUsers = result.map((e) => e['User']).toList();
    return {'users': listUsers};
  }

  @override
  Future<Map> getUserById(id) async {
    final result = await database.query(
        'SELECT id, name, email, role FROM "User" WHERE id = @id;',
        variables: {'id': id});
    final userMap = result.map((element) => element['User']).first;
    return result.map((element) => element['User']).first!;
  }

  @override
  Future<Map> crateUser(Map user) async {
    final userParams = (user as Map).cast<String, dynamic>();
    final result = await database.query(
      'INSERT INTO "User" (name, email, password) VALUES ( @name, @email, @password ) RETURNING id, email, role, name;',
      variables: userParams,
    );
    return result.map((element) => element['User']).first!;
  }

  @override
  Future<Map> updateUserById(id, Map user) async {
    final userParams = (user as Map).cast<String, dynamic>();
    final columns = user.keys
        .where((key) => key != 'id' || key != 'password')
        .map(
          (key) => '$key=@$key',
        )
        .toList();
    final query =
        'UPDATE "User" SET ${columns.join(',')} WHERE id=@id RETURNING id, email, role, name;';

    final result = await database.query(
      query,
      variables: userParams,
    );
    return result.map((element) => element['User']).first!;
  }

  @override
  Future<Map> deleteUserById(id, String password) async {
    final result = await database
        .query('DELETE FROM "User" WHERE id = @id;', variables: {'id': id});

    if (result.isEmpty) {
      return {};
    }

    return result.map((element) => element['User']).first!;
  }
}
