import 'package:PraticFitBackend/src/features/user/errors/errors.dart';

abstract class UserDatasource {
  Future<Map> getAllUser();
  Future<Map> getUserById(id);
  Future<Map> crateUser(Map user);
  Future<Map> updateUserById(id, Map user);
  Future<Map> deleteUserById(id, String password);
}

class UserRepository {
  final UserDatasource datasource;

  UserRepository(this.datasource);

  Future<Map> getAllUser() async {
    final result = await datasource.getAllUser();
    if (result.isEmpty) {
      throw UserException(403, 'Nenhum usuário encontrado');
    } else {
      return result;
    }
  }

  Future<Map> getUserById(id) async {
    final result = await datasource.getUserById(id);
    if (result.isEmpty) {
      throw UserException(403, 'Usuário não encontrado');
    } else {
      return result;
    }
  }

  Future<Map> createUser(Map user) async {
    final result = await datasource.crateUser(user);
    if (result.isEmpty) {
      throw UserException(403, 'Erro ao criar usuário');
    } else {
      return result;
    }
  }

  Future<Map> updateUserById(id, Map user) async {
    final result = await datasource.updateUserById(id, user);
    if (result.isEmpty) {
      throw UserException(403, 'Erro ao atualizar usuário');
    } else {
      return result;
    }
  }

  Future<Map> deleteUserById(id, String password) async {
    final result = await datasource.deleteUserById(id, password);
    if (result.isEmpty) {
      throw UserException(403, 'Erro ao deletar usuário');
    } else {
      return result;
    }
  }
}
