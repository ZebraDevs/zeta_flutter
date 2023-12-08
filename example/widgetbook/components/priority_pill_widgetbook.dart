import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_flutter/src/utils/enums.dart';

WidgetbookComponent priorityPillWidgetBook() {
  return WidgetbookComponent(
    name: 'PriorityPill',
    useCases: [
      WidgetbookUseCase(
        name: 'Priority Pill',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ZetaPriorityPill(
                  index: 1,
                  priority: 'Priority',
                  borderType: BorderType.rounded,
                ),
                SizedBox(height: 50),
                ZetaPriorityPill(
                  index: 2,
                  priority: 'Priority',
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
