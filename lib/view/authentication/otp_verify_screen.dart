import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getpoints/view/OtherPages/home_screen.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'reset_password.dart';

class OtpVerify extends StatefulWidget {
  static String routeName = './OtpVerify';
  const OtpVerify({super.key});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  GlobalKey<FormState> _forgotOtpFormKey = new GlobalKey<FormState>();

  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController firstInputController = TextEditingController();
  TextEditingController secondInputController = TextEditingController();
  TextEditingController thirdInputController = TextEditingController();
  TextEditingController forthInputController = TextEditingController();

  String firstInput = '';
  String secondInput = '';
  String thirdInput = '';
  String forthInput = '';

  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  forgotOtpUserValidation(String firstInput, String secondInput,
      String thirdInput, String fourthInput) async {}

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  void previousField(String value, FocusNode focusNode) {
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 100 / 100,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _forgotOtpFormKey,
              child: Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 6 / 100,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        AppImage.backIcon,
                        width: MediaQuery.of(context).size.width * 8 / 100,
                        height: MediaQuery.of(context).size.height * 8 / 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 60 / 100,
                      child: Text(
                        "Enter Verfication",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 80 / 100,
                      child: Text(
                        "Please enter the 4-digit code sent to",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 80 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              "+966",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 3),
                            alignment: Alignment.center,
                            child: Text(
                              "6878880909",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 5 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 80 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          child: Center(
                            child: TextFormField(
                              cursorColor: AppColor.blackColor,
                              autofocus: true,
                              readOnly: false,
                              focusNode: pin1FocusNode,
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.blackColor, width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.blackColor, width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.blackColor, width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                ),
                                contentPadding: EdgeInsets.all((12)),
                                fillColor:
                                    (firstInputController.text.length > 0)
                                        ? AppColor.themeColor
                                        : Colors.white,
                                filled: true,
                              ),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: (firstInputController.text.length > 0)
                                      ? Colors.black
                                      : Colors.black),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              onTap: () {
                                pin1FocusNode!.requestFocus();
                              },
                              onChanged: (value) {
                                print(firstInputController.text.length);
                                print(firstInputController.text);
                                firstInputController.text = value;
                                nextField(value, pin2FocusNode!);
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 55,
                          height: 55,
                          child: TextFormField(
                            cursorColor: AppColor.blackColor,
                            maxLength: 1,
                            autofocus: true,
                            readOnly: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textAlign: TextAlign.center,
                            focusNode: pin2FocusNode,
                            onTap: () {
                              pin2FocusNode!.requestFocus();
                            },
                            onChanged: (value) {
                              if (value.length == 0) {
                                secondInputController.text = '';
                                previousField(value, pin1FocusNode!);
                              } else {
                                secondInputController.text = value;
                                nextField(value, pin3FocusNode!);
                              }
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              contentPadding: EdgeInsets.all((12)),
                              fillColor: (secondInputController.text.length > 0)
                                  ? AppColor.themeColor
                                  : Colors.white,
                              filled: true,
                            ),
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: (secondInputController.text.length > 0)
                                    ? Colors.black
                                    : Colors.black),
                          ),
                        ),
                        Container(
                          width: (55),
                          height: (55),
                          child: TextFormField(
                            cursorColor: AppColor.blackColor,
                            maxLength: 1,
                            autofocus: true,
                            // readOnly: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              contentPadding: EdgeInsets.all((12)),
                              fillColor: (thirdInputController.text.length > 0)
                                  ? AppColor.themeColor
                                  : Colors.white,
                              filled: true,
                            ),
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: (thirdInputController.text.length > 0)
                                    ? Colors.black
                                    : Colors.black),
                            focusNode: pin3FocusNode,
                            onTap: () {
                              pin3FocusNode!.requestFocus();
                            },
                            onChanged: (value) {
                              print('hello');
                              if (value.length == 0) {
                                thirdInputController.text = '';
                                previousField(value, pin2FocusNode!);
                              } else {
                                nextField(value, pin4FocusNode!);
                                thirdInputController.text = value;
                              }
                            },
                          ),
                        ),
                        Container(
                          width: (55),
                          height: (55),
                          child: TextFormField(
                            cursorColor: AppColor.blackColor,
                            focusNode: pin4FocusNode,
                            autofocus: true,
                            readOnly: false,
                            maxLength: 1,
                            // obscureText: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blackColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              contentPadding: EdgeInsets.all((12)),
                              fillColor: (forthInputController.text.length > 0)
                                  ? AppColor.themeColor
                                  : Colors.white,
                              filled: true,
                            ),
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: (forthInputController.text.length > 0)
                                    ? Colors.black
                                    : Colors.black),
                            onTap: () {
                              pin4FocusNode?.requestFocus();
                            },
                            onChanged: (value) {
                              if (value.length == 0) {
                                forthInputController.text = '';
                                previousField(value, pin3FocusNode!);
                              } else {
                                forthInputController.text = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  AppButton(
                      text: AppLanguage.verifyButtonText[language],
                      onPress: () {
                        forgotOtpUserValidation(
                            firstInputController.text,
                            secondInputController.text,
                            thirdInputController.text,
                            forthInputController.text);
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 86 / 100,
                      height: MediaQuery.of(context).size.height * 7 / 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(width: 2, color: AppColor.themeColor),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Modification",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2.5 / 100,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.red, style: BorderStyle.solid),
                        ),
                      ),
                      child: Text(
                        AppLanguage.resendOtpText[language],
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
