import 'package:loggy/loggy.dart';

const LogLevel socketLevel = LogLevel('socket', 32);

extension SocketLoggy on Loggy {
  void socket(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(socketLevel, message, error, stackTrace);
}
