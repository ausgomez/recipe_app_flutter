import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final message;

  ErrorPage(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              color: Colors.red[400],
              child: Text(
                'Return Home',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
