import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/routes/routes.dart';
import '../../../common/values/constants.dart';
import '../../../common/widgets/base_text_widget.dart';
import '../../../global.dart';
import '../../application/bloc/app_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../signin/bloc/sign_in_bloc.dart';

AppBar buildAppBar() {
  return AppBar(
    title: reusableText('Settings'),
    centerTitle: true,
  );
}

Widget settingButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm logout'),
              content: const Text('Confirm logout'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel')),
                TextButton(
                  onPressed: () {
                    context.read<AppBloc>().add(const TriggerAppEvent(0));
                    context.read<HomeBloc>().add(const HomeDotsEvent(0));
                    Global.storageService
                        .remove(AppConstants.storageUserProfileKey);
                    Global.storageService
                        .remove(AppConstants.storageUserTokenKey);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.signIn, (route) => false);
                    context.read<SignInBloc>().add(const EmailEvent(''));
                    context.read<SignInBloc>().add(const PasswordEvent(''));
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          });
    },
    child: Container(
      height: 100.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/icons/Logout.png'),
            fit: BoxFit.fitHeight),
      ),
    ),
  );
}
