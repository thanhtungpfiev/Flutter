import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      floatingActionButton: MyButtonWidget(),
    );
  }
}

class MyButtonWidget extends StatelessWidget {
  const MyButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Scaffold.of(context).showBottomSheet(
          (context) => const Text('Flutter From Zero to Hero'),
        );
      },
    );
  }
}
