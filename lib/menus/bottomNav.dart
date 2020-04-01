import 'package:flutter/material.dart';

class myBottomNav extends StatefulWidget {
  final Function toggleView;
  int index;

  myBottomNav({this.toggleView, this.index});
  @override
  _myBottomNavState createState() => _myBottomNavState();
}

class _myBottomNavState extends State<myBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          title: Text('Discover'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Cook'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Profile'),
        ),
      ],
      backgroundColor: Colors.teal[600],
      fixedColor: Colors.white,
      unselectedItemColor: Colors.grey[400],
      onTap: (i) {
        widget.index = i;
        widget.toggleView(i);
        print('this is the widget index: ${widget.index}');
      },
    );
  }
}
