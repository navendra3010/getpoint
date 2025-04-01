import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_loader.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'content.dart';
import 'login_screen.dart';
import 'otp_verify_screen.dart';

class Signup extends StatefulWidget {
  static String routeName = './Signup';
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isCheckBoxValue = false;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool isApiCalling = false;

  TextEditingController fullNameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  signUpUserValidation(String fullname, String email, String password,
      String confirmpassword) async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCalling,
        opacity: 0.5,
        child: _buildUIScreen(context));
  }

  Widget _buildUIScreen(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              height: MediaQuery.of(context).size.height * 100 / 100,
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 10, left: 6),
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 8 / 100),
                  Container(
                    child: FlutterLogo(
                      size: 80,
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 8 / 100),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 85 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.name,
                        controller: fullNameTextEditingController,
                        maxLength: AppConstant.fullNameText,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            hintText: 'Full Name',
                            hintStyle: AppConstant.textFilledStyle),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 85 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailTextEditingController,
                        maxLength: AppConstant.emailMaxLength,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            hintText: 'Email',
                            hintStyle: AppConstant.textFilledStyle),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 85 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        controller: passwordTextEditingController,
                        maxLength: AppConstant.passwordMaxLength,
                        obscureText: isPasswordVisible,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            hintStyle: AppConstant.textFilledStyle),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 85 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        controller: confirmPasswordTextEditingController,
                        maxLength: AppConstant.passwordMaxLength,
                        obscureText: isConfirmPasswordVisible,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            suffixIcon: IconButton(
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'Confirm Password',
                            hintStyle: AppConstant.textFilledStyle),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 85 / 100,
                    child: Row(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 6 / 100,
                          width: MediaQuery.of(context).size.width * 6 / 100,
                          child: Checkbox(
                            value: this.isCheckBoxValue,
                            onChanged: (isCheckBoxValue) {
                              setState(() {
                                this.isCheckBoxValue = isCheckBoxValue!;
                              });
                            },
                          ),
                        ),
                        const Text(
                          "I Accpect",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.8 / 100),
                        GestureDetector(
                          onTap: (() {
                            Navigator.pushNamed(context, Content.routeName,
                                arguments: ContentClass(
                                    title: "Terms & Condition".toString()));
                          }),
                          child: const Text(
                            "Terms & Condications",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.8 / 100),
                        const Text(
                          "and ",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.8 / 100),
                        GestureDetector(
                          onTap: (() {
                            Navigator.pushNamed(context, Content.routeName,
                                arguments: ContentClass(
                                    title: "Privacy Policy".toString()));
                          }),
                          child: const Text(
                            "gdfgdf",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100),
                  AppButton(
                      text: "Signup",
                      onPress: () {
                        signUpUserValidation(
                            fullNameTextEditingController.text,
                            emailTextEditingController.text,
                            passwordTextEditingController.text,
                            confirmPasswordTextEditingController.text);
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 85 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
