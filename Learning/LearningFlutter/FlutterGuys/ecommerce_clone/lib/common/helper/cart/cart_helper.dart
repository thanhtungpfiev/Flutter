import 'package:ecommerce_clone/domain/order/entities/product_ordered_entity.dart';

class CartHelper {
  static double calculateCartSubtotal(List<ProductOrderedEntity> products) {
    double subtotalPrice = 0;
    for (var item in products) {
      subtotalPrice = subtotalPrice + item.totalPrice;
    }
    return subtotalPrice;
  }
}
