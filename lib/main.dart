import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'utilities/app_constant.dart';
import 'utilities/app_font.dart';
import 'utilities/routes.dart';
import 'view/authentication/splash_screen.dart';

Future<void> main() async {
  //Future.delayed(const Duration(seconds: 1), () async {
  runApp(const MyApp());
  await initOneSignal(AppConstant.oneSignalAppId);
  // });
}

Future<void> initOneSignal(oneSignalAppId) async {
  print("initOneSignal ------ ");
  var settings;
  if (AppConstant.deviceType == "android") {
    settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    };
  } else {
    settings = {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true
    };
  }
  await OneSignal.shared.setAppId(AppConstant.oneSignalAppId);

  print("Prompting for Permission");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  final status = await OneSignal.shared.getDeviceState();
  if (status != null) {
    print("main dart line 41");
    var tokenId = status.userId;
    if (tokenId != null) {
      print("player Id $tokenId");
      print(tokenId);
      AppConstant.playerID = tokenId;
      print("playerID : ${AppConstant.playerID}");
    }
  }

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    final status = await OneSignal.shared.getDeviceState();
    if (status != null) {
      print("status $status");
      final tokenId = status.userId;

      // Check if the player ID is generated
      if (tokenId != null) {
        //print("tokenId $tokenId");
        timer.cancel();
        AppConstant.playerID = tokenId;
        print('Interval stopped');
      }
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetPoints',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppFont.fontFamily,
        // ignore: deprecated_member_use
        // accentColor: const Color(0xffFFAD26),
      ),
      routes: routes,
      home: Splash(),
    );
  }
}
