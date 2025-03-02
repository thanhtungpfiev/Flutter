import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SensorDataGenerator {
  final String name;
  final double minValue;
  final double maxValue;
  final int frequency;
  final Color color;
  final Function(Map<String, dynamic>) onDataGenerated;

  Timer? _timer;
  final Random _random = Random();

  SensorDataGenerator({
    required this.name,
    required this.minValue,
    required this.maxValue,
    required this.frequency,
    required this.color,
    required this.onDataGenerated,
  });

  void start() {
    _timer = Timer.periodic(Duration(milliseconds: frequency), (timer) {
      final data = {
        'time': DateTime.now(),
        'value': minValue + _random.nextDouble() * (maxValue - minValue),
      };
      onDataGenerated(data);
    });
  }

  void stop() {
    _timer?.cancel();
  }
}
