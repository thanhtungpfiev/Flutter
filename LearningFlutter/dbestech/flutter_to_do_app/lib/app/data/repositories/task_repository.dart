import 'package:get/get.dart';

import '../models/task.dart';
import '../providers/db_provider.dart';

class TaskRepository extends GetxController {
  final allTasks = <Task>[].obs;

  Future<void> getAllTasksFromDb() async {
    var tasks = await DBProvider.readAllTasks();
    allTasks.assignAll(tasks.map((e) => Task.fromMap(e)).toList());
    print('getTasks ${tasks.length}');
    print('getAllTasks ${allTasks.length}');
  }

  Future<int> addTaskToDb(Task task) async {
    int id = -1;
    await DBProvider.createTask(task).then((value) => id = value);
    if (id != -1) {
      allTasks.add(task.copyWith(id: id));
    }
    return id;
  }

  Future<int> updateTaskToDb(Task oldTask, Task newTask) async {
    int id = -1;
    await DBProvider.updateTask(newTask).then((value) => id = value);
    if (id != -1) {
      allTasks[allTasks.indexOf(oldTask)] = newTask;
    }
    return id;
  }

  Future<int> deleteTaskFromDb(Task task) async {
    int id = -1;
    await DBProvider.deleteTask(task).then((value) => id = value);
    if (id != -1) {
      allTasks.remove(task);
    }
    return id;
  }

  void refreshTaskList() {
    allTasks.refresh();
  }
}
