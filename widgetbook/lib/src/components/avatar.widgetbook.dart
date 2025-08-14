import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

const avatarPath = '$componentsPath/Avatar';

@widgetbook.UseCase(
  name: 'Avatar',
  type: ZetaAvatar,
  path: avatarPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=20816-3883&t=N8coJ9AFu6DS3mOF-4',
)
Widget avatar(BuildContext context) {
  final Widget image = Image.asset('assets/Omer.jpg', fit: BoxFit.cover);
  final colors = Zeta.of(context).colors;

  return ZetaAvatar(
    image: context.knobs.boolean(label: 'Image') ? image : null,
    size: context.knobs.object.dropdown(
      label: 'Size',
      options: ZetaAvatarSize.values,
      labelBuilder: (value) => value.name.split('.').last.toUpperCase(),
      initialOption: ZetaAvatarSize.m,
    ),
    upperBadge: context.knobs.boolean(label: 'Status Badge')
        ? ZetaAvatarBadge.icon(
            icon: ZetaIcons.close,
            color: context.knobs.colorOrNull(label: 'Upper Badge Color', initialValue: colors.primitives.green) ??
                colors.mainDefault,
          )
        : null,
    borderColor: context.knobs.colorOrNull(label: 'Outline', initialValue: colors.primitives.green),
    lowerBadge: context.knobs.boolean(label: 'Notification Badge')
        ? ZetaAvatarBadge.notification(
            value: context.knobs.intOrNull.input(label: 'Value', initialValue: 1),
          )
        : null,
    initials: context.knobs.stringOrNull(label: 'Initials', initialValue: 'AZ'),
    backgroundColor:
        context.knobs.colorOrNull(label: 'Background color', initialValue: colors.primitives.purple.shade80),
  );
}

@widgetbook.UseCase(
  name: 'Avatar Rail',
  type: ZetaAvatarRail,
  path: avatarPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=875-10317&t=fFNXUv3Vk4zGNrMG-4',
)
Widget avatarRailUseCase(BuildContext context) {
  final Widget image = Image.asset('assets/Omer.jpg', fit: BoxFit.cover);
  final colors = Zeta.of(context).colors;

  return ZetaAvatarRail(
    labelMaxLines: context.knobs.int.slider(label: 'Label Max Lines', min: 1, max: 3, initialValue: 1),
    avatars: List.generate(
      context.knobs.int.slider(label: 'Number of Avatars', min: 1, max: 50, initialValue: 5),
      (index) => ZetaAvatar(
        key: ValueKey(index),
        image: context.knobs.boolean(label: 'Image') ? image : null,
        size: context.knobs.object.dropdown(
          label: 'Size',
          options: ZetaAvatarSize.values,
          labelBuilder: (value) => value.name.split('.').last.toUpperCase(),
          initialOption: ZetaAvatarSize.m,
        ),
        upperBadge: context.knobs.boolean(label: 'Status Badge', initialValue: false)
            ? ZetaAvatarBadge.icon(
                icon: ZetaIcons.close,
                color: context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.primitives.green) ??
                    colors.mainDefault,
              )
            : null,
        borderColor: context.knobs.colorOrNull(label: 'Outline', initialValue: colors.primitives.green),
        lowerBadge: context.knobs.boolean(label: 'Notification Badge', initialValue: false)
            ? ZetaAvatarBadge.notification(
                value: context.knobs.intOrNull.input(label: "Value", initialValue: 1),
              )
            : null,
        initials: context.knobs.stringOrNull(label: 'Initials', initialValue: 'AZ'),
        backgroundColor:
            context.knobs.colorOrNull(label: 'Background color', initialValue: colors.primitives.purple.shade80),
        onTap: () => debugPrint('Avatar tapped'),
        label: context.knobs.stringOrNull(label: 'Label', initialValue: 'ABC'),
      ),
    ),
  );
}
