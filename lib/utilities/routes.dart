import 'package:flutter/material.dart';
import 'package:getpoints/view/OtherPages/details_screen.dart';
import '../view/OtherPages/home_screen.dart';
import '../view/OtherPages/phonenumber.dart';
import '../view/OtherPages/qrcode_screen.dart';
import '../view/OtherPages/transactionsid_screen.dart';
import '../view/authentication/change_password.dart';
import '../view/authentication/contactus_screen.dart';
import '../view/authentication/content.dart';
import '../view/authentication/delete_account.dart';
import '../view/authentication/edit_profile_screen.dart';
import '../view/authentication/forgot_otp_verify_screen.dart';
import '../view/authentication/forgot_password_screen.dart';
import '../view/authentication/login_screen.dart';
import '../view/authentication/notifiction_screen.dart';
import '../view/authentication/otp_verify_screen.dart';
import '../view/authentication/profile.dart';
import '../view/authentication/reset_password.dart';
import '../view/authentication/setting_screen.dart';
import '../view/authentication/signup_screen.dart';
import '../view/authentication/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => const Splash(),
  //1.1 authentication route
  Login.routeName: (context) => const Login(),
  Setting.routeName: (context) => const Setting(),
  Content.routeName: (context) => const Content(),
  ContactUs.routeName: (context) => const ContactUs(),
  DeleteAccount.routeName: (context) => const DeleteAccount(),
  EditProfile.routeName: (context) => const EditProfile(),
  ForgotOtpVerify.routeName: (context) => const ForgotOtpVerify(),
  ForgotPassword.routeName: (context) => const ForgotPassword(),
  Notifications.routeName: (context) => const Notifications(),
  OtpVerify.routeName: (context) => const OtpVerify(),
  Profile.routeName: (context) => const Profile(),
  ResetPassword.routeName: (context) => const ResetPassword(),
  Signup.routeName: (context) => const Signup(),
  ChangePassword.routeName: (context) => const ChangePassword(),

  //1.2 OtherPages Route
  Home.routeName: (context) => const Home(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  TransactionsIdScreen.routeName: (context) => const TransactionsIdScreen(),
  QrCodeScreen.routeName: (context) => const QrCodeScreen(),
  PhoneNumber.routeName: (context) => const PhoneNumber(),
};
