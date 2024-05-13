import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utils/keys.dart';
import '../../models/task.dart';
import '../../services/storage/services.dart';

class TaskProvider {
  final _storageService = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storageService.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storageService.write(taskKey, jsonEncode(tasks));
  }
}
