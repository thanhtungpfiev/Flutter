import 'package:blog_app/core/services/app_logging_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize logging first
  await AppLoggingService.initialize();
}
