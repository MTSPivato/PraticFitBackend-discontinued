import 'dart:convert';

// Classe responsável por tratar as exceções
class UserException implements Exception {
  final String message;
  final int statusCode;

  UserException(this.statusCode, this.message);

  String toJson() {
    return jsonEncode({'error': message});
  }

  @override
  String toString() =>
      'AuthException(message: $message, statusCode: $statusCode)';
}
