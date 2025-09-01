import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';
import 'action_menu.dart';
import 'attachment_bar.dart';
import 'camera_button.dart';
import 'video_button.dart';
import 'voice_button.dart';

/// TODO
/// - Implement voice input functionality ✅
/// - Add support for image and video attachments ✅
/// - Add support for file attachments
/// - Add support for gif and sticker input
/// - Add support for voice memo input
/// - Add support for location sharing

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
    this.onSendAttachment,
    this.placeholder,
    this.allowsVoiceInput,
    this.allowsCameraInput,
    this.minLines,
    this.maxLines,
    this.usePresetActions = false,
    this.actions,
    this.attachments,
  });

  /// Comment input
  const MessageInput.comment({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.onSendAttachment,
    this.placeholder = 'Add a comment',
    this.allowsVoiceInput,
    this.allowsCameraInput,
    this.minLines = 1,
    this.maxLines = 1,
    this.usePresetActions = false,
    this.actions,
    this.attachments,
  });

  /// Message input with predefined actions
  const MessageInput.actionMenu({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.onSendAttachment,
    this.placeholder,
    this.allowsVoiceInput,
    this.allowsCameraInput,
    this.minLines = 1,
    this.maxLines = 5,
    this.usePresetActions = true,
    this.actions,
    this.attachments,
  });

  /// The text editing controller for the message input.
  final TextEditingController? controller;

  /// When there is no text in the input the send button will be greyed out.
  /// However, the onSend and onLongPressSend callbacks will still be triggered.
  final ValueChanged<String>? onSend;

  /// Callback for long press on the send button.
  final ValueChanged<String>? onLongPressSend;

  /// Callback for sending attachments (images, videos, files, etc.).
  final ValueChanged<List<File>>? onSendAttachment;

  /// Placeholder text for the message input.
  final String? placeholder;

  /// Whether the message input should support voice input.
  final bool? allowsVoiceInput;

  /// Whether the camera button shows when text field is empty
  final bool? allowsCameraInput;

  /// {@macro flutter.widgets.editableText.minLines}
  /// Minimum number of lines for the text input.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  /// Maximum number of lines for the text input.
  final int? maxLines;

  /// Wether to use the preset actions
  final bool? usePresetActions;

  /// The list of actions to display in the message input.
  final List<Widget>? actions;

  /// The list of file attachments.
  final List<File>? attachments;

  @override
  State<MessageInput> createState() => _MessageInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController?>('controller', controller))
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onSend', onSend))
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onLongPressSend', onLongPressSend))
      ..add(ObjectFlagProperty<ValueChanged<List<File>>?>.has('onSendAttachment', onSendAttachment))
      ..add(StringProperty('placeholder', placeholder))
      ..add(IntProperty('minLines', minLines))
      ..add(IntProperty('maxLines', maxLines))
      ..add(DiagnosticsProperty<bool?>('voice', allowsVoiceInput))
      ..add(DiagnosticsProperty<bool?>('allowsCameraInput', allowsCameraInput))
      ..add(DiagnosticsProperty<bool?>('usePresetActions', usePresetActions))
      ..add(IterableProperty<File>('attachments', attachments));
  }
}

class _MessageInputState extends State<MessageInput> {
  late TextEditingController _controller;
  bool _isTextEmpty = true;
  bool _isActionMenuOpen = false;
  final FocusNode _focusNode = FocusNode();
  List<File> _attachments = [];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isTextEmpty = _controller.text.isEmpty;
    _controller.addListener(_handleTextChange);
    _attachments = widget.attachments ?? [];
    _isActionMenuOpen = false;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _controller.removeListener(_handleTextChange);
    _attachments.clear();
    _focusNode.dispose();
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

  void _handleSend(String text, List<File> attachments) {
    widget.onSend!(text);
    widget.onSendAttachment!(attachments);
  }

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;
    final disabledColor = colors.mainDisabled;
    final verticalPadding = spacing.medium;
    final horizontalPadding = spacing.large;
    final hasActions = (widget.usePresetActions ?? false) ||
        (widget.actions != null && widget.actions!.isNotEmpty);
    final showTrailingButton = _isTextEmpty && (widget.allowsCameraInput ?? false);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        /* This keeps the keyboard open when using the message input */
        /* TODO: glitch where if the user taps the ZetaTextInput border it closes the keyboard */
        await SystemChannels.textInput.invokeMethod('TextInput.show');
      },
      child: Column(
        children: [
          if (_attachments.isNotEmpty)
            AttachmentsBar(
              attachments: _attachments,
              onCloseAttachment: (index) {
                setState(() {
                  _attachments.removeAt(index);
                });
              },
            )
          else
            const Nothing(),
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
                    icon: const Icon(ZetaIcons.add),
                    iconSize: spacing.xl_3,
                  )
                else
                  const Nothing(),
                Expanded(
                  child: ZetaTextInput(
                    focusNode: _focusNode,
                    minLines: widget.minLines,
                    maxLines: widget.maxLines,
                    controller: _controller,
                    rounded: context.rounded,
                    placeholder: widget.placeholder,
                    suffix: widget.allowsVoiceInput ?? false
                        ? VoiceButton(controller: _controller)
                        : const Nothing(),
                  ),
                ),
                if (showTrailingButton && _controller.text.isEmpty && _attachments.isEmpty)
                  CameraButton(
                    onCapture: (file) async {
                      await SystemChannels.textInput.invokeMethod('TextInput.show');
                      setState(() {
                        _attachments.add(file);
                      });
                    },
                  )
                else
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(ZetaIcons.send),
                        iconSize: spacing.xl_3,
                        color: _isTextEmpty && _attachments.isEmpty ? disabledColor : null,
                        onPressed: () => _handleSend(_controller.text, _attachments),
                        onLongPress: () => widget.onLongPressSend!(_controller.text),
                      ),
                      if (_attachments.isNotEmpty)
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
                                _attachments.length.toString(),
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
                  ),
              ].gap(spacing.small),
            ),
          ),
          if (_isActionMenuOpen && hasActions)
            ActionMenu(
              actions: widget.actions ??
                  [
                    IconButton(
                      icon: const Icon(ZetaIcons.attachment),
                      onPressed: () {
                        // Handle attachment action
                      },
                    ),
                    CameraButton(
                      onCapture: (file) {
                        setState(() {
                          _attachments.add(file);
                        });
                      },
                    ),
                    VideoButton(
                      onCapture: (file) {
                        setState(() {
                          _attachments.add(file);
                        });
                      },
                    ),
                    // IconButton(
                    //   icon: const Icon(ZetaIcons.sticker),
                    //   onPressed: () {
                    //     // Handle sticky note input action
                    //   },
                    // ),
                    // IconButton(
                    //   icon: const Icon(ZetaIcons.gif),
                    //   onPressed: () {
                    //     // Handle GIF input action
                    //   },
                    // ),
                    IconButton(
                      icon: const Icon(ZetaIcons.audio),
                      onPressed: () {
                        // Handle audio input action
                      },
                    ),
                    IconButton(
                      icon: const Icon(ZetaIcons.pin),
                      onPressed: () {
                        // Handle location input action
                      },
                    ),
                  ],
            ),
        ],
      ),
    );
  }
}
