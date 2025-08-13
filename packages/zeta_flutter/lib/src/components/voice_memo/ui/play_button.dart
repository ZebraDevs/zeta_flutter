// Documentation not required as this is an internal file.
// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.isPlaying,
    required this.onTap,
    required this.playButtonColor,
    required this.iconColor,
    required this.disabled,
  });

  final bool isPlaying;
  final VoidCallback onTap;
  final Color playButtonColor;
  final Color iconColor;
  final bool disabled;
  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Padding(
        padding: EdgeInsets.all(zeta.spacing.small),
        child: Container(
          width: zeta.spacing.xl_4,
          height: zeta.spacing.xl_4,
          decoration: BoxDecoration(
            color: disabled ? zeta.colors.mainDisabled : playButtonColor,
            borderRadius: BorderRadius.all(zeta.radius.full),
          ),
          child: Center(
            child: AnimatedCrossFade(
              firstChild: Icon(ZetaIcons.play, color: iconColor),
              secondChild: Icon(ZetaIcons.pause, color: iconColor),
              duration: ZetaAnimationLength.veryFast,
              crossFadeState: isPlaying ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isPlaying', isPlaying))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(ColorProperty('playButtonColor', playButtonColor))
      ..add(ColorProperty('iconColor', iconColor))
      ..add(DiagnosticsProperty<bool>('disabled', disabled));
  }
}
