import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/recipes.dart';
import 'package:recipe_app_design/screens/Cook/recipePage.dart';
import 'package:recipe_app_design/services/api_calls.dart' as api;

class SuggestRecipes extends StatefulWidget {
  final passedIngs;

  SuggestRecipes(this.passedIngs);

  @override
  _SuggestRecipesState createState() => _SuggestRecipesState();
}

class _SuggestRecipesState extends State<SuggestRecipes> {
  dynamic localRecipes = [];

  void fillLocalRecipes() async {
    var obj = await Recipes().matchRecipes(widget.passedIngs);
    if (obj == null) {
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
    return Scaffold(
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
                color: Colors.orange[200],
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
                            textLenCheck(localRecipes[index]['title']),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 20),
                          ),
                          FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.star),
                            label:
                                Text(localRecipes[index]['likes'].toString()),
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

  String textLenCheck(String text) {
    var arr = text.split(' ');

    if (arr.length > 4) {
      text = arr.sublist(0, 4).join(' ');
    } else {
      text = arr.join(' ');
    }
    return text;
  }
}

/*
Container(
              height: 150,
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
            ),*/
