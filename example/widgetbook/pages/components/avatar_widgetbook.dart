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
        name: 'Image Avatar',
        builder: (context) {
          final Widget image = Image.network('https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg', fit: BoxFit.cover);

          return WidgetbookTestWidget(
            widget: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ZetaAvatar.image(
                    image: context.knobs.boolean(label: 'Image') ? image : null,
                    size: context.knobs.list(label: 'Size', options: ZetaAvatarSize.values),
                    lowerBadge:
                        context.knobs.boolean(label: 'Status Badge', initialValue: false) ? ZetaIndicator.icon() : null,
                    borderColor: context.knobs.colorOrNull(label: 'Outline', initialValue: null),
                    upperBadge: context.knobs.boolean(label: 'Notification Badge', initialValue: false)
                        ? ZetaIndicator.notification()
                        : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Initials Avatar',
        builder: (context) {
          return WidgetbookTestWidget(
            widget: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ZetaAvatar.initials(
                    backgroundColor: context.knobs.colorOrNull(label: 'Background color', initialValue: null),
                    initials: context.knobs.stringOrNull(label: 'Initials', initialValue: 'AB'),
                    size: context.knobs.list(label: 'Size', options: ZetaAvatarSize.values),
                    lowerBadge: context.knobs.boolean(label: 'Status badge', initialValue: false)
                        ? ZetaIndicator.notification()
                        : null,
                    borderColor: context.knobs.colorOrNull(label: 'Outline', initialValue: null),
                    upperBadge: context.knobs.boolean(label: 'Notification badge', initialValue: false)
                        ? ZetaIndicator.icon()
                        : null,
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
