import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget bannerUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ZetaSystemBanner(
              context: context,
              title: context.knobs.string(label: 'Title', initialValue: 'Banner Title'),
              type: context.knobs.list(
                label: 'Type',
                options: ZetaSystemBannerStatus.values,
                labelBuilder: (value) => value.name.split('.').last.capitalize(),
              ),
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
    );
