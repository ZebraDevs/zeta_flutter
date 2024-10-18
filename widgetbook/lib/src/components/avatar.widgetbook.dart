import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Avatar',
  type: ZetaAvatar,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=20816-3883&t=bHlo20F9nuMNKs9A-4',
)
Widget avatar(BuildContext context) {
  final Widget image = Image.asset('assets/Omer.jpg', fit: BoxFit.cover);
  final colors = Zeta.of(context).colors;

  return ZetaAvatar(
    image: context.knobs.boolean(label: 'Image') ? image : null,
    size: context.knobs.list(
      label: 'Size',
      options: ZetaAvatarSize.values,
      labelBuilder: (value) => value.name.split('.').last.toUpperCase(),
      initialOption: ZetaAvatarSize.m,
    ),
    upperBadge: context.knobs.boolean(label: 'Status Badge', initialValue: false)
        ? ZetaAvatarBadge.icon(
            icon: ZetaIcons.close,
            color:
                context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.green) ?? colors.iconDefault,
          )
        : null,
    borderColor: context.knobs.colorOrNull(label: 'Outline', initialValue: colors.green),
    lowerBadge: context.knobs.boolean(label: 'Notification Badge', initialValue: false)
        ? ZetaAvatarBadge.notification(
            value: context.knobs.intOrNull.input(label: "Value", initialValue: 1),
          )
        : null,
    initials: context.knobs.stringOrNull(label: 'Initials', initialValue: 'AZ'),
    backgroundColor: context.knobs.colorOrNull(label: 'Background color', initialValue: colors.purple.shade80),
  );
}
