import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getpoints/view/OtherPages/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatelessWidget {
  static String routeName = './DetailsScreen';
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DetailsScreenClass? object;

    object = ModalRoute.of(context)!.settings.arguments as DetailsScreenClass;

    // print("firsttimestatus ${object.firsttimestatus}");

    print("welcomediscount ${object.welcomediscount}");

    return Scaffold(
      body: DetailsScreen1(
        businessId: object.businessId,
        customerUserId: object.customerUserId,
        discounttype: object.discounttype,
        welcomediscount: object.welcomediscount,
        validitydays: object.validitydays,
        usertransactiontype: object.usertransactiontype,
        totalpoints: object.totalpoints,
        // firsttimestatus: object.firsttimestatus,
        customermobile: object.customermobile,
        transactiontype: object.transactiontype,
        // welcomediscountfirsttime: object.welcomediscountfirsttime,
        mobileqracc: object.mobileqracc,
        welcomediscpercentage: object.welcomediscpercentage,
        mindiscountpercentage: object.mindiscountpercentage,
        maxdiscountpercentage: object.maxdiscountpercentage,
        mindiscountpercentagenew: object.mindiscountpercentagenew,
        maxdiscountpercentagenew: object.maxdiscountpercentagenew,
        welcomediscpercentagenew: object.welcomediscpercentagenew,
        minpurchasedisc: object.minpurchasedisc,
        offerdescription: object.offerdescription,
      ),
    );
  }
}

class DetailsScreen1 extends StatefulWidget {
  final int businessId;
  final int customerUserId;
  final int discounttype;
  final int welcomediscount;
  final int validitydays;
  final int usertransactiontype;
  final int totalpoints;
  // final int firsttimestatus;
  final int transactiontype;
  // final int welcomediscountfirsttime;
  final int customermobile;
  final String mobileqracc;
  final String welcomediscpercentage;
  final String mindiscountpercentage;
  final String maxdiscountpercentage;
  final String mindiscountpercentagenew;
  final String maxdiscountpercentagenew;
  final String welcomediscpercentagenew;
  final String minpurchasedisc;
  final String offerdescription;
  const DetailsScreen1({
    super.key,
    required this.businessId,
    required this.customerUserId,
    required this.discounttype,
    required this.welcomediscount,
    required this.validitydays,
    required this.usertransactiontype,
    required this.totalpoints,
    // required this.firsttimestatus,
    required this.transactiontype,
    // required this.welcomediscountfirsttime,
    required this.customermobile,
    required this.mobileqracc,
    required this.welcomediscpercentage,
    required this.mindiscountpercentage,
    required this.maxdiscountpercentage,
    required this.mindiscountpercentagenew,
    required this.maxdiscountpercentagenew,
    required this.welcomediscpercentagenew,
    required this.minpurchasedisc,
    required this.offerdescription,
  });

  @override
  State<DetailsScreen1> createState() => _DetailsScreen1State();
}

