import 'package:flutter/material.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'setting_screen.dart';

class ContactUs extends StatefulWidget {
  static String routeName = './ContactUs';

  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  contactUsUserValidation(
      String userFullName, String userEmail, String userMessage) async {}

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
          title: Text("Contact", style: AppConstant.appBarTitleStyle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 100 / 100,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.backIcon),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    78 /
                                    100,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.black,
                                  controller: fullNameTextEditingController,
                                  maxLength: AppConstant.fullNameText,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 2.0, left: 8),
                                      hintText: "Full Name",
                                      hintStyle: AppConstant.textFilledStyle),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 89 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.backIcon),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    78 /
                                    100,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailTextEditingController,
                                  cursorColor: Colors.black,
                                  maxLength: AppConstant.emailMaxLength,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 2.0, left: 8),
                                      hintText: "Email",
                                      hintStyle: AppConstant.textFilledStyle),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 89 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
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
                      // height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.backIcon),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    77 /
                                    100,
                                //  height:
                                //       MediaQuery.of(context).size .height * 6.0 / 100,

                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1)),
                                  keyboardType: TextInputType.multiline,
                                  controller: messageTextEditingController,
                                  // textInputAction: TextInputAction.done,
                                  maxLines: 5,
                                  maxLength: 250,
                                  // controller: messageTextEditingController,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Message",
                                      hintStyle: AppConstant.textFilledStyle),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top: 1),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 10 / 100,
                    ),
                    AppButton(
                      onPress: () {
                        contactUsUserValidation(
                            fullNameTextEditingController.text,
                            emailTextEditingController.text,
                            messageTextEditingController.text);
                      },
                      text: "Sumit",
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
