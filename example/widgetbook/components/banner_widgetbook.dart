import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent BannerWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Banners',
    useCases: [
      WidgetbookUseCase(
        name: 'System Banner',
        builder: (context) => TestWidget(
          widget: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ZetaSystemBanner(
                  title: Text(context.knobs.string(label: 'Title', initialValue: 'Banner Title')),
                  type: context.knobs.list(label: 'Type', options: ZetaSystemBannerType.values),
                  titleIcon: context.knobs.boolean(label: 'Leading Icon') ? Icon(ZetaIcons.info_round) : null,
                  centerTitle: context.knobs.boolean(label: 'Center title'),
                  actions: context.knobs.boolean(label: 'Trailing Icon')
                      ? [IconButton(icon: Icon(ZetaIcons.chevron_right_round), onPressed: () {})]
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'In Page Banner',
        builder: (context) => TestWidget(
          themeMode: ThemeMode.dark,
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
                  severity: context.knobs.list(label: 'Severity', options: WidgetSeverity.values),
                  showIconClose: context.knobs.boolean(label: 'Show Close icon'),
                  title: context.knobs.string(label: 'Title', initialValue: 'Title'),
                  borderType: context.knobs.boolean(label: 'Rounded') ? BorderType.rounded : BorderType.sharp,
                  firstButton: context.knobs.boolean(label: 'First Button')
                      ? ZetaPageBannerButton(onPressed: () {}, label: 'Button')
                      : null,
                  secondButton: context.knobs.boolean(label: 'Second Button')
                      ? ZetaPageBannerButton(onPressed: () {}, label: 'Button')
                      : null,
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
