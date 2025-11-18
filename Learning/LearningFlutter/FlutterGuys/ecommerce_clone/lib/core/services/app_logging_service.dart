import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_clone/core/services/logging_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class AppLoggingService implements LoggingService {
  static AppLoggingService? _instance;
  static Logger? _logger;
  static Logger? _fastLogger; // Logger without stack trace for performance
  static File? _logFile;
  static AsyncBufferedFileOutput? _fileOutput;
  static bool _isInitialized = false;
  static int _logCounter = 0; // For sampling

  // Configuration settings
  static Level _consoleLogLevel = Level.debug;
  static Level _fileLogLevel = Level.info;
  static bool _enableConsoleOutput = true;
  static bool _enableFileOutput = true;
  static int _bufferSize = 50;
  static int _logRetentionDays = 7;

  AppLoggingService._();

  static AppLoggingService get instance {
    _instance ??= AppLoggingService._();
    return _instance!;
  }

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Load configuration from file
      await _loadConfiguration();

      // Initialize the log file
      await _initializeLogFile();

      // Create async buffered file output for performance
      if (_logFile != null && _enableFileOutput) {
        _fileOutput = AsyncBufferedFileOutput(
          _logFile!,
          bufferSize: _bufferSize,
        );
      }

      // Build output list based on configuration
      final outputs = <LogOutput>[];
      if (_enableConsoleOutput) {
        outputs.add(ConsoleOutput());
      }
      if (_fileOutput != null && _enableFileOutput) {
        outputs.add(_fileOutput!);
      }

      // Create standard logger with configured outputs and levels
      _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 3,
          stackTraceBeginIndex: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
        output: MultiOutput(outputs),
        filter: ConfigurableLogFilter(
          consoleLevel: _consoleLogLevel,
          fileLevel: _fileLogLevel,
          enableConsole: _enableConsoleOutput,
          enableFile: _enableFileOutput,
        ),
      );

      // Create fast logger without stack trace for performance-critical logging
      _fastLogger = Logger(
        printer: SimplePrinter(colors: true, printTime: true),
        output: MultiOutput(outputs),
        filter: ConfigurableLogFilter(
          consoleLevel: _consoleLogLevel,
          fileLevel: _fileLogLevel,
          enableConsole: _enableConsoleOutput,
          enableFile: _enableFileOutput,
        ),
      );

      _isInitialized = true;
    } catch (e) {
      // Fallback to console-only logging if file initialization fails
      _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 3,
          stackTraceBeginIndex: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
        filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
      );
      _fastLogger = Logger(
        printer: SimplePrinter(colors: true, printTime: true),
        filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
      );
      _isInitialized = true;
      debugPrint('Failed to initialize file logging: $e');
    }
  }

  /// Load logging configuration from assets/config/log_config.json
  static Future<void> _loadConfiguration() async {
    try {
      final configString = await rootBundle.loadString(
        'assets/config/log_config.json',
      );
      final config = json.decode(configString) as Map<String, dynamic>;

      // Parse console log level
      final consoleLevel = config['console_log_level'] as String?;
      _consoleLogLevel = _parseLogLevel(consoleLevel ?? 'DEBUG');

      // Parse file log level
      final fileLevel = config['file_log_level'] as String?;
      _fileLogLevel = _parseLogLevel(fileLevel ?? 'INFO');

      // Parse output settings
      _enableConsoleOutput = config['enable_console_output'] as bool? ?? true;
      _enableFileOutput = config['enable_file_output'] as bool? ?? true;

      // Parse buffer size
      _bufferSize = config['buffer_size'] as int? ?? 50;

      // Parse retention days
      _logRetentionDays = config['log_retention_days'] as int? ?? 7;

      debugPrint(
        'Log configuration loaded: Console=$_consoleLogLevel, File=$_fileLogLevel',
      );
    } catch (e) {
      debugPrint('Failed to load log configuration, using defaults: $e');
      // Use default values (already set above)
    }
  }

  /// Parse log level string to Level enum
  static Level _parseLogLevel(String level) {
    switch (level.toUpperCase()) {
      case 'TRACE':
      case 'VERBOSE':
        return Level.trace;
      case 'DEBUG':
        return Level.debug;
      case 'INFO':
        return Level.info;
      case 'WARNING':
      case 'WARN':
        return Level.warning;
      case 'ERROR':
        return Level.error;
      case 'FATAL':
      case 'WTF':
        return Level.fatal;
      case 'OFF':
        return Level.off;
      default:
        return Level.debug;
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

      // Clean old log files based on retention days configuration
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
        Duration(days: _logRetentionDays),
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

  /// Flush all buffered logs to file immediately
  static Future<void> flush() async {
    await _fileOutput?.flushAndWait();
  }

  /// Ultra-fast logging for high-frequency data (no stack trace, minimal overhead)
  /// Use for: streaming data, continuous monitoring, high-frequency events (>100 Hz)
  static void stream(String message) {
    if (!_isInitialized || _fastLogger == null) return;
    _fastLogger!.i(message);
  }

  /// Fast debug logging without stack trace extraction
  /// Use for: frequent updates, performance-critical paths
  static void debugFast(String message) {
    if (!_isInitialized || _fastLogger == null) return;
    _fastLogger!.d(message);
  }

  /// Conditional logging with zero overhead when condition is false
  /// Use for: verbose debugging that can be toggled
  static void debugIf(bool condition, String message) {
    if (!condition) return;
    if (!_isInitialized || _logger == null) return;
    _logger!.d(message);
  }

  /// Sample-based logging to reduce volume for high-frequency events
  /// Only logs every Nth call based on sampleRate
  /// Example: debugSample("High frequency event", sampleRate: 100) logs 1 out of 100 calls
  static void debugSample(String message, {int sampleRate = 10}) {
    _logCounter++;
    if (_logCounter % sampleRate != 0) return;
    if (!_isInitialized || _fastLogger == null) return;
    _fastLogger!.d('[$_logCounter] $message');
  }

  /// Raw logging for structured data (CSV, JSON, audit trails)
  /// Minimal formatting, file-only output
  static void raw(String message) {
    if (_fileOutput == null) return;
    _fileOutput!.outputRaw(message);
  }
}

/// Custom log filter that supports different log levels for console and file
class ConfigurableLogFilter extends LogFilter {
  final Level consoleLevel;
  final Level fileLevel;
  final bool enableConsole;
  final bool enableFile;

  ConfigurableLogFilter({
    required this.consoleLevel,
    required this.fileLevel,
    required this.enableConsole,
    required this.enableFile,
  });

  @override
  bool shouldLog(LogEvent event) {
    // In debug mode, check against console level
    // In release mode, check against file level
    if (kDebugMode && enableConsole) {
      return event.level.index >= consoleLevel.index;
    } else if (enableFile) {
      return event.level.index >= fileLevel.index;
    }
    return false;
  }
}

/// Async buffered file output for high-performance logging
/// Buffers log entries and writes them asynchronously to reduce I/O blocking
class AsyncBufferedFileOutput extends LogOutput {
  final File file;
  final List<String> _buffer = [];
  final int _bufferSize;
  bool _isFlushing = false;

  AsyncBufferedFileOutput(this.file, {int bufferSize = 50})
    : _bufferSize = bufferSize;

  @override
  void output(OutputEvent event) {
    try {
      final timestamp = DateTime.now().toIso8601String();
      final logEntry = '$timestamp: ${event.lines.join('\n')}';
      _buffer.add(logEntry);

      // Auto-flush when buffer is full
      if (_buffer.length >= _bufferSize) {
        _flushBuffer();
      }
    } catch (e) {
      debugPrint('Error buffering log: $e');
    }
  }

  /// Write raw message directly without formatting (for structured data)
  void outputRaw(String message) {
    try {
      final timestamp = DateTime.now().toIso8601String();
      _buffer.add('$timestamp: $message');

      if (_buffer.length >= _bufferSize) {
        _flushBuffer();
      }
    } catch (e) {
      debugPrint('Error buffering raw log: $e');
    }
  }

  void _flushBuffer() {
    if (_buffer.isEmpty || _isFlushing) return;
    _isFlushing = true;

    final logsToWrite = List<String>.from(_buffer);
    _buffer.clear();

    // Write asynchronously without blocking
    file
        .writeAsString(
          '${logsToWrite.join('\n')}\n',
          mode: FileMode.append,
          flush: true,
        )
        .then((_) {
          _isFlushing = false;
        })
        .catchError((e) {
          debugPrint('Error flushing logs: $e');
          _isFlushing = false;
        });
  }

  /// Flush remaining logs and wait for completion
  Future<void> flushAndWait() async {
    if (_buffer.isEmpty) return;

    final logsToWrite = List<String>.from(_buffer);
    _buffer.clear();

    try {
      await file.writeAsString(
        '${logsToWrite.join('\n')}\n',
        mode: FileMode.append,
        flush: true,
      );
    } catch (e) {
      debugPrint('Error flushing logs: $e');
    }
  }
}
