import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components/grid_widgetbook.dart';
import 'utils/zebra.dart';

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(name: 'widgets', widgets: [gridWidgetBook()])
      ],
      appInfo: AppInfo(name: 'Zeta Flutter Widgetbook'),
      themes: [WidgetbookTheme(name: 'Flutter Material Theme', data: ThemeData())],
      devices: [
        Zebra.ec50,
        Zebra.ec30,
        Apple.iPhone13,
        Apple.iPad9Inch,
        Desktop.desktop1080p,
        Desktop.desktop1440p,
      ],
    );
  }
}
