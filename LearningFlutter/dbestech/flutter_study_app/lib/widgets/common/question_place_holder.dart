import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class QuestionPlaceHolder extends StatelessWidget {
  const QuestionPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: 12.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
      width: double.infinity,
      height: 50.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.blueGrey.withOpacity(0.5),
      child: EasySeparatedColumn(
        separatorBuilder: ((context, index) {
          return const SizedBox(
            height: 20,
          );
        }),
        children: [
          EasySeparatedColumn(
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 10,
              );
            }),
            children: [
              line,
              line,
              line,
            ],
          ),
          answer,
          answer,
          answer,
        ],
      ),
    );
  }
}
