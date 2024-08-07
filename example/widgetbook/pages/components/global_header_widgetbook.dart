import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget globalHeaderUseCase(BuildContext context) {
  final actionButtons = [
    IconButton(
      onPressed: () {},
      icon: const ZetaIcon(
        ZetaIcons.alert,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: const ZetaIcon(
        ZetaIcons.help,
      ),
    ),
  ];

  return WidgetbookScaffold(
    builder: (context, _) => ZetaGlobalHeader(
      title: context.knobs.string(label: "Title", initialValue: "Title"),
      tabItems: List.generate(
          context.knobs.int.slider(label: "Tabs"), (index) => ZetaGlobalHeaderItem(label: 'Button ${index + 1}')),
      searchBar: context.knobs.boolean(label: 'Search bar', initialValue: true)
          ? ZetaSearchBar(shape: ZetaWidgetBorder.full, size: ZetaWidgetSize.large)
          : null,
      actionButtons: context.knobs.boolean(label: "Menu buttons", initialValue: true) ? actionButtons : [],
      avatar: context.knobs.boolean(label: "Show Avatar", initialValue: true)
          ? const ZetaAvatar(initials: 'PS', size: ZetaAvatarSize.s)
          : null,
      onAppsButton: context.knobs.boolean(label: "Apps menu", initialValue: true) ? () => {} : null,
    ),
  );
}
