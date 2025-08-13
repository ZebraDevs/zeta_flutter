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
Widget voiceMemo(BuildContext context) => ZetaVoiceMemo();

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
    );
