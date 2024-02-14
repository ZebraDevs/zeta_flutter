import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent iconWidgetbook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Icons',
    useCases: [
      WidgetbookUseCase(
        name: 'All Icons',
        builder: (context) {
          Map<String, IconData> icons =
              (context.knobs.boolean(label: 'Rounded', initialValue: true)) ? iconsRounded : iconsSharp;

          return WidgetbookTestWidget(
            removeBody: true,
            widget: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text('Tap icon to copy name to clipboard', style: ZetaTextStyles.titleMedium)
                        .paddingAll(ZetaSpacing.l),
                    Wrap(
                      spacing: ZetaSpacing.l,
                      runSpacing: ZetaSpacing.l,
                      children: icons.entries.map(
                        (e) {
                          final nameArr = e.key.split('_')..removeLast();
                          return Container(
                            width: 100,
                            height: 100,
                            child: InkWell(
                              borderRadius: ZetaRadius.rounded,
                              hoverColor: Zeta.of(context).colors.surfaceHovered,
                              onTap: () async {
                                await Clipboard.setData(ClipboardData(text: 'ZetaIcons.' + e.key));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(e.value, size: 40),
                                  Text(nameArr.join(' '), textAlign: TextAlign.center)
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
        },
      ),
    ],
  );
}
