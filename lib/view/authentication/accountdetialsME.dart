import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:getpoints/utilities/app_constant.dart';
import 'package:getpoints/utilities/app_image.dart';
import 'package:getpoints/utilities/app_language.dart';
import 'package:getpoints/utilities/detailSendbutton.dart';
import 'package:getpoints/view/authentication/home_screen.dart';

class AccountDetailsByMe extends StatefulWidget {
  const AccountDetailsByMe({super.key});

  @override
  State<AccountDetailsByMe> createState() => _AccountDetailsByMeState();
}

class _AccountDetailsByMeState extends State<AccountDetailsByMe> {
  bool isSelectedButtom = false;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(children: [
              Container(
                child: Container(
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                          child: Image.asset(AppImage.backIcon),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 100,
                        ),
                        Container(
                            // height: MediaQuery.of(context).size.height * 8 / 100,
                            child: Text(
                          "Details",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                      ]),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),

              ///this code for price field
              Container(
                height: MediaQuery.of(context).size.height * 9 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(
                          "price:",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 5 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 70 / 100,
                        height: MediaQuery.of(context).size.height * 6 / 100,
                        child: TextFormField(
                          style:
                              const TextStyle(color: Colors.black, height: 0.9),
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            //fillColor: const Color.fromARGB(255, 224, 221, 221),
                            fillColor: Color(0xffF0F1F0),
                            filled: true,
                            counterText: '',
                          ),
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              //this line for percentage ann point earned
              Container(
                height: MediaQuery.of(context).size.height * 6 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: Row(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(top: 12),
                        child: Text(
                          AppLanguage.percentagePrice[language],
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppLanguage.discountPercentage[language],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 10 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 35 / 100,
                    height: MediaQuery.of(context).size.height * 8 / 100,

                    //Addition add for fix container buttom
                    child: Container(
                      width: MediaQuery.of(context).size.width * 20 / 100,
                      height: MediaQuery.of(context).size.height * 4 / 100,
                      child: Column(
                        children: [
                          Container(
                              width:
                                  MediaQuery.of(context).size.width * 25 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 4, left: 25),
                                child: Text(
                                  "10%",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),

              ///this code for balanced point
              Container(
                height: MediaQuery.of(context).size.height * 4 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: Row(children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          AppLanguage.earnedpoint[language],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 27 / 100,
                  ),
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 35 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: Column(
                        children: [
                          Container(
                              width:
                                  MediaQuery.of(context).size.width * 25 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 5, left: 20),
                                child: Text(
                                  "10 Points",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),

              Container(
                height: MediaQuery.of(context).size.height * 4 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: Row(children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          AppLanguage.welcomedis[language],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 26 / 100,
                  ),
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 35 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: Column(
                        children: [
                          Container(
                              width:
                                  MediaQuery.of(context).size.width * 25 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                              decoration: BoxDecoration(
                                color: Color(0xff3C8AD2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 4, left: 20),
                                child: Text(
                                  "50%",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              // yes or no buttom

              Container(
                height: MediaQuery.of(context).size.height * 7 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    child: Row(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 3 / 100,
                        child: GestureDetector(
                          onTap: () {
                            print("yes buttom press");
                            isSelectedButtom = true;
                            setState(() {
                              print(isSelectedButtom);
                              isSelectedButtom = true;
                            });
                          },
                          child: Container(
                            child: Image.asset(isSelectedButtom == true
                                ? AppImage.activeButton
                                : AppImage.deactivateButton),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100,
                      ),
                      Container(
                        child: Text(AppLanguage.yesButton[language],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 13 / 100,
                  ),
                  //this code for no buttom
                  Container(
                    child: Row(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 3 / 100,
                        child: GestureDetector(
                          onTap: () {
                            print("no buttom press");
                            isSelectedButtom = false;
                            setState(() {
                              isSelectedButtom = false;
                            });
                          },
                          child: Container(
                            child: Image.asset(
                              isSelectedButtom == false
                                  ? AppImage.activeButton
                                  : AppImage.deactivateButton,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100,
                      ),
                      Container(
                        child: Text(AppLanguage.nobutton[language],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ]),
                  ),
                ]),
              ),

              if (isSelectedButtom == true)
                Container(
                  // margin: EdgeInsets.only(right: 45),
                  height: MediaQuery.of(context).size.height * 8 / 100,
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        fillColor: const Color.fromARGB(255, 227, 230, 227),
                        filled: true,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              //this container for price after valid
              Container(
                height: MediaQuery.of(context).size.height * 9 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: Row(children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          AppLanguage.NoOfvalid[language],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 16 / 100,
                  ),
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 35 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: Column(
                        children: [
                          Container(
                              width:
                                  MediaQuery.of(context).size.width * 25 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 4, left: 20),
                                child: Text(
                                  "3 Days",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),

              Container(
                height: MediaQuery.of(context).size.height * 9 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: Row(children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          AppLanguage.priceDiscount[language],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 24 / 100,
                  ),
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 35 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: Column(
                        children: [
                          Container(
                              width:
                                  MediaQuery.of(context).size.width * 25 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 4, left: 20),
                                child: Text(
                                  "65.25.DH",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              SendDetailButton(
                text: AppLanguage.sendDetailButton[language],
                onPress: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Home(),
                  //     ));
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Navigator.of(context).pop(());

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(),
                                      ));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      30 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      80 /
                                      100,
                                  child: Column(children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              2 /
                                              100,
                                    ),
                                    //succesimage
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              10 /
                                              100,
                                      child: Image.asset(AppImage.successImage),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              4 /
                                              100,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              5 /
                                              100,
                                      child: Text(
                                          AppLanguage
                                              .transitationSuccesd[language],
                                          style: TextStyle(),
                                          textAlign: TextAlign.center),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              2 /
                                              100,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              6 /
                                              100,
                                      child: Text("Ok",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center),
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          ));
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
