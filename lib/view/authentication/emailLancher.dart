// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailLaunch extends StatefulWidget {
  @override
  State<EmailLaunch> createState() => _PhoneDailerState();
}

class _PhoneDailerState extends State<EmailLaunch> {
  void initState() {
    super.initState();
    _sendingMails();
  }

  // Replace with the phone number you want to dial
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('email '),
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

  _sendingMails() async {
    var url = Uri.parse("mailto:testcode@webkul.in");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
