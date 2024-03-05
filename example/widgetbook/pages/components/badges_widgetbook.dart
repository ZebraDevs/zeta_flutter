import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget statusLabelUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaStatusLabel(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        rounded: context.knobs.boolean(label: 'Rounded'),
        status: context.knobs.list(
          label: 'Status',
          labelBuilder: (value) => value.name.split('.').last.capitalize(),
          options: ZetaWidgetStatus.values,
        ),
        customIcon: context.knobs.list(
          label: 'Icon',
          options: [
            ZetaIcons.star_half_round,
            ZetaIcons.add_alert_round,
            ZetaIcons.add_box_round,
            ZetaIcons.barcode_round,
          ],
          labelBuilder: (value) {
            if (value == ZetaIcons.star_half_round) return 'ZetaIcons.star_half_round';
            if (value == ZetaIcons.add_alert_round) return 'ZetaIcons.add_alert_round';
            if (value == ZetaIcons.add_box_round) return 'ZetaIcons.add_box_round';
            if (value == ZetaIcons.barcode_round) return 'ZetaIcons.barcode_round';
            return '';
          },
        ),
      ),
    );

Widget priorityPillUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaPriorityPill(
        index: context.knobs.int.slider(label: 'Index'),
        priority: context.knobs.string(label: 'Priority', initialValue: 'Priority'),
        rounded: context.knobs.boolean(label: 'Rounded'),
      ),
    );
Widget badgeUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaBadge(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        rounded: context.knobs.boolean(label: 'Rounded'),
        status: context.knobs.list(
          label: 'Status',
          options: ZetaWidgetStatus.values,
          labelBuilder: (value) => value.name.split('.').last.capitalize(),
        ),
      ),
    );

Widget indicatorsUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Center(
        child: ZetaIndicator(
          type: context.knobs.list(
            label: 'Type',
            options: ZetaIndicatorType.values,
            labelBuilder: (value) => value.name.split('.').last.capitalize(),
          ),
          icon: context.knobs.list(
            label: 'Icon',
            options: [
              Icon(ZetaIcons.star_half_round),
              Icon(ZetaIcons.add_alert_round),
              Icon(ZetaIcons.add_box_round),
              Icon(ZetaIcons.barcode_round),
            ],
            labelBuilder: (value) {
              if (value?.icon == ZetaIcons.star_half_round) return 'ZetaIcons.star_half_round';
              if (value?.icon == ZetaIcons.add_alert_round) return 'ZetaIcons.add_alert_round';
              if (value?.icon == ZetaIcons.add_box_round) return 'ZetaIcons.add_box_round';
              if (value?.icon == ZetaIcons.barcode_round) return 'ZetaIcons.barcode_round';
              return '';
            },
          ),
          inverse: context.knobs.boolean(label: 'Inverse Border'),
          size: context.knobs.list(
            label: 'Size',
            labelBuilder: (value) => value.name.split('.').last.capitalize(),
            options: ZetaWidgetSize.values,
          ),
          value: context.knobs.int.slider(label: 'Value'),
        ),
      ),
    );

Widget tagsUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZetaTag(
            label: context.knobs.string(label: 'Label', initialValue: 'Tag'),
            rounded: context.knobs.boolean(label: 'Rounded'),
            direction: context.knobs.list(
              label: 'Direction',
              options: ZetaTagDirection.values,
              labelBuilder: (value) => value.name.split('.').last.capitalize(),
            ),
          ),
        ],
      ),
    );

Widget workcloudIndicatorsUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaWorkcloudIndicator(
          index: context.knobs.string(label: 'Index', initialValue: '1'),
          label: context.knobs.string(label: 'Label', initialValue: 'Label'),
          prioritySize: context.knobs.list(
            label: 'Size',
            labelBuilder: (value) => value.name.split('.').last.capitalize(),
            options: ZetaWidgetSize.values,
          ),
          priorityType: context.knobs.list(
            label: 'Type',
            labelBuilder: (value) => value.name.split('.').last.capitalize(),
            options: ZetaWorkcloudIndicatorType.values,
          ),
          icon: context.knobs.listOrNull(
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
          )),
    );
