import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getpoints/view/authentication/accountIdScreen.dart';
import 'package:getpoints/view/authentication/accountdetialsME.dart';
import 'package:getpoints/view/authentication/acountDetails.dart';
import 'package:getpoints/view/authentication/details_screen.dart';
import 'package:getpoints/view/authentication/edit_profile_screen.dart';
import 'package:getpoints/view/authentication/notificationScreen.dart';
import 'package:getpoints/view/authentication/phoneNumberSendButoon.dart';
import 'package:getpoints/view/authentication/qRcodeScanner.dart';
import 'package:image_picker/image_picker.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_footer.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';

class Home extends StatefulWidget {
  static String routeName = './Home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // File? _imageSelect;
  // var fileName;

  @override
  void initState() {
    super.initState();
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  // void selectImages() async {
  //   final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

  //   if (selectedImages!.isNotEmpty) {
  //     imageFileList!.addAll(selectedImages);
  //   }
  //   print("Image List Length:" + imageFileList!.length.toString());
  //   setState(() {});
  // // }
  // Future<void> _imgFromGallery() async {
  //   // ignore: deprecated_member_use
  //   dynamic image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       maxHeight: 450.0,
  //       maxWidth: 450.0,
  //       imageQuality: 50);
  //   if (image != null) {
  //     Future.delayed(const Duration(seconds: 2), () {
  //       setState(() {
  //         imageFileList!.add(image);
  //         _imageSelect = File(image!.path);
  //         fileName = image.path.split('/').last;

  //         var _btnActive = true;
  //         print(imageFileList);
  //       });
  //     });
  //   } else {
  //     setState(() {
  //       var _btnActive = false;
  //     });
  //   }

  //   // Navigator.of(context).pop();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final double rightPadding = screenSize.width * 0.5;
    final double leftPadding = screenSize.width * 0.1;
    return WillPopScope(
      onWillPop: () {
        return _showAlertDialog(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: Colors.white,
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  //////this container  getpoint logo and notification icons
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 3 / 100,
                          // width: leftPadding,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 5 / 100,
                          child: Image.asset(AppImage.getpointImage),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 40 / 100,
                          // width: leftPadding,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("notificaton button pressed");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NotificationPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 8 / 100,
                            child: Image.asset(AppImage.activeNotificationIcon),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //this container define the user profile and user name and user id
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 5 / 100,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 4 / 100,
                        ),
                        GestureDetector(
                          onTap: () {
                            // profileButtomSheet();
                            avatarsalert(context);
                          },
                          child: CircleAvatar(
                            radius: 23,
                            child: Image.asset(AppImage.activeProfileIcon),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 4 / 100,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello Business Name",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "ID:124434566746",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 12 / 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 13 / 100,
                          width: MediaQuery.of(context).size.width * 13 / 100,
                          child: Image.asset(AppImage.changelanguegeimage),
                        )
                      ],
                    ),
                  ),
                  //this container degine the  phone number account id and QR Code
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 5 / 100,
                          ),
                          GestureDetector(
                            onTap: () {
                              //print("hello");
                              // buttomSheet();
                              vatarsalertphoe(context);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width *
                                      40 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      80 /
                                      100,
                                  child: Image.asset(
                                    AppImage.phonenumber,
                                  ),
                                ),
                                Positioned(
                                  // top: 80,
                                  // right: 80,
                                  top: MediaQuery.of(context).size.height *
                                      12 /
                                      100,
                                  left: MediaQuery.of(context).size.width *
                                      25 /
                                      100,
                                  child: Text(
                                    "phone number",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 3 / 100,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRcodescanPage()));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width *
                                      40 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      80 /
                                      100,
                                  // decoration: BoxDecoration(
                                  //   borderRadius:
                                  //       BorderRadius.all(Radius.circular(30)),
                                  //   color: Colors.black,
                                  // ),
                                  child: Image.asset(
                                    AppImage.QRCodeImage,
                                  ),
                                ),
                                Positioned(
                                  // top: 80,
                                  // right: 80,
                                  top: MediaQuery.of(context).size.height *
                                      12 /
                                      100,
                                  left: MediaQuery.of(context).size.width *
                                      31 /
                                      100,
                                  child: Text(
                                    "QR Code",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 3 / 100,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AccountId()));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width *
                                      40 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      80 /
                                      100,
                                  // decoration: BoxDecoration(
                                  //   borderRadius:
                                  //       BorderRadius.all(Radius.circular(30)),
                                  //   color: Colors.black,
                                  // ),
                                  child: Image.asset(
                                    AppImage.AccountID,
                                  ),
                                ),
                                Positioned(
                                  // top: 80,
                                  // right: 80,
                                  top: MediaQuery.of(context).size.height *
                                      12 /
                                      100,
                                  left: MediaQuery.of(context).size.width *
                                      30 /
                                      100,
                                  child: Text(
                                    "Account ID",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )
                ]),
          ),
        ),

