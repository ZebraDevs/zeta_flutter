import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String switchPath = '$componentsPath/Switch';

@widgetbook.UseCase(
  name: 'Android',
  type: ZetaSwitch,
  path: switchPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1722-63391&t=eEOivHU9uV4K8qJq-4',
)
Widget androidSwitchUseCase(BuildContext context) {
  bool? isOn = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaSwitch(
        value: isOn,
        variant: ZetaSwitchType.android,
        onChanged: !disabledKnob(context) ? (value) => setState(() => isOn = value) : null,
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'iOS',
  type: ZetaSwitch,
  path: switchPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1153-26526&t=eEOivHU9uV4K8qJq-4',
)
Widget iOSswitchUseCase(BuildContext context) {
  bool? isOn = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaSwitch(
        value: isOn,
        variant: ZetaSwitchType.ios,
        onChanged: !disabledKnob(context) ? (value) => setState(() => isOn = value) : null,
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Web',
  type: ZetaSwitch,
  path: switchPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1153-26923&t=eEOivHU9uV4K8qJq-4',
)
Widget switchUseCase(BuildContext context) {
  bool? isOn = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaSwitch(
        value: isOn,
        variant: ZetaSwitchType.web,
        onChanged: !disabledKnob(context) ? (value) => setState(() => isOn = value) : null,
      );
    },
  );
}
