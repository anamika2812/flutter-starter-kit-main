// ignore_for_file: avoid_redundant_argument_values

import 'package:logger/logger.dart';

var logger = Logger(
    printer: PrettyPrinter(
  methodCount: 0,
  errorMethodCount: 5,
  lineLength: 50,
  colors: true,
  printEmojis: true,
  printTime: true,
));
Logger loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
