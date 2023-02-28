import 'package:PraticFitBackend/PraticFitBackend.dart';
import 'package:shelf/shelf_io.dart' as io;

// Função responsável por iniciar o servidor
void main(List<String> arguments) async {
  final handler = await startShelfModular();
  final server = await io.serve(handler, '0.0.0.0', 22669);
  print('Serving at http://${server.address.host}:${server.port}');
}
