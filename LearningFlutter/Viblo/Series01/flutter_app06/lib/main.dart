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
    return Scaffold(
      backgroundColor: const Color(0xFF1B5E20), // green
      body: Scaffold(
        backgroundColor: const Color(0xffe91e63), // pink
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(onPressed: () {
            print(Scaffold.of(context).widget.backgroundColor);
          });
        }),
      ),
    );
  }

}