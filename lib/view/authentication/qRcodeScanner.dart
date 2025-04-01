import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:getpoints/utilities/app_image.dart';
import 'package:getpoints/view/authentication/home_screen.dart';

class QRcodescanPage extends StatefulWidget {
  const QRcodescanPage({super.key});
  @override
  State<QRcodescanPage> createState() => _MyQRCodeScanner();
}

class _MyQRCodeScanner extends State<QRcodescanPage> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //       Duration(seconds: 3),
  //       () => Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => Home())));
  // }
  String _scanBarcode = 'Unknown';

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.DEFAULT);
      print("Barcode scan result: $barcodeScanRes");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Barcode Result: $_scanBarcode\n',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () => scanBarcode(),
              child: Text("Scan Barcode"),
            ),
          ],
        ),
      ),
    );
  }
}
