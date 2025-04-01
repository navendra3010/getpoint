import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:getpoints/view/OtherPages/phonenumber.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_footer.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import '../authentication/login_screen.dart';
import '../authentication/notifiction_screen.dart';
import 'accountid_screen.dart';
import 'details_screen.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static String routeName = './Home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  List<dynamic> languageList = <dynamic>[
    {"id": 0, "language": "English", "status": true},
    {"id": 1, "language": "Arabic", "status": false},
    {"id": 2, "language": "French", "status": false},
  ];

  String _scanBarcode = 'Unknown';

  TextEditingController phonenumberTextEditingController =
      TextEditingController();

  int userId = 0;
  int notificationcount1 = 0;
  int mobile = 0;
  String image = "NA";
  String email = "";
  String city = "";
  String getDistrict = "";
  String categoryname = "";
  String businessname = "";
  String categoryimage = "";
  String name = "";
  String aboutbusiness = "";
  String uniqueid = "";
  bool isApiCalling = false;

  List<dynamic> profileList = <dynamic>[];

  List<dynamic> categorynameList = <dynamic>[];
  List<dynamic> cityList = <dynamic>[];
  List<dynamic> getDistrictList = <dynamic>[];
  List<dynamic> aboutbusinessList = <dynamic>[];

  // -------------- Local Storage ----------------
  Future<dynamic> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic language1 = prefs.getString("language_id");
    dynamic userDetails = prefs.getString("user_details");

    // print("language $language1");

    // print("userDetails $userDetails");

    // ----------- userid and phone number --------------
    if (language1 != null) {
      dynamic data = json.decode(language1);

      language = data;

      List list = languageList;
      for (var i = 0; i < list.length; i++) {
        if (list[i]['id'] == data) {
          list[i]['status'] = true;
        } else {
          list[i]['status'] = false;
        }
      }
      print("list $list");
      List firstIndexRecord = [];
      List remainIndexRecord = [];

      for (var i = 0; i < list.length; i++) {
        if (list[i]['status'] == true) {
          firstIndexRecord.add(list[i]);
        } else {
          remainIndexRecord.add(list[i]);
        }
      }
      List finalLanguageList = [...firstIndexRecord, ...remainIndexRecord];
      setState(() {
        languageList = finalLanguageList;
      });
      // setState(() {
      //   languageList =
      // });
    }

    if (userDetails != null) {
      dynamic data = json.decode(userDetails);

      userId = data['user_id'];
      uniqueid = data['unique_id'];
      businessname = data['business_name'];

      categorynameList = data['CategoryName'];
      cityList = data['getCity'];
      getDistrictList = data['district_name'];
      aboutbusinessList = data['about_business'];

      print("getDistrictList $getDistrictList");
      print("cityList $cityList");

      email = data['email'];
      mobile = data['mobile'];
      categoryimage = data['category_image'];
      name = data['name'];

      setState(() {});

      categoryname = categorynameList[language];

      city = cityList[language];
      getDistrict = getDistrictList[language];

      print("getDistrict $getDistrict");
      print("city $city");

      setState(() {
        categoryname = categorynameList[language];

        city = cityList[language];
        getDistrict = getDistrictList[language];
      });

      print("uniqueid $uniqueid");
      print("uniqueid $businessname");

      if (data['image'] != null) {
        image = data['image'];

        setState(() {});
      }

      fetchprofilearr(userId);
    }
  }

  // ---------- QR Code ----------------

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print("barcode $barcode"));
  }

  Future<void> scanQR() async {
    print("barcodeScanRes");
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    print("barcodeScanRes $barcodeScanRes");

//barcode scanner flutter ant
    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    verifynoqraccApiCalling(barcodeScanRes, 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  // --------------- Get Profile Api Calling Start -----------

  Future<void> fetchprofilearr(userId) async {
    Uri url =
        Uri.parse("${AppConfigProvider.apiUrl}get_profile.php?user_id=$userId");
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
          notificationcount1 = res['notification_count'];

          setState(() {
            isApiCalling = false;
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

  // --------------- Get Profile Api Calling End -------------

  // --------------- Verify No Qr Accoun_Id Api Calling Start ---------

  verifynoqraccApiCalling(phonenumberqrcodenumber, type) async {
    print("phonenumberqrcodenumber $phonenumberqrcodenumber");
    print("type $type");
    Uri url = Uri.parse("${AppConfigProvider.apiUrl}verify_no_qr_acc.php");

    print("Url $url");

    setState(() {
      isApiCalling = true;
    });

    try {
      http.MultipartRequest formData = http.MultipartRequest('POST', url);

      formData.fields['user_id'] = userId.toString();
      formData.fields['type'] = type.toString();
      formData.fields['mobile_qr_acc'] = phonenumberqrcodenumber.toString();

      http.StreamedResponse response = await formData.send();
      // print("response--> $response");
      var responseString = await response.stream.toBytes();
      var res = jsonDecode(utf8.decode(responseString));

      if (response.statusCode == 200) {
        print("res123 : $res");
        if (res['success'] == 'true') {
          var detailarr = res['detail_arr'];

          int businessId = detailarr['business_id'];
          int customerUserId = detailarr['customer_user_id'];
          int discounttype = detailarr['discount_type'];
          int welcomediscount = detailarr['welcome_discount'];
          int validitydays = detailarr['validity_days'];
          int usertransactiontype = detailarr['user_transaction_type'];
          int totalpoints = detailarr['total_points'];
          // int firsttimestatus = detailarr['first_time_status'];
          int transactiontype = 1; //detailarr['transaction_type'];
          // int welcomediscountfirsttime =
          //     detailarr['welcome_discount_first_time'];
          int customermobile = detailarr['customer_mobile'];
          String mobileqracc = detailarr['mobile_qr_acc'];
          String welcomediscpercentage = detailarr['welcome_disc_percentage'];
          String mindiscountpercentage = detailarr['min_discount_percentage'];
          String maxdiscountpercentage = detailarr['max_discount_percentage'];
          String mindiscountpercentagenew =
              detailarr['min_discount_percentage_new'];
          String maxdiscountpercentagenew =
              detailarr['max_discount_percentage_new'];
          String welcomediscpercentagenew =
              detailarr['welcome_disc_percentage_new'];
          String minpurchasedisc = detailarr['min_purchase_disc'];
          final List offerdescription1 = detailarr['offer_description'];

          String offerdescription = offerdescription1[language];

          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, DetailsScreen.routeName,
              arguments: DetailsScreenClass(
                businessId: businessId,
                customerUserId: customerUserId,
                discounttype: discounttype,
                welcomediscount: welcomediscount,
                validitydays: validitydays,
                usertransactiontype: usertransactiontype,
                totalpoints: totalpoints,
                // firsttimestatus: firsttimestatus,
                transactiontype: transactiontype,
                // welcomediscountfirsttime: welcomediscountfirsttime,
                customermobile: customermobile,
                mobileqracc: mobileqracc,
                welcomediscpercentage: welcomediscpercentage,
                mindiscountpercentage: mindiscountpercentage,
                maxdiscountpercentage: maxdiscountpercentage,
                mindiscountpercentagenew: mindiscountpercentagenew,
                maxdiscountpercentagenew: maxdiscountpercentagenew,
                welcomediscpercentagenew: welcomediscpercentagenew,
                minpurchasedisc: minpurchasedisc,
                offerdescription: offerdescription,
              ));
        } else {
          // ignore: use_build_context_synchronously
          //SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
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

  // --------------- Verify No Qr Accoun_Id Api Calling End -----------

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColor.blackColor,
        statusBarIconBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () {
        return _showAlertDialog(context);
      },
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
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
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 90 / 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    5 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    50 /
                                    100,
                                child: Image.asset(
                                  AppImage.getpointsImage,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    14 /
                                    100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Notifications()),
                                        );
                                      },
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                        child: Image.asset(notificationcount1 ==
                                                0
                                            ? AppImage.deactivenotificationIcon
                                            : AppImage.activenotificationIcon),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showAlertDialog1(context);
                                      },
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                        child: Image.asset(AppImage.logoutIcon),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 90 / 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: AppColor.blackColor, width: 2)),
                                child: GestureDetector(
                                  onTap: () {
                                    businessprofilealert(context);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        10 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        10 /
                                        100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColor.secondryColor,
                                          width: 2),
                                      image: (image != "NA")
                                          ? DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  "${AppConfigProvider.imageUrl}$image"),
                                              fit: BoxFit.cover,
                                            )
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  AppImage.adminIcon),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                // margin: EdgeInsets.only(
                                //     left:
                                //         MediaQuery.of(context).size.width * 1 / 100),
                                width: MediaQuery.of(context).size.width *
                                    70 /
                                    100,

                                child: Column(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                67 /
                                                100,
                                        child: Text(
                                          "${AppLanguage.helloText[language]} $businessname",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                67 /
                                                100,
                                        child: Text(
                                          "${AppLanguage.idText1[language]}$uniqueid",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: AppColor.textColor,
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  languagealert(context);
                                },
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      6 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      6 /
                                      100,
                                  child: Image.asset(
                                    AppImage.languageIcon,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1.5 / 100),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PhoneNumber()),
                            );
                            // phonenumberTextEditingController.clear();
                            // phonenumberalert(context);
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage(AppImage.phonenumberImage),
                                    fit: BoxFit.fill)),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      13 /
                                      100),
                              child: Text(
                                AppLanguage.phonenumberText[language],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.secondryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        GestureDetector(
                          onTap: () {
                            scanQR();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const QrCodeScreen()),
                            // );
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImage.qrcodeImage),
                                    fit: BoxFit.fill)),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      13 /
                                      100),
                              child: Text(
                                AppLanguage.qrcodeText[language],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AccountIdScreen()),
                            );
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImage.accountidImage),
                                    fit: BoxFit.fill)),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      13 /
                                      100),
                              child: Text(
                                AppLanguage.accountidText[language],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: AppFooter(
                  selectedMenu: BottomMenus.home,
                  notificationCount: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------- Validication Start ----------------

  // mobilenumberValidication(String phonenumberqrcodenumber) {
  //   if (phonenumberqrcodenumber.isEmpty) {
  //     SnackBarToastMessage.showSnackBar(
  //         context, AppLanguage.phonenumberMessage[language]);
  //   } else if (phonenumberqrcodenumber.length < 9) {
  //     SnackBarToastMessage.showSnackBar(
  //         context, AppLanguage.validphonenumberMessage[language]);
  //   } else {
  //     verifynoqraccApiCalling(phonenumberqrcodenumber, 0);
  //   }
  // }

  // --------- Validication End ------------------

  // phonenumberalert(context) {
  //   showModalBottomSheet<void>(
  //     isScrollControlled: true,
  //     context: context,
  //     // ignore: use_full_hex_values_for_flutter_colors
  //     backgroundColor: const Color(0xff00000000).withOpacity(0.8),
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(builder: ((context, setState) {
  //         return
  //         GestureDetector(
  //           onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
  //           child: SizedBox(
  //             height: MediaQuery.of(context).size.height * 100 / 100,
  //             width: MediaQuery.of(context).size.width * 100 / 100,
  //             child: Center(
  //               child: Column(
  //                 children: [
  //                   SizedBox(
  //                       height: MediaQuery.of(context).size.height *
  //                           25 /
  //                           100), // vefore height 35
  //                   Container(
  //                       height: MediaQuery.of(context).size.height *
  //                           75 /
  //                           100, // before height 65
  //                       width: MediaQuery.of(context).size.width * 100 / 100,
  //                       alignment: Alignment.center,
  //                       decoration: const BoxDecoration(
  //                         borderRadius: BorderRadius.only(
  //                             topLeft: Radius.circular(35),
  //                             topRight: Radius.circular(35)),
  //                         color: AppColor.secondryColor,
  //                       ),
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                               height: MediaQuery.of(context).size.height *
  //                                   1 /
  //                                   100),
  //                           Container(
  //                             height:
  //                                 MediaQuery.of(context).size.width * 0.5 / 100,
  //                             width:
  //                                 MediaQuery.of(context).size.width * 12 / 100,
  //                             color: AppColor.textColor,
  //                           ),
  //                           SizedBox(
  //                               height: MediaQuery.of(context).size.height *
  //                                   5 /
  //                                   100),
  //                           SizedBox(
  //                             height:
  //                                 MediaQuery.of(context).size.height * 20 / 100,
  //                             width:
  //                                 MediaQuery.of(context).size.width * 60 / 100,
  //                             child:
  //                                 Image.asset(AppImage.phonenumbermodelImage),
  //                           ),
  //                           SizedBox(
  //                               height: MediaQuery.of(context).size.height *
  //                                   4 /
  //                                   100),
  //                           Container(
  //                             width:
  //                                 MediaQuery.of(context).size.width * 90 / 100,
  //                             alignment: Alignment.center,
  //                             child: Text(AppLanguage.phonenumberText[language],
  //                                 style: const TextStyle(
  //                                     fontSize: 17,
  //                                     fontWeight: FontWeight.w700,
  //                                     color: AppColor.blackColor)),
  //                           ),
  //                           SizedBox(
  //                               height: MediaQuery.of(context).size.height *
  //                                   1 /
  //                                   100),
  //                           Container(
  //                               width: MediaQuery.of(context).size.width *
  //                                   78 /
  //                                   100,
  //                               alignment: Alignment.center,
  //                               child: const Text(
  //                                   "Please let the user write down his number for confidentiality reasons.",
  //                                   textAlign: TextAlign.center,
  //                                   style: TextStyle(
  //                                       color: AppColor.textColor,
  //                                       fontSize: 14,
  //                                       fontWeight: FontWeight.w400))),
  //                           SizedBox(
  //                               height: MediaQuery.of(context).size.height *
  //                                   2 /
  //                                   100),
  //                           Center(
  //                             child: SizedBox(
  //                               width: MediaQuery.of(context).size.width *
  //                                   80 /
  //                                   100,
  //                               height: MediaQuery.of(context).size.height *
  //                                   6 /
  //                                   100,
  //                               child: Directionality(
  //                                 textDirection: language == 1
  //                                     ? TextDirection.rtl
  //                                     : TextDirection.ltr,
  //                                 child: TextFormField(
  //                                   // inputFormatters: [maskFormatter],
  //                                   style: const TextStyle(color: Colors.black),
  //                                   textAlignVertical: TextAlignVertical.center,
  //                                   keyboardType: TextInputType.phone,
  //                                   controller:
  //                                       phonenumberTextEditingController,
  //                                   maxLength: AppConstant.mobileMaxLenth,
  //                                   decoration: InputDecoration(
  //                                       prefixIcon: Column(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.center,
  //                                           children: [
  //                                             Padding(
  //                                               padding: language == 1
  //                                                   ? EdgeInsets.only(
  //                                                       // right: 5,
  //                                                       bottom: MediaQuery.of(
  //                                                                   context)
  //                                                               .size
  //                                                               .height *
  //                                                           0.8 /
  //                                                           100)
  //                                                   : EdgeInsets.only(
  //                                                       left: 5,
  //                                                       bottom: MediaQuery.of(
  //                                                                   context)
  //                                                               .size
  //                                                               .height *
  //                                                           0.4 /
  //                                                           100),
  //                                               child: SizedBox(
  //                                                 height: MediaQuery.of(context)
  //                                                         .size
  //                                                         .width *
  //                                                     5 /
  //                                                     100,
  //                                                 width: MediaQuery.of(context)
  //                                                         .size
  //                                                         .width *
  //                                                     5 /
  //                                                     100,
  //                                                 child: Image.asset(language ==
  //                                                         1
  //                                                     ? AppImage
  //                                                         .rightphonenumberIcon
  //                                                     : AppImage
  //                                                         .phonenumberIcon),
  //                                               ),
  //                                             )
  //                                           ]),
  //                                       border: const OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: AppColor.textinputColor),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(30.0)),
  //                                       ),
  //                                       enabledBorder: const OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: AppColor.textinputColor),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(30.0)),
  //                                       ),
  //                                       focusedBorder: const OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: AppColor.textinputColor),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(30.0)),
  //                                       ),
  //                                       fillColor: AppColor.textinputColor,
  //                                       filled: true,
  //                                       counterText: '',
  //                                       hintText: AppLanguage
  //                                           .phonenumberText[language],
  //                                       hintStyle: AppConstant.textFilledStyle),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                               height: MediaQuery.of(context).size.height *
  //                                   3 /
  //                                   100),
  //                           GestureDetector(
  //                             onTap: () {
  //                               mobilenumberValidication(
  //                                 phonenumberTextEditingController.text,
  //                               );
  //                             },
  //                             child: Container(
  //                                 width: MediaQuery.of(context).size.width *
  //                                     80 /
  //                                     100,
  //                                 height: MediaQuery.of(context).size.height *
  //                                     6 /
  //                                     100,
  //                                 decoration: const BoxDecoration(
  //                                   color: AppColor.themeColor,
  //                                   borderRadius:
  //                                       BorderRadius.all(Radius.circular(25)),
  //                                 ),
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                   AppLanguage.sendButtonText[language],
  //                                   style: const TextStyle(
  //                                       color: Colors.white,
  //                                       fontWeight: FontWeight.w500,
  //                                       fontSize: 15),
  //                                 )),
  //                           ),
  //                         ],
  //                       ))
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );

  //       }));
  //     },
  //   );
  // }

  businessprofilealert(context) {
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
                        height: MediaQuery.of(context).size.height * 65 / 100),
                    Container(
                        height: MediaQuery.of(context).size.height * 35 / 100,
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
                                  MediaQuery.of(context).size.width * 90 / 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        15 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        15 /
                                        100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                          color: AppColor.secondryColor,
                                          width: 2),
                                      image: (image != "NA")
                                          ? DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  "${AppConfigProvider.imageUrl}$image"),
                                              fit: BoxFit.cover,
                                            )
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  AppImage.adminIcon),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          4 /
                                          100),
                                  Column(
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              55 /
                                              100,
                                          child: Text(
                                            categoryname,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              55 /
                                              100,
                                          child: Text(
                                            name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w400),
                                          ))
                                    ],
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        15 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        15 /
                                        100,
                                    decoration: BoxDecoration(
                                      image: (categoryimage != "NA")
                                          ? DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  "${AppConfigProvider.imageUrl}$categoryimage"),
                                              fit: BoxFit.cover,
                                            )
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  AppImage.foodImage),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    3 /
                                    100),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        40 /
                                        100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLanguage.phoneText[language],
                                          style: const TextStyle(
                                              color: AppColor.textColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5 /
                                                100),
                                        Text(
                                          "+212 $mobile",
                                          style: const TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        40 /
                                        100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLanguage.emailText[language],
                                          style: const TextStyle(
                                              color: AppColor.textColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5 /
                                                100),
                                        Text(
                                          email,
                                          style: const TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    2 /
                                    100),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        40 /
                                        100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLanguage.cityText[language],
                                          style: const TextStyle(
                                              color: AppColor.textColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5 /
                                                100),
                                        Text(
                                          city,
                                          style: const TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        40 /
                                        100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLanguage.districtText[language],
                                          style: const TextStyle(
                                              color: AppColor.textColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5 /
                                                100),
                                        Text(
                                          getDistrict,
                                          style: const TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    3 /
                                    100),
                            // SizedBox(
                            //   width:
                            //       MediaQuery.of(context).size.width * 90 / 100,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         AppLanguage.aboutText[language],
                            //         style: const TextStyle(
                            //             color: AppColor.textColor,
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       SizedBox(
                            //           height:
                            //               MediaQuery.of(context).size.height *
                            //                   0.5 /
                            //                   100),
                            //       Text(
                            //         aboutbusiness,
                            //         style: const TextStyle(
                            //             color: AppColor.blackColor,
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.w500),
                            //       )
                            //     ],
                            //   ),
                            // )
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

  languagealert(context) {
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
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 72 / 100),
                  Container(
                      height: MediaQuery.of(context).size.height * 28 / 100,
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
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100),
                          Container(
                            height:
                                MediaQuery.of(context).size.width * 0.5 / 100,
                            width: MediaQuery.of(context).size.width * 12 / 100,
                            color: AppColor.textColor,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            child: Text(
                              AppLanguage.changelanguageText[language],
                              style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100),
                          SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 80 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 15 / 100,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  print("Index ${languageList[index]}");
                                  return InkWell(
                                    onTap: () async {
                                      List data = [];
                                      List firstIndexRecord = [];
                                      List remainIndexRecord = [];
                                      for (var i = 0;
                                          i < languageList.length;
                                          i++) {
                                        if (index == i) {
                                          languageList[i]['status'] = true;
                                          firstIndexRecord.add(languageList[i]);
                                        } else {
                                          languageList[i]['status'] = false;
                                          remainIndexRecord
                                              .add(languageList[i]);
                                        }
                                      }

                                      languageList = [
                                        ...firstIndexRecord,
                                        ...remainIndexRecord
                                      ];

                                      setState(() {});

                                      language = firstIndexRecord[0]['id'];
                                      // -----Local Storage ------------
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          "language_id", jsonEncode(language));
                                      // -----Local Storage End------------

                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Home()),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          80 /
                                          100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(languageList[index]['language'],
                                              style: const TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          if (languageList[index]['status'] ==
                                              true)
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    6 /
                                                    100,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    6 /
                                                    100,
                                                child: Image.asset(
                                                    AppImage.rightIcon))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ))
                        ],
                      ))
                ],
              ),
            ),
          );
        }));
      },
    );
  }
}

_showAlertDialog1(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      AppLanguage.noText[language],
      style: const TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      AppLanguage.yesText[language],
      style: const TextStyle(color: Colors.black),
    ),
    onPressed: () {
      localstorageclearbutton(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(AppLanguage.logoutModelText[language]),
    content: Text(AppLanguage.exitLogout[language]),
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

// --------- Localstotage clear -----------
localstorageclearbutton(context) async {
  final prefs = await SharedPreferences.getInstance();
  print("prefs =================>$prefs");
  prefs.remove('user_details');
  prefs.remove("password");

  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const Login(),
    ),
  );
}

_showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      AppLanguage.noText[language],
      style: const TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text(AppLanguage.yesText[language],
        style: const TextStyle(color: Colors.black)),
    onPressed: () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(AppLanguage.areYouSureText[language]),
    content: Text(AppLanguage.exitAppText[language]),
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
