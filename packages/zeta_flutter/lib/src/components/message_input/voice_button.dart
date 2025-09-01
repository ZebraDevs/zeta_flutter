import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../zeta_flutter.dart';

/// A widget that provides voice input functionality.
class VoiceButton extends StatefulWidget {
  /// Creates a [VoiceButton].
  const VoiceButton({super.key, required this.controller});

  /// The text input editing controller for the voice input.
  final TextEditingController controller;

  @override
  VoiceButtonState createState() => VoiceButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>('controller', controller),
    );
  }
}

/// The state for the [VoiceButton].
class VoiceButtonState extends State<VoiceButton> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';
  int _cursorPos = 0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  /// Handles the speech recognition result.
  void onSpeechResult(String text) {
    if (text.isEmpty) return;
    final beforeText = widget.controller.text.substring(0, _cursorPos);
    final afterText = widget.controller.text.substring(_cursorPos);
    final addOneToCursorPos = beforeText.isNotEmpty || afterText.isNotEmpty;

    if (_cursorPos != -1) {
      widget.controller.text =
          '${beforeText.isNotEmpty ? '${beforeText.trimRight()} ' : ''}$text${afterText.isNotEmpty ? ' ${afterText.trimLeft()}' : ''}';
    } else {
      widget.controller.text = widget.controller.text + text;
    }

    widget.controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _cursorPos + text.length + (addOneToCursorPos ? 1 : 0),
      ),
    );
  }

  Future<void> _startListening() async {
    setState(() => _cursorPos = widget.controller.selection.baseOffset);

    final bool available = await _speech.initialize(
      onStatus: (status) => {
        if (status == stt.SpeechToText.notListeningStatus)
          {
            setState(() => _isListening = false),
          },
        if (status == stt.SpeechToText.doneStatus)
          {onSpeechResult(_recognizedText)},
      },
      onError: (error) => {
        setState(() => _isListening = false),
      },
    );

    if (available) {
      setState(() => _isListening = true);
      setState(() => _recognizedText = '');
      await _speech.listen(
        pauseFor: const Duration(seconds: 3),
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        },
      );
    } else {
      _displayPermsErrorToast();
    }
  }

  Future<void> _stopListening() async {
    setState(() => _isListening = false);
    await _speech.stop();
  }

  void _displayPermsErrorToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      ZetaSnackBar(
        type: ZetaSnackBarType.error,
        context: context,
        content: const Text(
          'Speech recognition not available; could be due to insufficient permissions',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return IconButton(
      icon: Icon(
        ZetaIcons.microphone,
        color: _isListening ? colors.mainPrimary : colors.mainDisabled,
        size: spacing.xl_3,
      ),
      onPressed: _isListening ? _stopListening : _startListening,
    );
  }
}
