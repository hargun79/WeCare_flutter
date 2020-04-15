import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_care/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEmergencyContactScreen extends StatefulWidget {
  @override
  _AddEmergencyContactScreenState createState() =>
      _AddEmergencyContactScreenState();
}

class _AddEmergencyContactScreenState extends State<AddEmergencyContactScreen> {
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;
  String number;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add Emergency Contact'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add Emergency Contact',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  number = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter emergency contact number'),
              ),
              SizedBox(
                height: 24.0,
              ),
              FlatButton(
                child: Text('Submit'),
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                onPressed: () {
                  _firestore
                      .collection('/users')
                      .document(loggedInUser.uid)
                      .setData({
                    'emergencyContactNumber': number,
                  });
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                  _displaySnackBar(context);
                },
              ),
            ],
          ),
        ));
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Emergency Contact Submitted'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
