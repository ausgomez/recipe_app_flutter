import 'package:flutter/material.dart';
import 'package:recipe_app_design/screens/loading.dart';
import 'package:recipe_app_design/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_design/models/User.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    var gravatar = Gravatar(user.email);
    var url = gravatar.imageUrl(
      size: 200,
      defaultImage: GravatarImage.retro,
      rating: GravatarRating.pg,
      fileExtension: true,
    );

    return loading == false
        ? Container(
            color: Colors.orange[100],
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
            child: Column(
              children: [
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Page',
                  style: TextStyle(fontSize: 30),
                ),
                Card(
                  margin: EdgeInsets.only(top: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.orange[300],
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                    color: Colors.orange[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Welcome!',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(url),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton.icon(
                          elevation: 3,
                          onPressed: () async {
                            setState(() {
                              loading = true;
                              message = '';
                            });
                            await _auth.resetPassword(user.email);
                            print('sending email!');
                            setState(() {
                              loading = false;
                              print('loading false');
                              message = 'Password reset link sent to email';
                            });
                          },
                          color: Colors.grey[300],
                          icon: Icon(
                            Icons.settings,
                            color: Colors.black54,
                          ),
                          label: Text(
                            'Change password',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Text(
                          message,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton.icon(
                          elevation: 3,
                          onPressed: () async {
                            await _auth.signOut();
                          },
                          color: Colors.red[300],
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : LoadingPage();
  }
}
