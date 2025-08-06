// import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
// import 'package:ecommerce_clone/common/helper/theme/theme_helper.dart';
// import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
// import 'package:ecommerce_clone/core/constants/ui_constants.dart';
// import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
// import 'package:ecommerce_clone/domain/order/entities/order_entity.dart';
// import 'package:ecommerce_clone/presentation/settings/bloc/orders_display_cubit.dart';
// import 'package:ecommerce_clone/presentation/settings/bloc/orders_display_state.dart';
// import 'package:ecommerce_clone/presentation/settings/pages/order_detail_page.dart';
// import 'package:ecommerce_clone/service_locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MyOrdersPage extends StatelessWidget {
//   const MyOrdersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const BasicAppBar(title: Text(UIConstants.myOrders)),
//       body: BlocProvider(
//         create: (context) => sl<OrdersDisplayCubit>()..displayOrders(),
//         child: BlocBuilder<OrdersDisplayCubit, OrdersDisplayState>(
//           builder: (context, state) {
//             if (state is OrdersDisplayLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state is OrdersDisplayLoadSuccessState) {
//               return _orders(state.orders);
//             }

//             if (state is OrdersDisplayLoadErrorState) {
//               return Center(child: Text(state.errorMessage));
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _orders(List<OrderEntity> orders) {
//     return ListView.separated(
//       padding: EdgeInsets.all(ResponsiveUtils.width(16)),
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             AppNavigator.push(
//               context,
//               OrderDetailPage(orderEntity: orders[index]),
//             );
//           },
//           child: Container(
//             height: ResponsiveUtils.height(70),
//             padding: EdgeInsets.symmetric(
//               horizontal: ResponsiveUtils.width(16),
//             ),
//             decoration: BoxDecoration(
//               color: ThemeHelper.getSecondBackground(context),
//               borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.receipt_rounded),
//                     SizedBox(width: ResponsiveUtils.width(20)),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${UIConstants.orderNumber}${orders[index].code}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: ResponsiveUtils.fontSize(16),
//                           ),
//                         ),
//                         Text(
//                           '${orders[index].products.length} ${orders[index].products.length == 1 ? UIConstants.item : UIConstants.items}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: ResponsiveUtils.fontSize(12),
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const Icon(Icons.arrow_forward_ios_rounded),
//               ],
//             ),
//           ),
//         );
//       },
//       separatorBuilder:
//           (context, index) => SizedBox(height: ResponsiveUtils.height(20)),
//       itemCount: orders.length,
//     );
//   }
// }
