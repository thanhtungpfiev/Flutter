import 'package:ecommerce_clone_getx/app/core/services/app_logging_service.dart';

/// A simple logger utility that can be used throughout the app as a replacement for print() and debugPrint()
///
/// Usage examples:
/// ```dart
/// AppLogger.d('Debug message');
/// AppLogger.i('Info message');
/// AppLogger.w('Warning message');
/// AppLogger.e('Error message', error, stackTrace);
/// ```
class AppLogger {
  static AppLoggingService get _logger => AppLoggingService.instance;

  /// Log a debug message
  /// Use this for detailed debugging information that is not needed in production
  static void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.debug(message, error, stackTrace);
  }

  /// Log an info message
  /// Use this for general information about app flow
  static void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.info(message, error, stackTrace);
  }

  /// Log a warning message
  /// Use this for potentially problematic situations
  static void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  /// Log an error message
  /// Use this for error conditions
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.error(message, error, stackTrace);
  }

  /// Log a verbose message
  /// Use this for very detailed debugging information
  static void v(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.verbose(message, error, stackTrace);
  }

  /// Log a 'What a Terrible Failure' message
  /// Use this for critical errors that should never happen
  static void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error, stackTrace);
  }

  /// Clear all logs from the log file
  static Future<void> clearLogs() async {
    await _logger.clearLogs();
  }

  /// Get all logs from the log file
  static Future<List<String>> getLogs() async {
    return await _logger.getLogs();
  }

  /// Get the path to the current log file
  static Future<String?> getLogFilePath() async {
    return await _logger.getLogFilePath();
  }

  // Convenience methods that match common print/debugPrint usage patterns

  /// Print-like method for simple string logging
  /// This replaces the standard print() function
  static void print(Object? object) {
    i(object.toString());
  }

  /// DebugPrint-like method for debug logging
  /// This replaces the standard debugPrint() function
  static void debugPrint(String? message, {int? wrapWidth}) {
    if (message != null) {
      d(message);
    }
  }
}
