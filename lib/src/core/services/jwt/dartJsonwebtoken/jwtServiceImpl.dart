import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:PraticFitBackend/src/core/services/jwt/jwtService.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtServiceImpl implements JwtService {
  final DotEnvService dotEnvService;

  JwtServiceImpl(this.dotEnvService);

  @override
  String generateToken(Map claims, String audiance) {
    final jwt = JWT(claims, audience: Audience.one(audiance));
    final token = jwt.sign(SecretKey(dotEnvService['JWT_KEY']!));
    return token;
  }

  @override
  void verifyToken(String token, String audiance) {
    JWT.verify(
      token,
      SecretKey(dotEnvService['JWT_KEY']!),
      audience: Audience.one(audiance),
    );
  }

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
