import 'package:flutter/material.dart';

class CookPage extends StatefulWidget {
  @override
  _CookPageState createState() => _CookPageState();
}

class _CookPageState extends State<CookPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cook',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            'Page',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 50),
          RaisedButton(
            color: Colors.red,
            child: Text('Start Cooking'),
            onPressed: () {
              Navigator.pushNamed(context, '/ingredients-add');
            },
          ),
        ],
      ),
    );
  }
}
