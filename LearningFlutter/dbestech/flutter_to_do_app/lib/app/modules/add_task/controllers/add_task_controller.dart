import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/theme_color.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/task_repository.dart';

class AddTaskController extends GetxController {
  final dateSelected = DateTime.now().obs;
  final startTimeSelected = DateFormat("hh:mm a").format(DateTime.now()).obs;
  final endTimeSelected = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(hours: 1)))
      .obs;
  final remindSelected = 5.obs;
  List<int> reminds = [5, 10, 15, 20];
  final repeatSelected = "None".obs;
  List<String> repeats = ["None", "Daily", "Weekly", "Monthly"];
  final colorSelected = 0.obs;
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final taskRepository = Get.put(TaskRepository());

  Future<void> getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2123),
    );

    if (pickerDate != null) {
      dateSelected.value = pickerDate;
    }
  }

  Future<void> getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay(
        hour: int.parse(startTimeSelected.value.split(':')[0]),
        minute: int.parse(startTimeSelected.value.split(':')[1].split(' ')[0]),
      ),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickerTime != null) {
      final localizations = MaterialLocalizations.of(Get.context!);
      if (isStartTime == true) {
        startTimeSelected.value = localizations.formatTimeOfDay(pickerTime,
            alwaysUse24HourFormat: false);
      } else {
        endTimeSelected.value = localizations.formatTimeOfDay(pickerTime,
            alwaysUse24HourFormat: false);
      }
    }
  }

  void validateForm() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      _addTask();
      Get.back();
    } else {
      Get.snackbar(
        'Required',
        'All fields are required!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: ThemeColor.pinkColor,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }

  void _addTask() async {
    var task = Task(
      title: titleController.text,
      note: noteController.text,
      date: DateFormat.yMd().format(dateSelected.value),
      startTime: startTimeSelected.value,
      endTime: endTimeSelected.value,
      remind: remindSelected.value,
      repeat: repeatSelected.value,
      color: colorSelected.value,
      isCompleted: 0,
    );
    await taskRepository.addTaskToDb(task);
  }
}
