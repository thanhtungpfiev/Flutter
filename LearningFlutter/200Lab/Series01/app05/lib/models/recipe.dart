class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final List<dynamic> ingredients;
  final List<dynamic> categories;
  final List<dynamic> steps;
  final String chef;
  final String chefName;
  final String chefImageUrl;
  final String complexity;
  final String affordability;
  final bool isVegetarian;

  Recipe(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.duration,
      required this.ingredients,
      required this.categories,
      required this.steps,
      required this.chef,
      required this.chefName,
      required this.chefImageUrl,
      required this.complexity,
      required this.affordability,
      required this.isVegetarian});
}
