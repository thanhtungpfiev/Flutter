import 'package:flutter/material.dart';

import 'package:travo_app/representation/widgets/app_bar_container.dart';

class HotelBookingScreen extends StatefulWidget {
  static const routeName = '/hotel_booking_screen';

  const HotelBookingScreen({super.key});

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      implementLeading: true,
      title: const Text('Hotel booking'),
      child: Container(),
    );
  }
}
