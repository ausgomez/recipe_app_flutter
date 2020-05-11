import 'package:flutter/material.dart';
import 'package:recipe_app_design/screens/auth/authenticateScreen.dart';
import 'package:recipe_app_design/services/auth.dart';
import 'package:recipe_app_design/screens/loading.dart';
import 'package:recipe_app_design/services/constants.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  SignInScreen({this.toggleView});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  /* Creating a validator to then bind it to any form */
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            backgroundColor: Colors.orange[200],
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.orange[400],
              elevation: 0.0,
              title: Text('Sign in'),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key:
                      _formKey, // binding the private validator key to this property
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        /* setting validator */
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        decoration:
                            TextInputDecoration.copyWith(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          /* setting validator */
                          validator: (val) => val.length < 6
                              ? 'Password must be 6+ characters'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: TextInputDecoration.copyWith(
                              hintText: 'Password')),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text('Sign in',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            error = '';
                            if (_formKey.currentState.validate()) {
                              /* if the form is valid, then do something */
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Could not sign in with those credentials.';
                                    loading = false;
                                  });
                                }
                              }
                            }
                          }),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0))
                    ],
                  ),
                )),
          );
  }
}
