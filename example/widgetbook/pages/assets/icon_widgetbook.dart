import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget iconsUseCase(BuildContext context) {
  return WidgetbookScaffold(
    removeBody: true,
    builder: (context, _) => SingleChildScrollView(
      key: PageStorageKey(0),
      child: Center(
        child: Column(
          children: [
            Text('Zeta Icons v' + zetaIconsVersion, style: ZetaTextStyles.displayMedium)
                .paddingAll(Zeta.of(context).spacing.xl_4),
            Text('Tap icon to copy name to clipboard', style: ZetaTextStyles.titleMedium)
                .paddingAll(Zeta.of(context).spacing.xl_4),
            Wrap(
              spacing: Zeta.of(context).spacing.xl_4,
              runSpacing: Zeta.of(context).spacing.xl_4,
              children: icons.entries.map(
                (e) {
                  final nameArr = (e.key.split('_')).join(' ').capitalize();
                  return Container(
                    width: 140,
                    height: 140,
                    child: InkWell(
                      borderRadius: Zeta.of(context).radii.rounded,
                      hoverColor: Zeta.of(context).colors.surface.hover,
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
                              fontFamily: ZetaIcons.family,
                              fontPackage: ZetaIcons.package,
                            ),
                            size: Zeta.of(context).spacing.xl_6,
                          ),
                          Text(
                            nameArr,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
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
