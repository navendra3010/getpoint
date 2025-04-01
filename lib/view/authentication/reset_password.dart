// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getpoints/utilities/app_color.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_loader.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatelessWidget {
  static String routeName = './ResetPassword';

  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotnewpassworduserId? object;

    object =
        ModalRoute.of(context)!.settings.arguments as ForgotnewpassworduserId;
    print(object.userId);

    return Scaffold(
      body: ResetPassword1(
        userId: object.userId,
      ),
    );
  }
}

class ResetPassword1 extends StatefulWidget {
  final String userId;

  @override
  // ignore: library_private_types_in_public_api
  _ResetPassword1State createState() => _ResetPassword1State();
  const ResetPassword1({Key? key, required this.userId}) : super(key: key);
}

class _ResetPassword1State extends State<ResetPassword1> {
  TextEditingController newPasswordTextEditingController =
      TextEditingController();

  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  bool isApiCalling = false;
  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  updatepasswordbtnValidation(String newpassword, String confirmpassword) {
    if (newpassword.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.enternewpasswordText[language]);
    } else if (newpassword.length < 6) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.passwordminMessage[language]);
    } else if (confirmpassword.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.enterconfirmpasswordMessage[language]);
    } else if (confirmpassword.length < 6) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.passwordminMessage[language]);
    } else if (newpassword != confirmpassword) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.newpasswordandconfirmpasswordMessage[language]);
    } else {
      newpasswordApiCall(newpassword);
    }
  }

  // --------------- New passwrod API Start ---------------
  newpasswordApiCall(newpassword) async {
    Uri url = Uri.parse("${AppConfigProvider.apiUrl}forgot_new_password.php");
    print("Url $url");
    setState(() {
      isApiCalling = true;
    });
    try {
      http.MultipartRequest formData = http.MultipartRequest('POST', url);

      formData.fields['user_id'] = widget.userId.toString();
      formData.fields['new_password'] = newpassword.toString();
      formData.fields['user_type'] = "1".toString();

      http.StreamedResponse response = await formData.send();
      print("response--> $response");
      var responseString = await response.stream.toBytes();
      var res = jsonDecode(utf8.decode(responseString));

      if (response.statusCode == 200) {
        print("res========> : $res");
        print(res['msg'][0]);

        if (res['success'] == 'true') {
          print("userid ${widget.userId}");

          setState(() {
            isApiCalling = false;
          });
          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
          // ignore: use_build_context_synchronously

          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        } else {
          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
          // ignore: use_build_context_synchronously

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

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCalling, opacity: 0.5, child: _build(context));
  }

  Widget _build(BuildContext context) {
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
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 100 / 100,
              height: MediaQuery.of(context).size.height * 100 / 100,
              color: AppColor.secondryColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100,
                    ),
                    Directionality(
                      textDirection:
                          language == 1 ? TextDirection.rtl : TextDirection.ltr,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (() {
                              _showAlertDialog(context);
                            }),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                language == 1
                                    ? AppImage.rightbackIcon
                                    : AppImage.backIcon,
                                width:
                                    MediaQuery.of(context).size.width * 5 / 100,
                                height: MediaQuery.of(context).size.height *
                                    5 /
                                    100,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            padding: language == 1
                                ? EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        3 /
                                        100)
                                : EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        3 /
                                        100),
                            child: Directionality(
                              textDirection: language == 1
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: Text(
                                  AppLanguage.resetpasswordText[language],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColor.themeColor,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
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
                          controller: newPasswordTextEditingController,
                          maxLength: AppConstant.passwordMaxLength,
                          obscureText: isNewPasswordVisible,
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
                                        height:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                        child: Image.asset(language == 1
                                            ? AppImage.rightpasswordIcon
                                            : AppImage.passwordIcon),
                                      ),
                                    )
                                  ]),
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.textinputColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.textinputColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.textinputColor),
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
                                  child: Image.asset(
                                      isNewPasswordVisible == true
                                          ? AppImage.passwordhideIcon
                                          : AppImage.passwordshowIcon),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isNewPasswordVisible =
                                        !isNewPasswordVisible;
                                  });
                                },
                              ),
                              hintText: AppLanguage.newpasswordText[language],
                              hintStyle: AppConstant.textFilledStyle),
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
                          controller: confirmPasswordTextEditingController,
                          maxLength: AppConstant.passwordMaxLength,
                          obscureText: isConfirmPasswordVisible,
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
                                        height:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                        child: Image.asset(language == 1
                                            ? AppImage.rightpasswordIcon
                                            : AppImage.passwordIcon),
                                      ),
                                    )
                                  ]),
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.textinputColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.textinputColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.textinputColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              fillColor: AppColor.textinputColor,
                              filled: true,
                              counterText: '',
                              suffixIcon: IconButton(
                                icon: GestureDetector(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        5 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        5 /
                                        100,
                                    child: Image.asset(
                                        isConfirmPasswordVisible == true
                                            ? AppImage.passwordhideIcon
                                            : AppImage.passwordshowIcon),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              hintText:
                                  AppLanguage.confrimnewpasswordText[language],
                              hintStyle: AppConstant.textFilledStyle),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100),
                    AppButton(
                        text: AppLanguage.updatePasswordButtonText[language],
                        onPress: () {
                          updatepasswordbtnValidation(
                              newPasswordTextEditingController.text,
                              confirmPasswordTextEditingController.text);
                        }),
                  ],
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
      child: Directionality(
        textDirection: language == 1 ? TextDirection.rtl : TextDirection.ltr,
        child: Text(
          AppLanguage.noText[language],
          style: const TextStyle(color: Colors.red),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Directionality(
          textDirection: language == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: Text(AppLanguage.yesText[language],
              style: const TextStyle(color: Colors.black))),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Directionality(
          textDirection: language == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: Text(AppLanguage.areYouSureText[language])),
      content: Directionality(
          textDirection: language == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: Text(AppLanguage.doyouwantgobackText[language])),
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
}
