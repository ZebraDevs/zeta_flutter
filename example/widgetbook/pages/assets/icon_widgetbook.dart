import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget iconsUseCase(BuildContext context) {
  Map<String, IconData> icons =
      ((context.knobs.boolean(label: 'Rounded', initialValue: true)) ? iconsRound : iconsSharp);

  final Map<String, IconData> sortedIcons = Map.fromEntries(icons.entries.toList()
    ..sort((a, b) {
      final _a = (a.key.split('_')..removeLast()).join();
      final _b = (b.key.split('_')..removeLast()).join();
      return _a.compareTo(_b);
    }));

  return WidgetbookTestWidget(
    removeBody: true,
    widget: SingleChildScrollView(
      key: PageStorageKey(0),
      child: Center(
        child: Column(
          children: [
            Text('Zeta Icons v' + zetaIconsVersion, style: ZetaTextStyles.displayMedium).paddingAll(ZetaSpacing.xl_4),
            Text('Tap icon to copy name to clipboard', style: ZetaTextStyles.titleMedium).paddingAll(ZetaSpacing.xl_4),
            Wrap(
              spacing: ZetaSpacing.xl_4,
              runSpacing: ZetaSpacing.xl_4,
              children: sortedIcons.entries.map(
                (e) {
                  final nameArr = (e.key.split('_')..removeLast()).join(' ').capitalize();
                  return Container(
                    width: 120,
                    height: 120,
                    child: InkWell(
                      borderRadius: ZetaRadius.rounded,
                      hoverColor: Zeta.of(context).colors.surfaceHover,
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: 'ZetaIcons.' + e.key));
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          ZetaBanner(context: context, title: 'Icon name copied'),
                        );
                        await Future.delayed(Duration(seconds: 4));
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(e.value, size: ZetaSpacing.xl_6), Text(nameArr, textAlign: TextAlign.center)],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}
