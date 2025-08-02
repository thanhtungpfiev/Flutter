import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';

class ProductPriceHelper {
  static double provideCurrentPrice(ProductEntity product) {
    return product.discountedPrice != 0
        ? product.discountedPrice.toDouble()
        : product.price.toDouble();
  }
}
