import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// A header bar for screens, typically containing the title and actions.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24601-6781&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/screen-header-bar/zetascreenheaderbar/screen-header
class ZetaScreenHeaderBar extends ZetaStatelessWidget {
  /// Constructor for [ZetaScreenHeaderBar].
  const ZetaScreenHeaderBar({
    super.key,
    super.rounded,
    this.title,
    this.actionButtonLabel,
    this.onActionButtonPressed,
    this.backSemanticLabel,
    this.onBackButtonPressed,
  });

  /// The title of [ZetaScreenHeaderBar]. Normally a [Text] widget.
  final Widget? title;

  /// The label of the action button.
  final String? actionButtonLabel;

  /// Called when the action button is pressed.
  final VoidCallback? onActionButtonPressed;

  /// The semantic label for the back button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? backSemanticLabel;

  /// Called when the back button is pressed.
  ///
  /// If this is null, the back button will call [Navigator.maybePop].
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    final backButton = IconButton(
      onPressed: onBackButtonPressed ?? () => unawaited(Navigator.maybePop(context)),
      icon: Icon(context.rounded ? ZetaIcons.chevron_left_round : ZetaIcons.chevron_left_sharp),
    );

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: ZetaTopAppBar(
        leading: backSemanticLabel != null
            ? Semantics(
                label: backSemanticLabel,
                excludeSemantics: true,
                button: true,
                child: backButton,
              )
            : backButton,
        title: title,
        titleTextStyle: Zeta.of(context).textStyles.titleLarge,
        actions: actionButtonLabel == null
            ? []
            : [
                ZetaButton(
                  label: actionButtonLabel!,
                  onPressed: onActionButtonPressed,
                ),
              ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(StringProperty('actionButtonLabel', actionButtonLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onActionButtonPressed', onActionButtonPressed))
      ..add(StringProperty('backSemanticLabel', backSemanticLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onBackButtonPressed', onBackButtonPressed));
  }
}
