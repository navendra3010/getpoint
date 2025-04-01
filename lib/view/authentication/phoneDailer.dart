// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneDailer extends StatefulWidget {
  @override
  State<PhoneDailer> createState() => _PhoneDailerState();
}

class _PhoneDailerState extends State<PhoneDailer> {
  void initState() {
    super.initState();
    _launchDialer();
  }

  final String phoneNumber = '1234567890';

  // Replace with the phone number you want to dial
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Dialer Example'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  _launchDialer() async {
    const url = "tel:1234567";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
