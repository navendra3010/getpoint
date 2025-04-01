import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'setting_screen.dart';

class ChangePassword extends StatefulWidget {
  static String routeName = './ChangePassword';
  const ChangePassword({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordTextEditingController =
      TextEditingController();

  TextEditingController newPasswordTextEditingController =
      TextEditingController();

  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  bool isPasswordVisible = true;
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

  changePasswordUserValidation(String currentPassword, String newPassword,
      String confirmPassword) async {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          systemOverlayStyle: AppConstant.systemUiOverlayStyle,
          leading: InkWell(
              onTap: () {},
              child: IconButton(
                icon: Image.asset(
                  AppImage.backIcon,
                  width: MediaQuery.of(context).size.width * 8 / 100,
                  height: MediaQuery.of(context).size.height * 8 / 100,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Setting()),
                  );
                },
              )),
          title: Text("asfsf", style: AppConstant.appBarTitleStyle),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                Container(
                  //  padding: EdgeInsets.only(top:1),
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  height: MediaQuery.of(context).size.height * 6 / 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 8 / 100,
                            height: MediaQuery.of(context).size.width * 8 / 100,
                            child: Image.asset(AppImage.backIcon),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 75 / 100,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              obscureText: isPasswordVisible,
                              cursorColor: Colors.black,
                              maxLength: AppConstant.passwordMaxLength,
                              textAlignVertical: TextAlignVertical.center,
                              controller: currentPasswordTextEditingController,
                              decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true,
                                  //  contentPadding:EdgeInsets.only(bottom: 2.0,left: 8),
                                  suffixIcon: TextButton(
                                    child: Text(
                                      isPasswordVisible ? "Show" : "Hide",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                  hintText: "",
                                  hintStyle: AppConstant.textFilledStyle),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: EdgeInsets.only(top: 1),
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.height * 0.1 / 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
                Container(
                  //  padding: EdgeInsets.only(top:1),
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  height: MediaQuery.of(context).size.height * 6 / 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 8 / 100,
                            height: MediaQuery.of(context).size.width * 8 / 100,
                            child: Image.asset(AppImage.backIcon),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 75 / 100,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              obscureText: isNewPasswordVisible,
                              cursorColor: Colors.black,
                              controller: newPasswordTextEditingController,
                              textAlignVertical: TextAlignVertical.center,
                              maxLength: AppConstant.passwordMaxLength,
                              decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true,
                                  //  contentPadding:EdgeInsets.only(bottom: 2.0,left: 8),
                                  suffixIcon: TextButton(
                                    child: Text(
                                      isNewPasswordVisible ? "Show" : "Hide",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isNewPasswordVisible =
                                            !isNewPasswordVisible;
                                      });
                                    },
                                  ),
                                  hintText: "New Password",
                                  hintStyle: AppConstant.textFilledStyle),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: EdgeInsets.only(top: 1),
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.height * 0.1 / 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  height: MediaQuery.of(context).size.height * 6 / 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 8 / 100,
                            height: MediaQuery.of(context).size.width * 8 / 100,
                            child: Image.asset(AppImage.backIcon),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 75 / 100,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              obscureText: isConfirmPasswordVisible,
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.black,
                              controller: confirmPasswordTextEditingController,
                              maxLength: AppConstant.passwordMaxLength,
                              decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true,
                                  //  contentPadding:EdgeInsets.only(bottom: 2.0,left: 8),
                                  suffixIcon: TextButton(
                                    child: Text(
                                      isConfirmPasswordVisible
                                          ? "Show"
                                          : "Hide",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isConfirmPasswordVisible =
                                            !isConfirmPasswordVisible;
                                      });
                                    },
                                  ),
                                  hintText: "edgfds",
                                  hintStyle: AppConstant.textFilledStyle),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: EdgeInsets.only(top: 1),
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.height * 0.1 / 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 50),
                    child: AppButton(
                        text: AppLanguage.updatePasswordButtonText[language],
                        onPress: () {
                          changePasswordUserValidation(
                              currentPasswordTextEditingController.text,
                              newPasswordTextEditingController.text,
                              confirmPasswordTextEditingController.text);
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
