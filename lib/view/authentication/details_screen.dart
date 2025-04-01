import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:getpoints/utilities/app_image.dart';

class Mobiledetails extends StatelessWidget {
  const Mobiledetails({super.key});

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
