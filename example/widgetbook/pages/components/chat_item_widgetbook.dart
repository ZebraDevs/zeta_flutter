import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget chatItemWidgetBook(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'Chat name ID');
  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: 'Dummy text to represent the first lines of most recent message',
  );
  final count = context.knobs.int.input(label: 'Count', initialValue: 3);
  final enabledWarningIcon = context.knobs.boolean(label: 'Warning Icon', initialValue: false);
  final enabledNotificationIcon = context.knobs.boolean(label: 'Notification Icon', initialValue: false);
  final starred = context.knobs.boolean(label: 'Starred', initialValue: false);
  final enabledOnTap = context.knobs.boolean(label: 'Enabled Tap', initialValue: true);
  final enabledOnDelete = context.knobs.boolean(label: 'Delete', initialValue: true);
  final enabledOnMenuMore = context.knobs.boolean(label: 'Menu More', initialValue: true);
  final enabledOnCall = context.knobs.boolean(label: 'Call', initialValue: true);
  final enabledOnPtt = context.knobs.boolean(label: 'Ptt', initialValue: true);

  return WidgetbookTestWidget(
    widget: ZetaChatItem(
      time: DateTime.now(),
      enabledWarningIcon: enabledWarningIcon,
      enabledNotificationIcon: enabledNotificationIcon,
      count: count,
      onTap: enabledOnTap ? () {} : null,
      onDeleteTap: enabledOnDelete ? () {} : null,
      onCallTap: enabledOnCall ? () {} : null,
      onMenuMoreTap: enabledOnMenuMore ? () {} : null,
      onPttTap: enabledOnPtt ? () {} : null,
      starred: starred,
      leading: const ZetaAvatar.initials(initials: 'AZ', size: ZetaAvatarSize.m),
      title: Text(title),
      subtitle: Text(subtitle),
    ),
  );
}
