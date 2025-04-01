import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/app_button.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../authentication/edit_profile_screen.dart';

class Location extends StatefulWidget {
  static String routeName = './Location';
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String googleApikey = "AIzaSyANJfTKtqHrliVHGsZnjQS2hRHLgnzohlE";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng initialPosition = LatLng(21.0000, 78.0000);

  String location = "Search Location";

  String longitutte = "";
  String latitute = "";

  // List<dynamic> locationAddress = <dynamic>[];
  setItem() async {
    Map<String, dynamic> locationDetails =
        ({"lat": latitute, "lang": longitutte, "location": location});

    print(locationDetails);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("locationDetails", jsonEncode(locationDetails));
    print("jsonData $locationDetails");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => EditProfile()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Image.asset(
                AppImage.backIcon,
                height: 25,
                width: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(AppLanguage.locationText[language],
                style: AppConstant.appBarTitleStyle),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height * 100 / 100,
            width: MediaQuery.of(context).size.width * 100 / 100,
            child: Stack(alignment: Alignment.center, children: [
              GoogleMap(
                mapToolbarEnabled: false,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                myLocationEnabled: false,

                myLocationButtonEnabled: false,

                initialCameraPosition: CameraPosition(
                  // tilt: 47.5,
                  //innital position in map
                  target: initialPosition, //initial position
                  zoom: 14.0, //initial zoom level
                ),

                mapType: MapType.normal, //map type
                onMapCreated: (controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              ),

              //search autoconplete input
              Positioned(
                  //search input bar
                  top: 10,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 88 / 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () async {
                              var place = await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey: googleApikey,
                                  mode: Mode.overlay,
                                  types: [],
                                  strictbounds: false,
                                  onError: (err) {
                                    print(err);
                                  });

                              if (place != null) {
                                setState(() {
                                  location = place.description.toString();
                                });

                                final plist = GoogleMapsPlaces(
                                  apiKey: googleApikey,
                                  apiHeaders:
                                      await GoogleApiHeaders().getHeaders(),
                                );
                                String placeid = place.placeId ?? "0";

                                final detail =
                                    await plist.getDetailsByPlaceId(placeid);

                                print(detail.result.formattedAddress);
                                final geometry = detail.result.geometry!;
                                final lat = geometry.location.lat;
                                final lang = geometry.location.lng;
                                var newlatlang = LatLng(lat, lang);
                                initialPosition = LatLng(lat, lang);
                                setState(() {
                                  latitute = lat.toString();
                                  longitutte = lang.toString();
                                });
                                mapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: newlatlang, zoom: 17)));

                                print(lat);
                                print(lang);
                                print(geometry);
                                print(newlatlang);
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      90 /
                                      100,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  // height: MediaQuery.of(context).size.height *
                                  //     8 /
                                  //     100,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      location,
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.left,
                                    ),
                                    leading: Icon(
                                      Icons.search,
                                      size: 28,
                                    ),
                                    dense: false,
                                  )),
                            )),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: AppButton(
                              text: "Continue",
                              onPress: () {
                                setItem();
                              }),
                        ),
                      ],
                    ),
                  ))
            ]),
          )),
    );
  }
}