////footer navigation bar which is commmented by me////

        bottomNavigationBar: const AppFooter(
            selectedMenu: BottomMenus.home, notificationCount: 0),
        //  home
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes", style: TextStyle(color: Colors.black)),
      onPressed: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.areYouSureText[language]),
      content: Text(AppLanguage.exitAppText[language]),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //this buttom sheet define phone number bottom sheet
  vatarsalertphoe(context) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        // backgroundColor: const Color(0xff00000000).withOpacity(0.5),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Container(
                    height: MediaQuery.of(context).size.height * 90 / 100,
                    child: Center(
                        child: Container(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 4 / 100,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.width * 35 / 100,
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            child: Image.asset(
                              AppImage.phoneNumberModelimage,
                            ),
                          ),
                          Container(
                            child: Column(children: [
                              Text(
                                "Phone Number",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Please let the user write down his number for confidentially reasons",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height:
                                MediaQuery.of(context).size.height * 10 / 100,
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            padding: EdgeInsets.all(8),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(color: Colors.black),
                              // keyboardType: TextInputType.name,
                              //controller: firstNameTextEditingController,
                              //  maxLength: AppConstant.fullNameText,
                              // maxLength: AppConstant.onlytenNumber,
                              maxLength: 10,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  // prefixIcon: (Image.asset(
                                  //   AppImage.phoneIcon,
                                  // )),
                                  prefixIcon: Icon(Icons.phone),
                                  counterText: '',
                                  hintText: AppLanguage
                                      .phoneNumberbuttomsheet[language],
                                  hintStyle: AppConstant.textFilledStyle),
                            ),
                          ),
                          phoneNumberSendButtom(
                              text: AppLanguage.sendDetailsmsg[language],
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AccountDetailsByMe(),
                                    ));
                              }),
                        ],
                      ),
                    ))),
              );
            }),
          );
        });
  }

  avatarsalert(context) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        // backgroundColor: const Color(0xff00000000).withOpacity(0.5),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return Container(
                height: MediaQuery.of(context).size.height * 70 / 100,
                child: Center(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(children: [
                          // SizedBox(
                          //   height:
                          //       MediaQuery.of(context).size.height * 5 / 100,
                          // ),
                          Container(
                            width: MediaQuery.of(context).size.width *
                                double.infinity,
                            // height:
                            //     MediaQuery.of(context).size.height * 10 / 100,
                            child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        30 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        10 /
                                        100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                          AppImage.resturantImage,
                                        ))),
                                  ),
                                  //this container define the name of profile

                                  Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguage.companyName[language],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            AppLanguage.profileName[language],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ]),
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        30 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        10 /
                                        100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                AppImage.imageFood))),
                                  ),
                                ]),
                          ),
                          ////this row define phone number and email
                          ///
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                          ),

                          Container(
                            height:
                                MediaQuery.of(context).size.height * 8 / 100,
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguage.profilephone[language],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            AppLanguage
                                                .profilephoneNumber[language],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        23 /
                                        100,
                                  ),
                                  Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguage.profileEmail[language],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            AppLanguage
                                                .ProfileEmaiaddress[language],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                  ),
                                ]),
                          ),

                          //this row define city name and district
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 8 / 100,
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        100,
                                  ),
                                  Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguage.profileCity[language],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            AppLanguage
                                                .ProfileCityName[language],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        32.5 /
                                        100,
                                  ),
                                  Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguage
                                                .profileDistrictName[language],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            AppLanguage.profileDistrictaddress[
                                                language],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800),
                                            textAlign: TextAlign.center,
                                          ),
                                        ]),
                                  ),

                                  //this row define city and distric
                                ]),
                          ),

                          //SizedBox(height: MediaQuery.of(context).size.height * 1 / 100),

                          Container(
                            height:
                                MediaQuery.of(context).size.height * 30 / 100,
                            width: MediaQuery.of(context).size.width * 70 / 100,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Text(
                                      "About",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        70 /
                                        100,
                                    child: Text(
                                      AppLanguage.about[language],
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      //textAlign: TextAlign.center,
                                      textAlign: TextAlign.justify,
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }
}
