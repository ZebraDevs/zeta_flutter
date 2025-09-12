import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';
import 'action_button.dart';

/// Voice memo button for recording voice notes
class VoiceMemoButton extends ZetaStatelessWidget {
  /// Creates a [VoiceMemoButton].
  const VoiceMemoButton({
    super.key,
    this.onSend,
    this.maxDuration,
  });

  /// Callback for when a voice note is recorded.
  final void Function(File file, Uint8List bytes)? onSend;

  /// The maximum duration of voice memos.
  final Duration? maxDuration;

  Future<void> _onClick(BuildContext context) async {
    // Convert Uint8List to File for the callback
    Future<void> handleVoiceMemo(Uint8List audioData) async {
      // Create a temporary file from the audio data
      final directory = Directory.systemTemp;
      final tempFile = File('${directory.path}/voice_memo_${DateTime.now().millisecondsSinceEpoch}.wav');
      await tempFile.writeAsBytes(audioData);
      onSend!(tempFile, audioData);
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.3,
          builder: (context, scrollController) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Zeta.of(context).colors.mainInverse,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ZetaVoiceMemo(
                      maxRecordingDuration: maxDuration != null ? maxDuration! : const Duration(seconds: 120),
                      onSend: onSend != null
                          ? (audioData) {
                              unawaited(handleVoiceMemo(audioData));
                              Navigator.of(context).pop();
                            }
                          : null,
                      onDiscard: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      icon: ZetaIcons.audio,
      onPressed: onSend != null ? () => _onClick(context) : null,
      semanticLabel: 'record a voice memo',
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<void Function(File file, Uint8List bytes)>.has('onSend', onSend));
    properties.add(DiagnosticsProperty<Duration?>('maxDuration', maxDuration));
  }
}
