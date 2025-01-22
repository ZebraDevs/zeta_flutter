import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../zeta_flutter.dart';

/// A widget that displays a label above a form field.
class ZetaInputLabel extends ZetaStatelessWidget {
  /// Creates a new [ZetaInputLabel]
  const ZetaInputLabel({
    required this.label,
    required this.requirementLevel,
    required this.disabled,
    super.key,
  });

  /// The label text.
  final String label;

  /// The requirement level of the field.
  ///
  /// If set to [ZetaFormFieldRequirement.optional], the label will display '(optional)'.
  /// If set to [ZetaFormFieldRequirement.mandatory], the label will have an asterix next to it.
  final ZetaFormFieldRequirement requirementLevel;

  /// If true, the label will be disabled.
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    const textStyle = ZetaTextStyles.bodyMedium;

    Widget? requirementWidget;

    if (requirementLevel == ZetaFormFieldRequirement.optional) {
      requirementWidget = Text(
        '(optional)', // TODO(UX-1003): needs localizing.
        style: textStyle.copyWith(color: disabled ? colors.mainDisabled : colors.mainSubtle),
      );
    } else if (requirementLevel == ZetaFormFieldRequirement.mandatory) {
      requirementWidget = Text(
        '*',
        style: ZetaTextStyles.labelIndicator.copyWith(
          color: disabled ? colors.mainDisabled : colors.mainNegative,
        ),
      );
    }

    return Row(
      children: [
        Text(
          label,
          style: textStyle.copyWith(
            color: disabled ? colors.mainDisabled : colors.mainDefault,
          ),
        ),
        if (requirementWidget != null) requirementWidget.paddingStart(Zeta.of(context).spacing.minimum),
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
