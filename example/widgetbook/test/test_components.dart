import 'package:flutter/material.dart';

class WidgetbookTestWidget extends StatelessWidget {
  final Size? screenSize;
  final Widget widget;
  final bool removeBody;
  final Color? backgroundColor;

  const WidgetbookTestWidget({
    required this.widget,
    this.screenSize,
    super.key,
    this.removeBody = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      body: removeBody
          ? widget
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize?.width,
                  height: screenSize?.height,
                  child: MediaQuery(
                    data: MediaQueryData(
                        size: Size(screenSize?.width ?? double.infinity, screenSize?.height ?? double.infinity)),
                    child: SingleChildScrollView(child: Center(child: widget)),
                  ),
                ),
              ],
            ),
    );
  }
}
