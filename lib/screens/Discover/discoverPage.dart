import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/recipes.dart';
import 'package:recipe_app_design/screens/Cook/recipePage.dart';
import 'package:recipe_app_design/screens/Cook/searchRecipes.dart';
import 'package:recipe_app_design/screens/loading.dart' as loadingP;
import 'package:recipe_app_design/services/color_generator.dart' as cg;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int index = 0;
  dynamic localRecipes = [];

  void fillLocalRecipes() async {
    var obj = await Recipes().randomRecipes(5);
    print(obj);
    if (obj == null) {
      Navigator.pushNamed(context, '/error-page');
      return;
    }
    setState(() {
      localRecipes = obj;
    });
  }

  List suggestions = [
    {'title': 'American', 'icon': Icons.fastfood},
    {'title': 'Greek', 'icon': Icons.local_pizza},
    {'title': 'Italian', 'icon': Icons.local_pizza},
    {'title': 'Mexican', 'icon': Icons.local_pizza},
    {'title': 'Thai', 'icon': Icons.local_pizza},
    {'title': 'Chinese', 'icon': Icons.local_pizza},
    {'title': 'Japanese', 'icon': Icons.local_pizza},
    {'title': 'Korean', 'icon': Icons.local_pizza},
    {'title': 'German', 'icon': Icons.local_pizza}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillLocalRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 40.0),
        child: Container(
          padding: EdgeInsets.only(right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Search',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'for recipes',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 50),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: 'dish name',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
                onSubmitted: (value) => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchRecipes(value)))
                },
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              color: Colors.grey,
                              icon: Icon(suggestions[index]['icon']),
                              tooltip: 'Category',
                              onPressed: () {
                                setState(() {
                                  print(suggestions[index]);
                                });
                              },
                            ),
                            Text(
                              suggestions[index]['title'],
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20),
              Text(
                'Trending',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              /* TRENDING SLIDES */
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: localRecipes.length <= 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitRotatingCircle(
                            color: Colors.blue[200],
                            size: 50.0,
                          ),
                          Text(loadingP.randomLine()),
                        ],
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: localRecipes.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: InkWell(
                              onTap: () => {
                                /* when a slide is clicked */
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RecipePage(localRecipes[index].id)))
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: cg.lightColor(index),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundImage: NetworkImage(
                                            localRecipes[index].imageLink ??
                                                ''),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        localRecipes[index].title ?? 'Item',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
