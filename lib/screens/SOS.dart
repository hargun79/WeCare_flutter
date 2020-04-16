import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SOS extends StatefulWidget {
  @override
  _SOSState createState() => _SOSState();
}

String number;

class _SOSState extends State<SOS> {
  void getData() {
    _firestore
        .collection('/users')
        .document(loggedInUser.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      number = snapshot.data['emergencyContactNumber'];
    });
  }

  final _firestore = Firestore.instance;

  FirebaseUser loggedInUser;

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    Timer(Duration(seconds: 1), () {
      getLocation();
    });
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        getData();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SOS'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'SOS will be sent in a few seconds',
                  style: TextStyle(
                    fontSize: 50.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

void getLocation() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  String uri =
      'sms:+91 $number?body=I%20am%20in%20danger,%20my%20location%20is:%20$position';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    // iOS
    const uri = 'sms:0039-222-060-888';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
