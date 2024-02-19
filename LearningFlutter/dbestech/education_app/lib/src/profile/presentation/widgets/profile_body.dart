import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/profile/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    infoThemColour: Colours.physicsTileColour,
                    infoIcon: const Icon(
                      IconlyLight.document,
                      size: 24,
                      color: Color(0xFF767DFF),
                    ),
                    infoTitle: 'Courses',
                    infoValue: user!.enrolledCourseIds.length.toString(),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: UserInfoCard(
                    infoThemColour: Colours.languageTileColour,
                    infoIcon: Image.asset(
                      MediaRes.scoreboard,
                      width: 24,
                      height: 24,
                    ),
                    infoTitle: 'Score',
                    infoValue: user.points.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    infoThemColour: Colours.biologyTileColour,
                    infoIcon: const Icon(
                      IconlyLight.user,
                      size: 24,
                      color: Color(0xFF56AEFF),
                    ),
                    infoTitle: 'Followers',
                    infoValue: user.followers.length.toString(),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: UserInfoCard(
                    infoThemColour: Colours.chemistryTileColour,
                    infoIcon: const Icon(
                      IconlyLight.user,
                      size: 24,
                      color: Color(0xFFFF84AA),
                    ),
                    infoTitle: 'Following',
                    infoValue: user.following.length.toString(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
