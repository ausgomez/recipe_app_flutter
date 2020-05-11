import 'package:recipe_app_design/services/api_calls.dart';
import 'package:recipe_app_design/models/Recipe.dart';
import 'package:flutter/material.dart';

class Recipes {
  Future<List> matchRecipes(dynamic ings) async {
    try {
      final obj = await callRecipes(ings);
      return obj;
    } catch (e) {
      return null;
    }
  }

  Future<List> randomRecipes(int size) async {
    List<Recipe> recipes = List<Recipe>();

    try {
      final objs = await callRandomRecipes(size);
      print('passed objs');

      objs.forEach((obj) {
        var rec = new Recipe(obj["id"]);

        rec.title = obj["title"];
        rec.summary = obj["summary"];
        rec.imageLink = obj["image"];
        rec.prepTime = obj["readyInMinutes"].toString();

        recipes.add(rec);

        //print(rec);
        //print('recipe added!');
      });

      //print('recipes ready');
      //print(recipes);
      return recipes;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List> searchForRecipesByName(String query) async {
    try {
      final obj = await searchRecipesByQuery(query);
      print('recipes.dart returned an objet JSON 🖖🏻');
      return obj;
    } catch (e) {
      print('Uh oh! ERROR 🛑');
      print(e.toString());
      return e;
    }
  }

  Future<List> getRecipesByCuisine(String cuisine) async {
    try {
      final obj = await findRecipesByCuisine(cuisine);
      print('recipes.dart returned an objet JSON 🖖🏻');
      return obj;
    } catch (e) {
      print('Uh oh! ERROR 🛑');
      print(e.toString());
      return e;
    }
  }
}
