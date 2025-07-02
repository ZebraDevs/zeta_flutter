import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Empty states are used to convey there is no data is available for display. Types include No results, First use, No Data, User Cleared.
///
/// The [ZetaEmptyState] widget is a placeholder for an empty state in the application. It can be customized to display different messages or illustrations.
class ZetaEmptyState extends StatelessWidget {
  /// Constructs a [ZetaEmptyState].
  const ZetaEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.illustration,
    this.primaryAction,
    this.secondaryAction,
  });

  /// Title of the empty state, typically a short message indicating the state of the content.
  final String title;

  /// Subtitle of the empty state, providing additional context or instructions.
  final String subtitle;

  /// Illustration widget for the empty state, which can be a custom widget or an image.
  ///
  /// It is recommended to use one of the [ZetaIllustrations] widgets for consistency.
  final Widget? illustration;

  /// Primary action button for the empty state, typically used to guide the user to take an action.
  ///
  /// It is recommended to use a [ZetaButton] for consistency.
  final Widget? primaryAction;

  /// Secondary action button for the empty state, providing an alternative action.
  ///
  /// It is recommended to use a [ZetaButton.outlineSubtle] for consistency.
  final Widget? secondaryAction;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (illustration != null)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 144, maxWidth: 240),
              child: Center(child: illustration),
            ),
          SizedBox(height: zeta.spacing.large),
          Text(
            title,
            style: zeta.textStyles.h4,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: zeta.spacing.small),
          Text(
            subtitle,
            style: zeta.textStyles.bodySmall.apply(color: zeta.colors.mainSubtle),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: zeta.spacing.large),
          if (primaryAction != null || secondaryAction != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (secondaryAction != null) secondaryAction!,
                if (primaryAction != null && secondaryAction != null) SizedBox(width: zeta.spacing.medium, height: 0),
                if (primaryAction != null) primaryAction!,
              ],
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle));
  }
}
