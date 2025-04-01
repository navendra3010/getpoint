import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/app_color.dart';
import '../utilities/app_language.dart';

class AppModel {
  static Future<dynamic> commonModel(BuildContext context) async {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: const Color(0xff00000030),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: ((context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 27 / 100,
            width: MediaQuery.of(context).size.width * 80 / 100,
            color: const Color(0xff00000030),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100),
                  Container(
                    height: MediaQuery.of(context).size.height * 12 / 100,
                    width: MediaQuery.of(context).size.width * 80 / 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.secondryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        const Text(
                          "Select Option",
                          style: TextStyle(
                              color: Color(0xff6e6e6e),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100),
                        Container(
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            color: const Color(0xffd7d7d7)),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Report()),
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            child: const Text(
                              "Report",
                              style: TextStyle(
                                  color: Color(0xff323232),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 7 / 100,
                      width: MediaQuery.of(context).size.width * 80 / 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.secondryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Color(0xffff5050),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
      },
    );

    // return isActive;
    // return true;
  }
}
