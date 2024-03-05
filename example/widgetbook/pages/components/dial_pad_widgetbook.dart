import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent dialPadWidgetbook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Dial Pad',
    useCases: [
      WidgetbookUseCase(
        name: 'Dial Pad',
        builder: (context) {
          return WidgetbookTestWidget(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZetaDialPad(
                  buttonValues: context.knobs.boolean(label: 'Change to emoji')
                      ? {
                          '😀': '',
                          '🥲': '',
                          '🥳': '',
                          '🤠': '',
                          '😨': '',
                          '👀': '',
                          '🐤': '',
                          '🐞': '',
                          '🦊': '',
                          '🏆': '',
                          '⛺️': '',
                          '🧽': ''
                        }
                      : null,
                  buttonsPerRow: context.knobs.int.slider(label: 'Buttons per row', initialValue: 3, min: 1, max: 9),
                ),
              ],
            ).paddingAll(ZetaSpacing.l),
          );
        },
      ),
    ],
  );
}
