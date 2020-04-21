import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/ingredients.dart';
import 'package:recipe_app_design/screens/Cook/suggestRecipes.dart';
import 'package:recipe_app_design/screens/loading.dart' as loadingP;
import 'package:recipe_app_design/services/color_generator.dart' as cg;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddIngredientsPage extends StatefulWidget {
  @override
  _AddIngredientsPageState createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState extends State<AddIngredientsPage> {
  dynamic localIngs = [];
  dynamic localBasket = [];
  bool enable = true;
  String message = 'Please search for ingredients';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Ingredients'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  enabled: enable,
                  maxLength: 30,
                  decoration: InputDecoration(
                      hintText: 'Search for ingredients',
                      prefixIcon: Icon(Icons.search)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  //decoration: kTextFieldInputDecoration,
                  onChanged: (value) {},
                  onSubmitted: (value) async {
                    // when submitted, it will look for ingredients
                    print('before ings: $localIngs');
                    setState(() {
                      message = 'Looking for ingredients...';
                      enable = false;
                    });
                    var obj = await Ingredients().matchIngredients(value);
                    if (obj == null) {
                      Navigator.pushNamed(context, '/error-page');
                      return;
                    }
                    print('The object received:');
                    print(obj);
                    setState(() {
                      localIngs = obj.toList();
                      if (localIngs.length < 1) {
                        message = 'No ingredients found...';
                      }
                      enable = true;
                    });
                    print('ings: $localIngs');
                  },
                ),
              ),
              localIngs.length <= 0 && enable == true
                  ? Container(
                      margin: EdgeInsets.only(bottom: 40),
                      alignment: Alignment.center,
                      color: Colors.blue[200],
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Let\'s start',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w300),
                            ),
                            Text('by listing down your ingredients'),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '🍽',
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(15.0),
                      child: SizedBox(
                          height: 200.0,
                          child: enable == true
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: localIngs.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return InkWell(
                                      onTap: () {
                                        print('tapped!');
                                        setState(() {
                                          // insert into the local basket the selected ingredient
                                          localBasket.insert(
                                              0, localIngs[index]);

                                          // trying to remove the ingredient from the local list
                                          localIngs = localIngs.where((x) {
                                            print(x);
                                            return x != localIngs[index];
                                          }).toList();
                                        });
                                      },
                                      child: Card(
                                        elevation: 5,
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                              '${localIngs.toList()[index]['name']}'),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(loadingP.randomLine()),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SpinKitRotatingCircle(
                                      color: Colors.blue[200],
                                      size: 50.0,
                                    ),
                                  ],
                                )),
                    ),
              Text(
                '🧺 Your Basket (${localBasket.length})',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              localBasket.length <= 0
                  ? Container(
                      margin: EdgeInsets.only(top: 40),
                      alignment: Alignment.center,
                      color: Colors.orange[200],
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Nothing here yet',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '🤷‍♂️',
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 250,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: localBasket.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  localBasket.remove(localBasket[index]);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: cg.lightColor(index),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          'https://spoonacular.com/cdn/ingredients_100x100/${localBasket[index]['image']}'),
                                    ),
                                    SizedBox(height: 10),
                                    Center(
                                      child: Text(
                                        localBasket[index]['name'].trim(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: (localBasket.length > 2)
          ? FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuggestRecipes(localBasket),
                ),
              ),
              tooltip: 'Increment',
              child: Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}
