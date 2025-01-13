import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../zeta_flutter.dart';

/// A screen header bar that contains a back button, title and an optional action button.
///
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24601-6781&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/screen-header-bar
class ZetaScreenHeaderBar extends ZetaStatelessWidget {
  /// Constructor for [ZetaScreenHeaderBar].
  const ZetaScreenHeaderBar({
    super.key,
    super.rounded,
    this.title,
    this.actionButtonLabel,
    this.onActionButtonPressed,
    this.backSemanticLabel,
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

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: ZetaTopAppBar(
        leading: Semantics(
          label: backSemanticLabel,
          excludeSemantics: true,
          button: true,
          child: IconButton(
            onPressed: () async => Navigator.maybePop(context),
            icon: const ZetaIcon(ZetaIcons.chevron_left),
          ),
        ),
        title: title,
        titleTextStyle: ZetaTextStyles.titleLarge,
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
      ..add(StringProperty('backSemanticLabel', backSemanticLabel));
  }
}
