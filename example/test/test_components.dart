// ignore_for_file: avoid-top-level-members-in-tests
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class TestWidget extends StatelessWidget {
  final Device screenSize;
  final Widget widget;

  const TestWidget({required this.widget, this.screenSize = Desktop.desktop1080p, super.key});

  @override
  Widget build(BuildContext context) {
    final size = screenSize.resolution.logicalSize;

    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: MediaQuery(
            data: MediaQueryData(size: Size(size.width, size.height)),
            child: SingleChildScrollView(child: widget),
          ),
        ),
      ),
    );
  }
}
