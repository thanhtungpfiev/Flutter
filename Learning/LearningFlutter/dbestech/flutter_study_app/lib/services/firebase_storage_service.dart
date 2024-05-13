import 'package:get/get.dart';

import '../firebase_ref/references.dart';
import '../util/app_logger.dart';

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage
          .child("question_paper_images")
          .child("${imgName.toLowerCase()}.png");
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    } catch (e) {
      AppLogger.logger.e(e);
      return null;
    }
  }
}
