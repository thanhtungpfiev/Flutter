# Logging System Documentation

This project includes a comprehensive logging system that can write to both console and files, replacing the standard `print()` and `debugPrint()` functions.

## Features

- ✅ **Dual Output**: Logs to both console and file simultaneously
- ✅ **Multiple Log Levels**: Verbose, Debug, Info, Warning, Error, WTF
- ✅ **Automatic File Management**: Daily log files with automatic cleanup (keeps 7 days)
- ✅ **Exception Support**: Full error and stack trace logging
- ✅ **Platform Support**: Works on Android, iOS, Windows, macOS, and Linux
- ✅ **Clean Architecture Integration**: Properly integrated with dependency injection
- ✅ **Performance Optimized**: Different filters for debug vs production builds

## Quick Start

### 1. Basic Usage

Replace your existing `print()` statements with:

```dart
import 'package:ecommerce_clone/core/utils/app_logger.dart';

// Instead of: print('Hello World');
AppLogger.i('Hello World');

// Instead of: debugPrint('Debug info');
AppLogger.d('Debug info');
```

### 2. Different Log Levels

```dart
AppLogger.v('Verbose message - very detailed debug info');
AppLogger.d('Debug message - general debugging');
AppLogger.i('Info message - general information');
AppLogger.w('Warning message - potential issue');
AppLogger.e('Error message - something went wrong');
AppLogger.wtf('Critical failure - should never happen');
```

### 3. Error Logging with Exceptions

```dart
try {
  // Some risky operation
  await riskyOperation();
} catch (error, stackTrace) {
  AppLogger.e('Operation failed', error, stackTrace);
}
```

### 4. Convenience Methods

```dart
// Drop-in replacements for existing functions
AppLogger.print('Simple message');  // Replaces print()
AppLogger.debugPrint('Debug info');  // Replaces debugPrint()
```

## Advanced Usage

### Accessing Log Files

```dart
// Get current log file path
String? logPath = await AppLogger.getLogFilePath();

// Get all logs as a list
List<String> logs = await AppLogger.getLogs();

// Clear current log file
await AppLogger.clearLogs();
```

### Integration with Dependency Injection

The logging service is automatically registered in the service locator:

```dart
// Access the logging service directly (if needed)
final loggingService = sl<LoggingService>();
loggingService.info('Direct service usage');
```

## File Structure

```
lib/
├── core/
│   ├── services/
│   │   ├── logging_service.dart          # Abstract interface
│   │   └── app_logging_service.dart      # Implementation
│   └── utils/
│       ├── app_logger.dart               # Main utility class
│       └── logging_demo_page.dart        # Demo page
└── service_locator.dart                  # DI registration
```

## Log File Management

### File Location
- **Android/iOS**: `<app_documents>/logs/`
- **Desktop**: `<app_support>/logs/`

### File Naming
- Format: `app_log_YYYY-MM-DD.txt`
- Example: `app_log_2025-08-04.txt`

### Automatic Cleanup
- Keeps logs for 7 days
- Older files are automatically deleted on app start

## Demo Page

A complete demo page is available at `lib/core/utils/logging_demo_page.dart` that shows:
- All log levels in action
- File management features
- Real-time log viewing
- Usage examples

To use the demo page:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const LoggingDemoPage()),
);
```

## Migration Guide

### From print() to AppLogger

**Before:**
```dart
print('User logged in: ${user.name}');
print('Error: $error');
debugPrint('Debug info: $data');
```

**After:**
```dart
AppLogger.i('User logged in: ${user.name}');
AppLogger.e('Error occurred', error);
AppLogger.d('Debug info: $data');
```

### Best Practices

1. **Use appropriate log levels:**
   - `v()` for very detailed debugging (rarely needed)
   - `d()` for general debugging information
   - `i()` for important application flow information
   - `w()` for potential issues that don't break functionality
   - `e()` for errors that need attention
   - `wtf()` for critical failures that should never happen

2. **Include context in messages:**
   ```dart
   // Good
   AppLogger.i('User authentication successful for user: ${user.id}');
   
   // Better
   AppLogger.i('Auth Service: User authentication successful', 
              {'userId': user.id, 'method': 'email'});
   ```

3. **Always log exceptions with stack traces:**
   ```dart
   try {
     await apiCall();
   } catch (error, stackTrace) {
     AppLogger.e('API call failed', error, stackTrace);
   }
   ```

## Performance Considerations

- **Debug Mode**: All log levels are written to console and file
- **Release Mode**: Only Warning, Error, and WTF levels are processed
- **File I/O**: Asynchronous and non-blocking
- **Memory**: Old logs are automatically cleaned up

## Troubleshooting

### Common Issues

1. **Logs not appearing in file:**
   - Check if file permissions are correct
   - Verify the app has write access to documents directory
   - Check if initialization was successful

2. **Console logs missing:**
   - Ensure you're running in debug mode
   - Check if the logger was properly initialized

3. **Performance issues:**
   - Reduce verbose and debug logging in production
   - Consider using production filter

### Debug Information

```dart
// Check if logging is initialized
AppLogger.i('Logging system status: ${AppLoggingService.instance != null}');

// Get log file path for debugging
String? path = await AppLogger.getLogFilePath();
AppLogger.i('Log file location: $path');
```

## Dependencies

The logging system uses these packages:
- `logger: ^2.3.0` - Core logging functionality
- `path_provider: ^2.1.3` - File system access

These are automatically included in `pubspec.yaml`.
