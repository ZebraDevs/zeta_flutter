import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import '../../../zeta_flutter.dart';
import 'actions/action_button.dart';
import 'actions/attachment_button.dart';
import 'actions/image_button.dart';
import 'actions/location_button.dart';
import 'actions/send_button.dart';
import 'actions/video_button.dart';
import 'actions/voice_button.dart';
import 'actions/voice_memo_button.dart';
import 'panels/actions_panel.dart';
import 'panels/attachments_panel.dart';

/// A customizable message input widget for user text entry and sending actions.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS-Zeta---Components?node-id=18271-19682&m=dev
///
/// Widgetbook:
class ZetaMessageInput extends ZetaStatefulWidget {
  /// Default message input
  const ZetaMessageInput({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.onSendAttachments,
    this.onSendVoiceMemo,
    this.onSendLocation,
    this.placeholder,
    this.allowsVoiceInput,
    this.cameraTrailingButton,
    this.trailingButton,
    this.attachmentAction = true,
    this.pictureAction = true,
    this.videoAction = true,
    this.voiceMemoAction = true,
    this.locationAction = true,
    this.minLines,
    this.maxLines,
    this.hasActionMenu = false,
    this.actions,
    this.attachments,
    this.allowedExtensions,
    this.multiAttach = true,
    this.disabled,
    // this.maxAttachmentSize = 250000,
    // this.maxVoiceMemoDuration = const Duration(minutes: 1),
  });

  /// Comment input
  const ZetaMessageInput.comment({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.onSendAttachments,
    this.onSendVoiceMemo,
    this.onSendLocation,
    this.placeholder = 'Add a comment',
    this.allowsVoiceInput,
    this.cameraTrailingButton,
    this.trailingButton,
    this.attachmentAction = false,
    this.pictureAction = false,
    this.videoAction = false,
    this.voiceMemoAction = false,
    this.locationAction = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.hasActionMenu = false,
    this.actions,
    this.attachments,
    this.allowedExtensions,
    this.multiAttach = false,
    this.disabled,
    // this.maxAttachmentSize = 250000,
    // this.maxVoiceMemoDuration = const Duration(minutes: 1),
  });

  /// Message input with predefined actions
  const ZetaMessageInput.actionMenu({
    super.key,
    this.controller,
    this.onSend,
    this.onLongPressSend,
    this.onSendAttachments,
    this.onSendVoiceMemo,
    this.onSendLocation,
    this.placeholder,
    this.allowsVoiceInput,
    this.cameraTrailingButton,
    this.trailingButton,
    this.attachmentAction = true,
    this.pictureAction = true,
    this.videoAction = true,
    this.voiceMemoAction = true,
    this.locationAction = true,
    this.minLines = 1,
    this.maxLines = 5,
    this.hasActionMenu = true,
    this.actions,
    this.attachments,
    this.allowedExtensions,
    this.multiAttach = true,
    this.disabled,
    // this.maxAttachmentSize = 250000,
    // this.maxVoiceMemoDuration = const Duration(minutes: 1),
  });

  /// The text editing controller for the message input.
  final TextEditingController? controller;

  /// When there is no text in the input the send button will be greyed out.
  /// However, the onSend and onLongPressSend callbacks will still be triggered.
  final ValueChanged<String>? onSend;

  /// Callback for long press on the send button.
  final ValueChanged<String>? onLongPressSend;

  /// Callback for sending attachments (images, videos, files, etc.).
  final ValueChanged<List<File>>? onSendAttachments;

  /// Callback for sending voice memo.
  final void Function(File file, Uint8List bytes)? onSendVoiceMemo;

  /// Callback for sending location.
  final ValueChanged<LocationData>? onSendLocation;

  /// Placeholder text for the message input.
  final String? placeholder;

  /// Whether the message input should support voice input.
  final bool? allowsVoiceInput;

  /// Whether the camera button shows in place of a trailing button
  /// Override trailingButton prop
  final bool? cameraTrailingButton;

  /// The trailing button to show when the text field and attachments are empty;
  final Widget? trailingButton;

