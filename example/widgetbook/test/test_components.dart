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
    final size = screenSize ?? const Size(1280, 720);

    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      body: removeBody
          ? widget
          : Center(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: MediaQuery(
                  data: MediaQueryData(size: Size(size.width, size.height)),
                  child: SingleChildScrollView(child: Center(child: widget)),
                ),
              ),
            ),
    );
  }
}
