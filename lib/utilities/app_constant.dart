import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';

int language = 0;

class AppConstant {
  static double globalLatitude = 34.05223;
  static double globalLongitude = -118.24368;
  static const int appStatus = 0;
  static const TextStyle appBarTitleStyle = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static const TextStyle textFilledStyle = TextStyle(
    color: AppColor.placeholderColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  // Defination of max length
  static const int emailMaxLength = 100;
  static const int passwordMaxLength = 16;
  static const int fullNameText = 50;
  static const int mobileMaxLenth = 18;
  static const int messageMaxLenth = 250;
  static const int firstnameMaxLenth = 25;
  static const int lastnameMaxLenth = 25;
  static const int bankaccountnumberMaxLenth = 10;
  static const int specialcode = 16;
  static const int idcardnumber = 12;

  static String playerID = "123456";
  static String oneSignalAppId = "3d1f774d-2fd4-427f-9bdb-b7e9c73b1a27";

  static var deviceType = Platform.isAndroid ? 'android' : 'ios';

  static const TextStyle textFilledHeading =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);
  static const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}

class ContentClass {
  final String title;

  ContentClass({required this.title});
}

class ForgotuserId {
  final String userId;
  final String phonenumber;

  ForgotuserId({required this.userId, required this.phonenumber});
}

class ForgotnewpassworduserId {
  final String userId;

  ForgotnewpassworduserId({required this.userId});
}

class DetailsScreenClass {
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

  DetailsScreenClass({
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
}

enum BottomMenus { home, transactionsIdscreen, profile }
