import 'package:recipe_app_design/services/api_calls.dart';

class Ingredients {
  final ingredients = [
    'apple',
    'aniz',
    'banana',
    'kiwi',
    'mango',
    'salt',
    'salted',
    'pear',
    'orange',
    'watermelon',
    'flour',
    'eggs'
  ];

  Future<List> matchIngredients(String hint) async {
    try {
      final obj = await callIngredients(hint);
      return obj;
    } catch (e) {
      return null;
    }
  }
}
