import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_media_provider.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'profile.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static String routeName = './EditProfile';
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String imageController = "NA";
  String base64Image = "NA";
  String fileName = "NA";
  File? _imageSelect;
  bool isSelectedImage = false;

  File? _image;
  File? _pickedImage;

  String imageshow = "NA";

  TextEditingController firstNameTextEditingController =
      TextEditingController();

  TextEditingController lastNameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController mobileNumberTextEditingController =
      TextEditingController();

  String selectLocation = "NA";
  void initState() {
    super.initState();
  }

  editProfileUserValidation(
    String firstName,
    String lastName,
    String email,
    String mobileNumber,
  ) async {}

  @override
  void dispose() {
    super.dispose();
  }

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
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              )),
          title: Text("Edit", style: AppConstant.appBarTitleStyle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              // height: MediaQuery.of(context).size.height * 100 / 100,
              color: Colors.white,
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100,
                      ),
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
                              height:
                                  MediaQuery.of(context).size.width * 40 / 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 5, color: const Color(0xffe0e0e0)),
                                borderRadius:
                                    BorderRadius.circular(100), //<-- SEE HERE

                                image: _image != null
                                    ? DecorationImage(
                                        image: FileImage(_image!),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(AppImage.backIcon),
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: MediaQuery.of(context).size.width * 30 / 100,
                            child: GestureDetector(
                              onTap: (() async {
                                imagepickerButton();
                              }),
                              child: Container(
                                height: MediaQuery.of(context).size.width *
                                    12 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    12 /
                                    100,
                                child: Image.asset(AppImage.backIcon),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 1.5 / 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Liam Smith,",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              )),
                          Text("23",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              )),
                        ],
                      ),
                      const Text("Changi,Singapore",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 85 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.name,
                        controller: firstNameTextEditingController,
                        maxLength: AppConstant.fullNameText,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            hintText: "First Name",
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
                        keyboardType: TextInputType.name,
                        controller: lastNameTextEditingController,
                        maxLength: AppConstant.fullNameText,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            hintText: "Last",
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
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            hintText: AppLanguage.emailText[language],
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
                        enabled: true,
                        maxLength: AppConstant.mobileMaxLenth,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        controller: mobileNumberTextEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            counterText: '',
                            fillColor: Colors.white,
                            filled: true,
                            // contentPadding:
                            //     EdgeInsets.only(bottom: 2.0, left: 8),
                            // errorStyle: TextStyle(color: Colors.red),
                            hintText: "Mobile",
                            hintStyle: AppConstant.textFilledStyle),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 6 / 100),
                  AppButton(
                      text: "Update",
                      onPress: () {
                        editProfileUserValidation(
                            firstNameTextEditingController.text,
                            lastNameTextEditingController.text,
                            emailTextEditingController.text,
                            mobileNumberTextEditingController.text);
                      }),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  imagepickerButton() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: const Color(0xff00000030),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: ((context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 30 / 100,
            width: MediaQuery.of(context).size.width * 80 / 100,
            color: const Color(0xff00000030),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100),
                  Container(
                    height: MediaQuery.of(context).size.height * 16 / 100,
                    width: MediaQuery.of(context).size.width * 80 / 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.secondryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        const Text(
                          "Select Option",
                          style: TextStyle(
                              color: Color(0xff6e6e6e),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100),
                        Container(
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            color: const Color(0xffd7d7d7)),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            child: const Text(
                              "Camera",
                              style: TextStyle(
                                  color: Color(0xff323232),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100),
                        Container(
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            color: const Color(0xffd7d7d7)),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            child: const Text(
                              "Gallery",
                              style: TextStyle(
                                  color: Color(0xff323232),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 7 / 100,
                      width: MediaQuery.of(context).size.width * 80 / 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.secondryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Color(0xffff5050),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
      },
    );
  }
}
