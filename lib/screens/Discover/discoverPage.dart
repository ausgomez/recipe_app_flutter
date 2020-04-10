import 'package:flutter/material.dart';
import 'package:recipe_app_design/data/recipes.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int index = 0;
  List<String> tests = ["test1", "test2", "test3"];
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = tests.map((name) => new Text(name)).toList();
    return Container(
      padding: EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
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
          ),
          SizedBox(height: 50),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tests.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blue,
                      child: Container(
                        child: Center(
                            child: Text(
                          tests[index].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 36.0),
                        )),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
