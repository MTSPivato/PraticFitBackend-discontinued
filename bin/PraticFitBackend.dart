import 'package:PraticFitBackend/PraticFitBackend.dart';
import 'package:PraticFitBackend/src/constants/ipServer.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {
  final handler = await startShelfModular();
  final server = await io.serve(handler, serverUrl(), serverPort());
  print('Serving at http://${server.address.host}:${server.port}');
}
