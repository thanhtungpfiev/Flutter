import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import '../widgets/add_sensor_dialog.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddSensorDialog(
                      onAddSensor: (
                        name,
                        minValue,
                        maxValue,
                        frequency,
                        color,
                      ) {
                        controller.addSensor(
                          name,
                          minValue,
                          maxValue,
                          frequency,
                          color,
                        );
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Add Sensor'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.sensors.isEmpty) {
                  return Center(
                    child: Text(
                      'No Sensor',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.sensors.length,
                          itemBuilder: (context, index) {
                            final sensor = controller.sensors[index];
                            return Card(
                              child: ListTile(
                                title: Text(sensor['name']),
                                subtitle: Text(
                                  'Min: ${sensor['minValue']} | Max: ${sensor['maxValue']} | Frequency: ${sensor['frequency']} ms',
                                ),
                                leading: Icon(
                                  Icons.sensors,
                                  color: sensor['color'],
                                ),
                                trailing: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: sensor['color'],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child:
                            controller.sensorData.isEmpty
                                ? Center(
                                  child: Text(
                                    'No Data',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                                : LineChart(
                                  LineChartData(
                                    lineBarsData:
                                        controller.sensors.map((sensor) {
                                          final sensorName = sensor['name'];
                                          final sensorData =
                                              controller.sensorData
                                                  .where(
                                                    (data) =>
                                                        data['name'] ==
                                                        sensorName,
                                                  )
                                                  .toList();
                                          final color = sensor['color'];
                                          return LineChartBarData(
                                            spots:
                                                sensorData.map((point) {
                                                  final time =
                                                      point['time'] as DateTime;
                                                  final value =
                                                      point['value'] as double;
                                                  return FlSpot(
                                                    time.millisecondsSinceEpoch
                                                        .toDouble(),
                                                    value,
                                                  );
                                                }).toList(),
                                            isCurved: true,
                                            color: color,
                                            barWidth: 2,
                                            belowBarData: BarAreaData(
                                              show: false,
                                            ),
                                            dotData: FlDotData(show: true),
                                          );
                                        }).toList(),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        axisNameWidget: Text(
                                          'Time',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize:
                                              50, // Increase reserved size to prevent overlap
                                          getTitlesWidget: (value, meta) {
                                            final date =
                                                DateTime.fromMillisecondsSinceEpoch(
                                                  value.toInt(),
                                                );
                                            final formattedDate = DateFormat(
                                              'HH:mm:ss.SSS',
                                            ).format(date);
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: RotatedBox(
                                                quarterTurns: 3,
                                                child: Text(
                                                  formattedDate,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        10, // Adjust font size to prevent overlap
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        axisNameWidget: Text(
                                          'Value',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize:
                                              50, // Increase reserved size to prevent overlap
                                          getTitlesWidget: (value, meta) {
                                            if (value % 100 == 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 8.0,
                                                ),
                                                child: Text(
                                                  value.toInt().toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        10, // Adjust font size to prevent overlap
                                                  ),
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    gridData: FlGridData(show: true),
                                    // Enable zooming and panning
                                    lineTouchData: LineTouchData(
                                      touchTooltipData: LineTouchTooltipData(
                                        getTooltipItems: (touchedSpots) {
                                          return touchedSpots.map((
                                            touchedSpot,
                                          ) {
                                            final date =
                                                DateTime.fromMillisecondsSinceEpoch(
                                                  touchedSpot.x.toInt(),
                                                );
                                            final formattedDate = DateFormat(
                                              'HH:mm:ss.SSS',
                                            ).format(date);
                                            return LineTooltipItem(
                                              '${touchedSpot.y}\n$formattedDate',
                                              const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            );
                                          }).toList();
                                        },
                                      ),
                                      touchCallback: (
                                        FlTouchEvent event,
                                        LineTouchResponse? touchResponse,
                                      ) {
                                        // if (touchResponse != null &&
                                        //     touchResponse.lineBarSpots !=
                                        //         null) {
                                        //   final touchedSpot =
                                        //       touchResponse.lineBarSpots!.first;
                                        //   final date =
                                        //       DateTime.fromMillisecondsSinceEpoch(
                                        //         touchedSpot.x.toInt(),
                                        //       );
                                        //   final formattedDate = DateFormat(
                                        //     'HH:mm:ss.SSS',
                                        //   ).format(date);
                                        //   print(
                                        //     'Touched spot: ${touchedSpot.y} at $formattedDate',
                                        //   );
                                        //   // You can update the UI or display a message here
                                        // }
                                      },
                                      handleBuiltInTouches: true,
                                      enabled:
                                          true, // Enable touch interactions
                                      touchSpotThreshold:
                                          10, // Adjust threshold for better touch handling
                                    ),
                                    extraLinesData: ExtraLinesData(
                                      horizontalLines: [
                                        HorizontalLine(
                                          y: 0,
                                          color: Colors.black,
                                          strokeWidth: 1,
                                        ),
                                      ],
                                    ),
                                    minX:
                                        controller
                                            .sensorData
                                            .first['time']
                                            .millisecondsSinceEpoch
                                            .toDouble(),
                                    maxX:
                                        controller
                                            .sensorData
                                            .last['time']
                                            .millisecondsSinceEpoch
                                            .toDouble(),
                                    minY:
                                        controller.sensorData
                                            .map(
                                              (point) =>
                                                  point['value'] as double,
                                            )
                                            .reduce((a, b) => a < b ? a : b) -
                                        10, // Adjust minY for better panning
                                    maxY:
                                        controller.sensorData
                                            .map(
                                              (point) =>
                                                  point['value'] as double,
                                            )
                                            .reduce((a, b) => a > b ? a : b) +
                                        10, // Adjust maxY for better panning
                                    clipData:
                                        FlClipData.all(), // Allow panning beyond chart boundaries
                                  ),
                                ),
                      ),
                    ],
                  );
                }
              }),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controller.startDataGeneration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: controller.stopDataGeneration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
