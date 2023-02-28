import 'package:bcrypt/bcrypt.dart';

import 'bcryptService.dart';

class BCryptServiceImpl implements BCryptService {
  @override
  bool checkHash(String text, String hash) {
    return BCrypt.checkpw(text, hash);
  }

  @override
  String generateHash(String text) {
    final String hashed = BCrypt.hashpw(text, BCrypt.gensalt());
    return hashed;
  }
}
