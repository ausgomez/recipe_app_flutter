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
          icon: Icon(Icons.explore),
          title: Text('Discover'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          title: Text('Cook'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face),
          title: Text('Profile'),
        ),
      ],
      backgroundColor: Colors.red[300],
      //fixedColor: Colors.white,
      iconSize: 30,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.red[100],
      onTap: (i) {
        widget.index = i;
        widget.toggleView(i);
        print('this is the widget index: ${widget.index}');
      },
    );
  }
}
