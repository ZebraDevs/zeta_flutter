import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// List Item for notifications
class ZetaNotificationListItem extends StatefulWidget {
  /// Constructor for [ZetaNotificationListItem]
  const ZetaNotificationListItem({
    super.key,
    required this.leading,
    required this.body,
    required this.title,
    this.notificationRead = false,
    this.notificationTime,
    required this.action,
    this.showDivider = false,
  });

  /// Notification Badge to indicate type of notification or who it's coming from
  final ZetaNotificationBadge leading;

  /// Body of notification item
  final Widget body;

  /// Notification title
  final String title;

  /// If notification has been read
  final bool notificationRead;

  /// Time of notificaiton
  final String? notificationTime;

  /// If notification is a grouped and there are more notifications show divider.
  final bool? showDivider;

  /// Pass in a action widget to handle action functionality.
  final Widget action;

  @override
  State<ZetaNotificationListItem> createState() => _ZetaNotificationListItemState();

  /// Function that returns copy of a notification item with altered fields
  ZetaNotificationListItem copyWith({
    ZetaNotificationBadge? leading,
    Widget? body,
    String? title,
    String? notificationTime,
    String? linkText,
    VoidCallback? linkOnClick,
    Widget? action,
    bool? showDivider,
  }) {
    return ZetaNotificationListItem(
      leading: leading ?? this.leading,
      body: body ?? this.body,
      title: title ?? this.title,
      notificationTime: notificationTime ?? this.notificationTime,
      action: action ?? this.action,
      showDivider: showDivider ?? this.showDivider,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('notificationTime', notificationTime))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<bool>('notificationRead', notificationRead))
      ..add(DiagnosticsProperty<bool?>('showDivider', showDivider));
  }
}

class _ZetaNotificationListItemState extends State<ZetaNotificationListItem> {
  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return DecoratedBox(
      decoration: _getStyle(colors),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.leading,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (!widget.notificationRead)
                              ZetaIndicator(
                                color: colors.blue,
                                size: ZetaWidgetSize.small,
                              ),
                            Text(
                              widget.title,
                              style: ZetaTextStyles.labelLarge,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            if (widget.notificationTime != null)
                              Text(
                                widget.notificationTime!,
                                style: ZetaTextStyles.bodySmall.apply(color: colors.textDisabled),
                              ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(color: colors.surfaceNegative, borderRadius: ZetaRadius.full),
                              child: Icon(
                                ZetaIcons.important_notification_round,
                                color: colors.white,
                                size: ZetaSpacing.medium,
                              ),
                            ),
                          ].gap(ZetaSpacing.minimum),
                        ),
                      ],
                    ),
                    widget.body,
                  ].gap(ZetaSpacing.minimum),
                ),
              ),
            ].gap(ZetaSpacing.small),
          ),
          Container(alignment: Alignment.centerRight, child: widget.action),
        ],
      ).paddingAll(ZetaSpacing.small),
    );
  }

  BoxDecoration _getStyle(ZetaColors colors) {
    return BoxDecoration(
      color: widget.notificationRead ? colors.surfacePrimary : colors.surfaceSelected,
      borderRadius: ZetaRadius.rounded,
      border: (widget.showDivider ?? false)
          ? Border(bottom: BorderSide(width: ZetaSpacing.minimum, color: colors.blue))
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
    final colors = Zeta.of(context).colors;
    return avatar != null
        ? avatar!.copyWith(
            size: ZetaAvatarSize.m,
            lowerBadge: ZetaAvatarBadge.icon(icon: ZetaIcons.check_mark_round, color: colors.green),
            backgroundColor: colors.purple.shade80,
          )
        : icon != null
            ? Icon(
                icon,
                size: ZetaSpacing.xL8,
                color: iconColor,
              )
            : ClipRRect(
                borderRadius: ZetaRadius.rounded,
                child: SizedBox.fromSize(
                  size: const Size.square(ZetaSpacing.xL8), // Image radius
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
