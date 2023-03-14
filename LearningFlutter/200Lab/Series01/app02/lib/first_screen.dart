import 'package:flutter/material.dart';
import './second_screen.dart';

class FirstScreen extends StatelessWidget {
  static const routeName = '/first-screen';

  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('First Screen'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            const Text('This is the First Screen'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SecondScreen.routeName);
                },
                child: const Text('GO TO SECOND SCREEN')),
          ],
        ));
  }
}
