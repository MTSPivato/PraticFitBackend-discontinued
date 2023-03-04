import 'dart:async';
import 'dart:convert';
import 'package:PraticFitBackend/src/core/services/bcrypt/bcryptService.dart';
import 'package:PraticFitBackend/src/core/services/database/remoteDatabase.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

abstract class GetAllUsers extends Resource {
  @override
  // Método responsável por retornar todos os usuários
  FutureOr<Response> _getAllUser(Injector injector) async {
    final database = injector.get<RemoteDatabase>();
    final result =
        await database.query('SELECT id, name, email, role FROM "User";');

    final listUsers = result.map((e) => e['User']).toList();

    return Response.ok(jsonEncode(listUsers));
  }
}
