import 'package:flutter/material.dart';
import 'package:app03/models/english_today.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;

  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'English today',
          style:
              AppStyles.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      // body: GridView.count(
      //   padding: const EdgeInsets.symmetric(horizontal: 8),
      //   crossAxisCount: 2,
      //   mainAxisSpacing: 8,
      //   crossAxisSpacing: 8,
      //   children: words
      //       .map((e) => Container(
      //           alignment: Alignment.center,
      //           decoration: const BoxDecoration(
      //               color: AppColors.primaryColor,
      //               borderRadius: BorderRadius.all(Radius.circular(8))),
      //           child: AutoSizeText(
      //             e.noun ?? '',
      //             style: AppStyles.h3.copyWith(shadows: [
      //               const BoxShadow(
      //                   color: Colors.black38,
      //                   offset: Offset(3, 6),
      //                   blurRadius: 6)
      //             ]),
      //             maxLines: 1,
      //             overflow: TextOverflow.fade,
      //           )))
      //       .toList(),
      // ),
      body: ListView.builder(
          itemCount: words.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: (index % 2 == 0)
                      ? AppColors.primaryColor
                      : AppColors.secondColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  words[index].noun ?? '',
                  style: (index % 2 == 0)
                      ? AppStyles.h4
                      : AppStyles.h4.copyWith(color: AppColors.textColor),
                ),
                subtitle: Text(words[index].quote ?? ''),
                leading: Icon(Icons.favorite,
                    color: words[index].isFavorite ? Colors.red : Colors.grey),
              ),
            );
          }),
    );
  }
}