  /// Whether to show the attachment button.
  /// Defaults to true
  final bool? attachmentAction;

  /// Whether to show the picture button.
  /// Defaults to true
  final bool? pictureAction;

  /// Whether to show the video button.
  /// Defaults to true
  final bool? videoAction;

  /// Whether to show the voice button.
  /// Defaults to true
  final bool? voiceMemoAction;

  /// Whether to show the location button.
  /// Defaults to true
  final bool? locationAction;

  /// {@macro flutter.widgets.editableText.minLines}
  /// Minimum number of lines for the text input.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  /// Maximum number of lines for the text input.
  final int? maxLines;

  /// Whether to have the actions menu
  /// Defaults to true
  /// If true, it will use all the default action props
  final bool? hasActionMenu;

  /// The list of actions to display in the message input.
  final List<Widget>? actions;

  /// The list of file attachments.
  final List<File>? attachments;

  /// A list of allowed file extensions.
  /// If null, it will accept any extension.
  final List<String>? allowedExtensions;

  /// Whether or not the attachment button should let the user attach multiple files at once.
  final bool? multiAttach;

  /// Whether the entire message input is disabled.
  /// Defaults to false.
  final bool? disabled;

  // /// The maximum size of attachments in bytes.
  // final int? maxAttachmentSize;

  // /// The maximum duration of voice memos.
  // final Duration? maxVoiceMemoDuration;

  @override
  State<ZetaMessageInput> createState() => _MessageInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController?>('controller', controller))
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onSend', onSend))
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onLongPressSend', onLongPressSend))
      ..add(ObjectFlagProperty<ValueChanged<List<File>>?>.has('onSendAttachment', onSendAttachments))
      ..add(StringProperty('placeholder', placeholder))
      ..add(IntProperty('minLines', minLines))
      ..add(IntProperty('maxLines', maxLines))
      ..add(DiagnosticsProperty<bool?>('voice', allowsVoiceInput))
      ..add(DiagnosticsProperty<bool?>('allowsCameraInput', cameraTrailingButton))
      ..add(DiagnosticsProperty<bool?>('usePresetActions', hasActionMenu))
      ..add(IterableProperty<File>('attachments', attachments))
      ..add(DiagnosticsProperty<bool?>('attachmentAction', attachmentAction))
      ..add(DiagnosticsProperty<bool?>('cameraAction', pictureAction))
      ..add(DiagnosticsProperty<bool?>('videoAction', videoAction))
      ..add(DiagnosticsProperty<bool?>('voiceAction', voiceMemoAction))
      ..add(DiagnosticsProperty<bool?>('locationAction', locationAction))
      ..add(IterableProperty<String>('allowedExtensions', allowedExtensions))
      ..add(DiagnosticsProperty<bool?>('multiAttach', multiAttach))
      ..add(ObjectFlagProperty<void Function(File file, Uint8List bytes)?>.has('onSendVoiceMemo', onSendVoiceMemo))
      ..add(ObjectFlagProperty<ValueChanged<LocationData>?>.has('onSendLocation', onSendLocation))
      ..add(DiagnosticsProperty<bool?>('disabled', disabled));
    // ..add(IntProperty('maxAttachmentSize', maxAttachmentSize))
    // ..add(DiagnosticsProperty<Duration?>('maxVoiceMemoDuration', maxVoiceMemoDuration));
  }
}

class _MessageInputState extends State<ZetaMessageInput> {
  late TextEditingController _controller;
  late bool _isMessageContentEmpty;
  late bool _isActionMenuOpen;
  final FocusNode _focusNode = FocusNode();
  late List<File> _attachments;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isMessageContentEmpty = _controller.text.isEmpty;
    _attachments = widget.attachments ?? [];
    _isActionMenuOpen = false;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTextChange(String? text) {
    if (text == null) return;

    final isTextEmpty = text.trim().isEmpty && _attachments.isEmpty;
    if (_isMessageContentEmpty != isTextEmpty) setState(() => _isMessageContentEmpty = isTextEmpty);
  }

