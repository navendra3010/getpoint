// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../OtherPages/home_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class Splash extends StatefulWidget {
  const Splash({super.key});
  static String routeName = './Splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int phonenumber = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => loginUserApiCall());
  }

  loginUserApiCall() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic userDetails = prefs.getString("user_details");
    dynamic password = prefs.getString("password");
    dynamic language1 = prefs.getString("language_id");

    if (language1 != null) {
      dynamic data = json.decode(language1);

      language = data;
      setState(() {});
    }

    print("password $password");

    // ----------- userid and phone number --------------

    if (userDetails != null) {
      dynamic data = jsonDecode(userDetails);

      print("data $data");

      phonenumber = data['mobile'];

      print("phonenumber $phonenumber");

      if (data['profile_complete'] == 1) {
        Uri url = Uri.parse("${AppConfigProvider.apiUrl}login.php");

        print("Url $url");

        try {
          // String playeID = AppConstant.playerID;
          print("playeID splash.. ${AppConstant.playerID}");

          http.MultipartRequest formData = http.MultipartRequest('POST', url);

          formData.fields['mobile'] = phonenumber.toString();
          formData.fields['password'] = jsonDecode(password.toString());
          formData.fields['player_id'] = AppConstant.playerID;
          formData.fields['device_type'] = AppConstant.deviceType.toString();
          formData.fields['login_type'] = "app";
          formData.fields['language_id'] = language.toString();
          formData.fields['user_type'] = "2".toString();

          http.StreamedResponse response = await formData.send();
          print("response--> $response");
          var responseString = await response.stream.toBytes();
          var res = jsonDecode(utf8.decode(responseString));

          if (response.statusCode == 200) {
            print("res : $res");
            if (res['success'] == 'true') {
              if (res['user_details'] != "NA") {
                final prefs = await SharedPreferences.getInstance();
                print("prefs =================>$prefs");
                prefs.setString(
                    "user_details", jsonEncode(res['user_details']));

                Future.delayed(
                  const Duration(seconds: 2),
                  () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home())),
                );
              } else {
                Future.delayed(
                  const Duration(microseconds: 1000),
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  ),
                );
              }
            } else {
              Future.delayed(
                const Duration(microseconds: 1000),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                ),
              );
            }
          }
        } catch (e) {}
      } else {
        Future.delayed(
          const Duration(microseconds: 1000),
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          ),
        );
      }
    } else {
      Future.delayed(
        const Duration(microseconds: 1000),
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImage.splashImage),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
