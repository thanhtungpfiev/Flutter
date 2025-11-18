import 'package:blog_app/core/services/app_logging_service.dart';

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

  /// Flush all buffered logs to file immediately
  static Future<void> flush() async {
    await AppLoggingService.flush();
  }

  // Performance-optimized logging methods

  /// Ultra-fast logging for high-frequency data streams (no stack trace)
  /// Use for: streaming data, continuous monitoring, high-frequency events (>100 Hz)
  /// Example: AppLogger.stream('Packet received: ${packet.length} bytes');
  static void stream(String message) {
    AppLoggingService.stream(message);
  }

  /// Fast debug logging without stack trace extraction
  /// Use for: frequent updates, performance-critical debugging
  /// Example: AppLogger.debugFast('Processing item ${index}');
  static void debugFast(String message) {
    AppLoggingService.debugFast(message);
  }

  /// Conditional logging with zero overhead when condition is false
  /// Use for: verbose debugging that can be toggled
  /// Example: AppLogger.debugIf(isVerboseMode, 'Detailed info');
  static void debugIf(bool condition, String message) {
    AppLoggingService.debugIf(condition, message);
  }

  /// Sample-based logging to reduce volume for high-frequency events
  /// Only logs every Nth call based on sampleRate
  /// Example: AppLogger.debugSample('High freq event', sampleRate: 100);
  static void debugSample(String message, {int sampleRate = 10}) {
    AppLoggingService.debugSample(message, sampleRate: sampleRate);
  }

  /// Raw logging for structured data (CSV, JSON, audit trails)
  /// Minimal formatting, file-only output
  /// Example: AppLogger.raw('CSV,${timestamp},${value1},${value2}');
  static void raw(String message) {
    AppLoggingService.raw(message);
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
