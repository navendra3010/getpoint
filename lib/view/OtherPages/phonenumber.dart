import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_loader.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'details_screen.dart';
import 'package:http/http.dart' as http;

class PhoneNumber extends StatefulWidget {
  static String routeName = './PhoneNumber';
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  TextEditingController phonenumberTextEditingController =
      TextEditingController();
  bool isApiCalling = false;
  int userId = 0;

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
  }

  // --------- Validication Start ----------------

  mobilenumberValidication(String phonenumberqrcodenumber) {
    if (phonenumberqrcodenumber.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.phonenumberMessage[language]);
    } else if (phonenumberqrcodenumber.length < 9) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.validphonenumberMessage[language]);
    } else {
      verifynoqraccApiCalling(phonenumberqrcodenumber, 0);
    }
  }
  // --------- Validication End ------------------
  // --------------- Verify No Qr Accoun_Id Api Calling Start ---------

  verifynoqraccApiCalling(phonenumberqrcodenumber, type) async {
    print("phonenumberqrcodenumber $phonenumberqrcodenumber");
    print("type $type");
    print("user_id $userId");
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
          int transactiontype = 0; //detailarr['transaction_type'];
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
          print("else ${res['msg'][language]}");
          // ignore: use_build_context_synchronously
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
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
    return ProgressHUD(
        inAsyncCall: isApiCalling, opacity: 0.5, child: _build(context));
  }

  Widget _build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColor.blackColor,
        statusBarIconBrightness: Brightness.light));
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.blackColor,
          body: SafeArea(
              child: SizedBox(
            height: MediaQuery.of(context).size.height * 100 / 100,
            width: MediaQuery.of(context).size.width * 100 / 100,
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        color: AppColor.blackColor,
                        height: MediaQuery.of(context).size.height * 15 / 100),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 85 / 100,
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
                                height: MediaQuery.of(context).size.width *
                                    0.5 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    12 /
                                    100,
                                color: AppColor.textColor,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      5 /
                                      100),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    20 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    60 /
                                    100,
                                child:
                                    Image.asset(AppImage.phonenumbermodelImage),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      4 /
                                      100),
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    90 /
                                    100,
                                alignment: Alignment.center,
                                child: Text(
                                    AppLanguage.phonenumberText[language],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.blackColor)),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      100),
                              Container(
                                  width: MediaQuery.of(context).size.width *
                                      78 /
                                      100,
                                  alignment: Alignment.center,
                                  child: Text(
                                      AppLanguage
                                          .confidentialityreasonsText[language],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: AppColor.textColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      2 /
                                      100),
                              Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      80 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      6 /
                                      100,
                                  child: Directionality(
                                    textDirection: language == 1
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: TextFormField(
                                      // inputFormatters: [maskFormatter],
                                      style:
                                          const TextStyle(color: Colors.black),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.phone,
                                      controller:
                                          phonenumberTextEditingController,
                                      maxLength: AppConstant.mobileMaxLenth,
                                      decoration: InputDecoration(
                                          prefixIcon: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: language == 1
                                                      ? EdgeInsets.only(
                                                          // right: 5,
                                                          bottom: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.8 /
                                                              100)
                                                      : EdgeInsets.only(
                                                          left: 5,
                                                          bottom: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.4 /
                                                              100),
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
                                                    child: Image.asset(language ==
                                                            1
                                                        ? AppImage
                                                            .rightphonenumberIcon
                                                        : AppImage
                                                            .phonenumberIcon),
                                                  ),
                                                )
                                              ]),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.textinputColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.textinputColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.textinputColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                          ),
                                          fillColor: AppColor.textinputColor,
                                          filled: true,
                                          counterText: '',
                                          hintText: AppLanguage
                                              .phonenumberText[language],
                                          hintStyle:
                                              AppConstant.textFilledStyle),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      3 /
                                      100),
                              GestureDetector(
                                onTap: () {
                                  mobilenumberValidication(
                                    phonenumberTextEditingController.text,
                                  );
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        80 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        6 /
                                        100,
                                    decoration: const BoxDecoration(
                                      color: AppColor.themeColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLanguage.sendButtonText[language],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
