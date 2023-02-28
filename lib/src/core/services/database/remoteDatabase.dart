// esse arquivo é responsável por fazer a conexão com o banco de dados
abstract class RemoteDatabase {
  Future<List<Map<String, Map<String, dynamic>>>> query(
    String queryText, {
    Map<String, dynamic> variables = const {},
  });
}
