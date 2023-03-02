// Arquivo responsável por definir a interface de comunicação com o banco de dados remoto
abstract class RemoteDatabase {
  Future<List<Map<String, Map<String, dynamic>>>> query(
    String queryText, {
    Map<String, dynamic> variables = const {},
  });
}
