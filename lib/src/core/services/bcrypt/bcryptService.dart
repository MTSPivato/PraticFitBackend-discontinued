// Esse arquivo é responsável por gerar o hash e verificar se o hash é válido
abstract class BCryptService {
  String generateHash(String text);
  bool checkHash(String text, String hash);
}