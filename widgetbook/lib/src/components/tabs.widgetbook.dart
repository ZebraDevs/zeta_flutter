import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String tabsPath = '$componentsPath/Tabs';
@widgetbook.UseCase(
  name: 'Tab Item',
  type: ZetaTab,
  path: tabsPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-28869&t=eEOivHU9uV4K8qJq-4',
)
Widget tabItemUseCase(BuildContext context) {
  final bool selected = context.knobs.boolean(label: 'Selected', initialValue: false);
  final icon = iconKnob(context, nullable: true);

  return DefaultTabController(
    length: 2,
    initialIndex: selected ? 0 : 1,
    child: ZetaTabBar(
      context: context,
      onTap: disabledKnob(context) ? null : (_) {},
      tabs: [
        ZetaTab(
          text: context.knobs.string(label: 'Text', initialValue: 'Tab Item'),
          icon: icon != null ? Icon(icon) : null,
        ),
        ZetaTab(text: ''),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Tab Bar',
  type: ZetaTabBar,
  path: tabsPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-29001&t=eEOivHU9uV4K8qJq-4',
)
Widget tabBarUseCase(BuildContext context) {
  final numItems = context.knobs.int.slider(label: 'Number of tabs', initialValue: 5, min: 1, max: 30);
  final icon = iconKnob(context, nullable: true);
  final title = context.knobs.string(label: 'Title', initialValue: 'Tab Item');
  return DefaultTabController(
    length: numItems,
    child: ZetaTabBar(
      context: context,
      onTap: disabledKnob(context) ? null : (_) {},
      isScrollable: true,
      tabs: List.generate(
        numItems,
        (e) => ZetaTab(text: title, icon: icon != null ? Icon(icon) : null),
      ),
    ),
  );
}
