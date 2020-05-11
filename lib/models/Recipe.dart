import 'package:habanero_app/services/api_calls.dart' as api;

class Recipe {
  final int id;
  String title;
  String summary;
  String imageLink;
  String prepTime;
  int mins;
  int likes;
  dynamic steps;
  dynamic ingredients;

  Recipe(this.id) {
    print('creating Recipe');
  }

  void buildRecipe() async {
    var obj;
    try {
      print('trying to fetch recipe from API using id: $id');
      obj = await api.getRecipe(this.id);

      this.title = obj['title'];
      this.summary = obj['summary'];
      //print('summary passed as ${this.summary}');
      this.imageLink = obj['image'];
      this.prepTime = obj['cookingMinutes'].toString();
      this.steps = obj['analyzedInstructions'][0]['steps'];
      this.ingredients = obj['extendedIngredients'];
      this.mins = obj['readyInMinutes'];
      this.likes = obj['aggregateLikes'];
      //print('printing obj from class');
      //print(obj);
    } catch (e) {
      print('failed fetching recipe');
      print(e.toString());
    }
  }
}
