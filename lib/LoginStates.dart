import 'dart:io';
import 'package:chatwith/constants.dart';
import 'package:path_provider/path_provider.dart';
late String loginState="notLogIn";
late String ps=" ";
late String em=" ";
Future<String> _getDirPath() async {
  final _dir = await getApplicationDocumentsDirectory();
  return _dir.path;
}
Future<void> readState() async {
  final _dirPath = await _getDirPath();
  try {
    final _state = File('$_dirPath/state.txt');
    List<String> lines = _state.readAsLinesSync();
    loginState = lines.first;
    print(loginState);
    em = lines[1];
    ps = lines.last;
  }
  catch(e)
  {
    print(e);
  }
}
Future<void> writeState() async {
  final _dirPath = await _getDirPath();
  final _myFile = File('$_dirPath/state.txt');
  await _myFile.writeAsString('logIn\n$email\n$pass',);
}
