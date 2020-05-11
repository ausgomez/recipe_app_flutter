import 'package:flutter/material.dart';
import 'package:habanero_app/screens/Discover/discoverPage.dart';
import 'package:habanero_app/screens/Cook/cookPage.dart';
import 'package:habanero_app/screens/Profile/profilePage.dart';
import 'package:habanero_app/menus/bottomNav.dart';
import 'package:habanero_app/models/User.dart';
import 'package:provider/provider.dart';
import 'package:habanero_app/screens/auth/authenticateScreen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int index = 0;

  void toggleView(int i) {
    setState(() {
      index = i;
      print('got it! ${index}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    return (user != null)
        ? Scaffold(
            backgroundColor: Colors.white,
            body: index == 0
                ? DiscoverPage()
                : index == 1 ? CookPage() : ProfilePage(),
            bottomNavigationBar:
                myBottomNav(toggleView: toggleView, index: index),
          )
        : AuthenticateScreen();
  }
}
