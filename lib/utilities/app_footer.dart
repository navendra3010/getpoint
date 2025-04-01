import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getpoints/view/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../view/OtherPages/home_screen.dart';
import '../view/OtherPages/transactionsid_screen.dart';
import 'app_color.dart';
import 'app_config_provider.dart';
import 'app_constant.dart';
import 'app_image.dart';
import 'package:http/http.dart' as http;

import 'app_language.dart';
import 'app_snackbar_toast_message.dart';

class AppFooter extends StatelessWidget {
  const AppFooter(
      {key, required this.selectedMenu, required this.notificationCount})
      : super(key: key);

  final BottomMenus selectedMenu;
  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 100 / 100,
      height: MediaQuery.of(context).size.height * 8 / 100,
      // color: AppColor.secondryColor,
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 80 / 100,
        alignment: Alignment.center,
        // margin: const EdgeInsets.only(bottom: 12.5),

        decoration: BoxDecoration(
            color: AppColor.blackColor,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppColor.blackColor, width: 2)),
        child: Directionality(
          textDirection: language == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                top: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (BottomMenus.home != selectedMenu) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 26 / 100,
                        child: Column(
                          children: [
                            Container(
                              height:
                                  BottomMenus.home == selectedMenu ? 40 : 25,
                              width: BottomMenus.home == selectedMenu ? 40 : 25,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          BottomMenus.home == selectedMenu
                                              ? AppImage.activehomeIcon
                                              : AppImage.deactivehomeIcon))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (BottomMenus.transactionsIdscreen != selectedMenu) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TransactionsIdScreen()));
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 26 / 100,
                        child: Column(
                          children: [
                            Container(
                              height: BottomMenus.transactionsIdscreen ==
                                      selectedMenu
                                  ? 40
                                  : 30,
                              width: BottomMenus.transactionsIdscreen ==
                                      selectedMenu
                                  ? 40
                                  : 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          BottomMenus.transactionsIdscreen ==
                                                  selectedMenu
                                              ? AppImage.activetransactionsIcon
                                              : AppImage
                                                  .deactivetransactionsIcon))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (BottomMenus.profile != selectedMenu) {
                          getadminnumber(context);
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 26 / 100,
                        child: Column(
                          children: [
                            Container(
                              height:
                                  BottomMenus.profile == selectedMenu ? 40 : 22,
                              width:
                                  BottomMenus.profile == selectedMenu ? 40 : 22,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(BottomMenus.profile ==
                                              selectedMenu
                                          ? AppImage.deactivecontectusIcon
                                          : AppImage.deactivecontectusIcon))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getadminnumber(context) async {
    final prefs = await SharedPreferences.getInstance();

    dynamic userDetails = prefs.getString("user_details");

    int userId = 0;
    String whatsapp = "NA";
    if (userDetails != null) {
      dynamic data = json.decode(userDetails);
      userId = data['user_id'];

      Uri url = Uri.parse(
          "${AppConfigProvider.apiUrl}get_admin_number.php?user_id=$userId");
      print("url $url");

      Map<String, String> headers = ({
        "X-API-KEY": 1234567890.toString(),
      });

      try {
        final response = await http.get(url, headers: headers);

        if (response.statusCode == 200) {
          dynamic res = jsonDecode(response.body);
          // print("Line 156 $res");

          if (res['success'] == 'true') {
            whatsapp = res['admin_number'];

            var number = "+212" "${whatsapp}";

            print(number);

            if (AppConstant.deviceType == "ios") {
              openUrl(
                  url: "https://wa.me/$number?text=${Uri.parse("hello")}",
                  inApp: false);

              // openUrl(
              //     "https://wa.me/$number?text=${Uri.parse("hello")}");
            } else {
              openWhatsApp(phone: number, message: "Hello");

              // openUrl(
              //     "whatsapp://send?phone=$number&text=Hello");
            }
          } else {
            if (res['active_status'] == 0) {
              Future.delayed(const Duration(milliseconds: 300), () async {
                // ignore: use_build_context_synchronously
                SnackBarToastMessage.showSnackBar(
                    context, res['msg'][language]);
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            }
          }
        } else {}
      } catch (e) {}
    }
  }

  // --------- Url LanunchUrl ------------

  Future openUrl({
    required String url,
    bool inApp = false,
  }) async {
    print("url $url");
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: inApp, forceWebView: inApp, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  openWhatsApp({
    required String phone,
    required String message,
  }) async {
    String url = "https://wa.me/$phone/?text=${Uri.encodeFull(message)}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
