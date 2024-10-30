class Recipe {
  String id;
  String title;
  List<String> ingredients;
  List<String> steps;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.steps,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'ingredients': ingredients,
      'steps': steps,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map, String id) {
    return Recipe(
      id: id,
      title: map['title'],
      ingredients: List<String>.from(map['ingredients']),
      steps: List<String>.from(map['steps']),
    );
  }
}
