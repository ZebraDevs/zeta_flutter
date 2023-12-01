import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' ;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_example/pages/checkbox_example.dart';


WidgetbookComponent checkboxWidgetBook() {
  return WidgetbookComponent(
    name: 'Checkbox',
    useCases: [
      WidgetbookUseCase(
        name: 'Checkbox (sharp)',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: getCheckBoxRow(isEnabled: true),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Checkbox (rounded)',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: getCheckBoxRow(isEnabled: true, isSharp: false),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Checkbox disabled (rounded)',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: getCheckBoxRow(isEnabled: false, isSharp: false),
          ),
        ),
      ),
    ],
  );
}
