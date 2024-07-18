import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../zeta_flutter.dart';

class ZetaHintText extends StatelessWidget {
  const ZetaHintText({
    required this.disabled,
    required this.hintText,
    required this.errorText,
    required this.rounded,
  });
  final bool disabled;
  final bool rounded;
  final String? hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final error = errorText != null && errorText!.isNotEmpty;

    final text = error && !disabled ? errorText : hintText;

    Color elementColor = colors.textSubtle;

    if (disabled) {
      elementColor = colors.textDisabled;
    } else if (error) {
      elementColor = colors.error;
    }

    if (text == null || text.isEmpty) {
      return const Nothing();
    }

    return Row(
      children: [
        ZetaIcon(
          errorText != null ? ZetaIcons.error : ZetaIcons.info,
          size: ZetaSpacing.large,
          color: elementColor,
        ),
        const SizedBox(
          width: ZetaSpacing.minimum,
        ),
        Expanded(
          child: Text(
            text,
            style: ZetaTextStyles.bodyXSmall.copyWith(color: elementColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ).paddingTop(ZetaSpacing.small);
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
