import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget timeInputUseCase(BuildContext context) {
  String? _errorText;

  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(
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
        final disabled = disabledKnob(context);
        final size = context.knobs.list<ZetaWidgetSize>(
          label: 'Size',
          options: ZetaWidgetSize.values,
          labelBuilder: (size) => size.name,
        );

        return Padding(
          padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
          child: ZetaTimeInput(
            size: size,
            disabled: disabled,
            label: label,
            hintText: hintText,
            errorText: _errorText ?? errorText,
            onChange: (value) {},
          ),
        );
      },
    ),
  );
}
