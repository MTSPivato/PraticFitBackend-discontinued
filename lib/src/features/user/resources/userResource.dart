import 'dart:async';
import 'dart:convert';
import 'package:PraticFitBackend/src/core/services/bcrypt/bcryptService.dart';
import 'package:PraticFitBackend/src/features/auth/guard/authGuard.dart';
import 'package:PraticFitBackend/src/features/user/repositories/userRepository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:PraticFitBackend/src/features/user/errors/errors.dart';

// Classe responsável por gerenciar as rotas de usuário
class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/getall', _getAllUser, middlewares: [AuthGuard()]),
        Route.get('/get/:id', _getUserByid, middlewares: [AuthGuard()]),
        Route.post('/create', _createUser),
        Route.put('/update', _updateUser, middlewares: [AuthGuard()]),
        Route.delete('/delete/:id', _deleteUser, middlewares: [AuthGuard()]),
      ];

  // Método responsável por retornar todos os usuários
  FutureOr<Response> _getAllUser(Injector injector) async {
    try {
      final userRepository = injector.get<UserRepository>();
      final listUsers = await userRepository.getAllUser();
      return Response.ok(jsonEncode(listUsers));
    } on UserException catch (e) {
      return Response(e.statusCode, body: e.toJson());
    }
  }

  // Método responsável por retornar um usuário pelo id
  FutureOr<Response> _getUserByid(
      ModularArguments arguments, Injector injector) async {
    try {
      final id = arguments.params['id'];
      final userRepository = injector.get<UserRepository>();
      final user = await userRepository.getUserById(id);
      return Response.ok(jsonEncode(user));
    } on UserException catch (e) {
      return Response(e.statusCode, body: e.toJson());
    }
  }

  // Método responsável por deletar um usuário pelo id
  FutureOr<Response> _deleteUser(
      ModularArguments arguments, Injector injector) async {
    try {
      final id = arguments.params['id'];
      final bcrypt = injector.get<BCryptService>();
      final userParams = (arguments.data as Map).cast<String, dynamic>();
      userParams['password'] = bcrypt.generateHash(userParams['password']);
      final password = userParams['password'];
      final deletUser =
          await injector.get<UserRepository>().deleteUserById(id, password);
      return Response.ok(jsonEncode(deletUser));
    } on UserException catch (e) {
      return Response(e.statusCode, body: e.toJson());
    }
  }

  // Método responsável por criar um usuário
  FutureOr<Response> _createUser(
      ModularArguments arguments, Injector injector) async {
    try {
      final bcrypt = injector.get<BCryptService>();
      final userParams = (arguments.data as Map).cast<String, dynamic>();
      userParams['password'] = bcrypt.generateHash(userParams['password']);
      final createUser = await injector
          .get<UserRepository>()
          .createUser(userParams as Map<String, dynamic>);
      return Response.ok(jsonEncode(createUser));
    } on UserException catch (e) {
      return Response(e.statusCode, body: e.toJson());
    }
  }

  // Método responsável por atualizar um usuário
  FutureOr<Response> _updateUser(
      ModularArguments arguments, Injector injector) async {
    try {
      final id = arguments.params['id'];
      final userRepository = injector.get<UserRepository>();
      final updateUser =
          await userRepository.updateUserById(id, arguments.data);
      return Response.ok(jsonEncode(updateUser));
    } on UserException catch (e) {
      return Response(e.statusCode, body: e.toJson());
    }
  }
}
