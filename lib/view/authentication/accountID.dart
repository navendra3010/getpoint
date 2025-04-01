import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getpoints/utilities/app_image.dart';

class AccountID extends StatelessWidget {
  const AccountID({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (() {
          Navigator.pop(context);
        }),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                AppImage.backIcon,
                width: MediaQuery.of(context).size.width * 10 / 100,
                height: MediaQuery.of(context).size.height * 20 / 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
