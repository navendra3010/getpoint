import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_loader.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'forgot_otp_verify_screen.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  static String routeName = './ForgotPassword';

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phoneTextEditingController = TextEditingController();

  int userId = 0;
  bool isApiCalling = false;

  // --------------------- Forgot Password API End -------------
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCalling,
        opacity: 0.5,
        child: _buildUIScreen(context));
  }

  Widget _buildUIScreen(BuildContext context) {
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
                            Navigator.pop(context);
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
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 80 / 100,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 5 / 100,
                    width: MediaQuery.of(context).size.width * 50 / 100,
                    child: Image.asset(AppImage.getpointsImage),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Text(AppLanguage.forgotpasswordText[language],
                      style: const TextStyle(
                          fontSize: 16,
                          color: AppColor.themeColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 80 / 100,
                    child: Text(
                        AppLanguage.phonenumberfortheverificationText[language],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
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
                                            ? AppImage.rightphonenumberIcon
                                            : AppImage.phonenumberIcon),
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
                              hintText: AppLanguage.phonenumberText[language],
                              hintStyle: AppConstant.textFilledStyle),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  AppButton(
                      text: AppLanguage.sendButtonText[language],
                      onPress: () {
                        sendbtnValidation(phoneTextEditingController.text);
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  //------------- Send Btn Validation --------------

  sendbtnValidation(String phonenumber) {
    if (phonenumber.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.phonenumberMessage[language]);
    } else if (phonenumber.length < 9) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.validphonenumberMessage[language]);
    } else {
      forgotpasswordApiCallingStart(phonenumber);
    }
  }

  // ------------- Forgot Password Api Calling Start -------------

  forgotpasswordApiCallingStart(phonenumber) async {
    Uri url = Uri.parse("${AppConfigProvider.apiUrl}forgot_password.php");
    print("Url $url");
    setState(() {
      isApiCalling = true;
    });

    try {
      http.MultipartRequest formData = http.MultipartRequest('POST', url);

      formData.fields['mobile'] = phonenumber.toString();
      formData.fields['user_type'] = "2".toString();

      http.StreamedResponse response = await formData.send();
      print("response--> $response");
      var responseString = await response.stream.toBytes();
      var res = jsonDecode(utf8.decode(responseString));

      if (response.statusCode == 200) {
        print("res : $res");
        if (res['success'] == "true") {
          print("res : $res");
          if (res['user_details'] != "NA") {
            final userdetails = res['UserDetails'];

            print("userdetails line 126 $userdetails");

            userId = userdetails['user_id'];
            phonenumber = userdetails['mobile'];
            print("user_id $userId");
            print("phonenumber $phonenumber");
            // print("phone $phone");

            setState(() {
              isApiCalling = false;
            });

            // ignore: use_build_context_synchronously
            SnackBarToastMessage.showSnackBar(context, res['msg'][language]);

            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, ForgotOtpVerify.routeName,
                arguments: ForgotuserId(
                    userId: userId.toString(),
                    phonenumber: phonenumber.toString()));
          }
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
  // ------------- Forgot Password Api Calling End --------------
}
