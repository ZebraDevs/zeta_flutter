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
      leading: context.knobs.boolean(label: 'Avatar') ? ZetaAvatar(initials: 'AZ', size: ZetaAvatarSize.xs) : null,
      rounded: rounded,
      trailing: trailing != null ? Icon(trailing) : null,
    ),
  );
}

Widget filterChipUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaFilterChip(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        rounded: roundedKnob(context),
        selected: context.knobs.boolean(label: 'Selected'),
      ),
    );

Widget assistChipUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaAssistChip(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        rounded: roundedKnob(context),
        leading: context.knobs.boolean(label: 'Icon') ? Icon(ZetaIcons.star_round) : null,
      ),
    );
