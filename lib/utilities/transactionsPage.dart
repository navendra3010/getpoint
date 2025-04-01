import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getpoints/utilities/app_footer.dart';
import 'package:getpoints/utilities/transanProduct.dart';
import 'package:getpoints/view/authentication/home_screen.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _MyTransactionUI();
}

class _MyTransactionUI extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      Product(
          id: "Not yet registered",
          price: "130.5DH",
          discount: "120.5 DH",
          percentage: "15%",
          welcomePoints: "19.75 point",
          welcomeDiscount: "yes"),
      Product(
          id: "9873636367373",
          price: "120.5DH",
          discount: "100.5 DH",
          percentage: "16%",
          welcomePoints: "19.70 point",
          welcomeDiscount: "yes"),
      Product(
          id: "7474747483838",
          price: "120.5DH",
          discount: "110.5 DH",
          percentage: "16%",
          welcomePoints: "19.05 point",
          welcomeDiscount: "yes"),
      Product(
          id: "Not yet registered",
          price: "100.5DH",
          discount: "120.5 DH",
          percentage: "15%",
          welcomePoints: "19.75 point",
          welcomeDiscount: "yes"),
      Product(
          id: "0000001",
          price: "132.5DH",
          discount: "120.5 DH",
          percentage: "5%",
          welcomePoints: "19.70 point",
          welcomeDiscount: "yes"),
      Product(
          id: "9999992388383",
          price: "1110.5DH",
          discount: "1220.5 DH",
          percentage: "11%",
          welcomePoints: "9.75 point",
          welcomeDiscount: "yes"),
      Product(
          id: "Not yet registered",
          price: "130.5DH",
          discount: "120.5 DH",
          percentage: "15%",
          welcomePoints: "19.75 point",
          welcomeDiscount: "yes"),
      // Add more products as needed
    ];

    final List<Product> products2 = [
      Product(
          id: "198743737272",
          price: "120.5DH",
          discount: "1990.5 DH",
          percentage: "18%",
          welcomePoints: "19.70 point",
          welcomeDiscount: "no"),
    ];

    return Scaffold(
      body: Column(children: [
        //this container for sizer box for height
        SizedBox(
          height: MediaQuery.of(context).size.height * 2 / 100,
        ),
        Container(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              height: MediaQuery.of(context).size.height * 9 / 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 50 / 100,
                  ),
                  Container(
                    child: Image.asset(
                      AppImage.transicon,
                      height: 30,
                      width: 20,
                    ),
                  ),
                ],
              )),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                //this containe define the box main container box
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  height: MediaQuery.of(context).size.height * 38 / 100,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        // color: Color.fromARGB(255, 219, 219, 219),
                        color: Color(0xFFF0F1F0),
                        spreadRadius: 3,
                        //   blurRadius: 7,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),

                        // this continer for id
                        Container(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                          width: MediaQuery.of(context).size.width * 60 / 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xFF2F2D2D),
                          ),
                          //color: Colors.amber,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                                  child: Text(
                                    "ID: ${product.id}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                          width: MediaQuery.of(context).size.width * 40 / 100,
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Price: ${product.price}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                          width: MediaQuery.of(context).size.width * 80 / 100,
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Price after Discount: ${product.discount}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                          width: MediaQuery.of(context).size.width * 40 / 100,
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Percentage: ${product.percentage}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                          width: MediaQuery.of(context).size.width * 80 / 100,
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Welcome  Discount: ${product.welcomeDiscount}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        //this contianer for balanaced earned
                        Container(
                            height:
                                MediaQuery.of(context).size.height * 6 / 100,
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            // padding: EdgeInsets.only(left: 8),

                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: const Color.fromARGB(255, 20, 20, 20)),
                            //color: Colors.amber,

                            child: Container(
                              child: Column(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      6 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      80 /
                                      100,
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    "Balance of Point Earned: ${product.welcomePoints}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ]),
                            )),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ]),
      bottomNavigationBar: const AppFooter(
          selectedMenu: BottomMenus.transactions, notificationCount: 1),
    );
  }
}
