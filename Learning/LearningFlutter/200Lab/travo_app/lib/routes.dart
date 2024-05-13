import 'package:flutter/material.dart';

import 'representation/screens/hotel_booking_screen.dart';
import 'representation/screens/intro_screen.dart';
import 'representation/screens/main_app_screen.dart';
import 'representation/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainAppScreen.routeName: (context) => const MainAppScreen(),
  HotelBookingScreen.routeName: (context) => const HotelBookingScreen(),
};
