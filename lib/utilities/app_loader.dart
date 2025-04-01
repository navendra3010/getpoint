import 'package:flutter/material.dart';
import 'package:getpoints/utilities/app_image.dart';
import 'app_color.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  int count = 0;
  //  final Animation<Color> valueColor;

  ProgressHUD({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.count = 0,

    //  this.valueColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);

    if (count == 0) {
      if (inAsyncCall) {
        final modal = Stack(
          children: [
            Opacity(
              opacity: opacity,
              child: ModalBarrier(dismissible: false, color: color),
            ),
            const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
              AppColor.themeColor,
            ))),
          ],
        );
        widgetList.add(modal);
      }
    }

    return Stack(
      children: widgetList,
    );
  }
}
