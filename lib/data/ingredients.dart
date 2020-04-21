import 'package:recipe_app_design/services/api_calls.dart';

class Ingredients {
  Future<List> matchIngredients(String hint) async {
    try {
      final obj = await callIngredients(hint);
      return obj;
    } catch (e) {
      return null;
    }
  }
}
