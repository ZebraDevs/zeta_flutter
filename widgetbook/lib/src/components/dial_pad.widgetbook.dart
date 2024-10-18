import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Dial Pad',
  type: ZetaDialPad,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21156-19735&t=6jmGZpLRLKTDIfJL-4',
)
Widget dialPad(BuildContext context) => ZetaDialPad(
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
    );
