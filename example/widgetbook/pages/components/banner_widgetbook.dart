import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent bannerWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Banners',
    useCases: [
      WidgetbookUseCase(
        name: 'System Banner',
        builder: (context) => WidgetbookTestWidget(
          widget: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ZetaSystemBanner(
                  context: context,
                  title: context.knobs.string(label: 'Title', initialValue: 'Banner Title'),
                  type: context.knobs.list(label: 'Type', options: ZetaSystemBannerStatus.values),
                  leadingIcon: context.knobs.list(
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
                  titleStart: context.knobs.boolean(label: 'Center title'),
                  trailing: context.knobs.boolean(label: 'Trailing Icon')
                      ? IconButton(icon: Icon(ZetaIcons.chevron_right_round), onPressed: () {})
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'In Page Banner',
        builder: (context) => WidgetbookTestWidget(
          widget: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ZetaInPageBanner(
                  content: Text(
                    context.knobs.string(
                      label: 'content',
                      initialValue:
                          'Lorem ipsum dolor sit amet, conse ctetur  cididunt ut labore et do lore magna aliqua.',
                    ),
                  ),
                  status: context.knobs.list(label: 'Severity', options: ZetaWidgetStatus.values),
                  onClose: context.knobs.boolean(label: 'Show Close icon') ? () {} : null,
                  title: context.knobs.string(label: 'Title', initialValue: 'Title'),
                  rounded: context.knobs.boolean(label: 'Rounded'),
                  actions: () {
                    final x = context.knobs.list(label: 'Show Buttons', options: [0, 1, 2]);

                    if (x == 1) {
                      return [
                        ZetaButton(label: 'Button 1', onPressed: () {}),
                      ];
                    }
                    if (x == 2) {
                      return [
                        ZetaButton(label: 'Button 1', onPressed: () {}),
                        ZetaButton(label: 'Button 2', onPressed: () {})
                      ];
                    }
                    return <ZetaButton>[];
                  }(),
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
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
