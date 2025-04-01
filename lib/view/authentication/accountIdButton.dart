import 'package:flutter/material.dart';

class AccountIDButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const AccountIDButton({
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
            color: Color.fromARGB(255, 8, 8, 8),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          )),
    );
  }
}
