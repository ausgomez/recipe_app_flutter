import 'package:flutter/material.dart';
import 'package:habanero_app/screens/auth/authenticateScreen.dart';
import 'package:habanero_app/services/auth.dart';
import 'package:habanero_app/screens/loading.dart';
import 'package:habanero_app/services/constants.dart';

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
            body: SingleChildScrollView(
              child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key:
                        _formKey, // binding the private validator key to this property
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/images/habanero.png"),
                        ),
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
                        Container(
                          width: 1000,
                          height: 50,
                          child: RaisedButton(
                              color: Colors.red[300],
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
                        ),
                        Text(error,
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.0)),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(),
                        Text('Are you new here?',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 1000,
                          height: 50,
                          child: RaisedButton(
                              color: Colors.blue[400],
                              child: Text('Register Now',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () => widget.toggleView()),
                        )
                      ],
                    ),
                  )),
            ),
          );
  }
}
