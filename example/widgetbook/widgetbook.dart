import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'components/accordion_widgetbook.dart';
import 'components/avatar_widgetbook.dart';
import 'components/badges_widgetbook.dart';
import 'components/bottom_sheet_widgetbook.dart';
import 'components/button_widgetbook.dart';
import 'components/checkbox_widgetbook.dart';
import 'theme/color_widgetbook.dart';
import 'components/banner_widgetbook.dart';
import 'components/chip_widgetbook.dart';
import 'components/password_input_widgetbook.dart';
import 'theme/typography_widgetbook.dart';
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
              name: 'Components',
              isInitiallyExpanded: false,
              children: [
                badgeWidgetBook(),
                avatarWidgetBook(),
                checkboxWidgetBook(),
                buttonWidgetBook(),
                BannerWidgetBook(),
                accordionWidgetBook(),
                chipWidgetBook(),
                passwordInputWidgetBook(),
                bottomSheetWidgetBook(),
              ]..sort((a, b) => a.name.compareTo(b.name)),
            ),
            WidgetbookCategory(
              name: 'Theme',
              isInitiallyExpanded: false,
              children: [textWidgetBook(), colorWidgetBook(), checkboxWidgetBook()],
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
