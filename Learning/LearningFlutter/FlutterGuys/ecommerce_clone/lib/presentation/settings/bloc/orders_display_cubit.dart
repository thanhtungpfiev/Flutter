import 'package:ecommerce_clone/domain/order/usecases/get_orders_usecase.dart';
import 'package:ecommerce_clone/presentation/settings/bloc/orders_display_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersDisplayCubit extends Cubit<OrdersDisplayState> {
  OrdersDisplayCubit({required this.getOrdersUseCase})
    : super(OrdersDisplayLoadingState());

  final GetOrdersUseCase getOrdersUseCase;

  void displayOrders() async {
    var returnedData = await getOrdersUseCase.call();
    returnedData.fold(
      (error) {
        emit(OrdersDisplayLoadErrorState(errorMessage: error));
      },
      (orders) {
        emit(OrdersDisplayLoadSuccessState(orders: orders));
      },
    );
  }
}
