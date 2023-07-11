import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'components/grid_widgetbook.dart';
import 'components/spacing_widgetbook.dart';
import 'components/typography_widgetbook.dart';
import 'utils/zebra.dart';

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ZetaTheme.zeta,
      child: Widgetbook.material(
        directories: [
          WidgetbookCategory(
            name: 'widgets',
            children: [
              gridWidgetBook(),
              spacingWidgetbook(),
              textWidgetBook(),
            ],
          ),
        ],
        addons: [
          DeviceAddon(
            setting: DeviceSetting(
              devices: [
                Desktop.desktop720p,
                Desktop.desktop1080p,
                Desktop.desktop1440p,
                Zebra.ec50,
                Zebra.ec30,
                Apple.iPhone13,
                Apple.iPad9Inch,
              ],
              activeDevice: Zebra.ec50,
            ),
          ),
          MaterialThemeAddon(
            setting: ThemeSetting(
              themes: [WidgetbookTheme(name: 'Zeta', data: ZetaTheme.zeta)],
              activeTheme: WidgetbookTheme(
                name: 'Zeta',
                data: ZetaTheme.zeta,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
