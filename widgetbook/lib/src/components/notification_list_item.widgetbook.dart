import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

@widgetbook.UseCase(
  name: 'Notification Item',
  type: ZetaNotificationListItem,
  path: '$componentsPath/Notification Item',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26436-15209&t=AZEbv7Mm0mjIx0Or-4',
)
Widget notificationListItem(BuildContext context) => ZetaNotificationListItem(
      body: Text('New urgent message ' * 300, maxLines: 2, overflow: TextOverflow.ellipsis),
      attachment: context.knobs.boolean(label: 'Attachment') ? const Text('Spring-Donation-Drive.pdf') : null,
      title: context.knobs.string(label: 'Title', initialValue: 'Urgent Notification'),
      notificationTime: context.knobs.stringOrNull(label: 'Notification Time', initialValue: 'Just Now'),
      notificationRead: context.knobs.boolean(label: 'Notification Read'),
      leading: context.knobs.list(
        label: 'Badge',
        options: [
          const ZetaNotificationBadge.avatar(avatar: ZetaAvatar.initials(initials: 'JS')),
          const ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle),
          ZetaNotificationBadge.image(
            image: SvgPicture.asset(
              'packages/zeta_flutter/lib/assets/logos/zebra-logo-head.svg',
              fit: BoxFit.contain,
            ),
          ),
        ],
        labelBuilder: (value) => value.avatar != null
            ? 'Avatar'
            : value.icon != null
                ? 'Icon'
                : 'Image',
      ),
      action: context.knobs.boolean(label: 'Show action', initialValue: true)
          ? ZetaButton.outline(
              label: 'User Action',
              onPressed: () {},
              size: ZetaWidgetSize.small,
              borderType: ZetaWidgetBorder.rounded,
            )
          : null,
      showDivider: context.knobs.boolean(label: 'Show Divider'),
      showBellIcon: context.knobs.boolean(label: 'Show Bell Icon', initialValue: true),
    );
