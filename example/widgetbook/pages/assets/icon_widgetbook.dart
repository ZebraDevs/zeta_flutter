import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent iconWidgetbook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Icons',
    useCases: [
      WidgetbookUseCase(
        name: 'All Icons',
        builder: (context) {
          List<IconData> icons = (context.knobs.boolean(label: 'Rounded', initialValue: true)
              ? [...iconsRounded]
              : [...iconsSharp])
            ..sort((a, b) => a.codePoint < b.codePoint ? 1 : 0);
          return WidgetbookTestWidget(
            removeBody: true,
            widget: SingleChildScrollView(
              child: Wrap(
                spacing: ZetaSpacing.b,
                runSpacing: ZetaSpacing.b,
                children: icons.map((e) => Icon(e, size: ZetaSpacing.x10)).toList(),
              ),
            ),
          );
        },
      ),
    ],
  );
}
