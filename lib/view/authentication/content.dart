import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getpoints/utilities/app_image.dart';
import 'package:getpoints/view/authentication/setting_screen.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_language.dart';

class Content extends StatelessWidget {
  static String routeName = './Content';

  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContentClass? object;

    object = ModalRoute.of(context)!.settings.arguments as ContentClass;

    print(object.title);

    return Scaffold(
      body: ContentScreen(
        title: object.title,
      ),
    );
  }
}

class ContentScreen extends StatefulWidget {
  final String title;

  const ContentScreen({super.key, required this.title});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting()),
                );
              },
            )),
        title: Text(widget.title, style: AppConstant.appBarTitleStyle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      child: const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: AppColor.greyLightColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
