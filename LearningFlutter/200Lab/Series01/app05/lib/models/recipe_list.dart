import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './recipe.dart';

import '../providers/recipe_provider.dart';

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<RecipeProvider>(context, listen: false)
        .fetchAndSetRecipes()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeData = Provider.of<RecipeProvider>(context);
    final fetchedRecipes = recipeData.recipes;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: fetchedRecipes.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: RecipeListItem(
                  recipeId: fetchedRecipes[i].id,
                  recipeTitle: fetchedRecipes[i].title,
                  recipeImageUrl: fetchedRecipes[i].imageUrl,
                  chefName: fetchedRecipes[i].chefName,
                  chefImageUrl: fetchedRecipes[i].chefImageUrl,
                  isVegetarian: fetchedRecipes[i].isVegetarian,
                  duration: fetchedRecipes[i].duration,
                ),
              ),
            ),
          );
  }
}
