import 'package:logger/logger.dart';

class LoggerHelper {
  static var logger = Logger(
    printer: PrettyPrinter(printTime: true),
  );
}
