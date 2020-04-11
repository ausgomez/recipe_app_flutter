import 'package:recipe_app_design/services/api_calls.dart';

class Recipes {
  Future<List> matchRecipes(dynamic ings) async {
    try {
      final obj = await callRecipes(ings);
      return obj;
    } catch (e) {
      return null;
    }
  }
}
