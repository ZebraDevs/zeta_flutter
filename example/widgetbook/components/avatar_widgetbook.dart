import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent avatarWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Avatar',
    useCases: [
      WidgetbookUseCase(
        name: 'Avatar',
        builder: (context) {
          return TestWidget(
            themeMode: ThemeMode.dark,
            widget: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ZetaAvatar(
                    type: context.knobs.list(label: 'Avatar type', options: ZetaAvatarType.values),
                    imageUrl: context.knobs.string(
                      label: 'Image URL',
                      initialValue: 'https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg',
                    ),
                    initials: context.knobs.string(label: 'Initials', initialValue: 'AZ'),
                    showStatus: context.knobs.boolean(label: 'Show Status'),
                    size: context.knobs.list(label: 'Size', options: ZetaAvatarSize.values),
                    badge: () {
                      final x = context.knobs.intOrNull.slider(label: 'Notifications', initialValue: null, max: 10);
                      if (x == null) return null;
                      return ZetaIndicator.notification(value: x);
                    }(),
                    specialStatus:
                        context.knobs.boolean(label: 'Status Icon', initialValue: false) ? ZetaIndicator.icon() : null,
                    backgroundColor: context.knobs.colorOrNull(label: 'Background color'),
                    statusPrimaryColor: context.knobs.colorOrNull(label: 'Status primary color'),
                    statusSecondaryColor: context.knobs.colorOrNull(label: 'Status secondary color'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
