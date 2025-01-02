import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Tabs',
  type: ZetaTabBar,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=875-10317&t=fFNXUv3Vk4zGNrMG-4',
)
Widget tabsUseCase(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: Zeta.of(context).spacing.xl_4),
        child: DefaultTabController(
          length: 2,
          child: ZetaTabBar(
            context: context,
            onTap: context.knobs.boolean(label: 'Disabled') ? null : (_) {},
            tabs: [
              ZetaTab(icon: const ZetaIcon(ZetaIcons.star), text: 'Tab Item'),
              ZetaTab(icon: const ZetaIcon(ZetaIcons.star), text: 'Tab Item'),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: Zeta.of(context).spacing.xl_4),
        child: DefaultTabController(
          length: 5,
          child: ZetaTabBar(
            context: context,
            onTap: disabledKnob(context) ? null : (_) {},
            isScrollable: true,
            tabs: [
              ZetaTab(text: 'Tab Item'),
              ZetaTab(text: 'Tab Item'),
              ZetaTab(text: 'Tab Item'),
              ZetaTab(text: 'Tab Item'),
              ZetaTab(text: 'Tab Item'),
            ],
          ),
        ),
      ),
    ],
  );
}
