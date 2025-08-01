import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

const String appBarPath = '$componentsPath/Voice Memo';
//TODO(bug): Implement widgetbook
@widgetbook.UseCase(
  name: 'Voice Memo',
  type: ZetaVoiceMemo,
  path: appBarPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=38832-2389&t=MGPsY57Ld4bcpPeQ-4',
)
Widget voiceMemo(BuildContext context) => ZetaVoiceMemo();
