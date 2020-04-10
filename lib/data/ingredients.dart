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
    return ingredients.where((element) => element.contains(hint)).toList();
  }
}
