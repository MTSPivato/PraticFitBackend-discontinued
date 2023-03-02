import 'package:PraticFitBackend/PraticFitBackend.dart';
import 'package:PraticFitBackend/src/core/constants/isProduction.dart';
import 'package:shelf/shelf_io.dart' as io;

// Função responsável por iniciar o servidor
void main(List<String> arguments) async {
  final handler = await startShelfModular();
  final server = await io.serve(handler, '0.0.0.0', 47929);
  print(Production
      ? 'Caution server in production mode at http://${server.address.host}:${server.port}'
      : 'Server in development mode at http://${server.address.host}:${server.port}');
}
