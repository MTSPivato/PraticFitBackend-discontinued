import 'dart:async';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

// Classe responsável por gerenciar as rotas do recurso de autenticação
class AuthResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/auth/login', _login),
        Route.get('/auth/refreshToken', _refreshToken),
        Route.get('/auth/checkToken', _checkToken),
        Route.post('/auth/updatePassword', _updatePassword),
      ];

  // Modulo responsável por autenticar um usuário
  FutureOr<Response> _login(
      ModularArguments arguments, Injector injector) async {
    return Response.ok('');
  }

  // Modulo responsável por atualizar o token de um usuário
  FutureOr<Response> _refreshToken(
      ModularArguments arguments, Injector injector) async {
    return Response.ok('');
  }

  // Modulo responsável por verificar se o token é válido
  FutureOr<Response> _checkToken(
      ModularArguments arguments, Injector injector) async {
    return Response.ok('');
  }

  // Modulo responsável por atualizar a senha de um usuário
  FutureOr<Response> _updatePassword(
      ModularArguments arguments, Injector injector) async {
    return Response.ok('');
  }
}
