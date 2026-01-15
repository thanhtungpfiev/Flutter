import 'package:blog_app/core/services/network/connection_checker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;
  ConnectionCheckerImpl({required this.internetConnection});

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}
