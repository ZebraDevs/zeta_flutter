import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../zeta_flutter.dart';

class ZetaInputLabel extends StatelessWidget {
  const ZetaInputLabel({
    required this.label,
    required this.requirementLevel,
    required this.disabled,
  });

  final String label;
  final ZetaFormFieldRequirement requirementLevel;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    const textStyle = ZetaTextStyles.bodyMedium;

    Widget? requirementWidget;

    if (requirementLevel == ZetaFormFieldRequirement.optional) {
      requirementWidget = Text(
        '(optional)', // TODO(UX-1003): needs localizing.
        style: textStyle.copyWith(color: disabled ? colors.textDisabled : colors.textSubtle),
      );
    } else if (requirementLevel == ZetaFormFieldRequirement.mandatory) {
      requirementWidget = Text(
        '*',
        style: ZetaTextStyles.labelIndicator.copyWith(
          color: disabled ? colors.textDisabled : colors.error, // TODO(mikecoomber): change to textNegative when added
        ),
      );
    }

    return Row(
      children: [
        Text(
          label,
          style: textStyle.copyWith(
            color: disabled ? colors.textDisabled : colors.textDefault,
          ),
        ),
        if (requirementWidget != null) requirementWidget.paddingStart(ZetaSpacing.minimum),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(EnumProperty<ZetaFormFieldRequirement>('requirementLevel', requirementLevel))
      ..add(DiagnosticsProperty<bool>('disabled', disabled));
  }
}
