import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('All Recipes'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          RecipeList(),
        ],
      ),
    );
  }

}