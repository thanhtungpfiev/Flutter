import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/values/text_styles.dart';
import '../../../global_widgets/my_button.dart';
import '../../../global_widgets/my_custom_appbar.dart';
import '../../../global_widgets/my_input_field.dart';
import '../controllers/add_task_controller.dart';
import '../local_widgets/add_task_color_scheme.dart';

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        onTap: () => Get.back(),
        child: const Icon(Icons.arrow_back_ios),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Tasks',
                style: TextStyles.defaultStyle.headingStyle,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter title here.",
                controller: controller.titleController,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter note here.",
                controller: controller.noteController,
              ),
              Obx(() {
                return MyInputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(controller.dateSelected.value),
                  widget: IconButton(
                    onPressed: () {
                      controller.getDateFromUser();
                    },
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ),
                );
              }),
              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return MyInputField(
                        title: "Start Time",
                        hint: controller.startTimeSelected.value,
                        widget: IconButton(
                          onPressed: () {
                            controller.getTimeFromUser(isStartTime: true);
                          },
                          icon: const Icon(
                            Icons.access_time_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Obx(() {
                      return MyInputField(
                        title: "End Time",
                        hint: controller.endTimeSelected.value,
                        widget: IconButton(
                          onPressed: () {
                            controller.getTimeFromUser(isStartTime: false);
                          },
                          icon: const Icon(
                            Icons.access_time_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Obx(() {
                return MyInputField(
                  title: 'Remind',
                  hint: '${controller.remindSelected.value} minutes early',
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: TextStyles.defaultStyle.subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    items: controller.reminds
                        .map((e) => DropdownMenuItem(
                              value: e.toString(),
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.remindSelected.value = int.parse(value!);
                    },
                  ),
                );
              }),
              Obx(() {
                return MyInputField(
                  title: 'Repeat',
                  hint: controller.repeatSelected.value,
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: TextStyles.defaultStyle.subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    items: controller.repeats
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.repeatSelected.value = value!;
                    },
                  ),
                );
              }),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: AddTaskColorScheme(),
                  ),
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        controller.validateForm();
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
