import 'package:flutter/material.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import 'setting_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';


class TermsAndConditions extends StatefulWidget {
  static String routeName = './TermsAndConditions';

  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
   WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        systemOverlayStyle: AppConstant.systemUiOverlayStyle,
        leading: InkWell(
            onTap: () {},
            child: IconButton(
              icon: Image.asset(
                AppImage.backIcon,
                width: MediaQuery.of(context).size.width * 8 / 100,
            height: MediaQuery.of(context).size.height * 8 / 100,
              ),
              onPressed: () {
              Navigator.pop(context);
              },
            )),
        title: Text(AppLanguage.termsConditionText[language],
            style: AppConstant.appBarTitleStyle),
      ),
      body: SafeArea(
       child: WebView(
            initialUrl: 'https://flutter.dev',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
               _controller = webViewController;
            },
          ),
      ),
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Center(
      //       child: Container(
      //         width: MediaQuery.of(context).size.width * 100 / 100,
            
      //         color: Colors.white,
      //         child: Column(
      //           children: [
                
      //             SizedBox(
      //               height: MediaQuery.of(context).size.height * 1 / 100,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 8),
      //               child: Container(
      //                 margin: EdgeInsets.only(left: 8),
      //                 child: const Text(
      //                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      //                   style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.w500,
      //                       height: 1.5,
      //                       color: AppColor.greyLightColor),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
   
    );
  }
}
