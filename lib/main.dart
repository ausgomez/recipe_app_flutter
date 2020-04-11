import 'package:flutter/material.dart';
import 'package:recipe_app_design/screens/errorPage.dart';
import 'package:recipe_app_design/screens/wrapper.dart';
import 'package:recipe_app_design/screens/Cook/addIngsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/ingredients-add',
      routes: {
        '/': (context) => Wrapper(),
        '/ingredients-add': (context) => AddIngredientsPage(),
        '/error-page': (context) => ErrorPage(),
      },
    );
  }
}
