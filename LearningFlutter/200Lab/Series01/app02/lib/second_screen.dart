import 'package:flutter/material.dart';
import './first_screen.dart';

class SecondScreen extends StatelessWidget {
  static const routeName = '/second-screen';

  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Second Screen'),
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
            const Text('This is the second screen!'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(FirstScreen.routeName);
                },
                child: const Text('BACK TO FIRST SCREEN')),
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: const Text('BACK USING POP METHOD')),
          ],
        ));
  }
}
