import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent chipWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Chip',
    useCases: [
      WidgetbookUseCase(
        name: 'Input Chip',
        builder: (context) => TestWidget(
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ZetaChip.input(
                  label: context.knobs.string(label: 'Label', initialValue: 'Label'),
                  leading: context.knobs.boolean(label: 'Avatar')
                      ? ZetaAvatar.initials(initials: 'AZ', size: ZetaAvatarSize.xs)
                      : null,
                  rounded: context.knobs.boolean(label: 'Rounded'),
                  onDelete: context.knobs.boolean(label: 'Delete') ? () {} : null,
                ),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Filter Chip',
        builder: (context) => TestWidget(
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ZetaFilterChip(
                  label: context.knobs.string(label: 'Label', initialValue: 'Label'),
                  rounded: context.knobs.boolean(label: 'Rounded'),
                  selected: context.knobs.boolean(label: 'Selected'),
                  onChange: context.knobs.boolean(label: 'Enabled') ? ({bool value = false}) {} : null,
                )
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Assist Chip',
        builder: (context) => TestWidget(
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ZetaChip.assist(
                  label: context.knobs.string(label: 'Label', initialValue: 'Label'),
                  rounded: context.knobs.boolean(label: 'Rounded'),
                  showIcon: context.knobs.boolean(label: 'Show Icon'),
                  icon: context.knobs.list(
                    label: 'Icon',
                    options: [
                      Icon(ZetaIcons.star_half_round),
                      Icon(ZetaIcons.add_alert_round),
                      Icon(ZetaIcons.add_box_round),
                      Icon(ZetaIcons.barcode_round),
                    ],
                    labelBuilder: (value) {
                      if ((value as Icon).icon == ZetaIcons.star_half_round) return 'ZetaIcons.star_half_round';
                      if ((value).icon == ZetaIcons.add_alert_round) return 'ZetaIcons.add_alert_round';
                      if ((value).icon == ZetaIcons.add_box_round) return 'ZetaIcons.add_box_round';
                      if ((value).icon == ZetaIcons.barcode_round) return 'ZetaIcons.barcode_round';
                      return '';
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Status Chip',
        builder: (context) => TestWidget(
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [ZetaChip.status(context.knobs.string(label: 'Label', initialValue: 'Label'))]),
          ),
        ),
      ),
    ],
  );
}
