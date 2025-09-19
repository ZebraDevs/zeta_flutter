import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Message Input',
  type: ZetaMessageInput,
  path: '$componentsPath/ZetaMessageInput',
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=18271-19682',
)
Widget defaultMessageInput(BuildContext context) {
  final controller = TextEditingController();

  final String? placeholder = context.knobs.stringOrNull(label: 'Placeholder');
  final bool allowsVoiceInput = context.knobs.boolean(label: 'Allows Voice Input', initialValue: true);
  final range = context.knobs.range(label: 'Range of lines', initialValue: const RangeValues(1, 10));
  final minLines = range.start.round();
  final maxLines = range.end.round();
  final bool disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
  final bool hasActionMenu = context.knobs.boolean(label: 'Has Action Menu', initialValue: true);
  final bool cameraTrailingButton = context.knobs.boolean(label: 'Camera Trailing Button', initialValue: false);

  return StatefulBuilder(
      builder: (context, setState) => ZetaMessageInput.actionMenu(
            controller: controller,
            placeholder: placeholder,
            allowsVoiceInput: allowsVoiceInput,
            minLines: minLines,
            maxLines: maxLines,
            disabled: disabled,
            hasActionMenu: hasActionMenu,
            cameraTrailingButton: cameraTrailingButton,
            attachments: [],
            onSend: (message) {},
            onSendAttachments: (value) {},
          ));
}
