import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('MyApp build');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  @override
  StatelessElement createElement() {
    print('MyApp createElement');
    return super.createElement();
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print('MyHomePage createState');
    return _MyHomePageState();
  }

  @override
  StatefulElement createElement() {
    print('MyHomePage createElement');
    return super.createElement();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('MyHomePage build');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _counter % 2 == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('You have push the button this many times:'),
                  MyText(counter: _counter),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('You have push the button this many times:'),
                  MyText(counter: _counter),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final int _counter;

  const MyText({super.key, required int counter}) : _counter = counter;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('MyText build');
    return Text(
      '$_counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  @override
  StatelessElement createElement() {
    print('MyText createElement');
    return super.createElement();
  }
}
