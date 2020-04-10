import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/ingredients.dart';

class AddIngredientsPage extends StatefulWidget {
  @override
  _AddIngredientsPageState createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState extends State<AddIngredientsPage> {
  List localIngs = [];
  List localBasket = [];

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
                                  child: Text('${localIngs.toList()[index]}'),
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
                                backgroundImage: NetworkImage(
                                    'https://spoonacular.com/cdn/ingredients_100x100/apple-juice.jpg'),
                              ),
                              SizedBox(height: 10),
                              Text(
                                localBasket[index],
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
              onPressed: () => null,
              tooltip: 'Increment',
              child: Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}

/*
GridView.count(
                                    crossAxisCount: 4,
                                    childAspectRatio: 1.0,
                                    padding: const EdgeInsets.all(4.0),
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    children: <Widget>[
                                      Container(
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              "https://i.imgur.com/BoN9kdC.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text('${localBasket[index]}'),
                                      ),
                                      Text('${localBasket[index]}')
                                    ],
                                  )*/
