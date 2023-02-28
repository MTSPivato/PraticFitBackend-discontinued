import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../jwtService.dart';

// Classe responsável por gerenciar o serviço de JWT
class JwtServiceImpl implements JwtService {
  final DotEnvService dotEnvService;
  JwtServiceImpl(this.dotEnvService);

  // Método responsável por gerar o token
  @override
  String generateToken(Map claims, String audiance) {
    final jwt = JWT(claims, audience: Audience.one(audiance));
    final token = jwt.sign(SecretKey(dotEnvService['JWT_KEY']!));
    return token;
  }

  // Método responsável por verificar se o token é válido
  @override
  void verifyToken(String token, String audiance) {
    JWT.verify(
      token,
      SecretKey(dotEnvService['JWT_KEY']!),
      audience: Audience.one(audiance),
    );
  }

  // Método responsável por retornar o payload do token
  @override
  Map getPayload(String token) {
    final jwt = JWT.verify(
      token,
      SecretKey(dotEnvService['JWT_KEY']!),
      checkExpiresIn: false,
      checkHeaderType: false,
      checkNotBefore: false,
    );
    return jwt.payload;
  }
}
