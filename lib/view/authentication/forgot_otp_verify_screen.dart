// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_loader.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'reset_password.dart';
import 'package:http/http.dart' as http;

class ForgotOtpVerify extends StatelessWidget {
  static String routeName = './ForgotOtpVerify';

  const ForgotOtpVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgotuserId? object;

    object = ModalRoute.of(context)!.settings.arguments as ForgotuserId;
    print(object.userId);
    print(object.phonenumber);

    return Scaffold(
      body: ForgotOtpVerify1(
        userId: object.userId,
        phonenumber: object.phonenumber,
      ),
    );
  }
}

class ForgotOtpVerify1 extends StatefulWidget {
  final String userId;
  final String phonenumber;
  const ForgotOtpVerify1(
      {Key? key, required this.userId, required this.phonenumber})
      : super(key: key);

  @override
  State<ForgotOtpVerify1> createState() => _ForgotOtpVerify1State();
}

class _ForgotOtpVerify1State extends State<ForgotOtpVerify1> {
  GlobalKey<FormState> _forgotOtpFormKey = new GlobalKey<FormState>();

  late Timer _timer;
  late int _secondsRemaining;
  bool resendText = true;
  bool isApiCalling = false;

  TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _secondsRemaining = 120;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          print("Else case timer");
          _timer.cancel();
          resendText = false;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCalling, opacity: 0.5, child: _build(context));
  }

  Widget _build(BuildContext context) {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    const focusedBorderColor = AppColor.textinputColor;
    const Color fillColor = AppColor.textinputColor;

    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.only(left: 8),
      width: 60,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColor.themeColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColor.textinputColor),
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColor.blackColor,
        statusBarIconBrightness: Brightness.light));
    return GestureDetector(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 10 / 100,
                      ),
                      Directionality(
                        textDirection: language == 1
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (() {
                                Navigator.pop(context);
                              }),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  language == 1
                                      ? AppImage.rightbackIcon
                                      : AppImage.backIcon,
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      5 /
                                      100,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 5 / 100,
                        width: MediaQuery.of(context).size.width * 50 / 100,
                        child: Image.asset(AppImage.getpointsImage),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      Text(AppLanguage.otpverficationText[language],
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColor.themeColor,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 100,
                      ),
                      Directionality(
                        textDirection: language == 1
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 85 / 100,
                          child: Column(
                            children: [
                              Text(
                                AppLanguage.wesentansmswithdigitcodetoyourText[
                                    language],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    85 /
                                    100,
                                child: Text(
                                  "+212 ${widget.phonenumber} ${AppLanguage.enteritsoweText[language]}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: AppColor.textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Text(
                                AppLanguage.besurethatthisnumberText[language],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      Pinput(
                        controller: pinController,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        autofocus: true,
                        length: 4,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          // setState(() {
                          //   verificationOtp = pin;
                          // });
                        },
                        onChanged: (value) {
                          // setState(() {
                          //   _btnActive = value.length == 5 ? true : false;
                          //   verificationOtp = value;
                          // });
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: 2,
                              height: 25,
                              color: AppColor.themeColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: focusedBorderColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        // errorPinTheme: defaultPinTheme.copyBorderWith(
                        //   border: Border.all(color: Colors.redAccent),
                        // ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                      AppButton(
                          text: AppLanguage.verifyButtonText[language],
                          onPress: () {
                            verifybtnValidation(pinController.text);
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        alignment: Alignment.center,
                        child: Text(
                          AppLanguage.recievetheotpText[language],
                          style: const TextStyle(
                              color: Color(0xff6F6F6F),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 100,
                      ),
                      resendText == false
                          ? GestureDetector(
                              onTap: () {
                                resendApiCall(widget.userId);
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      90 /
                                      100,
                                  alignment: Alignment.center,
                                  child: Directionality(
                                    textDirection: language == 1
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: Text(
                                      AppLanguage.resendOtpText[language],
                                      style: const TextStyle(
                                          color: Color(0xffD64252),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                  )),
                            )
                          : Text(
                              '$minutes:${seconds.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                  fontSize: 32, color: AppColor.themeColor),
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

  // ----------- Verify Btn Validation ----------
  verifybtnValidation(String otp) {
    if (otp.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.otpMessage[language]);
    } else if (otp.length < 4) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.otpless4Message[language]);
    } else {
      forgotOtpApiCall(otp);
    }
  }

  // ----------------- forgot OTP API call Start -------------
  forgotOtpApiCall(otp) async {
    Uri url =
        Uri.parse("${AppConfigProvider.apiUrl}forgot_password_otp_verify.php");
    print("Url $url");
    setState(() {
      isApiCalling = true;
    });
    try {
      http.MultipartRequest formData = http.MultipartRequest('POST', url);

      formData.fields['user_id'] = widget.userId.toString();

      formData.fields['otp'] = otp.toString();

      http.StreamedResponse response = await formData.send();
      print("response--> $response");
      var responseString = await response.stream.toBytes();
      var res = jsonDecode(utf8.decode(responseString));

      if (response.statusCode == 200) {
        print("res========> : $res");
        print(res['msg'][0]);

        if (res['success'] == 'true') {
          if (res['user_details'] != "NA") {
            setState(() {
              isApiCalling = false;
            });

            print("Hello");

            // ignore: use_build_context_synchronously
            SnackBarToastMessage.showSnackBar(context, res['msg'][language]);

            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, ResetPassword.routeName,
                arguments:
                    ForgotnewpassworduserId(userId: widget.userId.toString()));
          }
        } else {
          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
          // ignore: use_build_context_synchronously
          print(res['msg']);
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

// ----------------- forgot OTP API call End --------------

// ------------------ Resend OTP Api Calling Start ---------

  resendApiCall(userId) async {
    Uri url =
        Uri.parse("${AppConfigProvider.apiUrl}forgot_password_resend_otp.php");
    print("Url $url");
    setState(() {
      isApiCalling = true;
    });
    try {
      http.MultipartRequest formData = http.MultipartRequest('POST', url);

      formData.fields['user_id'] = userId.toString();

      http.StreamedResponse response = await formData.send();
      print("response--> $response");
      var responseString = await response.stream.toBytes();
      var res = jsonDecode(utf8.decode(responseString));

      if (response.statusCode == 200) {
        print("res : $res");
        if (res['success'] == 'true') {
          _secondsRemaining = 120;
          _startTimer();
          resendText = true;

          print("resendText $resendText");

          setState(() {
            isApiCalling = false;
          });

          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
          // ignore: use_build_context_synchronously

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

// ------------------ Resend OTP Api Calling End  ----------
}
