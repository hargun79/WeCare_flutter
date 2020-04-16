import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_care/screens/landing_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:we_care/constants.dart';

String errorMessage;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'LOG IN',
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Log In',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your e-mail'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              FlatButton(
                child: Text('Log In'),
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyStatefulWidget()),
                      );
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (error) {
                    //print(e);
                    switch (error.code) {
                      case "ERROR_INVALID_EMAIL":
                        errorMessage =
                            "Your email address appears to be malformed.";
                        break;
                      case "ERROR_WRONG_PASSWORD":
                        errorMessage = "Your password is wrong.";
                        break;
                      case "ERROR_USER_NOT_FOUND":
                        errorMessage = "User with this email doesn't exist.";
                        break;
                      case "ERROR_USER_DISABLED":
                        errorMessage =
                            "User with this email has been disabled.";
                        break;
                      case "ERROR_TOO_MANY_REQUESTS":
                        errorMessage = "Too many requests. Try again later.";
                        break;
                      case "ERROR_OPERATION_NOT_ALLOWED":
                        errorMessage =
                            "Signing in with Email and Password is not enabled.";
                        break;
                      default:
                        errorMessage = "An undefined Error happened.";
                    }
                    setState(() {
                      showSpinner = false;
                      FocusScope.of(context).unfocus();
                      _displaySnackBar(context);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('$errorMessage'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
