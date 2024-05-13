import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:getx_todo_list/app/modules/report/views/report_view.dart';
import '../../../core/utils/extension.dart';
import '../../../data/models/task.dart';
import '../widgets/add_dialog.dart';
import '../widgets/task_card.dart';

import '../../../core/values/color.dart';
import '../controllers/home_controller.dart';
import '../widgets/add_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.sp),
                    child: Text(
                      'My List',
                      style: TextStyle(
                          fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable(
                                  data: element,
                                  onDragStarted: () =>
                                      controller.changeIsDeleting(true),
                                  onDraggableCanceled: (velocity, offset) =>
                                      controller.changeIsDeleting(false),
                                  onDragEnd: (details) =>
                                      controller.changeIsDeleting(false),
                                  feedback: Opacity(
                                    opacity: 0.8,
                                    child: TaskCard(task: element),
                                  ),
                                  child: TaskCard(task: element)),
                            )
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ReportPage()
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(builder: (BuildContext context,
          List<Object?> candidateData, List<dynamic> rejectedData) {
        return Obx(
          () => FloatingActionButton(
            backgroundColor: controller.isDeleting.value ? Colors.red : blue,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(() => AddDialog(), transition: Transition.downToUp);
              } else {
                EasyLoading.showInfo('Please create your task type');
              }
            },
            child: Icon(controller.isDeleting.value ? Icons.delete : Icons.add),
          ),
        );
      }, onAccept: (Task task) {
        controller.deleteTask(task);
        EasyLoading.showSuccess('Successfully deleted');
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(() => BottomNavigationBar(
                onTap: (int index) => controller.changeTabIndex(index),
                currentIndex: controller.tabIndex.value,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Padding(
                      padding: EdgeInsets.only(right: 15.0.wp),
                      child: const Icon(Icons.apps),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Report',
                    icon: Padding(
                      padding: EdgeInsets.only(left: 15.0.wp),
                      child: const Icon(Icons.data_usage),
                    ),
                  )
                ])),
      ),
    );
  }
}
