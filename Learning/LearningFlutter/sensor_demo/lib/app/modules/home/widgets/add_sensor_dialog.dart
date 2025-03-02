import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class AddSensorDialog extends StatefulWidget {
  final Function(String, double, double, int, Color) onAddSensor;

  const AddSensorDialog({required this.onAddSensor, super.key});

  @override
  _AddSensorDialogState createState() => _AddSensorDialogState();
}

class _AddSensorDialogState extends State<AddSensorDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _minValueController = TextEditingController();
  final TextEditingController _maxValueController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  Color _selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Sensor'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _minValueController,
              decoration: InputDecoration(labelText: 'Min Value'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxValueController,
              decoration: InputDecoration(labelText: 'Max Value'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _frequencyController,
              decoration: InputDecoration(labelText: 'Frequency (ms)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Color:'),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    Color? pickedColor = await showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: _selectedColor,
                                onColorChanged: (color) {
                                  setState(() {
                                    _selectedColor = color;
                                  });
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Select'),
                                onPressed: () {
                                  Navigator.of(context).pop(_selectedColor);
                                },
                              ),
                            ],
                          ),
                    );
                    if (pickedColor != null) {
                      setState(() {
                        _selectedColor = pickedColor;
                      });
                    }
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final name = _nameController.text;
            final minValue = double.parse(_minValueController.text);
            final maxValue = double.parse(_maxValueController.text);
            final frequency = int.parse(_frequencyController.text);
            widget.onAddSensor(
              name,
              minValue,
              maxValue,
              frequency,
              _selectedColor,
            );
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
