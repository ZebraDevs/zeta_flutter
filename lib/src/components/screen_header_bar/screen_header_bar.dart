import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// [ZetaScreenHeaderBar]
class ZetaScreenHeaderBar extends StatelessWidget {
  /// Constructor for [ZetaScreenHeaderBar].
  const ZetaScreenHeaderBar({
    this.title,
    this.rounded = true,
    this.actionButtonLabel,
    this.onActionButtonPressed,
    super.key,
  });

  /// The title of [ZetaScreenHeaderBar]. Normally a [Text] widget.
  final Widget? title;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// The label of the action button.
  final String? actionButtonLabel;

  /// Called when the action button is pressed.
  final VoidCallback? onActionButtonPressed;

  @override
  Widget build(BuildContext context) {
    return ZetaTopAppBar(
      leading: IconButton(
        onPressed: () async => Navigator.maybePop(context),
        icon: Icon(rounded ? ZetaIcons.chevron_left_round : ZetaIcons.chevron_left_sharp),
      ),
      title: title,
      titleSpacing: 0,
      titleTextStyle: ZetaTextStyles.titleLarge,
      actions: actionButtonLabel == null
          ? null
          : [
              ZetaButton(
                label: actionButtonLabel!,
                onPressed: onActionButtonPressed,
                borderType: rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp,
              ),
            ],
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
