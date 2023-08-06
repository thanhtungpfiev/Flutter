import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/helpers/asset_helper.dart';
import 'package:travo_app/representation/screens/main_app_screen.dart';
import 'package:travo_app/representation/widgets/button_widget.dart';
import 'package:travo_app/representation/widgets/intro_screen_item.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';

  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  final StreamController<int> _streamController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _streamController.add(_pageController.page!.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
              IntroScreenItem(
                image: AssetHelper.imageIntro1,
                title: "Book a flight",
                description:
                    "Found a flight that matches your destination and schedule? Book it instantly.",
                alignment: Alignment.centerRight,
              ),
              IntroScreenItem(
                image: AssetHelper.imageIntro2,
                title: "Find a hotel room",
                description:
                    "Select the day, book your room. We give you the best price.",
                alignment: Alignment.center,
              ),
              IntroScreenItem(
                image: AssetHelper.imageIntro3,
                title: "Enjoy your trip",
                description:
                    "Easy discovering new places and share these between your friends and travel together.",
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          Positioned(
            left: kMediumPadding,
            right: kMediumPadding,
            bottom: kDefaultPadding,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotWidth: kMinPadding,
                      dotHeight: kMinPadding,
                      activeDotColor: Colors.orange,
                    ),
                  ),
                ),
                StreamBuilder<int>(
                    initialData: 0,
                    stream: _streamController.stream,
                    builder: (context, snapshot) {
                      return Expanded(
                        flex: 4,
                        child: ButtonWidget(
                          title: snapshot.data != 2 ? 'Next' : 'Get Started',
                          onTap: () {
                            if (_pageController.page != 2) {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            } else {
                              Navigator.of(context)
                                  .pushNamed(MainAppScreen.routeName);
                            }
                          },
                        ),
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
