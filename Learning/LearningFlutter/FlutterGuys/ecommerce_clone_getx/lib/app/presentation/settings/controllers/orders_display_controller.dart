import 'package:ecommerce_clone_getx/app/domain/order/entities/order_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/order/usecases/get_orders_usecase.dart';
import 'package:get/get.dart';

enum OrdersDisplayState { initial, loading, success, error }

class OrdersDisplayController extends GetxController {
  OrdersDisplayController({required this.getOrdersUseCase});

  final GetOrdersUseCase getOrdersUseCase;

  final state = OrdersDisplayState.initial.obs;
  final orders = <OrderEntity>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    displayOrders();
  }

  Future<void> displayOrders() async {
    state.value = OrdersDisplayState.loading;
    errorMessage.value = '';
    var returnedData = await getOrdersUseCase.call();
    returnedData.fold(
      (error) {
        state.value = OrdersDisplayState.error;
        errorMessage.value = error;
        orders.clear();
      },
      (data) {
        state.value = OrdersDisplayState.success;
        orders.assignAll(data);
      },
    );
  }
}
