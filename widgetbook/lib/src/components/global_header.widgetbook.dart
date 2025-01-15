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
      title: context.knobs.string(label: 'Title', initialValue: 'Title'),
      tabItems: List.generate(
        context.knobs.int.slider(label: 'Tabs'),
        (index) => ZetaGlobalHeaderItem(label: 'Button ${index + 1}'),
      ),
      searchBar: context.knobs.boolean(label: 'Search bar', initialValue: true)
          ? ZetaSearchBar(shape: ZetaWidgetBorder.full, size: ZetaWidgetSize.large)
          : null,
      actionButtons: context.knobs.boolean(label: 'Menu buttons', initialValue: true)
          ? [
              IconButton(
                onPressed: () {},
                icon: const ZetaIcon(ZetaIcons.alert),
              ),
              IconButton(
                onPressed: () {},
                icon: const ZetaIcon(ZetaIcons.help),
              ),
            ]
          : [],
      avatar: context.knobs.boolean(label: 'Show Avatar', initialValue: true)
          ? const ZetaAvatar(initials: 'PS', size: ZetaAvatarSize.s)
          : null,
      onAppsButton: context.knobs.boolean(label: 'Apps menu', initialValue: true) ? () => {} : null,
    );
