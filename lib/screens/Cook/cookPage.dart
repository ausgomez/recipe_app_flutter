import 'package:flutter/material.dart';
import 'package:habanero_app/screens/Cook/addIngsPage.dart';

class CookPage extends StatefulWidget {
  @override
  _CookPageState createState() => _CookPageState();
}

class _CookPageState extends State<CookPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/cooking-background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Center(
            child: Text(
              'Start cooking',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'with what you have',
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: ButtonTheme(
              minWidth: 200.0,
              height: 60.0,
              child: RaisedButton(
                color: Colors.red[400],
                child: Text(
                  "Let's do it",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/ingredients-add',
                    arguments: AddIngredientsPage(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
