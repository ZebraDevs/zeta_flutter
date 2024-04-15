import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Zeta Priority Pill.
///
/// This badge is used to indicate the order of importance.
class ZetaPriorityPill extends StatelessWidget {
  ///Constructs [ZetaPriorityPill]
  const ZetaPriorityPill({
    required this.index,
    required this.priority,
    this.rounded = true,
    super.key,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Leading number in component.
  final int index;

  /// Text in main part of component.
  final String priority;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final backgroundColor = theme.colors.primary;
    final Color foregroundColor = backgroundColor.onColor;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: rounded ? ZetaRadius.full : ZetaRadius.none,
        color: backgroundColor.shade10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            height: ZetaSpacing.x7,
            width: ZetaSpacing.x7,
            decoration: BoxDecoration(
              shape: rounded ? BoxShape.circle : BoxShape.rectangle,
              color: backgroundColor,
            ),
            child: Text(index.formatMaxChars(), style: ZetaTextStyles.bodySmall.apply(color: foregroundColor)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.x2, vertical: ZetaSpacing.x1),
            child: Text(
              priority,
              style: ZetaTextStyles.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index))
      ..add(StringProperty('priority', priority))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}
