import 'dart:async';
import 'dart:convert';
import 'package:PraticFitBackend/src/core/services/bcrypt/bcryptService.dart';
import 'package:PraticFitBackend/src/core/services/database/remoteDatabase.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import '../../auth/guard/authGuard.dart';

// Classe responsável por gerenciar as rotas de usuário
class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/user', _getAllUser, middlewares: [AuthGuard()]),
        Route.get('/user/:id', _getUserByid, middlewares: [AuthGuard()]),
        Route.post('/user', _createUser),
        Route.put('/user', _updateUser, middlewares: [AuthGuard()]),
        Route.delete('/user/:id', _deleteUser, middlewares: [AuthGuard()]),
      ];

  // Método responsável por retornar todos os usuários
  FutureOr<Response> _getAllUser(Injector injector) async {
    final database = injector.get<RemoteDatabase>();
    final result =
        await database.query('SELECT id, name, email, role FROM "User";');

    final listUsers = result.map((e) => e['User']).toList();

    return Response.ok(jsonEncode(listUsers));
  }

  // Método responsável por retornar um usuário pelo id
  FutureOr<Response> _getUserByid(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
        'SELECT id, name, email, role FROM "User" WHERE id = @id;',
        variables: {'id': id});
    final userMap = result.map((element) => element['User']).first;
    return Response.ok(jsonEncode(userMap));
  }

  // Método responsável por deletar um usuário pelo id
  FutureOr<Response> _deleteUser(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];

    final database = injector.get<RemoteDatabase>();
    await database
        .query('DELETE FROM "User" WHERE id = @id;', variables: {'id': id});
    return Response.ok(jsonEncode({'message': 'deleted $id'}));
  }

  // Método responsável por criar um usuário
  FutureOr<Response> _createUser(
      ModularArguments arguments, Injector injector) async {
    final bcrypt = injector.get<BCryptService>();

    final userParams = (arguments.data as Map).cast<String, dynamic>();
    userParams['password'] = bcrypt.generateHash(userParams['password']);

    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
      'INSERT INTO "User" (name, email, password) VALUES ( @name, @email, @password ) RETURNING id, email, role, name;',
      variables: userParams,
    );
    final userMap = result.map((element) => element['User']).first;
    return Response.ok(jsonEncode(userMap));
  }

  // Método responsável por atualizar um usuário
  FutureOr<Response> _updateUser(
      ModularArguments arguments, Injector injector) async {
    final userParams = (arguments.data as Map).cast<String, dynamic>();

    final columns = userParams.keys
        .where((key) => key != 'id' || key != 'password')
        .map(
          (key) => '$key=@$key',
        )
        .toList();

    final query =
        'UPDATE "User" SET ${columns.join(',')} WHERE id=@id RETURNING id, email, role, name;';

    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
      query,
      variables: userParams,
    );
    final userMap = result.map((element) => element['User']).first;
    return Response.ok(jsonEncode(userMap));
  }
}
