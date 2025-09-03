import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

const String path = '$componentsPath/Voice Memo';

@widgetbook.UseCase(
  name: 'Voice Memo',
  type: ZetaVoiceMemo,
  path: path,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=38832-2389&t=MGPsY57Ld4bcpPeQ-4',
)
Widget voiceMemo(BuildContext context) => ZetaVoiceMemo(
      canRecord: context.knobs.boolean(label: "Can record", initialValue: true),
      maxLimitLabel: context.knobs.string(
        label: "Max limit label",
        initialValue: "Recording message {timer} seconds left...",
      ),
      maxRecordingDuration: Duration(
        seconds: context.knobs.int.slider(label: "Max recording duration", initialValue: 10).toInt(),
      ),
      playingLabel: context.knobs.string(label: "Playing label", initialValue: "Playing..."),
      warningDuration: Duration(
        seconds: context.knobs.int.slider(label: "Warning duration", initialValue: 5).toInt(),
      ),
      sendMessageLabel: context.knobs.string(
        label: "Send message label",
        initialValue: "Send message?",
      ),
      recordingLabel: context.knobs.string(
        label: "Recording label",
        initialValue: "Recording...",
      ),
      recordingNotAllowedLabel: context.knobs.string(
        label: "Recording not allowed label",
        initialValue: "Recording not allowed.",
      ),
      loudnessMultiplier: context.knobs.int
          .slider(
            label: "Loudness multiplier",
            initialValue: 20,
            min: 1,
            max: 1000,
          )
          .toDouble(),
    );

@widgetbook.UseCase(
  name: 'Audio Visualizer',
  type: ZetaAudioVisualizer,
  path: path,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=38832-2389&t=MGPsY57Ld4bcpPeQ-4',
)
Widget audioVisualizer(BuildContext context) => ZetaAudioVisualizer(
      assetPath: 'assets/notification.wav',
      backgroundColor: context.knobs.colorOrNull(label: "Background color"),
      foregroundColor: context.knobs.colorOrNull(label: "Foreground color"),
      playButtonColor: context.knobs.colorOrNull(label: "Play button color"),
      rounded: context.knobs.boolean(label: "Rounded", initialValue: true),
      tertiaryColor: context.knobs.colorOrNull(label: "Tertiary color"),
      errorMessage: context.knobs.string(label: "Error message", initialValue: "Audio cannot be played"),
    );
