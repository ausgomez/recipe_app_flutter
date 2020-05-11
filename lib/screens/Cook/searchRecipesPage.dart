import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/recipes.dart';
import 'package:recipe_app_design/screens/Cook/recipePage.dart';
import 'package:recipe_app_design/screens/errorPage.dart';
import 'package:recipe_app_design/services/api_calls.dart' as api;
import 'package:recipe_app_design/services/color_generator.dart' as cg;
import 'package:recipe_app_design/screens/loading.dart';
import 'package:recipe_app_design/services/utilities.dart' as utils;

class SearchRecipesPage extends StatefulWidget {
  final query;
  SearchRecipesPage(this.query);

  @override
  _SearchRecipesPageState createState() => _SearchRecipesPageState();
}

class _SearchRecipesPageState extends State<SearchRecipesPage> {
  dynamic localRecipes = [];
  bool searched = false;

  void fillLocalRecipes() async {
    print("query is ${widget.query}");
    var obj = await Recipes().searchForRecipesByName(widget.query);
    if (obj == null) {
      print('obj is null! 🛑');
      print(obj);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ErrorPage('Error getting Recipes by Query')));
      return;
    }
    setState(() {
      localRecipes = obj.toList();
      searched = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillLocalRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return searched == false
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              title: Text('Searching for "${widget.query}"'),
            ),
            body: localRecipes.length == 0
                ? Container(
                    alignment: Alignment.center,
                    child: Text("No Results Found!",
                        style: TextStyle(fontSize: 30)),
                  )
                : ListView.builder(
                    itemCount: localRecipes.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecipePage(localRecipes[index]['id'])));
                        },
                        child: Container(
                          height: 130,
                          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: cg.lightColor(index),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.all(20),
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(
                                      'https://spoonacular.com/recipeImages/${localRecipes[index]['image']}'),
                                ),
                              ),
                              Container(
                                child: Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        utils.textLenCheck(
                                            localRecipes[index]['title']),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20),
                                      ),
                                      FlatButton.icon(
                                        onPressed: null,
                                        icon: Icon(Icons.access_time),
                                        label: Text(localRecipes[index]
                                                    ['readyInMinutes']
                                                .toString() +
                                            " mins"),
                                        color: Colors.orange,
                                        padding: EdgeInsets.all(10.0),
                                      )
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    localRecipes = [];
  }
}
