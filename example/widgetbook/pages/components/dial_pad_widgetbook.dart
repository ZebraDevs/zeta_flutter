import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget dialPadUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ZetaDialPad(
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
      ),
    );
