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
        final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
        final size = context.knobs.list<ZetaDateInputSize>(
          label: 'Size',
          options: ZetaDateInputSize.values,
          labelBuilder: (size) => size.name,
        );
        final datePattern = context.knobs.list<String>(
          label: 'Date pattern',
          options: ['MM/dd/yyyy', 'dd/MM/yyyy', 'dd.MM.yyyy', 'yyyy-MM-dd'],
          labelBuilder: (pattern) => pattern,
        );

        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.x5),
          child: ZetaDateInput(
            size: size,
            rounded: rounded,
            enabled: enabled,
            label: 'Birthdate',
            hint: 'Enter birthdate',
            datePattern: datePattern,
            hasError: _errorText != null,
            errorText: _errorText ?? errorText,
            onChanged: (value) {
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
