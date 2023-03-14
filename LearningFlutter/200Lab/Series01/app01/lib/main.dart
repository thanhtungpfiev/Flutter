import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First App Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const DummyWidget(),
    );
  }
}

class DummyWidget extends StatefulWidget {
  const DummyWidget({super.key});

  @override
  DummyWidgetState createState() {
    return DummyWidgetState();
  }
}

class DummyWidgetState extends State<DummyWidget> {
  bool _isGreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _isGreen ? Colors.green : Colors.red,
        appBar: AppBar(
          title: const Text('Your First App'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _isGreen = !_isGreen;
                });
              },
              child: Text(_isGreen ? 'TURN RED' : 'TURN GREEN'),
            )
          ],
        )));
  }
}
