import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_footer.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import 'package:http/http.dart' as http;

import '../../utilities/app_loader.dart';
import '../../utilities/app_snackbar_toast_message.dart';

class TransactionsIdScreen extends StatefulWidget {
  static String routeName = './TransactionsIdScreen';
  const TransactionsIdScreen({super.key});

  @override
  State<TransactionsIdScreen> createState() => _TransactionsIdScreenState();
}

class _TransactionsIdScreenState extends State<TransactionsIdScreen> {
  List<dynamic> filterbyList = <dynamic>[
    {"id": 0, "name": AppLanguage.alltimeText[language]},
    {"id": 1, "name": AppLanguage.todayText[language]},
    {"id": 2, "name": AppLanguage.thisweekText[language]},
    {"id": 3, "name": AppLanguage.thismonthTExt[language]},
    {"id": 4, "name": AppLanguage.thisyearText[language]},
  ];

  int userId = 0;
  int statusId = 0;
  bool isApiCalling = false;
  bool apiCallingStatus = false;

  List<dynamic> transactionList = <dynamic>[];

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<dynamic> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic userDetails = prefs.getString("user_details");

    if (userDetails != null) {
      dynamic data = json.decode(userDetails);

      userId = data['user_id'];

      setState(() {});
    }

    fetchgetalltransaction(userId, statusId);
  }

  // ------------- Get All Transaction Api Calling Start ------------------

  Future<void> fetchgetalltransaction(userId, statusId) async {
    Uri url = Uri.parse(
        "${AppConfigProvider.apiUrl}get_all_transaction.php?user_id=$userId&filter_type=$statusId");
    print("url $url");

    Map<String, String> headers = ({
      "X-API-KEY": 1234567890.toString(),
    });

    setState(() {
      isApiCalling = true;
    });

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        dynamic res = jsonDecode(response.body);
        // print("Line 156 $res");

        if (res['success'] == 'true') {
          var item = res['transaction_arr'];

          if (item != "NA") {
            setState(() {
              transactionList = item;
              apiCallingStatus = true;
            });
          } else {
            setState(() {
              transactionList = [];
              apiCallingStatus = true;
            });
          }

          print("transactionList $transactionList");

          setState(() {
            isApiCalling = false;
            apiCallingStatus = true;
          });
        } else {
          if (res['active_status'] == 0) {
            Future.delayed(const Duration(milliseconds: 300), () async {
              // ignore: use_build_context_synchronously
              SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
            });
          }
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
  // ------------- Get All Transaction Api Calling End --------------------

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCalling, opacity: 0.5, child: _build(context));
  }

  Widget _build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColor.blackColor,
        statusBarIconBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () {
        return _showAlertDialog(context);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.blackColor,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  height: MediaQuery.of(context).size.height * 100 / 100,
                  color: AppColor.secondryColor,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        Directionality(
                          textDirection: language == 1
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                    AppLanguage.transactionsidText[language],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColor.themeColor,
                                        fontWeight: FontWeight.w600)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  filteralert(context);
                                },
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        5 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                    child: Image.asset(AppImage.filterIcon)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        if (apiCallingStatus == true)
                          Column(
                            children: [
                              transactionList.isNotEmpty
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              100 /
                                              100,
                                      // padding: EdgeInsets.only(bottom: 15),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Directionality(
                                          textDirection: language == 1
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  ...List.generate(
                                                      transactionList.length,
                                                      (index) {
                                                    return Container(
                                                      height: language == 1
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              28 /
                                                              100
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              25 /
                                                              100,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              90 /
                                                              100,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 7),
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .transactionsscreenbgColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                80 /
                                                                100,
                                                            margin: EdgeInsets.only(
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    1.5 /
                                                                    100),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          13,
                                                                      vertical:
                                                                          5),
                                                                  decoration: BoxDecoration(
                                                                      color: AppColor
                                                                          .greydarkColor
                                                                          .withOpacity(
                                                                              0.72),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          AppLanguage.idText[
                                                                              language],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                AppColor.secondryColor,
                                                                          )),
                                                                      Text(
                                                                          transactionList[index]['user_transaction_type'] == 0
                                                                              ? "Not yet registered"
                                                                              : transactionList[index][
                                                                                  'transactions_id'],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                AppColor.secondryColor,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Text(
                                                                    transactionList[
                                                                            index]
                                                                        [
                                                                        'createtime_get'],
                                                                    style: const TextStyle(
                                                                        color: AppColor
                                                                            .textColor,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400))
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  1.5 /
                                                                  100),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                80 /
                                                                100,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    AppLanguage
                                                                            .priceText[
                                                                        language],
                                                                    style: const TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      left: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          1 /
                                                                          100),
                                                                  child: Text(
                                                                      "${transactionList[index]['price']} ${AppLanguage.dhText[language]}",
                                                                      style: const TextStyle(
                                                                          color: AppColor
                                                                              .blackColor,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.5 /
                                                                  100),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                80 /
                                                                100,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    AppLanguage
                                                                            .priceafterdiscountText[
                                                                        language],
                                                                    style: const TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                Text(
                                                                    " : ${transactionList[index]['price_after_discount']} ${AppLanguage.dhText[language]}",
                                                                    style: const TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.5 /
                                                                  100),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                80 /
                                                                100,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    AppLanguage
                                                                            .percentageText[
                                                                        language],
                                                                    style: const TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                Text(
                                                                    transactionList[
                                                                            index]
                                                                        [
                                                                        'discount_percentage'],
                                                                    style: const TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.5 /
                                                                  100),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                80 /
                                                                100,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    AppLanguage
                                                                            .welcomediscountText[
                                                                        language],
                                                                    style: const TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                Text(
                                                                    transactionList[index]['welcome_discount'] ==
                                                                            0
                                                                        ? AppLanguage.noText[
                                                                            language]
                                                                        : AppLanguage.yesText[
                                                                            language],
                                                                    style: const TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  2 /
                                                                  100),
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  80 /
                                                                  100,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  5 /
                                                                  100,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: AppColor
                                                                    .themeColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            25)),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "${AppLanguage.balanceofpointearnedText[language]} ${transactionList[index]['discount_point']} ${AppLanguage.pointsText[language]}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14),
                                                              ))
                                                        ],
                                                      ),
                                                    );
                                                  })
                                                ],
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      50 /
                                                      100),
                                            ],
                                          ),
                                        ),
                                      ))
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              70 /
                                              100,
                                      child: Center(
                                        child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                60 /
                                                100,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                60 /
                                                100,
                                            child: Image.asset(
                                                AppImage.nodatafoundImage)),
                                      ),
                                    )
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: AppFooter(
                    selectedMenu: BottomMenus.transactionsIdscreen,
                    notificationCount: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  filteralert(context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: const Color(0xff00000000).withOpacity(0.8),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: ((context, setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 100 / 100,
            width: MediaQuery.of(context).size.width * 100 / 100,
            child: Center(
              child: Directionality(
                textDirection:
                    language == 1 ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  children: [
                    SizedBox(
                        height: language == 1
                            ? MediaQuery.of(context).size.height * 60 / 100
                            : MediaQuery.of(context).size.height * 65 / 100),
                    Container(
                        height: language == 1
                            ? MediaQuery.of(context).size.height * 40 / 100
                            : MediaQuery.of(context).size.height * 35 / 100,
                        width: MediaQuery.of(context).size.width * 100 / 100,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35)),
                          color: AppColor.secondryColor,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    100),
                            Container(
                              height:
                                  MediaQuery.of(context).size.width * 0.5 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 12 / 100,
                              color: AppColor.textColor,
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    5 /
                                    100),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 80 / 100,
                              child: Text(
                                AppLanguage.filterbyText[language],
                                style: const TextStyle(
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    100),
                            SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                height: AppConstant.deviceType == "ios"
                                    ? MediaQuery.of(context).size.height *
                                        25 /
                                        100
                                    : language == 1
                                        ? MediaQuery.of(context).size.height *
                                            22 /
                                            100
                                        : MediaQuery.of(context).size.height *
                                            18.5 /
                                            100,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: filterbyList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            statusId =
                                                filterbyList[index]['id'];
                                            apiCallingStatus = false;
                                          });
                                          Navigator.pop(context);
                                          fetchgetalltransaction(
                                              userId, statusId);
                                        },
                                        child: Container(
                                          color: AppColor.secondryColor,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              80 /
                                              100,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(filterbyList[index]['name'],
                                                  style: const TextStyle(
                                                      color:
                                                          AppColor.blackColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              if (filterbyList[index]['id'] ==
                                                  statusId)
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              5 /
                                                              100,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              5 /
                                                              100,
                                                      child: Image.asset(
                                                          AppImage.rightIcon)),
                                                )
                                            ],
                                          ),
                                        ),
                                      );
                                    })),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.8 /
                                    100),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                color: AppColor.secondryColor,
                                child: Text(AppLanguage.cancelText[language],
                                    style: const TextStyle(
                                        color: Color(0xffBC1522),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        }));
      },
    );
  }

  _showAlertDialog(BuildContext context) {}
}
