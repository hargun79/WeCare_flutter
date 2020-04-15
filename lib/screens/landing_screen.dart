import 'package:flutter/material.dart';
import 'package:we_care/screens/SafeZone.dart';
import 'package:we_care/screens/add_emergency_contact_screen.dart';
import 'package:we_care/screens/fightBack.dart';
import 'package:we_care/screens/helplineNumbers.dart';
import 'package:we_care/screens/SOS.dart';
import 'package:we_care/screens/reportCrime.dart';
import 'package:we_care/screens/GetSafeguide.dart';
import 'package:we_care/screens/BecomeSafeguide.dart';
import 'package:we_care/screens/Connect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_care/screens/welcome_screen.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SafeZone()),
        );
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SOS()),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FightBack()),
        );
      }
      if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelplineNumbers()),
        );
      }
      if (index == 4) {
        reportCrime();
      }
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        setState(() {
          _auth.signOut();
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        });
        break;
      case 'Add Emergency Contact':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddEmergencyContactScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeCare'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Add Emergency Contact', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 20,
            ),
            Text(
              'WeCare',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 20,
              height: 20,
            ),
            Image.asset(
              'assets/images/logo.png',
            ),
            SizedBox(
              width: 20,
              height: 20,
            ),
            Text(
              'We at WeCare provide the best safety services for women and help them overcome many difficulties encountered in their safety as an individual in the society.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 20,
              height: 20,
            ),
            FlatButton(
              child: Text('Get a SafeGuide'),
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetSafeguide()),
                );
              },
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            FlatButton(
              child: Text('Become a SafeGuide'),
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BecomeSafeguide()),
                );
              },
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            FlatButton(
              child: Text('Connect with someone'),
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Connect()),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.near_me,
              color: Colors.black54,
            ),
            title: Text(
              'SafeZone',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.announcement,
              color: Colors.black54,
            ),
            title: Text(
              'SOS',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.reply,
              color: Colors.black54,
            ),
            title: Text(
              'Learn',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              color: Colors.black54,
            ),
            title: Text(
              'Helpline',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.report,
              color: Colors.black54,
            ),
            title: Text(
              'Report',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Log Out', icon: Icons.close),
  const Choice(title: 'Add Emergency Contact', icon: Icons.close),
];
