import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'components/accordion_widgetbook.dart';
import 'components/avatar_widgetbook.dart';
import 'components/badge_widgetbook.dart';
import 'components/button_widgetbook.dart';
import 'components/checkbox_widgetbook.dart';
import 'components/color_widgetbook.dart';
import 'components/grid_widgetbook.dart';
import 'components/indicator_widgetbook.dart';
import 'components/menu_items_widgetbook.dart';
import 'components/priority_pill_widgetbook.dart';
import 'components/spacing_widgetbook.dart';
import 'components/status_label_widgetbook.dart';
import 'components/tag_widgetbook.dart';
import 'components/typography_widgetbook.dart';
import 'components/workcloud_indicator_widgetbook.dart';
import 'utils/zebra.dart';

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      builder: (context, theme, colors) {
        return Widgetbook.material(
          directories: [
            WidgetbookCategory(
              name: 'widgets',
              children: [
                gridWidgetBook(),
                spacingWidgetbook(),
                textWidgetBook(),
                colorWidgetBook(),
                statusLabelWidgetBook(),
                tagWidgetBook(),
                badgeWidgetBook(),
                indicatorWidgetBook(),
                priorityPillWidgetBook(),
                workcloudIndicatorWidgetBook(),
                avatarWidgetBook(),
                checkboxWidgetBook(),
                buttonWidgetBook(),
                menuItemsWidgetBook(),
                accordionWidgetBook(),
                buttonWidgetBook()
              ],
            ),
          ],
          addons: [
            DeviceFrameAddon(
              devices: [
                Devices.windows.wideMonitor,
                Devices.macOS.wideMonitor,
                Devices.ios.iPad,
                Devices.ios.iPhone13,
                Zebra.ec30,
                Zebra.ec50,
              ],
            ),
          ],
        );
      },
    );
  }
}
