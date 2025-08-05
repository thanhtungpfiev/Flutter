// import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
// import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_state.dart';
// import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BasicReactiveButton extends StatelessWidget {
//   const BasicReactiveButton({
//     required this.onPressed,
//     this.title = '',
//     this.height,
//     this.width,
//     this.content,
//     super.key,
//   });

//   final VoidCallback onPressed;
//   final String title;
//   final double? height;
//   final double? width;
//   final Widget? content;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BasicReactiveButtonCubit, BasicReactiveButtonState>(
//       builder: (context, state) {
//         if (state is BasicReactiveButtonLoadingState) {
//           return _loading();
//         }
//         return _initial();
//       },
//     );
//   }

//   Widget _loading() {
//     return ElevatedButton(
//       onPressed: null,
//       style: ElevatedButton.styleFrom(
//         minimumSize: Size(
//           width ?? ResponsiveUtils.screenWidth,
//           height ?? ResponsiveUtils.height(50),
//         ),
//       ),
//       child: Container(
//         height: height ?? ResponsiveUtils.height(50),
//         alignment: Alignment.center,
//         child: const CircularProgressIndicator(),
//       ),
//     );
//   }

//   Widget _initial() {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         minimumSize: Size(
//           width ?? ResponsiveUtils.screenWidth,
//           height ?? ResponsiveUtils.height(50),
//         ),
//       ),
//       child:
//           content ??
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w400,
//               fontSize: ResponsiveUtils.fontSize(16),
//             ),
//           ),
//     );
//   }
// }
