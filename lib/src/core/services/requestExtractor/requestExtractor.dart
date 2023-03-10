import 'dart:convert';
import 'package:shelf/shelf.dart';

// Classe responsável por extrair informações da requisição
class RequestExtractor {
  // Método responsável por extrair o token de autenticação
  String getAuthorizationBearer(Request request) {
    var authorization = request.headers['authorization'] ?? '';
    authorization = authorization.split(' ').last;
    return authorization;
  }

  // Método responsável por extrair as credenciais de login
  LoginCredential getAuthorizationBasic(Request request) {
    var authorization = request.headers['authorization'] ?? '';
    authorization = authorization.split(' ').last;
    authorization = String.fromCharCodes(base64Decode(authorization));
    final credential = authorization.split(':');
    return LoginCredential(
      email: credential.first,
      password: credential.last,
    );
  }
}

// Classe responsável por armazenar as credenciais de login
class LoginCredential {
  final String email;
  final String password;

  LoginCredential({required this.email, required this.password});
}
