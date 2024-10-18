import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Chat Item',
  type: ZetaChatItem,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24820-42166&t=6jmGZpLRLKTDIfJL-4',
)
Widget chatItem(BuildContext context) {
  return ZetaChatItem(
    time: DateTime.now(),
    enabledWarningIcon: context.knobs.boolean(label: 'Warning Icon', initialValue: false),
    enabledNotificationIcon: context.knobs.boolean(label: 'Notification Icon', initialValue: false),
    count: context.knobs.int.input(label: 'Count', initialValue: 3),
    onTap: context.knobs.boolean(label: 'Enabled Tap', initialValue: true) ? () {} : null,
    slidableActions: context.knobs.boolean(label: 'Slidable actions')
        ? [
            ZetaSlidableAction.delete(onPressed: () {}),
            ZetaSlidableAction.menuMore(onPressed: () {}),
            ZetaSlidableAction.call(onPressed: () {}),
            ZetaSlidableAction.ptt(onPressed: () {}),
          ]
        : [],
    starred: context.knobs.booleanOrNull(label: 'Starred', initialValue: false),
    leading: const ZetaAvatar.initials(initials: 'AZ', size: ZetaAvatarSize.m),
    title: Text(context.knobs.string(label: 'Title', initialValue: 'Chat name ID')),
    subtitle: Text(context.knobs.string(
      label: 'Subtitle',
      initialValue: 'Dummy text to represent the first lines of most recent message',
    )),
  );
}
