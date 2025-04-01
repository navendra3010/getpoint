import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_color.dart';

class AppMediaProvider {
  static Future<dynamic> imagePicker(BuildContext context) async {
    var cameraGallery = "Na";
    bool isSelectedImage = false;
    var base64Image;
    var fileName;
    var _imageSelect;

    Future<void> _imgFromCamera() async {
      // ignore: deprecated_member_use
      var image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);

      if (image != null) {
        Future.delayed(Duration(seconds: 2), () {
          _imageSelect = File(image.path);
          print(_imageSelect);
          final bytes = File(image.path).readAsBytesSync();
          base64Image = base64Encode(bytes);
          // base64Image = base64Encode(image.path as List<int>);
          //  print("Hello $base64Image");
          fileName = image.path.split('/').last;
          isSelectedImage = true;
        });
      } else {}
    }
  }
}
