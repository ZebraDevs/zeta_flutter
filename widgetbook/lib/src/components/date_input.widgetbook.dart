import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Date Input',
  type: Zeta,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=875-10317&t=fFNXUv3Vk4zGNrMG-4',
)
Widget dateInput(BuildContext context) {
  String? errorText2;

  return StatefulBuilder(
    builder: (context, setState) {
      final errorText = context.knobs.string(
        label: 'Error message for invalid date',
        initialValue: 'Invalid date',
      );
      final disabled = disabledKnob(context);
      final size = context.knobs.list<ZetaWidgetSize>(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: (size) => size.name,
      );
      final datePattern = context.knobs.list<String>(
        label: 'Date pattern',
        options: ['MM/dd/yyyy', 'dd/MM/yyyy', 'dd.MM.yyyy', 'yyyy-MM-dd'],
        labelBuilder: (pattern) => pattern,
      );

      return Padding(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
        child: ZetaDateInput(
          size: size,
          disabled: disabled,
          label: 'Birthdate',
          hintText: 'Enter birthdate',
          dateFormat: datePattern,
          errorText: errorText2 ?? errorText,
          onChange: (value) {
            if (value == null) return setState(() => errorText2 = null);
            final now = DateTime.now();
            setState(
              () => errorText2 = value.difference(DateTime(now.year, now.month, now.day)).inDays > 0
                  ? 'Birthdate cannot be in the future'
                  : null,
            );
          },
        ),
      );
    },
  );
}
