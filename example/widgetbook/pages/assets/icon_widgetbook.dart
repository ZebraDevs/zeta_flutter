import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget iconsUseCase(BuildContext context) {
  bool rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);

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
              children: icons.entries.map(
                (e) {
                  final nameArr = (e.key.split('_')).join(' ').capitalize();
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
                        children: [
                          ZetaIcon(
                            IconData(
                              e.value.codePoint,
                              fontFamily: rounded ? ZetaIcons.familyRound : ZetaIcons.familySharp,
                              fontPackage: ZetaIcons.package,
                            ),
                            size: ZetaSpacing.xl_6,
                          ),
                          Text(
                            nameArr,
                            textAlign: TextAlign.center,
                          )
                        ],
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
