import 'package:flutter/material.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_footer.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import 'edit_profile_screen.dart';
import 'setting_screen.dart';

class Profile extends StatefulWidget {
  static String routeName = './Profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        systemOverlayStyle: AppConstant.systemUiOverlayStyle,
        title: Text("Profile", style: AppConstant.appBarTitleStyle),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 100 / 100,
          height: MediaQuery.of(context).size.height * 100 / 100,
          color: Colors.white,
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 40 / 100,
                    height: MediaQuery.of(context).size.width * 40 / 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 7, color: Colors.white60),
                      borderRadius: BorderRadius.circular(100), //<-- SEE HERE

                      image: const DecorationImage(
                        image: AssetImage(AppImage.backIcon),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 1.5 / 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Liam Smith,",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          )),
                      Text("23",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          )),
                    ],
                  ),
                  Text("Changi,Singapore",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfile()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 85 / 100,
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  // alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff5F6368),
                        width: 1,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text("EDit",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 17,
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 7 / 100,
                          height: MediaQuery.of(context).size.width * 7 / 100,
                          child: Image.asset(
                            AppImage.backIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 85 / 100,
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Color(0xff5F6368),
                    width: 1,
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Setting",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 17,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 7 / 100,
                          height: MediaQuery.of(context).size.width * 7 / 100,
                          child: Image.asset(
                            AppImage.backIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppFooter(
          selectedMenu: BottomMenus.profile, notificationCount: 2),
    );
  }
}
