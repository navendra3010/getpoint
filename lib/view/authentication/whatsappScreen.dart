// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatSaappLanuch extends StatefulWidget {
  @override
  State<WhatSaappLanuch> createState() => _PhoneDailerState();
}

class _PhoneDailerState extends State<WhatSaappLanuch> {
  void initState() {
    super.initState();
    _launchWhatsapp();
  }

  // Replace with the phone number you want to dial
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }

  _launchWhatsapp() async {
    const url = "https://wa.me/?text=Hey buddy, try this super cool new app!";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
