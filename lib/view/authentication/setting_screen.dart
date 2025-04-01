import 'package:flutter/material.dart';
import 'package:getpoints/view/authentication/content.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import 'change_password.dart';
import 'contactus_screen.dart';
import 'delete_account.dart';
import 'login_screen.dart';
import 'profile.dart';
import 'package:share_plus/share_plus.dart';

class Setting extends StatefulWidget {
  static String routeName = './setting';

  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String shareWith = "NA";
  shareApp(BuildContext context) async {
    var shareUrl = shareWith;
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(shareUrl,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

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
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            )),
        title: const Text("Setting", style: AppConstant.appBarTitleStyle),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                SettingRow(
                  leadingIcon: AppImage.backIcon,
                  title: "About Us",
                  onPress: () {
                    Navigator.pushNamed(context, Content.routeName,
                        arguments: ContentClass(title: "About Us".toString()));
                  },
                ),
                SettingRow(
                  leadingIcon: AppImage.backIcon,
                  title: "Change Password",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ChangePassword())),
                    );
                  },
                ),
                SettingRow(
                  leadingIcon: AppImage.backIcon,
                  title: "Terms & Condication",
                  onPress: () {
                    Navigator.pushNamed(context, Content.routeName,
                        arguments: ContentClass(
                            title: "Terms & Condition".toString()));
                  },
                ),
                SettingRow(
                  leadingIcon: AppImage.backIcon,
                  title: "Privacy Policy",
                  onPress: () {
                    Navigator.pushNamed(context, Content.routeName,
                        arguments:
                            ContentClass(title: "Privacy Policy".toString()));
                  },
                ),
                SettingRow(
                  leadingIcon: AppImage.backIcon,
                  title: "Contact",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ContactUs())),
                    );
                  },
                ),
                SettingRow(
                  leadingIcon: AppImage.backIcon,
                  title: "Share App",
                  onPress: () {
                    shareApp(context);
                  },
                ),
                SettingRow(
                  leadingIcon: AppImage.backIcon,
                  title: "Rate App",
                  onPress: () {},
                ),
                SettingRow(
                  leadingIcon: AppImage.backIcon,
                  title: "Delete Account",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const DeleteAccount())),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 21 / 100,
                ),
                GestureDetector(
                  onTap: () {
                    _showAlertDialog1(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width * 85 / 100,
                    height: MediaQuery.of(context).size.height * 7 / 100,
                    decoration: const BoxDecoration(
                        color: Color(0xffFFF5F5),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 8 / 100,
                          height: MediaQuery.of(context).size.width * 8 / 100,
                          child: Image.asset(AppImage.backIcon),
                        ),
                        Text(
                          AppLanguage.logoutText[language],
                          style: const TextStyle(
                              color: Color(0xffff0000),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAlertDialog1(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        AppLanguage.noText[language],
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        AppLanguage.yesText[language],
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
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
}

class SettingRow extends StatelessWidget {
  const SettingRow({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.onPress,
  }) : super(key: key);
  final String title;
  final String leadingIcon;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (() {
          onPress();
        }),
        child: Container(
          width: MediaQuery.of(context).size.width * 93 / 100,
          height: MediaQuery.of(context).size.height * 7 / 100,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 8 / 100,
                height: MediaQuery.of(context).size.width * 8 / 100,
                child: Image.asset(leadingIcon),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 100,
              ),
              Text(title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 19,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
