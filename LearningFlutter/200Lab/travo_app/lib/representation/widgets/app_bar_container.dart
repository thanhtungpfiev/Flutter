import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dimension_constants.dart';
import '../../helpers/asset_helper.dart';
import '../../helpers/image_helper.dart';

class AppBarContainerWidget extends StatelessWidget {
  final Widget child;
  final Widget? title;
  final bool implementLeading;
  final bool implementTrailing;

  const AppBarContainerWidget({
    super.key,
    required this.child,
    this.title,
    this.implementLeading = false,
    this.implementTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 186,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 90,
              backgroundColor: ColorPalette.backgroundScaffoldColor,
              title: Row(
                children: [
                  if (implementLeading)
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(kDefaultPadding),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(kItemPadding),
                      child: const Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.black,
                        size: kDefaultIconSize,
                      ),
                    ),
                  Expanded(
                    child: title!,
                  ),
                  if (implementTrailing)
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(kDefaultPadding),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(kItemPadding),
                      child: const Icon(
                        FontAwesomeIcons.bars,
                        color: Colors.black,
                        size: kDefaultIconSize,
                      ),
                    ),
                ],
              ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: Gradients.defaultBackgroundGradient,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(kDefaultPadding),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ImageHelper.loadFromAssets(AssetHelper.imageOval1),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ImageHelper.loadFromAssets(AssetHelper.imageOval2),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 156),
            padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            child: child,
          ),
        ],
      ),
    );
  }
}
