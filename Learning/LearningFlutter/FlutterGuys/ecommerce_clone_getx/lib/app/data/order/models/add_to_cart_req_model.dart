// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:ecommerce_clone/core/constants/order_constants.dart';

// class AddToCartReqModel {
//   final String productId;
//   final String productTitle;
//   final int productQuantity;
//   final String productColor;
//   final String productSize;
//   final double productPrice;
//   final double totalPrice;
//   final String productImage;
//   final String createdDate;

//   AddToCartReqModel({
//     required this.productId,
//     required this.productTitle,
//     required this.productQuantity,
//     required this.productColor,
//     required this.productSize,
//     required this.productPrice,
//     required this.totalPrice,
//     required this.productImage,
//     required this.createdDate,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       OrderConstants.productId: productId,
//       OrderConstants.productTitle: productTitle,
//       OrderConstants.productQuantity: productQuantity,
//       OrderConstants.productColor: productColor,
//       OrderConstants.productSize: productSize,
//       OrderConstants.productPrice: productPrice,
//       OrderConstants.totalPrice: totalPrice,
//       OrderConstants.productImage: productImage,
//       OrderConstants.createdDate: createdDate,
//     };
//   }
// }
