import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';

/// Not intended for individual use
///
/// A badge with Zeta styling
class InternalZetaBadge extends StatelessWidget {
  /// Creates a new [InternalZetaBadge]
  const InternalZetaBadge({
    required this.rounded,
    required this.status,
    required this.child,
    super.key,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// {@macro zeta-component-badge-status}
  final ZetaWidgetStatus status;

  /// The child of the badge
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ZetaColorSwatch colors = status.colorSwatch(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.shade10,
        border: Border.all(color: colors.border),
        borderRadius: rounded ? ZetaRadius.full : ZetaRadius.minimal,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.x2, vertical: ZetaSpacing.x0_5),
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(EnumProperty<ZetaWidgetStatus>('status', status));
  }
}
