import 'package:recipe_app_design/services/api_calls.dart';

class Recipes {
  Future<List> matchRecipes(dynamic ings) async {
    final obj = await callRecipes(ings);
    return obj;
  }
}
