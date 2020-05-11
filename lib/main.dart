import 'package:flutter/material.dart';
import 'package:habanero_app/screens/errorPage.dart';
import 'package:habanero_app/screens/loading.dart';
import 'package:habanero_app/screens/wrapper.dart';
import 'package:habanero_app/screens/Cook/addIngsPage.dart';
import 'package:provider/provider.dart';
import 'package:habanero_app/services/auth.dart';
import 'package:habanero_app/models/User.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  /* load the .env file */
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/ingredients-add': (context) => AddIngredientsPage(),
          '/error-page': (context) => ErrorPage('Something went wrong'),
          '/loading-page': (context) => LoadingPage(),
        },
      ),
    );
  }
}
