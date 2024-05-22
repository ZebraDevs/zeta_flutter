import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget timeInputUseCase(BuildContext context) {
  String? _errorText;

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        final label = context.knobs.string(
          label: 'Label',
          initialValue: 'Label',
        );
        final errorText = context.knobs.string(
          label: 'Error message',
          initialValue: 'Oops! Error hint text',
        );
        final hintText = context.knobs.string(
          label: 'Hint',
          initialValue: 'Default hint text',
        );
        final rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);
        final disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
        final size = context.knobs.list<ZetaWidgetSize>(
          label: 'Size',
          options: ZetaWidgetSize.values,
          labelBuilder: (size) => size.name,
        );

        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.x5),
          child: ZetaTimeInput(
            size: size,
            rounded: rounded,
            disabled: disabled,
            label: label,
            hint: hintText,
            errorText: _errorText ?? errorText,
            onChange: (value) {},
          ),
        );
      },
    ),
  );
}
