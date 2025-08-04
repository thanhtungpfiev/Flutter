import 'package:ecommerce_clone/core/services/app_logging_service.dart';
import 'package:ecommerce_clone/core/utils/app_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Logging System Tests', () {
    setUpAll(() async {
      // Initialize the logging system
      await AppLoggingService.initialize();
    });

    test('AppLogger should log messages without throwing exceptions', () {
      expect(() => AppLogger.d('Debug message'), returnsNormally);
      expect(() => AppLogger.i('Info message'), returnsNormally);
      expect(() => AppLogger.w('Warning message'), returnsNormally);
      expect(() => AppLogger.e('Error message'), returnsNormally);
      expect(() => AppLogger.v('Verbose message'), returnsNormally);
      expect(() => AppLogger.wtf('WTF message'), returnsNormally);
    });

    test('AppLogger should handle errors with exceptions', () {
      final error = Exception('Test exception');
      final stackTrace = StackTrace.current;

      expect(
        () => AppLogger.e('Error with exception', error, stackTrace),
        returnsNormally,
      );
    });

    test('AppLogger convenience methods should work', () {
      expect(() => AppLogger.print('Print replacement'), returnsNormally);
      expect(
        () => AppLogger.debugPrint('DebugPrint replacement'),
        returnsNormally,
      );
    });

    test('AppLogger should provide log management features', () async {
      // These should not throw exceptions
      expect(() async => await AppLogger.getLogs(), returnsNormally);
      expect(() async => await AppLogger.getLogFilePath(), returnsNormally);
      expect(() async => await AppLogger.clearLogs(), returnsNormally);
    });
  });
}
