import 'dart:async';

class Recipe {
  String name;
  String desc;

  Recipe(String name, String desc) {
    this.name = name;
    this.desc = desc;
  }
}

StreamController<Recipe> recipesController = StreamController<Recipe>();
Stream recipesStream = recipesController.stream;

void addRecipe(String name, String desc) async {
  recipesController.add(new Recipe(name, desc));
}
