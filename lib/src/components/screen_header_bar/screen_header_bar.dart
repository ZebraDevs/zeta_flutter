import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// [ZetaScreenHeaderBar]
class ZetaScreenHeaderBar extends ZetaStatelessWidget {
  /// Constructor for [ZetaScreenHeaderBar].
  const ZetaScreenHeaderBar({
    super.key,
    super.rounded,
    this.title,
    this.actionButtonLabel,
    this.onActionButtonPressed,
  });

  /// The title of [ZetaScreenHeaderBar]. Normally a [Text] widget.
  final Widget? title;

  /// The label of the action button.
  final String? actionButtonLabel;

  /// Called when the action button is pressed.
  final VoidCallback? onActionButtonPressed;

  @override
  Widget build(BuildContext context) {
    final bool rounded = context.rounded;
    return ZetaRoundedScope(
      rounded: rounded,
      child: ZetaTopAppBar(
        leading: IconButton(
          onPressed: () async => Navigator.maybePop(context),
          icon: Icon(rounded ? ZetaIcons.chevron_left_round : ZetaIcons.chevron_left_sharp),
        ),
        title: title,
        titleTextStyle: ZetaTextStyles.titleLarge,
        actions: actionButtonLabel == null
            ? null
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
      ..add(ObjectFlagProperty<VoidCallback?>.has('onActionButtonPressed', onActionButtonPressed));
  }
}
