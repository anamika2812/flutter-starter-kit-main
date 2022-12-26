import 'package:loggy/loggy.dart';

import '../../_utils/ui_components/extra_loggers.dart';
import '../../_utils/ui_components/socket_level.dart';

class ExampleNetworkLoggy with NetworkLoggy {
  ExampleNetworkLoggy() {
    loggy.debug('This is log from Network logger');

    loggy.info('This is log from Network logger');

    loggy.warning('This is log from Network logger');

    loggy.error('This is log from Network logger');

    loggy.socket('This is log with custom log level in Network logger');
  }
}

class ExampleUiLoggy with UiLoggy {
  ExampleUiLoggy() {
    loggy.warning('This is log from UI logger');
    loggy.warning('This is log from UI logger');
    loggy.warning('This is log from UI logger');
    loggy.warning('This is log from UI logger');

    loggy.socket('This is log with custom log level in UI logger');
  }
}

class ExampleBlackListedLoggy with CustomLoggy {
  ExampleBlackListedLoggy() {
    loggy
        .info('This log is from Blacklisted logger and should not be visible!');
    loggy.warning(
        'This log is from Blacklisted logger and should not be visible!');
  }
}

class ExampleWhatLoggyCanDo with CustomLoggy {
  ExampleWhatLoggyCanDo() {
    loggy.info('Loggys can do some stuff:');
    loggy.info(
        'You can pass function to the logger, it will evaluate only if log gets shown');
    loggy.debug(() {
      loggy.warning('Using logger inside of the logger #WeNeedToGoDeeper');

      const secret = 0 / 0;
      return '${List.generate(8, (_) => secret).fold<String>('', (value, e) => value += e.toString())} Batman';
    });

    final childLoggy = newLoggy('Test');

    childLoggy.debug(
        'I\'m new logger called "${childLoggy.name}" and my parent logger name is "${childLoggy.parent!.name}"');
    childLoggy.debug(
        'Even if I\'m a new logger, I still share everything with my parent');

    final detachedloggy = detachedLoggy('Detached logger');
    detachedloggy.level = const LogOptions(LogLevel.all);
    detachedloggy.printer = const DefaultPrinter();
    detachedloggy.debug(
        'I\'m a detached logger. I don\'t have a parent and I have no connection or shared info with root logger!');
  }
}
