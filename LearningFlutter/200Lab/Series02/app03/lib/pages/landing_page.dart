import 'package:app03/pages/home_page.dart';
import 'package:app03/values/app_assets.dart';
import 'package:flutter/material.dart';

import 'package:app03/values/app_colors.dart';
import 'package:app03/values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Welcome to',
                style: AppStyles.h3,
              ),
            )),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'English',
                      style: AppStyles.h2.copyWith(
                          color: AppColors.blackGrey,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Quotes"',
                        textAlign: TextAlign.right,
                        style: AppStyles.h4.copyWith(height: 0.5),
                      ),
                    )
                  ],
                )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 72.0),
              child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  },
                  shape: const CircleBorder(),
                  fillColor: AppColors.lightBlue,
                  child: Image.asset(AppAssets.rightArrow)),
            )),
          ],
        ),
      ),
    );
  }
}
