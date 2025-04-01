// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_loader.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import '../OtherPages/home_screen.dart';
import 'forgot_password_screen.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  static String routeName = './Login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordVisible = true;
  bool isApiCalling = false;

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  List<dynamic> languageList = <dynamic>[
    {"id": 0, "language": "English", "status": true},
    {"id": 1, "language": "Arabic", "status": false},
    {"id": 2, "language": "French", "status": false},
  ];

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  // -------------- Local Storage ----------------
  Future<dynamic> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic language1 = prefs.getString("language_id");

    print("language $language1");

    // ----------- Language --------------
    if (language1 != null) {
      dynamic data = json.decode(language1);

      language = data;

      List list = languageList;
      for (var i = 0; i < list.length; i++) {
        if (list[i]['id'] == data) {
          list[i]['status'] = true;
        } else {
          list[i]['status'] = false;
        }
      }
      print("list $list");
      List firstIndexRecord = [];
      List remainIndexRecord = [];

      for (var i = 0; i < list.length; i++) {
        if (list[i]['status'] == true) {
          firstIndexRecord.add(list[i]);
        } else {
          remainIndexRecord.add(list[i]);
        }
      }
      List finalLanguageList = [...firstIndexRecord, ...remainIndexRecord];
      setState(() {
        languageList = finalLanguageList;
      });
      // setState(() {
      //   languageList =
      // });
    }
  }

  // --------- Login Btn Validation ---------

  loginbtnValidation(String phonenumber, String password) {
    if (phonenumber.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.phonenumberMessage[language]);
    } else if (phonenumber.length < 9) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.validphonenumberMessage[language]);
    } else if (password.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.passwordMessage[language]);
    } else if (password.length < 6) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.passwordminMessage[language]);
    } else {
      loginapicallingStart(phonenumber, password, 1);
    }
  }

  // --------- Login Api Calling Start -------------------

  loginapicallingStart(phonenumber, password, count) async {
    Uri url = Uri.parse("${AppConfigProvider.apiUrl}login.php");

    print("Url $url");

    setState(() {
      isApiCalling = true;
    });

    try {
      String playeID = AppConstant.playerID.toString();
      print("playeID line number 101 $playeID");
      http.MultipartRequest formData = http.MultipartRequest('POST', url);

      formData.fields['mobile'] = phonenumber.toString();
      formData.fields['password'] = password.toString();
      formData.fields['player_id'] = playeID;
      formData.fields['device_type'] = AppConstant.deviceType.toString();
      formData.fields['login_type'] = "app";
      formData.fields['language_id'] = language.toString();
      formData.fields['user_type'] = "2".toString();

      http.StreamedResponse response = await formData.send();
      print("response--> $response");
      var responseString = await response.stream.toBytes();
      var res = jsonDecode(utf8.decode(responseString));

      if (response.statusCode == 200) {
        print("res : $res");
        if (res['success'] == 'true') {
          if (res['user_details'] != "NA") {
            final prefs = await SharedPreferences.getInstance();
            print("prefs =================>$prefs");
            prefs.setString("user_details", jsonEncode(res['user_details']));
            prefs.setString("password", jsonEncode(password.toString()));
            setState(() {
              isApiCalling = false;
            });

            // ignore: use_build_context_synchronously
            SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
            //FirebaseProvider.firebaseCreateUser(true);
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        } else {
          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
          setState(() {
            isApiCalling = false;
          });
        }
      } else {
        setState(() {
          isApiCalling = false;
        });
      }
    } catch (e) {
      setState(() {
        isApiCalling = false;
      });
    }
  }

  // --------- Login Api Calling End ---------------------

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCalling,
        opacity: 0.5,
        child: _buildUIScreen(context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildUIScreen(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColor.blackColor,
        statusBarIconBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () {
        return _showAlertDialog(context);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.blackColor,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  height: MediaQuery.of(context).size.height * 100 / 100,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 37 / 100,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            AppImage.loginImage,
                          ),
                          fit: BoxFit.fill,
                        )),
                      ),

                      // --------------- Start Textinput -----------------

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLanguage.businessloginText[language],
                              style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 21),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.5 /
                                    100),
                            Text(
                              AppLanguage
                                  .enterthedetailsgivenbelcowText[language],
                              style: const TextStyle(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 90 / 100,
                          height: MediaQuery.of(context).size.height * 7 / 100,
                          child: Directionality(
                            textDirection: language == 1
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: TextFormField(
                              // inputFormatters: [maskFormatter],
                              style: const TextStyle(color: Colors.black),
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.phone,
                              controller: phoneTextEditingController,
                              maxLength: AppConstant.mobileMaxLenth,
                              decoration: InputDecoration(
                                  prefixIcon: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: language == 1
                                              ? EdgeInsets.only(
                                                  // right: 5,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.8 /
                                                      100)
                                              : EdgeInsets.only(
                                                  left: 5,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4 /
                                                      100),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                5 /
                                                100,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                5 /
                                                100,
                                            child: Image.asset(language == 1
                                                ? AppImage.rightphonenumberIcon
                                                : AppImage.phonenumberIcon),
                                          ),
                                        )
                                      ]),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.textinputColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.textinputColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.textinputColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  fillColor: AppColor.textinputColor,
                                  filled: true,
                                  counterText: '',
                                  hintText:
                                      AppLanguage.phonenumberText[language],
                                  hintStyle: AppConstant.textFilledStyle),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        child: Directionality(
                          textDirection: language == 1
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(color: AppColor.blackColor),
                            keyboardType: TextInputType.text,
                            controller: passwordTextEditingController,
                            maxLength: AppConstant.passwordMaxLength,
                            obscureText: isPasswordVisible,
                            decoration: InputDecoration(
                                prefixIcon: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: language == 1
                                            ? EdgeInsets.only(
                                                // right: 5,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.8 /
                                                    100)
                                            : EdgeInsets.only(
                                                left: 5,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    100),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              5 /
                                              100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              5 /
                                              100,
                                          child: Image.asset(language == 1
                                              ? AppImage.rightpasswordIcon
                                              : AppImage.passwordIcon),
                                        ),
                                      )
                                    ]),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                fillColor: AppColor.textinputColor,
                                filled: true,
                                counterText: '',
                                suffixIcon: IconButton(
                                  icon: SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        5 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        5 /
                                        100,
                                    child: Image.asset(isPasswordVisible == true
                                        ? AppImage.passwordhideIcon
                                        : AppImage.passwordshowIcon),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                                hintText: AppLanguage.passwordText[language],
                                hintStyle: AppConstant.textFilledStyle),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      AppButton(
                          text: AppLanguage.loginButtonText[language],
                          onPress: () {
                            loginbtnValidation(phoneTextEditingController.text,
                                passwordTextEditingController.text);
                          }),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 95 / 100,
                        child: TextButton(
                          child: Text(
                            AppLanguage.forgotpasswordText[language],
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100),
                      GestureDetector(
                        onTap: () {
                          languagealert(context);
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            height:
                                MediaQuery.of(context).size.height * 7 / 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                border: Border.all(
                                  color: AppColor.blackColor,
                                )),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      10 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      10 /
                                      100,
                                  child: Image.asset(
                                    AppImage.languageIcon,
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        100),
                                Text(
                                  AppLanguage.changelanguageText[language],
                                  style: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        AppLanguage.noText[language],
        style: const TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(AppLanguage.yesText[language],
          style: const TextStyle(color: Colors.black)),
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

  languagealert(context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: const Color(0xff00000000).withOpacity(0.8),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: ((context, setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 100 / 100,
            width: MediaQuery.of(context).size.width * 100 / 100,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 72 / 100),
                  Container(
                      height: MediaQuery.of(context).size.height * 28 / 100,
                      width: MediaQuery.of(context).size.width * 100 / 100,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                        color: AppColor.secondryColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100),
                          Container(
                            height:
                                MediaQuery.of(context).size.width * 0.5 / 100,
                            width: MediaQuery.of(context).size.width * 12 / 100,
                            color: AppColor.textColor,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            child: Text(
                              AppLanguage.changelanguageText[language],
                              style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100),
                          SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 80 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 15 / 100,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  print("Index ${languageList[index]}");
                                  return InkWell(
                                    onTap: () async {
                                      List data = [];
                                      List firstIndexRecord = [];
                                      List remainIndexRecord = [];
                                      for (var i = 0;
                                          i < languageList.length;
                                          i++) {
                                        if (index == i) {
                                          languageList[i]['status'] = true;
                                          firstIndexRecord.add(languageList[i]);
                                        } else {
                                          languageList[i]['status'] = false;
                                          remainIndexRecord
                                              .add(languageList[i]);
                                        }
                                      }

                                      languageList = [
                                        ...firstIndexRecord,
                                        ...remainIndexRecord
                                      ];

                                      setState(() {});

                                      language = firstIndexRecord[0]['id'];
                                      // -----Local Storage ------------
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          "language_id", jsonEncode(language));
                                      // -----Local Storage End------------

                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          80 /
                                          100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(languageList[index]['language'],
                                              style: const TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          if (languageList[index]['status'] ==
                                              true)
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    6 /
                                                    100,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    6 /
                                                    100,
                                                child: Image.asset(
                                                    AppImage.rightIcon))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ))
                        ],
                      ))
                ],
              ),
            ),
          );
        }));
      },
    );
  }
}
