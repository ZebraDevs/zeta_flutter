import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

@widgetbook.UseCase(
  name: 'Global Header',
  type: ZetaGlobalHeader,
  path: '$componentsPath/Global Header',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23144-118110&t=N8coJ9AFu6DS3mOF-4',
)
Widget globalHeader(BuildContext context) => ZetaGlobalHeader(
      platformName: context.knobs.string(label: 'Platform Name', initialValue: 'Platform Name'),
      name: context.knobs.string(label: 'Name', initialValue: 'Name'),
      initials: context.knobs.string(label: 'Initials', initialValue: 'RK'),
      navItems: List.generate(
        context.knobs.int.slider(label: 'Nav Items', min: 0, max: 6, initialValue: 2),
        (index) => ZetaButton(label: 'Nav Item', type: ZetaButtonType.text, size: ZetaWidgetSize.small, onPressed: () {},),
      ),
      searchBar: context.knobs.boolean(label: 'Search bar', initialValue: true),
      actionItems: List.generate(
        context.knobs.int.slider(label: 'Action Items', min: 0, max: 6, initialValue: 2),
        (index) => ZetaIconButton(icon: ZetaIcons.star, type: ZetaButtonType.text, size: ZetaWidgetSize.small, onPressed: () {},),
      ),
      appSwitcher: context.knobs.boolean(label: 'App Switcher', initialValue: true),
    );
