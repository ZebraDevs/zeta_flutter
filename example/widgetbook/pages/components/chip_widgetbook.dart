import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget inputChipUseCase(BuildContext context) {
  final trailing = context.knobs.listOrNull(
    label: 'Icon',
    options: [
      ZetaIcons.star_half_round,
      ZetaIcons.add_alert_round,
      ZetaIcons.add_box_round,
      ZetaIcons.barcode_round,
    ],
    initialOption: null,
    labelBuilder: (value) {
      if (value == ZetaIcons.star_half_round) return 'ZetaIcons.star_half_round';
      if (value == ZetaIcons.add_alert_round) return 'ZetaIcons.add_alert_round';
      if (value == ZetaIcons.add_box_round) return 'ZetaIcons.add_box_round';
      if (value == ZetaIcons.barcode_round) return 'ZetaIcons.barcode_round';
      return '';
    },
  );
  return WidgetbookTestWidget(
    widget: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZetaInputChip(
            label: context.knobs.string(label: 'Label', initialValue: 'Label'),
            leading: context.knobs.boolean(label: 'Avatar')
                ? ZetaAvatar(
                    initials: 'AZ',
                    size: ZetaAvatarSize.xs,
                  )
                : null,
            rounded: context.knobs.boolean(label: 'Rounded'),
            trailing: trailing != null ? Icon(trailing) : null,
          ),
        ],
      ),
    ),
  );
}

Widget filterChipUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ZetaFilterChip(
              label: context.knobs.string(label: 'Label', initialValue: 'Label'),
              rounded: context.knobs.boolean(label: 'Rounded'),
              selected: context.knobs.boolean(label: 'Selected'),
            )
          ],
        ),
      ),
    );
Widget assistChipUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ZetaAssistChip(
              label: context.knobs.string(label: 'Label', initialValue: 'Label'),
              rounded: context.knobs.boolean(label: 'Rounded'),
              leading: context.knobs.boolean(label: 'Icon') ? Icon(ZetaIcons.star_round) : null,
            )
          ],
        ),
      ),
    );
