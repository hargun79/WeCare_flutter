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
  /* _firestore
      .collection('/users')
      .document(loggedInUser.uid)
      .data['emergencyContactNumber'];*/

  void getData() {
    _firestore
        .collection('/users')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents
          .forEach((f) => number = '${f.data['emergencyContactNumber']}');
    });
  }

  final _firestore = Firestore.instance;

  FirebaseUser loggedInUser;

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getData();
    getLocation();
    Navigator.pop(context);
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
    return Scaffold();
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
