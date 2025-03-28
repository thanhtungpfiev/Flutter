import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/sensor_data_generator.dart';

class HomeController extends GetxController {
  var sensors = <Map<String, dynamic>>[].obs;
  var sensorData = <Map<String, dynamic>>[].obs;
  final List<SensorDataGenerator> _generators = [];
  var isRunning = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    for (var generator in _generators) {
      generator.stop();
    }
    super.onClose();
  }

  void addSensor(
    String name,
    double minValue,
    double maxValue,
    int frequency,
    Color color,
  ) {
    final sensor = {
      'name': name,
      'minValue': minValue,
      'maxValue': maxValue,
      'frequency': frequency,
      'color': color,
    };
    sensors.add(sensor);

    final generator = SensorDataGenerator(
      name: name,
      minValue: minValue,
      maxValue: maxValue,
      frequency: frequency,
      color: color,
      onDataGenerated: (data) {
        data['name'] = name; // Include sensor name in the data
        sensorData.add(data);
      },
    );
    _generators.add(generator);

    // Start data generation for the new sensor if already running
    if (isRunning.value) {
      generator.start();
    }
  }

  void removeSensor(String name) {
    final index = sensors.indexWhere((sensor) => sensor['name'] == name);
    if (index != -1) {
      _generators[index].stop();
      _generators.removeAt(index);
      sensors.removeAt(index);
      sensorData.removeWhere((data) => data['name'] == name);
    }
  }

  void startDataGeneration() {
    isRunning.value = true;
    for (var generator in _generators) {
      generator.start();
    }
  }

  void stopDataGeneration() {
    isRunning.value = false;
    for (var generator in _generators) {
      generator.stop();
    }
  }
}
