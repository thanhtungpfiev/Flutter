import 'package:get/get.dart';

import '../models/data_model.dart';
import '../services/data_service.dart';

class DataController extends GetxController {
  final list = <DataModel>[].obs;
  final service = DataService();
  final isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    // var info = await service.getUsers();
    var info = await service.getBillInfos();
    list.addAll(info);
    isLoading.value = false;
  }

  List<DataModel> get newList =>
      list.where((e) => e.status).map((e) => e).toList();
}
