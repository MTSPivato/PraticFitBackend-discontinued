import 'bcryptService.dart';
import 'package:bcrypt/bcrypt.dart';

// Classe responsável por gerar e validar hash de senha
class BCryptServiceImpl implements BCryptService {
  // Método responsável por verificar se o hash é válido
  @override
  bool checkHash(String text, String hash) {
    return BCrypt.checkpw(text, hash);
  }

  // Método responsável por gerar o hash da senha
  @override
  String generateHash(String text) {
    final String hashed = BCrypt.hashpw('text', BCrypt.gensalt());
    return hashed;
  }
}