class _DetailsScreen1State extends State<DetailsScreen1> {
  bool yesnotbutton = false;
  bool applieddiscount = false;
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

  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController idTextEditingController = TextEditingController();
  TextEditingController discountTextEditingController = TextEditingController();
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
            color: AppColor.secondryColor,
            child: SingleChildScrollView(
              child: Directionality(
                textDirection:
                    language == 1 ? TextDirection.rtl : TextDirection.ltr,
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
                                    ? AppImage.rightbackIcon
                                    : AppImage.backIcon,
                                width:
                                    MediaQuery.of(context).size.width * 5 / 100,
                                height: MediaQuery.of(context).size.height *
                                    5 /
                                    100,
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
                              child: Text(AppLanguage.detailsText[language],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColor.themeColor,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 3 / 100),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLanguage.priceText[language],
                            style: const TextStyle(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          Center(
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 70 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              child: Directionality(
                                textDirection: language == 1
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: TextFormField(
                                  // inputFormatters: [maskFormatter],
                                  style: const TextStyle(color: Colors.black),
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.phone,
                                  controller: amountTextEditingController,
                                  maxLength: 5,
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.textinputColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.textinputColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.textinputColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          top: 5, left: 15),
                                      fillColor: AppColor.textinputColor,
                                      filled: true,
                                      counterText: '',
                                      hintText:
                                          AppLanguage.priceinputText[language],
                                      hintStyle: AppConstant.textFilledStyle),
                                  onTap: () {
                                    setState(() {
                                      applieddiscount = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      child: Text(
                        "${AppLanguage.minimumpurchaseshouldbeatleastMessage[language]} ${widget.minpurchasedisc}",
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 5 / 100),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLanguage.percentageofpointsearnedText[language],
                            style: const TextStyle(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          if (widget.discounttype == 0)
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 27 / 100,
                              height: MediaQuery.of(context).size.height *
                                  3.5 /
                                  100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.greydarkColor.withOpacity(0.72),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                (widget.mindiscountpercentagenew),
                                style: const TextStyle(
                                    color: AppColor.secondryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                          if (widget.discounttype == 1)
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    27 /
                                    100,
                                height: MediaQuery.of(context).size.height *
                                    3.5 /
                                    100,
                                alignment: Alignment.center,
                                child: Directionality(
                                  textDirection: language == 1
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  child: TextFormField(
                                    // inputFormatters: [maskFormatter],
                                    style: const TextStyle(
                                        color: AppColor.secondryColor),
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.phone,
                                    controller: discountTextEditingController,
                                    maxLength: 2,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.greydarkColor
                                                .withOpacity(0.72),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.greydarkColor
                                                .withOpacity(0.72),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.greydarkColor
                                                .withOpacity(0.72),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 8),
                                        fillColor: AppColor.greydarkColor
                                            .withOpacity(0.72),
                                        filled: true,
                                        counterText: '',
                                        hintText:
                                            AppLanguage.discountText[language],
                                        hintStyle: AppConstant.textFilledStyle),
                                    onTap: () {
                                      setState(() {
                                        applieddiscount = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2 / 100),
                    if (widget.discounttype == 1)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        child: Text(
                          "(${widget.mindiscountpercentagenew} to ${widget.maxdiscountpercentagenew})",
                          style: const TextStyle(
                              color: Color(0xffD21E1E),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 3 / 100),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLanguage.balanceofpointsText[language],
                            style: const TextStyle(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 27 / 100,
                            height:
                                MediaQuery.of(context).size.height * 3.5 / 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.greydarkColor.withOpacity(0.72),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "${widget.totalpoints} ${AppLanguage.pointsText[language]}",
                              style: const TextStyle(
                                  color: AppColor.secondryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (widget.welcomediscount == 1)
                      Column(
                        children: [
                          // if (widget.welcomediscountfirsttime == 0)
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100),
                          // if (widget.welcomediscountfirsttime == 0)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLanguage.welcomediscountText[language],
                                  style: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      27 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      3.5 /
                                      100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff3C8AD2)
                                        .withOpacity(0.72),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    widget.welcomediscpercentagenew,
                                    style: const TextStyle(
                                        color: AppColor.secondryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // if (widget.welcomediscountfirsttime == 0)
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100),
                          // if (widget.welcomediscountfirsttime == 0)
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    18 /
                                    100,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      welcomediscountstatus = 1;
                                      yesnotbutton = true;
                                      applieddiscount = false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                3 /
                                                100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                3 /
                                                100,
                                        child: Image.asset(yesnotbutton == true
                                            ? AppImage.activerediobuttonIcon
                                            : AppImage.deactiverediobuttonIcon),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              2 /
                                              100),
                                      Text(
                                        AppLanguage.yesText[language],
                                        style: const TextStyle(
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    18 /
                                    100,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      welcomediscountstatus = 0;
                                      yesnotbutton = false;
                                      applieddiscount = false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                3 /
                                                100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                3 /
                                                100,
                                        child: Image.asset(yesnotbutton == false
                                            ? AppImage.activerediobuttonIcon
                                            : AppImage.deactiverediobuttonIcon),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              2 /
                                              100),
                                      Text(
                                        AppLanguage.noText[language],
                                        style: const TextStyle(
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // if (widget.welcomediscountfirsttime == 0)
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100),
                        ],
                      ),
                    if (yesnotbutton == true)
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 90 / 100,
                          height: MediaQuery.of(context).size.height * 6 / 100,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.name,
                            controller: idTextEditingController,
                            maxLength: AppConstant.idcardnumber,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                fillColor: AppColor.textinputColor,
                                filled: true,
                                counterText: '',
                                hintText: AppLanguage
                                    .nationalcardnumberText[language],
                                hintStyle: AppConstant.textFilledStyle),
                          ),
                        ),
                      ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 3 / 100),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLanguage.numberofdaysarevalidText[language],
                            style: const TextStyle(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 27 / 100,
                            height:
                                MediaQuery.of(context).size.height * 3.5 / 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.greydarkColor.withOpacity(0.72),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "${widget.validitydays} Days",
                              style: const TextStyle(
                                  color: AppColor.secondryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              appliediscountBtn(
                                  amountTextEditingController.text,
                                  idTextEditingController.text,
                                  discountTextEditingController.text);
                            },
                            child: Container(
                                height: MediaQuery.of(context).size.height *
                                    4 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    35 /
                                    100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.blackColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  applieddiscount == false
                                      ? AppLanguage.applydiscount[language]
                                      : AppLanguage
                                          .applieddiscountText[language],
                                  style: const TextStyle(
                                      color: AppColor.secondryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                )),
                          ),
                        ],
                      ),
                    ),
                    if (applieddiscount == true)
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 4 / 100),
                    if (applieddiscount == true)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLanguage.priceafterdiscountText[language],
                              style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 27 / 100,
                              height: MediaQuery.of(context).size.height *
                                  3.5 /
                                  100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.greydarkColor.withOpacity(0.72),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "$priceAfterDiscounted ${AppLanguage.dhText[language]}",
                                style: const TextStyle(
                                    color: AppColor.secondryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 6 / 100),
                    AppButton(
                        text: AppLanguage.sendButtonText[language],
                        onPress: () {
                          businessfilldetailsApiCalling();
                          // alert(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double discountedPrice = 0;
  double priceAfterDiscounted = 0;
  double pointearne = 0;
  double discountpercentage = 0;
  String productprice = "";
  int walletpoint = 0; // Used Points
  int walletpointstatus = 0;
  int welcomediscountstatus = 0;
  String nationalityId = "";

  appliediscountBtn(String price1, String idcardnumber, String discount) {
    FocusScope.of(context).unfocus();
    productprice = price1;

    if (yesnotbutton == true) {
      if (price1.isEmpty) {
        SnackBarToastMessage.showSnackBar(
            context, AppLanguage.priceMessage[language]);
      } else if (int.parse(price1) < double.parse(widget.minpurchasedisc)) {
        SnackBarToastMessage.showSnackBar(context,
            "${AppLanguage.minimumpurchaseshouldbeatleastMessage[language]} ${widget.minpurchasedisc}");
      } else if (idcardnumber.isEmpty) {
        SnackBarToastMessage.showSnackBar(
            context, AppLanguage.idcardNumber[language]);
      } else if (idcardnumber.length <= 11) {
        SnackBarToastMessage.showSnackBar(
            context, AppLanguage.valididcardNumber[language]);
      } else {
        // -------------Welcome Percentage Count ---------------

        double price = double.parse(price1);
        double discountPercentage1 = double.parse(widget.welcomediscpercentage);

        discountedPrice = (price * discountPercentage1 / 100);

        priceAfterDiscounted = price - discountedPrice;

        pointearne = 0;
        discountpercentage = 0;
        walletpoint = 0;
        walletpointstatus = 0;

        print("Totalprice $priceAfterDiscounted");

        Future.delayed(const Duration(seconds: 1), () => setState(() {}));

        print("pointearne $pointearne");
        print("discountedPrice $discountedPrice");

        setState(() {
          nationalityId = idcardnumber;
          pointearne = 0;
          discountpercentage = 0;
          walletpoint = 0;
          walletpointstatus = 0;
          applieddiscount = true;
        });
      }
    } else {
      if (widget.discounttype == 0) {
        if (price1.isEmpty) {
          SnackBarToastMessage.showSnackBar(
              context, AppLanguage.priceMessage[language]);
        } else if (int.parse(price1) < double.parse(widget.minpurchasedisc)) {
          SnackBarToastMessage.showSnackBar(context,
              "${AppLanguage.minimumpurchaseshouldbeatleastMessage[language]} ${widget.minpurchasedisc}");
        } else {
          // if (widget.firsttimestatus == 0) {
          //   double price = double.parse(price1);
          //   double discountPercentage1 =
          //       double.parse(widget.mindiscountpercentage);

          //   priceAfterDiscounted = price;

          //   pointearne = (price * discountPercentage1 / 100);

          //   Future.delayed(const Duration(seconds: 1), () => setState(() {}));

          //   print("pointearne First $pointearne");

          //   setState(() {
          //     walletpoint = 0;
          //     walletpointstatus = 1;
          //     discountpercentage = discountPercentage1;
          //     applieddiscount = true;
          //   });
          // } else {
          double price = double.parse(price1);
          double discountPercentage1 =
              double.parse(widget.mindiscountpercentage);

          priceAfterDiscounted = price - widget.totalpoints;

          pointearne = (price * discountPercentage1 / 100);

          print("discountedPrice $priceAfterDiscounted");

          print("pointearne secound $pointearne");

          Future.delayed(const Duration(seconds: 1), () => setState(() {}));

          setState(() {
            walletpointstatus = 1;
            walletpoint = widget.totalpoints;
            discountpercentage = discountPercentage1;
            applieddiscount = true;
          });
          // }
          // ------------- Percentage Count ---------------

          //   double price = double.parse(price1);
          //   double discountPercentage =
          //       double.parse(widget.mindiscountpercentage);

          //   discountedPrice = (price * discountPercentage / 100);

          //   priceAfterDiscounted = price - discountedPrice;

          //   print("Totalprice $priceAfterDiscounted");

          //   Future.delayed(const Duration(seconds: 1), () => setState(() {}));

          //   print("discountedPrice $discountedPrice");

          //   setState(() {
          //     applieddiscount = true;
          //   });
        }
      } else {
        if (price1.isEmpty) {
          SnackBarToastMessage.showSnackBar(
              context, AppLanguage.priceMessage[language]);
        } else if (int.parse(price1) < double.parse(widget.minpurchasedisc)) {
          SnackBarToastMessage.showSnackBar(context,
              "${AppLanguage.minimumpurchaseshouldbeatleastMessage[language]} ${widget.minpurchasedisc}");
        } else if (discount.isEmpty) {
          SnackBarToastMessage.showSnackBar(
              context, AppLanguage.enterdiscountMessage[language]);
        } else if (int.parse(discount) <
                double.parse(widget.mindiscountpercentage) ||
            int.parse(discount) > double.parse(widget.maxdiscountpercentage)) {
          SnackBarToastMessage.showSnackBar(
              context, AppLanguage.discountMessage[language]);
        } else {
          // if (widget.firsttimestatus == 0) {
          //   double price = double.parse(price1);
          //   double discountPercentage1 = double.parse(discount);

          //   priceAfterDiscounted = price;

          //   pointearne = (price * discountPercentage1 / 100);

          //   Future.delayed(const Duration(seconds: 1), () => setState(() {}));

          //   setState(() {
          //     walletpoint = 0;
          //     walletpointstatus = 1;
          //     discountpercentage = discountPercentage1;
          //     applieddiscount = true;
          //   });
          // } else {
          double price = double.parse(price1);
          double discountPercentage1 = double.parse(discount);

          priceAfterDiscounted = price - widget.totalpoints;

          pointearne = (price * discountPercentage1 / 100);

          Future.delayed(const Duration(seconds: 1), () => setState(() {}));

          setState(() {
            walletpointstatus = 1;
            walletpoint = widget.totalpoints;
            discountpercentage = discountPercentage1;
            applieddiscount = true;
          });
          // }
          // double price = double.parse(price1);
          // double discountPercentage = double.parse(discount);

          // discountedPrice = (price * discountPercentage / 100);

          // priceAfterDiscounted = price - discountedPrice;

          // print("Totalprice $priceAfterDiscounted");

          // Future.delayed(const Duration(seconds: 1), () => setState(() {}));

          // print("discountedPrice $discountedPrice");

          // setState(() {
          //   applieddiscount = true;
          // });
        }
      }
    }
  }

// ---------------- Api Calling Start -------------------

  businessfilldetailsApiCalling() async {
    if (applieddiscount == false) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.applydiscountMessage[language]);
    } else {
      Uri url =
          Uri.parse("${AppConfigProvider.apiUrl}business_fill_details.php");

      print("Url $url");

      setState(() {
        isApiCalling = true;
      });

      try {
        http.MultipartRequest formData = http.MultipartRequest('POST', url);

        formData.fields['user_id'] = userId.toString();
        formData.fields['customer_id'] = widget.customerUserId.toString();
        formData.fields['mobile'] = widget.customermobile.toString();
        formData.fields['price'] = productprice.toString();
        formData.fields['transaction_type'] = widget.transactiontype.toString();
        formData.fields['user_transaction_type'] =
            widget.usertransactiontype.toString();
        formData.fields['discount_percentage'] = discountpercentage.toString();
        formData.fields['discount_point'] = pointearne.toString();
        formData.fields['wallet_point'] = walletpoint.toString();
        formData.fields['wallet_point_status'] = walletpointstatus.toString();
        // formData.fields['type'] = widget.firsttimestatus.toString();
        formData.fields['mobile_qr_account_id'] = widget.mobileqracc.toString();
        formData.fields['number_of_valid_days'] =
            widget.validitydays.toString();
        formData.fields['price_after_discount'] =
            priceAfterDiscounted.toString();
        formData.fields['welcome_discount'] = welcomediscountstatus.toString();
        formData.fields['nationality_id'] = nationalityId.toString();
        formData.fields['discount_type'] = widget.discounttype.toString();

        http.StreamedResponse response = await formData.send();
        print("response--> $response");
        var responseString = await response.stream.toBytes();
        var res = jsonDecode(utf8.decode(responseString));

        print("res Rohit Modi $res");

        if (response.statusCode == 200) {
          print("res123 : $res");
          if (res['success'] == 'true') {
            // ignore: use_build_context_synchronously
            alert(context);
          } else {
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
  }

// ---------------- Api Calling End ---------------------

}

alert(context) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    useRootNavigator: false,
    isDismissible: false,
    enableDrag: false,
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
                SizedBox(height: MediaQuery.of(context).size.height * 35 / 100),
                Container(
                    height: MediaQuery.of(context).size.height * 22 / 100,
                    width: MediaQuery.of(context).size.width * 70 / 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.secondryColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 10 / 100,
                          width: MediaQuery.of(context).size.width * 10 / 100,
                          child: Image.asset(AppImage.checkIcon),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 50 / 100,
                          margin: EdgeInsets.only(
                              top:
                                  MediaQuery.of(context).size.height * 2 / 100),
                          child: Text(
                              textAlign: TextAlign.center,
                              AppLanguage
                                      .transactionhasbeensuccessfullysentText[
                                  language],
                              style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 4 / 100,
                            width: MediaQuery.of(context).size.width * 20 / 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColor.blackColor,
                            ),
                            child: Text(AppLanguage.okText[language],
                                style: const TextStyle(
                                    color: AppColor.secondryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ),
                        )
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
