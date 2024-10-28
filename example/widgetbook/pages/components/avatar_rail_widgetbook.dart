import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget avatarRailUseCase(BuildContext context) {
  final Widget image = Image.asset('assets/Omer.jpg', fit: BoxFit.cover);
  final colors = Zeta.of(context).colors;

  return WidgetbookScaffold(
    builder: (context, _) => ZetaAvatarRail(
      labelMaxLines: context.knobs.int.slider(label: 'Label Max Lines', min: 1, max: 3, initialValue: 1),
      avatars: [
        ZetaAvatar(
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
                  color: context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.green) ??
                      colors.iconDefault,
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
          onTap: () => print('Avatar tapped'),
          label: context.knobs.stringOrNull(label: 'Label', initialValue: 'ABC'),
        ),
        ZetaAvatar(
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
                  color: context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.green) ??
                      colors.iconDefault,
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
          onTap: () => print('Avatar tapped'),
          label: context.knobs.stringOrNull(label: 'Label', initialValue: 'ABC'),
        ),
        ZetaAvatar(
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
                  color: context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.green) ??
                      colors.iconDefault,
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
          onTap: () => print('Avatar tapped'),
          label: context.knobs.stringOrNull(label: 'Label', initialValue: 'ABC'),
        ),
        ZetaAvatar(
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
                  color: context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.green) ??
                      colors.iconDefault,
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
          onTap: () => print('Avatar tapped'),
          label: context.knobs.stringOrNull(label: 'Label', initialValue: 'ABC'),
        ),
        ZetaAvatar(
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
                  color: context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.green) ??
                      colors.iconDefault,
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
          onTap: () => print('Avatar tapped'),
          label: context.knobs.stringOrNull(label: 'Label', initialValue: 'ABC'),
        ),
        ZetaAvatar(
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
                  color: context.knobs.colorOrNull(label: "Upper Badge Color", initialValue: colors.green) ??
                      colors.iconDefault,
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
          onTap: () => print('Avatar tapped'),
          label: context.knobs.stringOrNull(label: 'Label', initialValue: 'ABC'),
        ),
      ],
    ),
  );
}
