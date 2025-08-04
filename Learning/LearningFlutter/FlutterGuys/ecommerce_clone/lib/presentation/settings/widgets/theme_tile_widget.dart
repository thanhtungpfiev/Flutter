import 'package:ecommerce_clone/common/utils/theme_utils.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/presentation/settings/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeTileWidget extends StatelessWidget {
  const ThemeTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;

        return GestureDetector(
          onTap: () {
            context.read<ThemeCubit>().toggleTheme();
          },
          child: Container(
            height: ResponsiveUtils.height(70),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.width(16),
            ),
            decoration: BoxDecoration(
              color: ThemeUtils.getSecondBackground(context),
              borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      size: ResponsiveUtils.width(24),
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                    SizedBox(width: ResponsiveUtils.width(12)),
                    Text(
                      UIConstants.theme,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: ResponsiveUtils.fontSize(16),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      isDarkMode ? UIConstants.darkMode : UIConstants.lightMode,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: ResponsiveUtils.fontSize(14),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[400]
                                : Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: ResponsiveUtils.width(8)),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: ResponsiveUtils.width(16),
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[400]
                              : Colors.grey[600],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
