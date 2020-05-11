import 'package:flutter/material.dart';
import 'package:recipe_app_design/screens/auth/registerScreen.dart';
import 'package:recipe_app_design/screens/auth/signInScreen.dart';

class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  bool showSignIn = true; //this is to decide what screen to show
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignIn
          ? SignInScreen(toggleView: toggleView)
          : RegisterScreen(toggleView: toggleView),
    );
  }
}
