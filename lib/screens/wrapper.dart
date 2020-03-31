import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('Discover'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Ingredients'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Profile'),
          ),
        ],
        backgroundColor: Colors.teal[600],
        fixedColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
      ),
    );
  }
}
