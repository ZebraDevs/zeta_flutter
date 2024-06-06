import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget inputChipUseCase(BuildContext context) {
  final bool rounded = roundedKnob(context);
  final trailing = iconKnob(context);

  return WidgetbookTestWidget(
    widget: ZetaInputChip(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      leading: context.knobs.boolean(label: 'Avatar', initialValue: true)
          ? ZetaAvatar(
              initials: 'AZ',
              image: context.knobs.boolean(label: 'Avatar Image')
                  ? Image.asset('assets/Omer.jpg', fit: BoxFit.cover)
                  : null,
            )
          : null,
      rounded: rounded,
      trailing: trailing != null ? Icon(trailing) : null,
    ),
  );
}

Widget filterChipUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaFilterChip(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        rounded: roundedKnob(context),
        selected: context.knobs.boolean(label: 'Selected', initialValue: true),
      ),
    );

Widget assistChipUseCase(BuildContext context) {
  final rounded = roundedKnob(context);
  return WidgetbookTestWidget(
    widget: ZetaAssistChip(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      rounded: rounded,
      leading: Icon(iconKnob(context, rounded: rounded)),
    ),
  );
}
