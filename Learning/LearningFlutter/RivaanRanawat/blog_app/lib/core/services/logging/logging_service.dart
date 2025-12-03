abstract class LoggingService {
  void debug(String message, [dynamic error, StackTrace? stackTrace]);
  void info(String message, [dynamic error, StackTrace? stackTrace]);
  void warning(String message, [dynamic error, StackTrace? stackTrace]);
  void error(String message, [dynamic error, StackTrace? stackTrace]);
  void verbose(String message, [dynamic error, StackTrace? stackTrace]);
  void wtf(String message, [dynamic error, StackTrace? stackTrace]);
  Future<void> clearLogs();
  Future<List<String>> getLogs();
}
