import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget avatarUseCase(BuildContext context) {
  final Widget image = Image.asset('assets/Omer.jpg', fit: BoxFit.cover);
  final colors = Zeta.of(context).colors;

  return WidgetbookTestWidget(
    widget: ZetaAvatar(
      image: context.knobs.boolean(label: 'Image') ? image : null,
      size: context.knobs.list(
        label: 'Size',
        options: ZetaAvatarSize.values,
        labelBuilder: (value) => value.name.split('.').last.toUpperCase(),
      ),
      upperBadge: context.knobs.boolean(label: 'Status Badge', initialValue: false)
          ? ZetaAvatarBadge.icon(
              icon: ZetaIcons.close_round,
              iconColor: context.knobs.colorOrNull(label: "Badge Icon Color"),
              color: context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.green) ??
                  colors.iconDefault,
            )
          : null,
      borderColor: context.knobs.colorOrNull(
        label: 'Outline',
      ),
      lowerBadge: context.knobs.boolean(label: 'Notification Badge', initialValue: false)
          ? ZetaAvatarBadge.notification(
              value: context.knobs.intOrNull.input(label: "Value", initialValue: 1),
            )
          : null,
      initials: context.knobs.stringOrNull(label: 'Initials', initialValue: null),
      backgroundColor: context.knobs.colorOrNull(
        label: 'Background color',
      ),
    ),
  );
}
