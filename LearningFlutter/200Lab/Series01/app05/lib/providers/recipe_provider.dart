import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes {
    return [..._recipes];
  }

  Future<Recipe?> fetchAndSetRecipes() async {
    const url = 'https://bakeology-alpha-stage.herokuapp.com/user/recipes';
    try {
      final response = await http.get(url as Uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Recipe> loadedRecipes = [];
      extractedData['recipes'].forEach((recipeData) {
        loadedRecipes.add(
          Recipe(
              id: recipeData["_id"],
              title: recipeData["title"],
              duration: recipeData["duration"],
              imageUrl: recipeData["imageUrl"],
              affordability: recipeData["affordability"],
              isVegetarian: recipeData["isVegetarian"],
              steps: recipeData["steps"],
              categories: recipeData["categories"],
              chef: recipeData["chef"]["_id"],
              chefName: recipeData["chef"]["name"],
              chefImageUrl: recipeData["chef"]["profileImageUrl"],
              complexity: recipeData["complexity"],
              ingredients: recipeData["ingredients"]),);
      });
      _recipes = loadedRecipes;
      notifyListeners();
    } catch(error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
    return null;
  }
}
