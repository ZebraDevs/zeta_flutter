import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent badgeWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Badges',
    useCases: [
      WidgetbookUseCase(
        name: 'Status Label',
        builder: (context) {
          return TestWidget(
            themeMode: ThemeMode.dark,
            widget: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ZetaStatusLabel(
                    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
                    borderType: context.knobs.boolean(label: 'Rounded') ? BorderType.rounded : BorderType.sharp,
                    severity: context.knobs.list(label: 'Status', options: WidgetSeverity.values),
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
                    isDefaultIcon: context.knobs.boolean(label: 'Use default Icon'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Priority Pill',
        builder: (context) => TestWidget(
          themeMode: ThemeMode.dark,
          widget: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: ZetaPriorityPill(
                  index: context.knobs.int.slider(label: 'Index'),
                  priority: context.knobs.string(label: 'Priority', initialValue: 'Priority'),
                  borderType: context.knobs.boolean(label: 'Rounded') ? BorderType.rounded : BorderType.sharp,
                ),
              ),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Badge',
        builder: (context) => TestWidget(
          themeMode: ThemeMode.dark,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: ZetaBadge(
                  label: context.knobs.string(label: 'Label', initialValue: 'Label'),
                  borderType: context.knobs.boolean(label: 'Rounded') ? BorderType.rounded : BorderType.sharp,
                  severity: context.knobs.list(label: 'Status', options: WidgetSeverity.values),
                ),
              ),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Indicators',
        builder: (context) => TestWidget(
          themeMode: ThemeMode.dark,
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: ZetaIndicator(
                  type: context.knobs.list(label: 'Type', options: ZetaIndicatorType.values),
                  backgroundColor: context.knobs.colorOrNull(label: 'Background Color'),
                  borderColor: context.knobs.colorOrNull(label: 'Border Color'),
                  foregroundColor: context.knobs.colorOrNull(label: 'Foreground Color'),
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
                  inverseBorder: context.knobs.boolean(label: 'Inverse Border'),
                  rounded: context.knobs.boolean(label: 'Rounded'),
                  size: context.knobs.list(label: 'Size', options: ZetaIndicatorSize.values),
                  value: context.knobs.int.slider(label: 'Value'),
                ),
              ),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Tags',
        builder: (context) => TestWidget(
          themeMode: ThemeMode.dark,
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: ZetaTag(
                  label: context.knobs.string(label: 'Label', initialValue: 'Tag'),
                  borderType: context.knobs.boolean(label: 'Rounded') ? BorderType.rounded : BorderType.sharp,
                  direction: context.knobs.list(label: 'Direction', options: ZetaTagDirection.values),
                ),
              )
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Workcloud Indicators',
        builder: (context) => TestWidget(
          themeMode: ThemeMode.dark,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ZetaWorkcloudIndicator(
                      index: context.knobs.string(label: 'Index', initialValue: '1'),
                      isStatusBadge: context.knobs.boolean(label: 'Status Badge', initialValue: false),
                      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
                      prioritySize: context.knobs.list(label: 'Size', options: ZetaWidgetSize.values),
                      priorityType: context.knobs.list(label: 'Type', options: ZetaWorkcloudIndicatorType.values),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
