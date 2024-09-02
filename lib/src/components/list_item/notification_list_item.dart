import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Notification list items are used in notification lists.
/// {@category Components}
class ZetaNotificationListItem extends ZetaStatelessWidget {
  /// Constructor for [ZetaNotificationListItem]
  const ZetaNotificationListItem({
    super.key,
    super.rounded,
    required this.leading,
    required this.body,
    required this.title,
    this.notificationRead = false,
    this.notificationTime,
    required this.action,
    this.showDivider = false,
    this.semanticLabel,
  });

  /// Notification Badge to indicate type of notification or who it's coming from
  final ZetaNotificationBadge leading;

  /// Body of notification item
  final Widget body;

  /// Notification title
  final String title;

  /// If notification has been read
  final bool notificationRead;

  /// Time of notification
  final String? notificationTime;

  /// If notification is a grouped and there are more notifications show divider.
  final bool? showDivider;

  /// Pass in a action widget to handle action functionality.
  final Widget action;

  /// Semantic label for the notification list item.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('notificationTime', notificationTime))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<bool>('notificationRead', notificationRead))
      ..add(DiagnosticsProperty<bool?>('showDivider', showDivider))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Semantics(
        explicitChildNodes: true,
        label: semanticLabel,
        button: true,
        child: DecoratedBox(
          decoration: _getStyle(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leading,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MergeSemantics(
                              child: Row(
                                children: [
                                  if (!notificationRead)
                                    ZetaIndicator(
                                      color: colors.blue,
                                      size: ZetaWidgetSize.small,
                                    ),
                                  Text(
                                    title,
                                    style: ZetaTextStyles.labelLarge,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                if (notificationTime != null)
                                  Text(
                                    notificationTime!,
                                    style: ZetaTextStyles.bodySmall.apply(color: colors.textDisabled),
                                  ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: colors.surfaceNegative,
                                    borderRadius: Zeta.of(context).radius.full,
                                  ),
                                  child: ZetaIcon(
                                    ZetaIcons.important_notification,
                                    color: colors.white,
                                    size: Zeta.of(context).spacing.medium,
                                  ),
                                ),
                              ].gap(Zeta.of(context).spacing.minimum),
                            ),
                          ],
                        ),
                        body,
                      ].gap(Zeta.of(context).spacing.minimum),
                    ),
                  ),
                ].gap(Zeta.of(context).spacing.small),
              ),
              Container(alignment: Alignment.centerRight, child: action),
            ],
          ).paddingAll(Zeta.of(context).spacing.small),
        ),
      ),
    );
  }

  BoxDecoration _getStyle(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return BoxDecoration(
      color: notificationRead ? colors.surfacePrimary : colors.surfaceSelected,
      borderRadius: Zeta.of(context).radius.rounded,
      border: (showDivider ?? false)
          ? Border(bottom: BorderSide(width: Zeta.of(context).spacing.minimum, color: colors.blue))
          : null,
    );
  }
}

extension on Image {
  /// Return copy of image with altered height and width
  Image copyWith({double? height, double? width, BoxFit? fit}) {
    return Image(
      height: height ?? this.height,
      width: width ?? this.width,
      fit: fit ?? this.fit,
      image: image,
    );
  }
}

// TODO(UX-1138): Can this be refactored to use ZetaIndicator?
/// Badge item for notification list items. Can be an avatar, icon or image
class ZetaNotificationBadge extends StatelessWidget {
  /// Constructs a notification badge with an avatar.
  const ZetaNotificationBadge.avatar({
    super.key,
    required this.avatar,
  })  : icon = null,
        iconColor = null,
        image = null;

  /// Constructs a notification badge with an icon.
  const ZetaNotificationBadge.icon({
    super.key,
    required this.icon,
    this.iconColor,
  })  : avatar = null,
        image = null;

  /// Constructs a notification badge with an image.
  const ZetaNotificationBadge.image({
    super.key,
    required this.image,
  })  : icon = null,
        iconColor = null,
        avatar = null;

  /// Avatar to display as notification badge.
  final ZetaAvatar? avatar;

  /// Image to display as notification badge.
  final Image? image;

  /// Icon to display as notification badge.
  final IconData? icon;

  /// Icon color for notification badge.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return avatar != null
        ? avatar!.copyWith(size: ZetaAvatarSize.m)
        : icon != null
            ? ZetaIcon(
                icon,
                size: Zeta.of(context).spacing.xl_8,
                color: iconColor,
              )
            : ClipRRect(
                borderRadius: Zeta.of(context).radius.rounded,
                child: SizedBox.fromSize(
                  size: Size.square(Zeta.of(context).spacing.xl_8), // Image radius
                  child: image!.copyWith(fit: BoxFit.cover),
                ),
              );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(ColorProperty('iconColor', iconColor));
  }
}
