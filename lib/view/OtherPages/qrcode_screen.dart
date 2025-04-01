import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';

class QrCodeScreen extends StatefulWidget {
  static String routeName = './QrCodeScreen';
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
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
                                  ? AppImage.backIcon
                                  : AppImage.backIcon,
                              width:
                                  MediaQuery.of(context).size.width * 5 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100,
                              color: AppColor.secondryColor,
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
                            child: Text(AppLanguage.qrcodeText[language],
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColor.secondryColor,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 70 / 100,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(AppImage.qrcodeImage1),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
