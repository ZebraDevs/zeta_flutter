import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/src/utils/enums.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent badgeWidgetBook() {
  return WidgetbookComponent(
    name: 'Badge',
    useCases: [
      WidgetbookUseCase(
        name: 'Badge Rounded',
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              _badgeExampleRow(WidgetSeverity.info),
              _badgeExampleRow(WidgetSeverity.positive),
              _badgeExampleRow(WidgetSeverity.warning),
              _badgeExampleRow(WidgetSeverity.negative),
              _badgeExampleRow(WidgetSeverity.neutral),
              _badgeExampleRow(WidgetSeverity.custom, customColor: Colors.blue),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Badge Sharp',
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              _badgeExampleRow(WidgetSeverity.info, isRounded: false),
              _badgeExampleRow(WidgetSeverity.positive, isRounded: false),
              _badgeExampleRow(WidgetSeverity.warning, isRounded: false),
              _badgeExampleRow(WidgetSeverity.negative, isRounded: false),
              _badgeExampleRow(WidgetSeverity.neutral, isRounded: false),
              _badgeExampleRow(
                WidgetSeverity.custom,
                customColor: Colors.blue,
                isRounded: false,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _badgeExampleRow(WidgetSeverity type, {bool isRounded = true, Color? customColor}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ZetaBadge(
              label: 'Label',
              severity: type,
              customColor: customColor,
              borderType: isRounded ? BorderType.rounded : BorderType.sharp,
            )),
      ]);
}