  void _handleSend(String text, List<File> attachments) {
    widget.onSend!(text);
    widget.onSendAttachments?.call(attachments);
  }

  void _handleLongPressSend(String text, List<File> attachments) {
    widget.onLongPressSend!(text);
    widget.onSendAttachments?.call(attachments);
  }

  void _openActionsMenu() => setState(() => _isActionMenuOpen = !_isActionMenuOpen);
  void _onCloseAttachment(int index) => setState(() => _attachments.removeAt(index));
  void _onCapture(File file) => setState(() => _attachments.add(file));
  void _onAttach(List<File> files) => setState(() => _attachments.addAll(files));

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;
    final verticalPadding = spacing.medium;
    final horizontalPadding = spacing.large;

    final showCameraButton = _isMessageContentEmpty && (widget.cameraTrailingButton ?? false);
    final showTrailingButton =
        _isMessageContentEmpty && widget.trailingButton != null && !(widget.cameraTrailingButton ?? false);
    final showSendButton = !_isMessageContentEmpty || (!showCameraButton && !showTrailingButton);

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          /* This keeps the keyboard open when using the message input */
          /* TODO: glitch where if the user taps the ZetaTextInput border it closes the keyboard */
          await SystemChannels.textInput.invokeMethod('TextInput.show');
        },
        child: Column(
          children: [
            if (_attachments.isNotEmpty)
              AttachmentsPanel(
                attachments: _attachments,
                onCloseAttachment: _onCloseAttachment,
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
                  if (widget.hasActionMenu ?? false)
                    ActionButton(
                      onPressed: _openActionsMenu,
                      icon: ZetaIcons.add,
                      disabled: widget.disabled,
                      semanticLabel: 'open action menu',
                    )
                  else
                    const Nothing(),
                  Expanded(
                    child: ZetaTextInput(
                      disabled: widget.disabled ?? false,
                      onChange: _handleTextChange,
                      focusNode: _focusNode,
                      minLines: widget.minLines,
                      maxLines: widget.maxLines,
                      controller: _controller,
                      rounded: context.rounded,
                      placeholder: widget.placeholder,
                      semanticLabel: widget.placeholder,
                      suffix: widget.allowsVoiceInput ?? false
                          ? VoiceButton(
                              controller: _controller,
                              disabled: widget.disabled,
                            )
                          : null,
                    ),
                  ),
                  if (showCameraButton)
                    ImageButton(
                      onCapture: _onCapture,
                      disabled: widget.disabled,
                    ),
                  if (showTrailingButton) widget.trailingButton!,
                  if (showSendButton)
                    SendButton(
                      controller: _controller,
                      attachments: _attachments,
                      onPressed: widget.onSend != null ? _handleSend : null,
                      onLongPress: widget.onLongPressSend != null ? _handleLongPressSend : null,
                      disabled: (_isMessageContentEmpty || widget.onSend == null) || (widget.disabled ?? false),
                    ),
                ].gap(spacing.small),
              ),
            ),
            if (_isActionMenuOpen && (widget.hasActionMenu ?? false))
              ActionsPanel(
                actions: [
                  if (widget.attachmentAction ?? false)
                    AttachmentButton(
                      allowMultiple: widget.multiAttach ?? false,
                      allowedExtensions: widget.allowedExtensions,
                      onAttach: widget.onSendAttachments != null ? _onAttach : null,
                    ),
                  if (widget.pictureAction ?? false)
                    ImageButton(
                      onCapture: widget.onSendAttachments != null ? _onCapture : null,
                    ),
                  if (widget.videoAction ?? false)
                    VideoButton(
                      onCapture: widget.onSendAttachments != null ? _onCapture : null,
                    ),
                  if (widget.voiceMemoAction ?? false)
                    VoiceMemoButton(
                      onSend: widget.onSendVoiceMemo,
                    ),
                  if (widget.locationAction ?? false)
                    LocationButton(
                      onLocationCapture: widget.onSendLocation,
                    ),
                  if (widget.actions != null) ...widget.actions!,
                ],
              ),
          ],
        ),
      ),
    );
  }
}
