import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../widgets.dart';

class IllustrationsExample extends StatefulWidget {
  static const String name = 'Illustrations';

  const IllustrationsExample({super.key});

  @override
  State<IllustrationsExample> createState() => _IconsExampleState();
}

class _IconsExampleState extends State<IllustrationsExample> {
  bool showGeneratedColors = false;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: IllustrationsExample.name,
      child: SingleChildScrollView(
        key: PageStorageKey(0),
        child: Center(
          child: Column(
            children: [
              // Text('Zeta Icons v' + zetaIconsVersion, style: Zeta.of(context).textStyles.displayMedium)
              //     .paddingAll(Zeta.of(context).spacing.xl_4),
              Text('Tap illustration to copy name to clipboard', style: Zeta.of(context).textStyles.titleMedium)
                  .paddingAll(Zeta.of(context).spacing.xl_4),
              Wrap(
                spacing: Zeta.of(context).spacing.xl_4,
                runSpacing: Zeta.of(context).spacing.xl_4,
                children: illustrations.entries.map(
                  (e) {
                    return Container(
                      width: 260,
                      height: 260,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Zeta.of(context).radius.rounded),
                        hoverColor: Zeta.of(context).colors.surfaceHover,
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(text: 'ZetaIllustrations.' + e.key));
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            ZetaSystemBanner(context: context, title: 'Illustration name copied'),
                          );
                          await Future.delayed(Duration(seconds: 4));
                          ScaffoldMessenger.of(context).clearMaterialBanners();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: e.value),
                            Text(
                              'ZetaIllustrations.' + e.key,
                              textAlign: TextAlign.center,
                              style: Zeta.of(context).textStyles.bodyMedium.copyWith(fontSize: 12),
                            )
                          ],
                        ).paddingAll(16),
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
}
