import 'package:flutter/material.dart';
import 'package:flutter_study_app/controllers/questions_papers/data_uploader.dart';
import 'package:get/get.dart';

import '../../../controllers/questions_papers/loading_status.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({Key? key}) : super(key: key);
  final DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.completed
                ? "Upload completed"
                : "Uploading...")),
      ),
    );
  }
}
