// Arquivo responsável por definir a interface de criptografia e descriptografia
abstract class BCryptService {
  String generateHash(String text);
  bool checkHash(String text, String hash);
}
