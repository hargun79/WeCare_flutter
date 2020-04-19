import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

String name;
String dob;
String pNumber;
String email;
String location;
DateTime selectedDate = DateTime.now();

class BecomeSafeguide extends StatefulWidget {
  @override
  _BecomeSafeguideState createState() => _BecomeSafeguideState();
}

class _BecomeSafeguideState extends State<BecomeSafeguide> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _controller1 = new TextEditingController();

  final TextEditingController _controller2 = new TextEditingController();

  final TextEditingController _controller3 = new TextEditingController();

  final TextEditingController _controller4 = new TextEditingController();

  final TextEditingController _controller5 = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var formatter = new DateFormat('dd-MM-yyyy');
        String formatted = formatter.format(selectedDate);
        dob = formatted;
        _controller2.text = formatted.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Become a Safeguide'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Text(
                'With great power comes great responsibility. Be a hero for someone and help them travel them in the area which you live safely when they are feeling unsafe.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
              new TextFormField(
                controller: _controller1,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your first and last name',
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              new TextFormField(
                  controller: _controller2,
                  focusNode: AlwaysDisabledFocusNode(),
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.calendar_today),
                    hintText: 'Enter your date of birth',
                    labelText: 'Dob',
                  ),
                  onChanged: (value) {
                    dob = value;
                  },
                  onTap: () {
                    _selectDate(context);
                  }),
              new TextFormField(
                controller: _controller3,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.phone),
                  hintText: 'Enter a phone number',
                  labelText: 'Phone',
                ),
                onChanged: (value) {
                  pNumber = value;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
              new TextFormField(
                controller: _controller4,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter a email address',
                  labelText: 'Email',
                ),
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              new TextFormField(
                controller: _controller5,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.location_on),
                  hintText: 'Enter area',
                  labelText: 'Location',
                ),
                onChanged: (value) {
                  location = value;
                },
              ),
              new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    _mailto() async {
                      String url =
                          'mailto:wecare2020@gmail.com?subject=Become%20a%20safeguide&body=Name:%20$name%0D%0ADOB:%20$dob%0D%0APhone%20Number:%20$pNumber%0D%0AEmail:%20$email%0D%0ALocation:%20$location';
                      print("test url1");
                      if (await canLaunch(url)) {
                        print("test url2");
                        await launch(url);
                      } else {
                        print("test url3");
                        throw 'Could not launch $url';
                      }
                    }

                    _controller1.clear();
                    _controller2.clear();
                    _controller3.clear();
                    _controller4.clear();
                    _controller5.clear();
                    _mailto();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
