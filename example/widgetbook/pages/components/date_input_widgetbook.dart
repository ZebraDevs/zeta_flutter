import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget dateInputUseCase(BuildContext context) {
  String? _errorText;

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        final errorText = context.knobs.string(
          label: 'Error message for invalid date',
          initialValue: 'Invalid date',
        );
        final rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);
        final disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
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
          padding: const EdgeInsets.all(ZetaSpacing.xL),
          child: ZetaDateInput(
            size: size,
            rounded: rounded,
            disabled: disabled,
            label: 'Birthdate',
            hintText: 'Enter birthdate',
            dateFormat: datePattern,
            errorText: _errorText ?? errorText,
            onChange: (value) {
              if (value == null) return setState(() => _errorText = null);
              final now = DateTime.now();
              setState(
                () => _errorText = value.difference(DateTime(now.year, now.month, now.day)).inDays > 0
                    ? 'Birthdate cannot be in the future'
                    : null,
              );
            },
          ),
        );
      },
    ),
  );
}
