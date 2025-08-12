// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_clone/core/constants/order_constants.dart';

// class OrderStatusModel {
//   final String title;
//   final bool done;
//   final Timestamp createdDate;

//   OrderStatusModel({
//     required this.title,
//     required this.done,
//     required this.createdDate,
//   });

//   factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
//     return OrderStatusModel(
//       title: map[OrderConstants.title] as String,
//       done: map[OrderConstants.done] as bool,
//       createdDate: map[OrderConstants.createdDate] as Timestamp,
//     );
//   }
// }
