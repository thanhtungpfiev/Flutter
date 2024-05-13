import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/helpers/asset_helper.dart';
import 'package:travo_app/helpers/image_helper.dart';
import 'package:travo_app/representation/screens/hotel_booking_screen.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/home_screen_categorty_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      implementLeading: false,
      implementTrailing: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi Jame!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: kMediumPadding,
                ),
                Text(
                  'Where are you going next?',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              FontAwesomeIcons.bell,
              size: kDefaultIconSize,
              color: Colors.white,
            ),
            const SizedBox(
              width: kTopPadding,
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  kItemPadding,
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(kMinPadding),
              child: ImageHelper.loadFromAssets(AssetHelper.imageAvatar),
            )
          ],
        ),
      ),
      child: Container(
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search your destination',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(
                    kTopPadding,
                  ),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                    size: kDefaultIconSize,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      kItemPadding,
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: kItemPadding,
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: HomeScreenCategoryItem(
                    icon: ImageHelper.loadFromAssets(
                      AssetHelper.iconHotel,
                      width: kMediumPadding,
                      height: kMediumPadding,
                    ),
                    color: const Color(0xffFE9C5E),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(HotelBookingScreen.routeName);
                    },
                    title: 'Hotels',
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding,
                ),
                Expanded(
                  child: HomeScreenCategoryItem(
                    icon: ImageHelper.loadFromAssets(
                      AssetHelper.iconFlight,
                      width: kMediumPadding,
                      height: kMediumPadding,
                    ),
                    color: const Color(0xffF77777),
                    onTap: () {},
                    title: 'Flights',
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding,
                ),
                Expanded(
                  child: HomeScreenCategoryItem(
                    icon: ImageHelper.loadFromAssets(
                      AssetHelper.iconHotelAndFlight,
                      width: kMediumPadding,
                      height: kMediumPadding,
                    ),
                    color: const Color(0xff3EC8BC),
                    onTap: () {},
                    title: 'All',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
