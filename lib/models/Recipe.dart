import 'package:recipe_app_design/services/api_calls.dart' as api;

class Recipe {
  final int id;
  String title;
  String summary;
  String imageLink;
  String prepTime;
  dynamic steps;

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
      //print('printing obj from class');
      //print(obj);
    } catch (e) {
      print('failed fetching recipe');
      print(e.toString());
    }
  }
}
