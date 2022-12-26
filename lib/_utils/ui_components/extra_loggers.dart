import 'package:loggy/loggy.dart';

mixin CustomLoggy implements LoggyType {
  @override
  Loggy<CustomLoggy> get loggy =>
      Loggy<CustomLoggy>('Custom Loggy - $runtimeType');
}
