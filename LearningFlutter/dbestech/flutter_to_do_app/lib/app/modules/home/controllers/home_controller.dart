import 'package:get/get.dart';

import '../../../core/utils/helpers/local_notification_helper.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/task_repository.dart';

class HomeController extends GetxController {
  final localNotificationHelper = LocalNotificationHelper();
  final taskRepository = Get.put(TaskRepository());
  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    localNotificationHelper.initializeNotification();
    localNotificationHelper.requestAndroidPermissions();
  }

  @override
  void onReady() {
    super.onReady();
    getAllTasks();
  }

  void getAllTasks() async {
    await taskRepository.getAllTasksFromDb();
  }

  void updateTask(Task oldTask, Task newTask) async {
    await taskRepository.updateTaskToDb(oldTask, newTask);
  }

  void deleteTask(Task task) async {
    await taskRepository.deleteTaskFromDb(task);
  }

  void updateSelectedDate(DateTime value) {
    selectedDate.value = value;
    refreshTaskList();
  }

  void refreshTaskList() {
    taskRepository.refreshTaskList();
  }
}
