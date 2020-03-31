import 'package:flutter/material.dart';

BottomNavigationBar myBottomNavigationBar(int i) {
  return BottomNavigationBar(
    currentIndex: i,
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
  );
}
