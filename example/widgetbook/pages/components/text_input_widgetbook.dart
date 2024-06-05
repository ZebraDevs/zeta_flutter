import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget textInputUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        final label = context.knobs.string(
          label: 'Label',
          initialValue: 'Label',
        );
        final errorText = context.knobs.stringOrNull(
          label: 'Error message',
          initialValue: 'Oops! Error hint text',
        );
        final hintText = context.knobs.string(
          label: 'Hint',
          initialValue: 'Default hint text',
        );
        final rounded = roundedKnob(context);
        final disabled = disabledKnob(context);
        final size = context.knobs.list<ZetaWidgetSize>(
          label: 'Size',
          options: ZetaWidgetSize.values,
          labelBuilder: (size) => size.name,
        );

        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.x5),
          child: ZetaTextInput(
            size: size,
            rounded: rounded,
            disabled: disabled,
            label: label,
            hintText: hintText,
            errorText: errorText,
            prefixText: '£',
            suffix: IconButton(
              icon: Icon(ZetaIcons.star_round),
              onPressed: () {},
            ),
            onChange: (value) {},
          ),
        );
      },
    ),
  );
}
