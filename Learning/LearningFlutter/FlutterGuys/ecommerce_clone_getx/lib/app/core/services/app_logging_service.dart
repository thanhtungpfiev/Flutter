import 'dart:io';

import 'package:ecommerce_clone_getx/app/core/services/logging_service.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class AppLoggingService implements LoggingService {
  static AppLoggingService? _instance;
  static Logger? _logger;
  static File? _logFile;
  static bool _isInitialized = false;

  AppLoggingService._();

  static AppLoggingService get instance {
    _instance ??= AppLoggingService._();
    return _instance!;
  }

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize the log file
      await _initializeLogFile();

      // Create custom logger with both console and file output
      _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 3,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
        output: MultiOutput([
          ConsoleOutput(),
          if (_logFile != null) FileOutput(_logFile!),
        ]),
        filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
      );

      _isInitialized = true;
    } catch (e) {
      // Fallback to console-only logging if file initialization fails
      _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 3,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
        filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
      );
      _isInitialized = true;
      debugPrint('Failed to initialize file logging: $e');
    }
  }

  static Future<void> _initializeLogFile() async {
    try {
      Directory appDocDir;
      if (Platform.isAndroid || Platform.isIOS) {
        appDocDir = await getApplicationDocumentsDirectory();
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        appDocDir = await getApplicationSupportDirectory();
      } else {
        throw UnsupportedError('Platform not supported for file logging');
      }

      final logsDir = Directory('${appDocDir.path}/logs');
      if (!await logsDir.exists()) {
        await logsDir.create(recursive: true);
      }

      // Create log file with current date
      final now = DateTime.now();
      final dateStr =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      _logFile = File('${logsDir.path}/app_log_$dateStr.txt');

      // Clean old log files (keep only last 7 days)
      await _cleanOldLogFiles(logsDir);
    } catch (e) {
      debugPrint('Error initializing log file: $e');
      rethrow;
    }
  }

  static Future<void> _cleanOldLogFiles(Directory logsDir) async {
    try {
      final List<FileSystemEntity> files = logsDir.listSync();
      final DateTime cutoffDate = DateTime.now().subtract(
        const Duration(days: 7),
      );

      for (final file in files) {
        if (file is File && file.path.contains('app_log_')) {
          final FileStat stat = await file.stat();
          if (stat.modified.isBefore(cutoffDate)) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      debugPrint('Error cleaning old log files: $e');
    }
  }

  Logger get logger {
    if (!_isInitialized || _logger == null) {
      throw StateError(
        'AppLoggingService not initialized. Call AppLoggingService.initialize() first.',
      );
    }
    return _logger!;
  }

  @override
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error: error, stackTrace: stackTrace);
  }

  @override
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.w(message, error: error, stackTrace: stackTrace);
  }

  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.t(message, error: error, stackTrace: stackTrace);
  }

  @override
  void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.f(message, error: error, stackTrace: stackTrace);
  }

  @override
  Future<void> clearLogs() async {
    try {
      if (_logFile != null && await _logFile!.exists()) {
        await _logFile!.writeAsString('');
      }
    } catch (e) {
      debugPrint('Error clearing logs: $e');
    }
  }

  @override
  Future<List<String>> getLogs() async {
    try {
      if (_logFile != null && await _logFile!.exists()) {
        final content = await _logFile!.readAsString();
        return content.split('\n').where((line) => line.isNotEmpty).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error reading logs: $e');
      return [];
    }
  }

  // Helper method to get log file path
  Future<String?> getLogFilePath() async {
    return _logFile?.path;
  }
}

/// Custom file output for the logger that writes to a file
class FileOutput extends LogOutput {
  final File file;

  FileOutput(this.file);

  @override
  void output(OutputEvent event) {
    try {
      final timestamp = DateTime.now().toIso8601String();
      final logEntry = '$timestamp: ${event.lines.join('\n')}\n';
      file.writeAsStringSync(logEntry, mode: FileMode.append);
    } catch (e) {
      debugPrint('Error writing to log file: $e');
    }
  }
}
