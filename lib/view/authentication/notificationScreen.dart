import 'package:flutter/material.dart';
import 'package:getpoints/utilities/app_constant.dart';
import 'package:getpoints/utilities/app_image.dart';
import 'package:getpoints/utilities/app_language.dart';
import 'package:getpoints/view/authentication/home_screen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> listItem = <dynamic>[
    {"name": "Admin", "Status": false},
    {"name": "Ram", "Status": false},
    {"name": "Shayam", "Status": false},
    {"name": "Rohit", "Status": false},
    {"name": "Raman", "Status": false},
    {"name": "Amit", "Status": false},
    {"name": "Rahul", "Status": false},
    {"name": "Sankar", "Status": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        // centerTitle: true,
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
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: Text(
              AppLanguage.cleartextName[language],
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
        ],
      ),
      body: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height * 1 / 100),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listItem.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 238, 238, 238),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 172, 167, 167)
                              .withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 15 / 100,
                          height: MediaQuery.of(context).size.width * 15 / 100,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: AssetImage(AppImage.adminicon),
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 1 / 100,
                        ),
                        Column(
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 68 / 100,
                              child: Text(
                                listItem[index]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 1 / 100,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 70 / 100,
                              child: const Text(
                                  " you have successfully sent an points",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 134, 134, 134),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 5 / 100,
                        //   height: MediaQuery.of(context).size.height * 5 / 100,
                        //   decoration: BoxDecoration(shape: BoxShape.circle),
                        //   child:
                        //       Container(child: Image.asset(AppImage.crossIcon)),
                        // ),

                        ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(10), // Image radius
                            child: Image.asset(AppImage.crossIcon,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: const Text("15 min ago",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ]),
                );
              }),
        ),
      ]),
    );
  }
}
