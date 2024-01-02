import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/password_input_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent passwordInputWidgetBook() {
  return WidgetbookComponent(
    name: 'Password Input',
    useCases: [
      WidgetbookUseCase(
        name: 'Rounded',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.x5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.x10),
                ...passwordInputExampleRow(ZetaWidgetSize.large),
                Divider(height: Dimensions.x20),
                ...passwordInputExampleRow(ZetaWidgetSize.medium),
                Divider(height: Dimensions.x20),
                ...passwordInputExampleRow(ZetaWidgetSize.small),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Sharp',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.x5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.x10),
                ...passwordInputExampleRow(ZetaWidgetSize.large, borderType: BorderType.sharp),
                Divider(height: Dimensions.x20),
                ...passwordInputExampleRow(ZetaWidgetSize.medium, borderType: BorderType.sharp),
                Divider(height: Dimensions.x20),
                ...passwordInputExampleRow(ZetaWidgetSize.small, borderType: BorderType.sharp),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
