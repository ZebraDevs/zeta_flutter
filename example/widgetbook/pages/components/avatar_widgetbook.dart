import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget avatarUseCase(BuildContext context) {
  final Widget image = Image.asset('assets/Omer.jpg', fit: BoxFit.cover);

  return WidgetbookTestWidget(
    widget: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: ZetaAvatar(
            image: context.knobs.boolean(label: 'Image') ? image : null,
            size: context.knobs.list(
              label: 'Size',
              options: ZetaAvatarSize.values,
              labelBuilder: (value) => value.name.split('.').last.toUpperCase(),
            ),
            lowerBadge: context.knobs.boolean(label: 'Status Badge', initialValue: false) ? ZetaIndicator.icon() : null,
            borderColor: context.knobs.colorOrNull(label: 'Outline', initialValue: null),
            upperBadge: context.knobs.boolean(label: 'Notification Badge', initialValue: false)
                ? ZetaIndicator.notification()
                : null,
            initials: context.knobs.stringOrNull(label: 'Initials', initialValue: null),
            backgroundColor: context.knobs.colorOrNull(label: 'Background color'),
          ),
        ),
      ],
    ),
  );
}
