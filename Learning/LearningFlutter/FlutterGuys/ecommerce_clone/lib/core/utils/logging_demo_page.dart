import 'package:ecommerce_clone/core/utils/app_logger.dart';
import 'package:flutter/material.dart';

/// Example page demonstrating the logging system
/// This page shows how to use the AppLogger for different log levels
/// and provides functionality to view and clear logs
class LoggingDemoPage extends StatefulWidget {
  const LoggingDemoPage({super.key});

  @override
  State<LoggingDemoPage> createState() => _LoggingDemoPageState();
}

class _LoggingDemoPageState extends State<LoggingDemoPage> {
  List<String> _logs = [];
  String? _logFilePath;

  @override
  void initState() {
    super.initState();
    _loadLogs();
    _getLogFilePath();
  }

  Future<void> _loadLogs() async {
    final logs = await AppLogger.getLogs();
    setState(() {
      _logs = logs;
    });
  }

  Future<void> _getLogFilePath() async {
    final path = await AppLogger.getLogFilePath();
    setState(() {
      _logFilePath = path;
    });
  }

  Future<void> _clearLogs() async {
    await AppLogger.clearLogs();
    await _loadLogs();
    AppLogger.i('Logs cleared from demo page');
  }

  void _demonstrateLogging() {
    // Demonstrate different log levels
    AppLogger.v('This is a verbose message - very detailed debug info');
    AppLogger.d('This is a debug message - general debugging');
    AppLogger.i('This is an info message - general information');
    AppLogger.w('This is a warning message - potential issue');
    AppLogger.e('This is an error message - something went wrong');

    // Simulate error with exception
    try {
      throw Exception('Simulated exception for demo');
    } catch (e, stackTrace) {
      AppLogger.e('Caught exception in demo', e, stackTrace);
    }

    AppLogger.wtf('This is a WTF message - critical failure');

    // Test the convenience methods
    AppLogger.print('Using print replacement method');
    AppLogger.debugPrint('Using debugPrint replacement method');

    // Reload logs to show new entries
    _loadLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logging System Demo'), elevation: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Logging System Features',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Logs to both console and file\n'
                      '• Automatic log rotation (keeps 7 days)\n'
                      '• Different log levels (verbose, debug, info, warning, error, wtf)\n'
                      '• Replaces print() and debugPrint()\n'
                      '• Exception and stack trace support',
                    ),
                    const SizedBox(height: 8),
                    if (_logFilePath != null) ...[
                      const Text(
                        'Log File Location:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        _logFilePath!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _demonstrateLogging,
                    child: const Text('Generate Sample Logs'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _loadLogs,
                    child: const Text('Refresh Logs'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clearLogs,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Clear Logs'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Logs display
            Expanded(
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Text(
                            'Recent Logs',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_logs.length} entries',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child:
                          _logs.isEmpty
                              ? const Center(
                                child: Text(
                                  'No logs available\nTap "Generate Sample Logs" to create some logs',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                              : ListView.builder(
                                itemCount: _logs.length,
                                itemBuilder: (context, index) {
                                  final log = _logs[index];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      log,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
            ),

            // Usage example
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Usage Examples',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Replace your print() calls with:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Text(
                        '''// Instead of: print('Hello World');
AppLogger.i('Hello World');

// Instead of: debugPrint('Debug info');
AppLogger.d('Debug info');

// For errors with exceptions:
AppLogger.e('Error occurred', error, stackTrace);''',
                        style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
