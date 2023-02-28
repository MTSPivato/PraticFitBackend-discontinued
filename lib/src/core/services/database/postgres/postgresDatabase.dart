import 'dart:async';
import 'package:PraticFitBackend/src/core/services/database/remoteDatabase.dart';
import 'package:PraticFitBackend/src/core/services/dotEnv/dotEnvService.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf_modular/shelf_modular.dart';

// Classe responsável por gerenciar a conexão com o banco de dados
class PostgresDatabase implements RemoteDatabase, Disposable {
  final completer = Completer<PostgreSQLConnection>();
  final DotEnvService dotEnv;

  PostgresDatabase(this.dotEnv) {
    _init();
  }

  // Função responsável por iniciar a conexão com o banco de dados
  _init() async {
    final url = dotEnv['DATABASE_URL'];
    final uri = Uri.parse(url!);

    var connection = PostgreSQLConnection(
      uri.host,
      uri.port,
      uri.pathSegments.first,
      username: uri.userInfo.split(':').first,
      password: uri.userInfo.split(':').last,
    );
    await connection.open();
    completer.complete(connection);
  }

  // Função responsável por executar uma query no banco de dados
  @override
  Future<List<Map<String, Map<String, dynamic>>>> query(
    String queryText, {
    Map<String, dynamic> variables = const {},
  }) async {
    final connection = await completer.future;

    return await connection.mappedResultsQuery(
      queryText,
      substitutionValues: variables,
    );
  }

  // Função responsável por fechar a conexão com o banco de dados
  @override
  void dispose() async {
    final connection = await completer.future;
    await connection.close();
  }
}
