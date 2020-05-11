import 'package:flutter/material.dart';
import 'package:recipe_app_design/models/Recipe.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:recipe_app_design/screens/loading.dart';
import 'package:recipe_app_design/services/color_generator.dart' as cg;

class RecipePage extends StatefulWidget {
  /* To build a recipe page, a valid recipe ID must be provided */
  RecipePage(this.id);
  final int id;
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Recipe recipe;

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
      print(recipe);
    });
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return recipe != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(recipe.title),
            ),
            body: Center(
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
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text(
                          recipe.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 90,
                              child: Column(
                                children: [
                                  Container(
                                      height: 50,
                                      child: RaisedButton(
                                        elevation: 20,
                                        color: Colors.blue[400],
                                        child: Icon(
                                          Icons.access_time,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => {},
                                        shape: CircleBorder(),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10)),
                                  Text(
                                    '${recipe.mins} min',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 90,
                              child: Column(
                                children: [
                                  Container(
                                      height: 50,
                                      child: RaisedButton(
                                        elevation: 20,
                                        color: Colors.blue[400],
                                        child: Icon(
                                          Icons.thumb_up,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => {},
                                        shape: CircleBorder(),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10)),
                                  Text(
                                    recipe.likes.toString() + ' likes',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 90,
                              child: Column(
                                children: [
                                  Container(
                                      height: 50,
                                      child: RaisedButton(
                                        elevation: 20,
                                        color: Colors.blue[400],
                                        child: Icon(
                                          Icons.bookmark_border,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => {},
                                        shape: CircleBorder(),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10)),
                                  Text(
                                    'Save',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  recipe.steps != null
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Ingredients',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ingsTabs(recipe.ingredients),
                              //Text(recipe.ingredients.toString()),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  'Steps',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              stepsTabs(recipe.steps),
                              //stepsTabs(4)
                              //Text(recipe.steps['steps'].toString())
                            ],
                          ),
                        )
                      : Center(
                          child: Text(
                          'No Steps available',
                          style: TextStyle(fontSize: 20),
                        ))
                ],
              ),
            ))
        : LoadingPage();
  }
}

dynamic stepsTabs(var steps) => SizedBox(
      height: 350,
      child: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (context, int index) {
          return InkWell(
            onTap: () {},
            child: Container(
              /* The container height adapts to the length of the text if the
              length is more than 100 characters */
              height: steps[index]['step'].length > 100
                  ? 35 * (steps[index]['step'].length / 32)
                  : 200,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: cg.mediumColor(index),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Container(
                    child: Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              steps[index]['step'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );

dynamic ingsTabs(var ingredients) => Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.40,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.orange[300],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://spoonacular.com/cdn/ingredients_100x100/${ingredients[index]['image']}' ??
                              ''),
                    ),
                    SizedBox(height: 10),
                    Text(
                      ingredients[index]['originalString'] ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
