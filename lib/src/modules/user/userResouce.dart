import 'dart:async';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import '../../core/services/database/remoteDatabase.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/user', _getAllUser),
        Route.get('/user/:id', _getUserById),
        Route.post('/user', _createUser),
        Route.put('/user/:id', _updateUser),
        Route.delete('/user/:id', _deleteUser),
      ];

  FutureOr<Response> _getAllUser(Injector injector) async {
    final database = injector.get<RemoteDatabase>();
    final result = await database
        .query('SELECT id, nome, email, role FROM public."User";');
    final listUser = result.map((e) => e['User']).toList();
    return Response.ok(jsonEncode(listUser));
  }

  FutureOr<Response> _getUserById(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
        'SELECT id, nome, email, role FROM public."User" WHERE id = @id;',
        variables: {'id': id});
    final userMap = result.map((element) => element['User']).first;
    return Response.ok(jsonEncode(userMap));
  }

  FutureOr<Response> _createUser(
      ModularArguments arguments, Injector injector) async {
    final userParams = (arguments.data as Map).cast<String, dynamic>();
    userParams.remove('id');
    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
        'INSERT INTO "User" (nome, email, senha) VALUES (@nome, @email, @senha) RETURNING id, email, nome;',
        variables: userParams);
    final userMap = result.map((e) => e['User']).first;
    return Response.ok(jsonEncode(userMap));
  }

  FutureOr<Response> _updateUser(
      ModularArguments arguments, Injector injector) async {
    final userParams = (arguments.data as Map).cast<String, dynamic>();

    final columns = userParams.keys
        .where((element) => element != 'id' || element != 'senha')
        .map(
          (key) => '$key=@$key',
        )
        .toList();
    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
        'UPDATE "User" SET ${columns.join(',')} WHERE id = @id RETURNING id, email, nome;',
        variables: userParams);
    final userMap = result.map((e) => e['User']).first;
    return Response.ok(jsonEncode(userMap));
  }

  FutureOr<Response> _deleteUser(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final database = injector.get<RemoteDatabase>();
    await database
        .query('DELETE FROM "User" WHERE id = @id;', variables: {'id': id});
    return Response.ok('Deleted user: $id');
  }
}
