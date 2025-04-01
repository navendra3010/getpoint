import 'package:flutter/material.dart';
import 'package:getpoints/utilities/app_constant.dart';
import 'package:getpoints/utilities/app_image.dart';
import 'package:getpoints/utilities/app_language.dart';
import 'package:getpoints/utilities/detailSendbutton.dart';
import 'package:getpoints/view/authentication/home_screen.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  bool isYesButtomSelected = false;
  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          //padding: EdgeInsets.all(8),
          child: Column(children: <Widget>[
            Container(
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
                    Container(
                        // height: MediaQuery.of(context).size.height * 8 / 100,
                        child: Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                  ]),
                ),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),

            ///acccount details field/////////////////

            Container(
              height: MediaQuery.of(context).size.height * 8 / 100,
              child: Container(
                child: Row(children: [
                  Container(
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height * 5 / 100,
                    child: Row(
                      children: [
                        Container(
                          child: Text("price:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ),
                        Container(
                          child: TextFormField(
                            maxLength: 10,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Circular border
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Circular border
                                borderSide: BorderSide
                                    .none, // Remove underline when focused
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              fillColor:
                                  const Color.fromARGB(255, 227, 230, 227),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(

                  //   child: TextFormField(
                  //     maxLength: 10,
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(
                  //             30.0), // Circular border
                  //         borderSide: BorderSide.none,
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(
                  //             30.0), // Circular border
                  //         borderSide: BorderSide
                  //             .none, // Remove underline when focused
                  //       ),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(30)),
                  //       fillColor: const Color.fromARGB(255, 227, 230, 227),
                  //       filled: true,
                  //     ),
                  //   ),
                  // ),
                ]),
              ),
              ////this is coloumn start  percentageof point
            ),

            ///define percentage of c
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLanguage.percentagePrice[language],
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        Text(AppLanguage.discountPercentage[language],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 20 / 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide
                                .none, // Remove underline when focused
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: const Color.fromARGB(255, 227, 230, 227),
                          filled: true,
                        ),
                      ),
                    ),
                  ]),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            //balanced to be earned
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLanguage.earnedpoint[language],
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 20 / 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide
                                .none, // Remove underline when focused
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: const Color.fromARGB(255, 227, 230, 227),
                          filled: true,
                        ),
                      ),
                    ),
                  ]),
            ),
            //welocome discount table
            Container(
              height: MediaQuery.of(context).size.height * 7 / 100,
              padding: EdgeInsets.all(8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child:
                          // welcome discount point text
                          Text(AppLanguage.welcomedis[language],
                              style: TextStyle(
                                fontSize: 18,
                              )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 20 / 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide
                                .none, // Remove underline when focused
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: const Color.fromARGB(255, 227, 230, 227),
                          filled: true,
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),

            //yes or no btton container button
            Container(
              // width: MediaQuery.of(context).size.width * 100 / 100,
              child: Row(

                  //crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 3 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isYesButtomSelected = true;
                        });
                        print("isYesButtomSelected $isYesButtomSelected");
                      },
                      child: Row(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                            child: Image.asset(
                              isYesButtomSelected == true
                                  ? AppImage.activeButton
                                  : AppImage.deactivateButton,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                            //child: Image.asset(AppImage.yesNoButton),
                            child: Text(AppLanguage.yesButton[language],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 13 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isYesButtomSelected = false;
                        });
                        print("isYesButtomSelected $isYesButtomSelected");
                      },
                      child: Row(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                            child: Image.asset(isYesButtomSelected == false
                                ? AppImage.activeButton
                                : AppImage.deactivateButton),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                            //child: Image.asset(AppImage.yesNoButton),
                            child: Text(AppLanguage.nobutton[language],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),

            if (isYesButtomSelected == true)
              Container(
                // padding: EdgeInsets.only(left: 30),
                margin: EdgeInsets.only(right: 60),
                height: MediaQuery.of(context).size.height * 8 / 100,
                width: MediaQuery.of(context).size.width * 80 / 100,

                child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      fillColor: const Color.fromARGB(255, 227, 230, 227),
                      filled: true,
                    ),
                  ),
                ),
              ),

            /// nunmber of days valid point
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLanguage.NoOfvalid[language],
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 20 / 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide
                                .none, // Remove underline when focused
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: const Color.fromARGB(255, 227, 230, 227),
                          filled: true,
                        ),
                      ),
                    ),
                  ]),
            ),
            //price after discount
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLanguage.priceDiscount[language],
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 20 / 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Circular border
                            borderSide: BorderSide
                                .none, // Remove underline when focused
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: const Color.fromARGB(255, 227, 230, 227),
                          filled: true,
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 7 / 100,
            ),
            // SendDetailButton(
            //   text: AppLanguage.sendDetailButton[language],
            //   onPress: () {
            //     // Navigator.push(
            //     //     context,
            //     //     MaterialPageRoute(
            //     //       builder: (context) => Home(),
            //     //     ));
            //     showDialog(
            //         context: context,
            //         builder: (context) => AlertDialog(
            //               actions: <Widget>[
            //                 TextButton(
            //                   onPressed: () {
            //                     // Navigator.of(context).pop(());

            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                           builder: (context) => Home(),
            //                         ));
            //                   },
            //                   child: Container(
            //                     height: MediaQuery.of(context).size.height *
            //                         30 /
            //                         100,
            //                     width: MediaQuery.of(context).size.width *
            //                         80 /
            //                         100,
            //                     child: Column(children: [
            //                       //succesimage
            //                       Container(
            //                         height: MediaQuery.of(context).size.height *
            //                             10 /
            //                             100,
            //                         child: Image.asset(AppImage.successImage),
            //                       ),
            //                       SizedBox(
            //                         height: MediaQuery.of(context).size.height *
            //                             4 /
            //                             100,
            //                       ),
            //                       Container(
            //                         height: MediaQuery.of(context).size.height *
            //                             5 /
            //                             100,
            //                         child: Text(
            //                             AppLanguage
            //                                 .transitationSuccesd[language],
            //                             style: TextStyle(),
            //                             textAlign: TextAlign.center),
            //                       ),
            //                       SizedBox(
            //                         height: MediaQuery.of(context).size.height *
            //                             3 /
            //                             100,
            //                       ),
            //                       Container(
            //                         height: MediaQuery.of(context).size.height *
            //                             5 /
            //                             100,
            //                         child: Text("Ok",
            //                             style: TextStyle(
            //                                 fontSize: 25,
            //                                 color: Colors.black,
            //                                 fontWeight: FontWeight.w500),
            //                             textAlign: TextAlign.center),
            //                       ),
            //                     ]),
            //                   ),
            //                 ),
            //               ],
            //             ));
            //   },
            // ),
          ]),
        ),
      ),
    );
  }
}
