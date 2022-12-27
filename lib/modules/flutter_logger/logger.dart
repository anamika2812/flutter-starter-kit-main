import 'dart:convert';

import 'package:flutter/material.dart';
import '../../_utils/ui_components/logger.dart';
import 'package:http/http.dart' as http;

Future<void> updateState() async {
  var data = await http.get(
    Uri.parse("https://list.ly/api/v4/meta?url=http://google.com"),
    headers: {'Content-Type': 'application/json'},
  );
  logger.i(data);
  if (data.statusCode == 200) {
    return loggerNoStack.d(json.decode(data.body));
  } else {
    throw Exception('Failed to load api');
  }
}

class LoggerExample extends StatefulWidget {
  const LoggerExample({super.key});

  @override
  LoggerExampleState createState() => LoggerExampleState();
}

class LoggerExampleState extends State<LoggerExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            onTap: () => logger.d('_imageUrl'),
            onChanged: (text) => logger.d(text),
          ),
          ElevatedButton(
            onPressed: () {
              logger.wtf("What a terrible failure log");

              logger.d('Log message with 2 methods');

              loggerNoStack.i('Info message');

              loggerNoStack.w('Just a warning!');

              logger.e('Error! Something bad happened', 'Test Error');

              loggerNoStack.v({'key': 5, 'value': 'something'});
            },
            child: const Text(
              'TEST WITH LOGGER',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
              child: const Text(
                "btn Demo",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                updateState();
              }),
        ],
      ),
    );
  }
}
