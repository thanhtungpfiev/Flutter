import 'package:ecommerce_clone/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.spacing16),
      child: TextField(
        readOnly: true,
        style: TextStyle(fontSize: ResponsiveUtils.font16),
        onTap: () {
          // AppNavigator.push(context, const SearchPage());
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(ResponsiveUtils.spacing12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.responsive(
                mobile: ResponsiveUtils.radius(50),
                desktop: 50.0,
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.responsive(
                mobile: ResponsiveUtils.radius(50),
                desktop: 50.0,
              ),
            ),
          ),
          prefixIcon: SvgPicture.asset(AppVectors.search, fit: BoxFit.none),
          hintText: 'search',
          hintStyle: TextStyle(fontSize: ResponsiveUtils.font16),
        ),
      ),
    );
  }
}
