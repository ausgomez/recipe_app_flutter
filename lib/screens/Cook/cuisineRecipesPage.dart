import 'package:flutter/material.dart';
import 'package:habanero_app/data/recipes.dart';
import 'package:habanero_app/screens/Cook/recipePage.dart';
import 'package:habanero_app/screens/errorPage.dart';
import 'package:habanero_app/services/api_calls.dart' as api;
import 'package:habanero_app/services/color_generator.dart' as cg;
import 'package:habanero_app/screens/loading.dart';
import 'package:habanero_app/services/utilities.dart' as utils;

class CuisineRecipesPage extends StatefulWidget {
  final String cuisine;

  CuisineRecipesPage(this.cuisine);

  @override
  _CuisineRecipesPageState createState() => _CuisineRecipesPageState();
}

class _CuisineRecipesPageState extends State<CuisineRecipesPage> {
  dynamic localRecipes = [];
  bool searched = false;

  void fillLocalRecipes() async {
    print("cuisine is ${widget.cuisine}");
    var obj = await Recipes().getRecipesByCuisine(widget.cuisine);
    if (obj == null) {
      print('obj is null! 🛑');
      print(obj);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ErrorPage('Error getting Recipes by Cuisine Name')));
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
              title: Text('${widget.cuisine} Cuisine'),
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
                                      '${localRecipes[index]['image']}'),
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
}
