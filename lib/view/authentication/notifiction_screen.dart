import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_loader.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import '../OtherPages/home_screen.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  static String routeName = './Notifications';
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<dynamic> notifications = <dynamic>[
    {"name": "Admin", "status": false},
    {"name": "Admin", "status": false},
    {"name": "Admin", "status": false},
    {"name": "Admin", "status": false},
    {"name": "Admin", "status": false},
    {"name": "Admin", "status": false},
    {"name": "Admin", "status": false},
    {"name": "Admin", "status": false},
    {"name": "Admin", "status": false},
  ];

  bool isApiCalling = false;
  bool apiCallingStatus = false;

  int userId = 0;

  List<dynamic> notificationList = <dynamic>[];

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<dynamic> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic userDetails = prefs.getString("user_details");

    // ----------- userid and phone number --------------
    if (userDetails != null) {
      dynamic data = json.decode(userDetails);
      userId = data['user_id'];

      setState(() {});

      print("userId $userId");
    }
    fetchnotificationList(userId);
  }

  // -------------- fetch Notification APi Calling Start -----------

  fetchnotificationList(userId) async {
    Uri url = Uri.parse("${AppConfigProvider.apiUrl}get_notification.php");

    print("Url $url");

    setState(() {
      isApiCalling = true;
    });

    try {
      http.MultipartRequest formData = http.MultipartRequest('POST', url);

      formData.fields['limit'] = "10".toString();
      formData.fields['user_id'] = userId.toString();
      formData.fields['offset'] = "0".toString();
      formData.fields['language_id'] = language.toString();

      http.StreamedResponse response = await formData.send();
      print("response--> $response");
      var responseString = await response.stream.toBytes();
      var res = jsonDecode(utf8.decode(responseString));

      if (response.statusCode == 200) {
        if (res['success'] == 'true') {
          final item = res['notification_arr'];

          if (item != "NA") {
            setState(() {
              apiCallingStatus = true;
              notificationList = item;
            });
          } else {
            notificationList = [];
            setState(() {
              apiCallingStatus = true;
            });
          }

          print("notificationList line number 122 => $notificationList");

          setState(() {
            isApiCalling = false;
            apiCallingStatus = true;
          });
        } else {
          setState(() {
            apiCallingStatus = true;
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

  // ------------- fetch Notification Api Calling End ----------------

  // ----------- Delete Single Notification Api Calling  -------

  deletesinglenotification(deletenotification, userId) async {
    Uri url = Uri.parse(
        "${AppConfigProvider.apiUrl}delete_single_notification.php?user_id=$userId&notification_id=$deletenotification");

    print("Url $url");

    setState(() {
      isApiCalling = true;
    });

    try {
      http.MultipartRequest formData = http.MultipartRequest('POST', url);

      formData.fields['user_id'] = userId.toString();
      formData.fields['notification_id'] = deletenotification.toString();

      http.StreamedResponse response = await formData.send();
      print("response--> $response");
      var responseString = await response.stream.toBytes();
      var res = jsonDecode(utf8.decode(responseString));

      if (response.statusCode == 200) {
        /// print("res : $res");
        if (res['success'] == 'true') {
          fetchnotificationList(userId);

          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);

          setState(() {
            isApiCalling = false;
          });
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

  // ----------- Delete Single Notification Api Calling End -------

  // ------------- delete_all_notification Api Calling Start ---------
  deleteallnotification(
    userId,
  ) async {
    Uri url = Uri.parse(
        "${AppConfigProvider.apiUrl}delete_all_notification.php?user_id=$userId");

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
        /// print("res : $res");
        if (res['success'] == 'true') {
          setState(() {
            notificationList = [];
          });

          Future.delayed(const Duration(seconds: 10), () async {
            fetchnotificationList(userId);
          });
          print("notificationList $notificationList");

          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);

          setState(() {
            isApiCalling = false;
          });
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
  // ------------- delete_all_notification Api Calling End ---------

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCalling, opacity: 0.5, child: _build(context));
  }

  Widget _build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: AppColor.secondryColor,
            child: Directionality(
              textDirection:
                  language == 1 ? TextDirection.rtl : TextDirection.ltr,
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                );
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
                            Container(
                              padding: language == 1
                                  ? EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          3 /
                                          100)
                                  : EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          3 /
                                          100),
                              child: Text(
                                  AppLanguage.notificationText[language],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColor.themeColor,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        if (notificationList.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _showAlertDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width *
                                      0.5 /
                                      100),
                              child: Text(AppLanguage.clearText[language],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // ------------ Hearder Closed -------------
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),

                  if (apiCallingStatus == true)
                    Column(
                      children: [
                        notificationList.isNotEmpty
                            ? SingleChildScrollView(
                                child: Container(
                                  height: AppConstant.deviceType == 'ios'
                                      ? MediaQuery.of(context).size.height *
                                          79.5 /
                                          100
                                      : MediaQuery.of(context).size.height *
                                          85.5 /
                                          100,
                                  padding: const EdgeInsets.only(bottom: 5),
                                  width: double.infinity,
                                  color: AppColor.secondryColor,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: notificationList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                90 /
                                                100,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffF0F1F0)),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      13 /
                                                      100,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      13 /
                                                      100,
                                                  // child:
                                                  //     Image.asset(AppImage.adminIcon),
                                                  decoration: BoxDecoration(
                                                    //<-- SEE HERE

                                                    image: (notificationList[
                                                                        index]
                                                                    ['image'] !=
                                                                "NA" &&
                                                            notificationList[
                                                                        index]
                                                                    ['image'] !=
                                                                null)
                                                        ? DecorationImage(
                                                            image: CachedNetworkImageProvider(
                                                                "${AppConfigProvider.imageUrl}${notificationList[index]['image']}"))
                                                        : const DecorationImage(
                                                            image: AssetImage(
                                                                AppImage
                                                                    .adminIcon),
                                                          ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      2.5 /
                                                      100,
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              75 /
                                                              100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                37 /
                                                                100,
                                                            alignment: language ==
                                                                    1
                                                                ? Alignment
                                                                    .centerRight
                                                                : Alignment
                                                                    .centerLeft,
                                                            child: Text(
                                                                notificationList[
                                                                        index]
                                                                    ['title'],
                                                                maxLines: 1,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Text(
                                                              notificationList[
                                                                      index][
                                                                  'noti_date_time'],
                                                              style: const TextStyle(
                                                                  color: AppColor
                                                                      .textColor,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              1 /
                                                              100,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              75 /
                                                              100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                69 /
                                                                100,
                                                            child: Text(
                                                                notificationList[
                                                                        index]
                                                                    ['message'],
                                                                style: const TextStyle(
                                                                    color: AppColor
                                                                        .textColor,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              deletesinglenotification(
                                                                notificationList[
                                                                        index][
                                                                    'notification_message_id'],
                                                                userId,
                                                              );
                                                            },
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  3.5 /
                                                                  100,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  3.5 /
                                                                  100,
                                                              child: Image.asset(
                                                                  AppImage
                                                                      .crossicon),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Center(
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        70 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        70 /
                                        100,
                                    child: Image.asset(
                                        AppImage.nodatafoundImage))),
                      ],
                    )

                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 1 / 100,
                  // ),
                ],
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
            style: const TextStyle(color: Colors.black)),
      ),
      onPressed: () {
        deleteallnotification(userId);

        Navigator.of(context).pop();

        // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Directionality(
          textDirection: language == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: Text(AppLanguage.areYouSureText[language])),
      content: Directionality(
          textDirection: language == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: Text(AppLanguage.clearnotificationText[language])),
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
