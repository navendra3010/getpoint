import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_footer.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';

class MultipuleImage extends StatefulWidget {
  static String routeName = './MultipuleImage';

  const MultipuleImage({super.key});

  @override
  State<MultipuleImage> createState() => _MultipuleImageState();
}

class _MultipuleImageState extends State<MultipuleImage> {
  File? _imageSelect;
  var fileName;

  @override
  void initState() {
    super.initState();
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Multipule images'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  selectImages();
                },
                child: const Text('Select Images'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(
                          File(imageFileList![index].path),
                          fit: BoxFit.cover,
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
