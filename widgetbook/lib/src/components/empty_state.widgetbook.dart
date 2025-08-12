import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Empty State',
  type: ZetaEmptyState,
  path: '$componentsPath/EmptyState',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=38470-1055&m=dev',
)
Widget dropdown(BuildContext context) {
  final primaryAction = context.knobs.stringOrNull(label: 'Primary Action');
  final secondaryAction = context.knobs.stringOrNull(label: 'Secondary Action');

  final illustration = context.knobs.objectOrNull.dropdown(
    label: 'Illustration',
    options: illustrations.keys.toList(),
    labelBuilder: sentencer,
    initialOption: 'serverDisconnect',
  );

  return ZetaEmptyState(
    title: context.knobs.string(label: 'Title', initialValue: 'Title'),
    description: context.knobs.string(
      label: 'Subtitle',
      initialValue: 'This is a placeholder description. It explains what this view is for and what to do next.',
    ),
    illustration: illustration != null ? illustrations[illustration] : null,
    primaryAction: primaryAction != null ? ZetaButton(label: primaryAction, onPressed: () {}) : null,
    secondaryAction:
        secondaryAction != null ? ZetaButton.outlineSubtle(label: secondaryAction, onPressed: () {}) : null,
  );
}
