import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/presentation/settings/widgets/my_favorties_tile_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text(UIConstants.settings)),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.width(16)),
        child: Column(
          children: [
            MyFavoritesTileWidget(),
            SizedBox(height: ResponsiveUtils.height(15)),
            // MyOrdersTile(),
          ],
        ),
      ),
    );
  }
}
