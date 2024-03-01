import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent navigationBarWidgetbook() {
  return WidgetbookComponent(
    name: 'Navigation Bar',
    isInitiallyExpanded: false,
    useCases: [
      WidgetbookUseCase(
        name: 'Navigation bar',
        builder: (context) {
          final items = [
            ZetaNavigationBarItem(
              icon: ZetaIcons.star_round,
              label: 'Label',
              showBadge: true,
              badgeValue: 2,
            ),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
          ];
          return WidgetbookTestWidget(
            widget: Center(
              child: ZetaNavigationBar(
                items: items,
                currentIndex: context.knobs.intOrNull.input(
                  label: 'Selected index',
                  initialValue: 0,
                ),
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Divided navigation bar',
        builder: (context) {
          final items = [
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
          ];
          return WidgetbookTestWidget(
            widget: Center(
              child: ZetaNavigationBar.divided(
                items: items,
                dividerIndex: context.knobs.intOrNull.input(
                  label: 'Divider index',
                  initialValue: 3,
                ),
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Split navigation bar',
        builder: (context) {
          final items = [
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
          ];
          return WidgetbookTestWidget(
            widget: Center(
              child: ZetaNavigationBar.split(items: items),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Navigation bar with action',
        builder: (context) {
          final items = [
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
            ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
          ];
          return WidgetbookTestWidget(
            widget: Center(
              child: ZetaNavigationBar.action(
                items: items,
                action: ZetaButton.primary(label: 'Button'),
              ),
            ),
          );
        },
      ),
    ],
  );
}
