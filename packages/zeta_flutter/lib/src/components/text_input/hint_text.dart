import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../zeta_flutter.dart';

/// A widget that displays hint or error text below a form field.
class ZetaHintText extends ZetaStatelessWidget {
  /// Creates a new [ZetaHintText]
  const ZetaHintText({
    required this.disabled,
    required this.hintText,
    required this.errorText,
    super.rounded,
    super.key,
  });

  /// If true, the hint text will be disabled.
  final bool disabled;

  /// The hint text.
  final String? hintText;

  /// The error text. If defined, it will be shown instead of the hint text.
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final error = errorText != null && errorText!.isNotEmpty;

    final text = error && !disabled ? errorText : hintText;

    Color elementColor = colors.mainSubtle;

    if (disabled) {
      elementColor = colors.mainDisabled;
    } else if (error) {
      elementColor = colors.mainNegative;
    }

    if (text == null || text.isEmpty) {
      return const Nothing();
    }

    return Row(
      children: [
        Icon(
          errorText != null
              ? (context.rounded ? ZetaIcons.error_round : ZetaIcons.error_sharp)
              : (context.rounded ? ZetaIcons.info_round : ZetaIcons.info_sharp),
          size: Zeta.of(context).spacing.large,
          color: elementColor,
        ),
        SizedBox(
          width: Zeta.of(context).spacing.minimum,
        ),
        Expanded(
          child: Text(
            text,
            style: Zeta.of(context).textStyles.bodyXSmall.copyWith(color: elementColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ).paddingTop(Zeta.of(context).spacing.small);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText));
  }
}
