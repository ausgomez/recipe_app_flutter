import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/ingredients.dart';
import 'package:recipe_app_design/screens/Cook/suggestRecipes.dart';

class AddIngredientsPage extends StatefulWidget {
  @override
  _AddIngredientsPageState createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState extends State<AddIngredientsPage> {
  dynamic localIngs = [];
  dynamic localBasket = [];

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
                  decoration: InputDecoration(
                      hintText: 'Search for ingredients',
                      prefixIcon: Icon(Icons.search)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  //decoration: kTextFieldInputDecoration,
                  onChanged: (value) {},
                  onSubmitted: (value) async {
                    print('before ings: $localIngs');
                    var obj = await Ingredients().matchIngredients(value);
                    print('The object received:');
                    print(obj);
                    setState(() {
                      localIngs = obj.toList();
                    });
                    print('ings: $localIngs');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 200.0,
                  child: localIngs.length > 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: localIngs.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return InkWell(
                              onTap: () {
                                print('tapped!');
                                setState(() {
                                  // insert into the local basket the selected ingredient
                                  localBasket.insert(0, localIngs[index]);

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
                      : Text(''),
                ),
              ),
              Text('Your Basket'),
              Container(
                margin: EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 300,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            color: Colors.blue,
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
                              Text(
                                localBasket[index]['name'],
                                style: TextStyle(color: Colors.white),
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
