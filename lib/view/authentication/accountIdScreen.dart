// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getpoints/utilities/app_constant.dart';
import 'package:getpoints/utilities/app_image.dart';
import 'package:getpoints/utilities/app_language.dart';
import 'package:getpoints/view/authentication/accountIdButton.dart';
import 'package:getpoints/view/authentication/accountdetialsME.dart';
import 'package:getpoints/view/authentication/acountDetails.dart';
import 'package:google_maps_webservice/directions.dart';

class AccountId extends StatefulWidget {
  const AccountId({super.key});

  @override
  State<AccountId> createState() => _AccountIdState();
}

class _AccountIdState extends State<AccountId> {
  TextEditingController _IdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SafeArea(
              child: Container(
                  child: Column(
        children: [
          Container(
            child: Row(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 7 / 100,
                    child: Image.asset(AppImage.backIcon),
                  ),
                  Container(
                      // height: MediaQuery.of(context).size.height * 8 / 100,
                      child: Text(
                    "Account Id",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
                ]),
              ),
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0 / 100,
          ),
          Stack(
            children: [
              Container(
                child: Image.asset(AppImage.AccountID),
              ),
              Positioned(
                  top: 120,
                  left: 100,
                  child: Text(
                    AppLanguage.AccountIdText[language],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 7 / 100,
            width: MediaQuery.of(context).size.width * 90 / 100,
            alignment: Alignment.center,
            // padding: EdgeInsets.all(8),
            child: Column(children: [
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _IdController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: "User Account ID",
                    prefixIcon: Icon(Icons.account_box_outlined),
                    fillColor: Color.fromARGB(255, 238, 234, 234),
                    filled: true),
              ),
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 5 / 100,
          ),
          AccountIDButton(
            text: AppLanguage.AccountIdsendButton[language],
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountDetailsByMe()));
            },
          ),
        ],
      )))),
    );
  }
}
