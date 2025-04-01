import 'package:flutter/material.dart';
import 'package:getpoints/utilities/app_image.dart';

import '../utilities/app_color.dart';

class ChangeColor extends StatelessWidget {
  final String text;
  final Function onPress;

  const ChangeColor({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 90 / 100,
        height: MediaQuery.of(context).size.height * 7 / 100,
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide(width: 1)),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: MediaQuery.of(context).size.height * 5 / 100,
            child: Image.asset(AppImage.changelanguegeimage),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 100,
          ),
          Container(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 17),
            ),
          ),
        ]),
      ),
    );
  }
}
