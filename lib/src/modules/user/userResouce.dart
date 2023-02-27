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
        Route.post('/userUpdate/:id', _userUpdate),
        Route.delete('/user/:id', _deleteUser),
      ];

  FutureOr<Response> _getAllUser(Injector injector) async {
    final database = injector.get<RemoteDatabase>();
    final result = await database
        .query('SELECT id, name, email, role FROM public."User";');
    final listUser = result.map((e) => e['User']).toList();
    return Response.ok(jsonEncode(listUser));
  }

  FutureOr<Response> _getUserById(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
        'SELECT id, name, email, role FROM public."User" WHERE id = @id;',
        variables: {'id': id});
    final userMap = result.map((element) => element['User']).first;
    return Response.ok(jsonEncode(userMap));
  }

  FutureOr<Response> _createUser(
      ModularArguments arguments, Injector injector) async {
    final userMap = arguments.data as Map;

    userMap.remove('id');

    final database = injector.get<RemoteDatabase>();
    final user = arguments.data;
    final result = await database.query(
        'INSERT INTO public."User" (name, email, password, role) VALUES (@name, @email, @password, @role) RETURNING id;',
        variables: {
          'name': user['name'],
          'email': user['email'],
          'password': user['password'],
          'role': user['role']
        });
    final id = result.map((e) => e['User']).first!['id'];
    return Response.ok(jsonEncode({'id': id}));
  }

  FutureOr<Response> _updateUser(
      ModularArguments arguments, Injector injector) async {
    return Response.ok('Updated user: ${arguments.data}');
  }

  FutureOr<Response> _userUpdate(
      ModularArguments arguments, Injector injector) async {
    return Response.ok('Updated user: ${arguments.params['id']}');
  }

  FutureOr<Response> _deleteUser(
      ModularArguments arguments, Injector injector) async {
    return Response.ok('Deleted user: ${arguments.params['id']}');
  }
}
