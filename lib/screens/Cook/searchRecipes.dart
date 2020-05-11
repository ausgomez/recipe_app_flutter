import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/recipes.dart';
import 'package:recipe_app_design/screens/Cook/recipePage.dart';
import 'package:recipe_app_design/services/api_calls.dart' as api;
import 'package:recipe_app_design/services/color_generator.dart' as cg;
import 'package:recipe_app_design/screens/loading.dart';
import 'package:recipe_app_design/services/utilities.dart' as utils;

class SearchRecipes extends StatefulWidget {
  final query;
  SearchRecipes(this.query);

  @override
  _SearchRecipesState createState() => _SearchRecipesState();
}

class _SearchRecipesState extends State<SearchRecipes> {
  dynamic localRecipes = [];

  void fillLocalRecipes() async {
    print("query is ${widget.query}");
    var obj = await Recipes().searchForRecipesByName(widget.query);
    if (obj == null) {
      print('obj is null! 🛑');
      print(obj);
      Navigator.pushNamed(context, '/error-page');
      return;
    }
    setState(() {
      localRecipes = obj.toList();
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
    return localRecipes.length <= 0
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              title: Text('Recipes Available'),
            ),
            body: ListView.builder(
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
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage('${localRecipes[index]['image']}'),
                          ),
                        ),
                        Container(
                          child: Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  utils.textLenCheck(
                                      localRecipes[index]['title']),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 20),
                                ),
                                FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.star),
                                  label: Text(
                                      localRecipes[index]['likes'].toString()),
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
