// Esse arquivo é responsável por gerar o token e verificar se o token é válido
abstract class JwtService {
  String generateToken(Map claims, String audiance);
  void verifyToken(String token, String audiance);
  Map getPayload(String token);
}
