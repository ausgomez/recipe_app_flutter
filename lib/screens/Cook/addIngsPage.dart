import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/ingredients.dart';

class AddIngredientsPage extends StatefulWidget {
  @override
  _AddIngredientsPageState createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState extends State<AddIngredientsPage> {
  dynamic localIngs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Ingredients'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
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
            Text('hey'),
            localIngs != null
                ? Container(
                    margin: EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 200.0,
                      child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: localIngs.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                            onTap: () => {print('clicked on tab $index')},
                            child: Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text('${localIngs.toList()[index]}'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Text('nothing yet'),
          ],
        ),
      ),
    );
  }
}
