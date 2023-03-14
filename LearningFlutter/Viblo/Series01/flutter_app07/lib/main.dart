import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyHomePage(isLoading: false, counter: 0, child: MyCenterWidget(),),
  ));
}

class MyHomePage extends StatefulWidget {
  final bool isLoading;
  final int counter;
  final Widget child;

  const MyHomePage({super.key, required this.isLoading, required this.counter, required this.child});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  late bool _isLoading;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    _counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('rebuild MyHomePage');
    return Scaffold(
      body: MyInheritedWidget(
        isLoading: _isLoading,
        counter: _counter,
        child: widget.child,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFloatingButtonClicked,
      ),
    );
  }

  void onFloatingButtonClicked() {
    print('Button clicked!. Call setState method');
    setState(() {
      _counter++;
      if (_counter % 2 == 0) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
    });
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  // const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('rebuild CounterWidget');
    final myInheritedWidget = MyInheritedWidget.of(context);

    if (myInheritedWidget == null) {
      return const Text('MyInheritedWidget was not found');
    }

    return myInheritedWidget.isLoading
        ? const CircularProgressIndicator()
        : Text('${myInheritedWidget.counter}');
  }
}

class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({super.key});

  // const MyCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('rebuild MyCenterWidget');
    return const Center(
      child: CounterWidget(),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final bool isLoading;
  final int counter;
  @override
  final Widget child;

  const MyInheritedWidget(
      {super.key,
      required this.isLoading,
      required this.counter,
      required this.child})
      : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget  oldWidget) {
    // TODO: implement updateShouldNotify
    return isLoading != oldWidget.isLoading || counter != oldWidget.counter;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
