import 'dart:convert';
import 'package:shelf/shelf.dart';

// Classe responsável por extrair informações da requisição
class RequestExtractoService {
  // Método responsável por extrair o token de autorização do header da requisição
  String getAuthorizationBearer(Request request) {
    var authorization = request.headers['authorization'] ?? '';
    authorization = authorization.split(' ').last;
    return authorization;
  }

  // Método responsável por extrair o email e a senha do header da requisição
  LoginCredentials getAuthorizationBasic(Request request) {
    var authorization = request.headers['authorization'] ?? '';
    authorization = authorization.split(' ').last;
    authorization = String.fromCharCodes(base64Decode(authorization));
    final credentials = authorization.split(':');
    return LoginCredentials(
      email: credentials.first,
      password: credentials.last,
    );
  }
}

// Classe responsável por armazenar as credenciais de login
class LoginCredentials {
  final String email;
  final String password;

  LoginCredentials({required this.email, required this.password});
}
