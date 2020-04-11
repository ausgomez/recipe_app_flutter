import 'package:flutter/material.dart';
import 'package:recipe_app_design/models/Recipe.dart';
import 'package:flutter_html/flutter_html.dart';

class RecipePage extends StatefulWidget {
  RecipePage(this.id);
  final int id;
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  dynamic recipe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillingLocalRecipe();
  }

  Future<void> fillingLocalRecipe() async {
    print('filling Local recipe');
    final res = Recipe(widget.id);
    await res.buildRecipe();
    setState(() {
      recipe = res;
    });
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: recipe != null
          ? Center(
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(recipe.imageLink),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    recipe.title + '\n' + recipe.id.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: Html(
                      data: recipe.summary,
                    ),
                  ),
                ],
              ),
            )
          : Center(child: Text('loading...')),
    );
  }
}
