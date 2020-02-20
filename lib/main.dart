import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_care/screens/landing_screen.dart';
import 'package:we_care/screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

FirebaseAuth _auth = FirebaseAuth.instance;
String uid;

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  bool _loggedIn = false;
  @override
  void initState() {
    super.initState();
    isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        setLoggedIn();
      }
    });
  }

  void setLoggedIn() {
    setState(() {
      _loggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loggedIn ? MyStatefulWidget() : WelcomeScreen();
  }
}

Future<FirebaseUser> getUser() async {
  return _auth.currentUser().then((user) {
    uid = user.uid;
    return user;
  });
}

Future<bool> isLoggedIn() async {
  FirebaseUser _user = await getUser();
  return _user != null;
}
