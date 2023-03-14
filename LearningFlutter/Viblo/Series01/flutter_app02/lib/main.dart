import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CounterWidget(isLoading: false, counter: 0),
        ),
      ),
    ),
  );
}

class CounterWidget extends StatelessWidget {
  final bool isLoading;
  final int counter;

  const CounterWidget({
    super.key,
    required this.isLoading,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading ? const CircularProgressIndicator() : Text('$counter');
  }
}
