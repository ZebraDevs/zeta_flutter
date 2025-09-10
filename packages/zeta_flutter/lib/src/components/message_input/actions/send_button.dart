import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';
import 'action_button.dart';

/// The send button used in the message input
class SendButton extends ZetaStatelessWidget {
  /// Creates a [SendButton].
  const SendButton({
    super.key,
    required this.controller,
    this.attachments,
    this.onPressed,
    this.onLongPress,
    this.disabled,
  });

  /// The text editing controller of the connected text input.
  final TextEditingController controller;

  /// A list of attachment.
  final List<File>? attachments;

  /// The callback invoked on press of the send button.
  final void Function(String text, List<File> attachments)? onPressed;

  /// The callback invoked on long press of the send button.
  final void Function(String text, List<File> attachments)? onLongPress;

  /// Wether or not the button is disabled.
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return Stack(
      children: [
        ActionButton(
          icon: ZetaIcons.send,
          onPressed: onPressed != null ? () => onPressed!(controller.text, attachments ?? []) : null,
          onLongPress: onLongPress != null ? () => onLongPress!(controller.text, attachments ?? []) : null,
          disabled: disabled,
          semanticLabel: 'send the message',
        ),
        if (attachments != null && attachments!.isNotEmpty)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              width: spacing.large,
              height: spacing.large,
              decoration: BoxDecoration(
                color: colors.surfacePrimarySubtle,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  attachments!.length.toString(),
                  style: TextStyle(
                    color: colors.mainDefault,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController>('controller', controller))
      ..add(IterableProperty<File>('attachments', attachments))
      ..add(ObjectFlagProperty<void Function(String text, List<File> attachments)?>.has('onPressed', onPressed))
      ..add(ObjectFlagProperty<void Function(String text, List<File> attachments)?>.has('onLongPress', onLongPress))
      ..add(DiagnosticsProperty<bool?>('isDisabled', disabled));
  }
}
