import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

import '../../_utils/ui_components/extra_loggers.dart';

class LoggyCounterExample extends StatefulWidget {
  const LoggyCounterExample({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoggyCounterExampleState createState() => _LoggyCounterExampleState();
}

class _LoggyCounterExampleState extends State<LoggyCounterExample>
    with UiLoggy {
  late CounterLogic _counter;

  @override
  void initState() {
    super.initState();
    loggy.debug('Init state called!');
    _counter = CounterLogic(0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loggy.debug('Did change dependencies called!');
  }

  void _click({bool increase = true}) {
    loggy.info('Button clicked!');

    setState(() {
      if (increase) {
        _counter.increment();
      } else {
        _counter.decrement();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loggy.debug('Build called!');
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ThemeData.dark().scaffoldBackgroundColor,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${_counter.value}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _click,
            heroTag: 'increment_tag',
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 12.0,
          ),
          FloatingActionButton(
            onPressed: () => _click(increase: false),
            tooltip: 'Decrement',
            heroTag: 'decrement_tag',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterLogic with CustomLoggy {
  CounterLogic(this._counter) {
    loggy.debug('Started new counter! Start count value is: $_counter');
  }

  int _counter;

  int get value => _counter;

  void increment() {
    loggy.info('Incrementing counter! Current value: $_counter');

    if (_counter > 2) {
      loggy.debug(
          'Counter is over 2! This is really long message: Lorem Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');
    }

    _counter++;
  }

  void decrement() {
    loggy.warning('Decrementing counter! Current value: $_counter');

    if (_counter == 0) {
      loggy.error('Counter is at 0. Counter should never be below 0');
      return;
    }

    _counter--;
  }
}
