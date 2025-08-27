import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

final List<IconButton> presetActions = [
  IconButton(
    icon: const Icon(ZetaIcons.attachment),
    onPressed: () {
      // Handle attachment action
    },
  ),
  cameraAction,
  IconButton(
    icon: const Icon(ZetaIcons.sticker),
    onPressed: () {
      // Handle sticky note input action
    },
  ),
  IconButton(
    icon: const Icon(ZetaIcons.gif),
    onPressed: () {
      // Handle GIF input action
    },
  ),
  IconButton(
    icon: const Icon(ZetaIcons.audio),
    onPressed: () {
      // Handle audio input action
    },
  ),
  IconButton(
    icon: const Icon(ZetaIcons.priority_important),
    onPressed: () {
      // Handle priority input action
    },
  ),
];

final IconButton cameraAction = IconButton(onPressed: () {}, icon: const Icon(ZetaIcons.camera));


/// A customizable message input widget for user text entry and sending actions.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS-Zeta---Components?node-id=18271-19682&m=dev
///
/// Widgetbook:
class MessageInput extends ZetaStatefulWidget {
  /// Default message input
  const MessageInput({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.placeholder,
    this.allowsVoiceInput,
    this.minLines,
    this.maxLines,
    this.trailingButton,
    this.actions,
  });

  /// Comment input
  const MessageInput.comment({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.placeholder = 'Add a comment',
    this.allowsVoiceInput,
    this.minLines = 1,
    this.maxLines = 1,
    this.trailingButton,
    this.actions,
  });

  /// Message input with predefined actions
  MessageInput.actionMenu({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.placeholder,
    this.allowsVoiceInput,
    this.minLines = 1,
    this.maxLines = 5,
    this.trailingButton,
  }) : actions = presetActions;

  /// Message input with predefined actions
  MessageInput.actionsAndCamera({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.placeholder,
    this.allowsVoiceInput,
    this.minLines = 1,
    this.maxLines = 5,
  })  : trailingButton = cameraAction,
        actions = presetActions;

  /// The text editing controller for the message input.
  final TextEditingController? controller;

  /// When there is no text in the input the send button will be greyed out.
  /// However, the onSend and onLongPressSend callbacks will still be triggered.
  final VoidCallback? onSend;

  /// Callback for long press on the send button.
  final VoidCallback? onLongPressSend;

  /// Placeholder text for the message input.
  final String? placeholder;

  /// Whether the message input should support voice input.
  final bool? allowsVoiceInput;

  /// {@macro flutter.widgets.editableText.minLines}
  /// Minimum number of lines for the text input.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  /// Maximum number of lines for the text input.
  final int? maxLines;

  /// If [trailingButton] is provided, it will be displayed while there is no text in the input.
  /// If there is text in the input, the send button will be displayed.
  final IconButton? trailingButton;

  /// The list of actions to display in the message input.
  final List<IconButton>? actions;

  @override
  State<MessageInput> createState() => _MessageInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController?>('controller', controller))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSend', onSend))
      ..add(StringProperty('placeholder', placeholder))
      ..add(IntProperty('minLines', minLines))
      ..add(IntProperty('maxLines', maxLines))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onLongPressSend', onLongPressSend))
      ..add(DiagnosticsProperty<bool?>('voice', allowsVoiceInput));
  }
}

class _MessageInputState extends State<MessageInput> {
  late TextEditingController _controller;
  bool _isTextEmpty = true;
  bool _isActionMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isTextEmpty = _controller.text.isEmpty;
    _controller.addListener(_handleTextChange);

    _isActionMenuOpen = false;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _handleTextChange() {
    final isTextEmpty = _controller.text.isEmpty;
    if (_isTextEmpty != isTextEmpty) {
      setState(() {
        _isTextEmpty = isTextEmpty;
      });
    }
  }

  void _openActionsMenu() {
    // Open the actions menu
    setState(() {
      _isActionMenuOpen = !_isActionMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;
    final disabledColor = colors.mainDisabled;
    final verticalPadding = spacing.medium;
    final horizontalPadding = spacing.large;
    final hasActions = widget.actions != null && widget.actions!.isNotEmpty;
    final showTrailingButton = _isTextEmpty && widget.trailingButton != null;

    return Column(
      children: [
        if (_isActionMenuOpen && hasActions)
          ColoredBox(
            color: colors.surfaceDefault,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.actions!
                    .map(
                      (action) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: spacing.small,
                        ),
                        child: action,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceDefault,
            border: Border(
              top: BorderSide(color: colors.borderDefault),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textBaseline: TextBaseline.ideographic,
            children: [
              if (hasActions)
                IconButton(
                  onPressed: _openActionsMenu,
                  icon: Icon(ZetaIcons.add, size: spacing.xl_3),
                )
              else
                const Nothing(),
              Expanded(
                child: ZetaTextInput(
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  controller: _controller,
                  rounded: context.rounded,
                  placeholder: widget.placeholder,
                  suffix: (widget.allowsVoiceInput ?? false) && _isTextEmpty
                      ? IconButton(
                          icon: Icon(
                            ZetaIcons.microphone,
                            color: disabledColor,
                            size: 26,
                          ),
                          onPressed: () {
                            // Handle voice input action
                          },
                        )
                      : null,
                ),
              ),
              if (showTrailingButton)
                IconButton(
                  icon: widget.trailingButton!.icon,
                  onPressed: widget.trailingButton!.onPressed,
                )
              else
                IconButton(
                  icon: const Icon(ZetaIcons.send),
                  color: _isTextEmpty ? disabledColor : null,
                  onPressed: widget.onSend,
                  onLongPress: widget.onLongPressSend,
                ),
            ].gap(spacing.small),
          ),
        ),
      ],
    );
  }
}
