import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocationCheckingPermissions();
  }

  Future<void> getCurrentLocationCheckingPermissions() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(
          'Location services are disabled. Please activate them.');
    } else {
      locationPermission = await Geolocator.checkPermission();
      if (LocationPermission.unableToDetermine == locationPermission) {
        return Future.error(
            'Unable to determine if location permissions are enabled.');
      } else if (LocationPermission.denied == locationPermission ||
          LocationPermission.deniedForever == locationPermission) {
        print(Future.error('Location permissions are denied: ' +
            locationPermission.toString()));
        try {
          locationPermission = await Geolocator.requestPermission();
        } catch (e) {
          print(e);
        }
      }

      if (LocationPermission.whileInUse == locationPermission ||
          LocationPermission.always == locationPermission) {
        WeatherModel weatherModel = WeatherModel();
        var weatherData = await weatherModel.getWeatherData();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
          );
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
