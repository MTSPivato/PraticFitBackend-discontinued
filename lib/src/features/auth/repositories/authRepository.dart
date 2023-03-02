import 'package:PraticFitBackend/src/core/services/requestExtractor/requestExtractor.dart';
import '../../../core/services/bcrypt/bcryptService.dart';
import '../../../core/services/jwt/jwtService.dart';
import '../errors/errors.dart';
import '../models/tokenization.dart';

//  Classe responsável por gerenciar as rotas de autenticação
abstract class AuthDatasource {
  Future<Map> getIdAndRoleByEmail(String email);
  Future<String> getRoleById(id);
  Future<String> getPasswordById(id);
  Future<void> updatePasswordById(id, String password);
}

// Classe responsável por validar as credenciais de login
class AuthRepository {
  final BCryptService bcrypt;
  final JwtService jwt;
  final AuthDatasource datasource;

  AuthRepository(this.datasource, this.bcrypt, this.jwt);

  Future<Tokenization> login(LoginCredential credential) async {
    final userMap = await datasource.getIdAndRoleByEmail(credential.email);

    if (userMap.isEmpty) {
      throw AuthException(403, 'Email ou senha invalida');
    }

    if (!bcrypt.checkHash(credential.password, userMap['password'])) {
      throw AuthException(403, 'Email ou senha invalida');
    }

    final payload = userMap..remove('password');

    return _generateToken(payload);
  }

  // Método responsável por atualizar o token de autenticação
  Future<Tokenization> refreshToken(String token) async {
    final payload = jwt.getPayload(token);
    final role = await datasource.getRoleById(payload['id']);
    return _generateToken({
      'id': payload['id'],
      ' role': role,
    });
  }

  // Método responsável por gerar um novo token de autenticação
  Tokenization _generateToken(Map payload) {
    payload['exp'] = _determineExpiration(Duration(minutes: 10));

    final accessToken = jwt.generateToken(payload, 'accessToken');

    payload['exp'] = _determineExpiration(Duration(days: 3));
    final refreshToken = jwt.generateToken(payload, 'refreshToken');
    return Tokenization(accessToken: accessToken, refreshToken: refreshToken);
  }

  // Método responsável por determinar a data de expiração do token
  int _determineExpiration(Duration duration) {
    final expiresDate = DateTime.now().add(duration);
    final expiresIn =
        Duration(milliseconds: expiresDate.millisecondsSinceEpoch);
    return expiresIn.inSeconds;
  }

  // Método responsável por atualizar a senha do usuário
  Future<void> updatePassword(
      String token, String password, String newPassword) async {
    final payload = jwt.getPayload(token);
    final hash = await datasource.getPasswordById(payload['id']);

    if (!bcrypt.checkHash(password, hash)) {
      throw AuthException(403, 'senha invalida');
    }

    newPassword = bcrypt.generateHash(newPassword);

    await datasource.updatePasswordById(payload['id'], newPassword);
  }
}
