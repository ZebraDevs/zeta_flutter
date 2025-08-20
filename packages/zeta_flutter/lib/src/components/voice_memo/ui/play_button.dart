import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../zeta_flutter.dart';
import '../state/playback_state.dart';

/// Play button for [ZetaAudioVisualizer] and [ZetaVoiceMemo].
class PlayButton extends StatelessWidget {
  /// Constructs a [PlayButton]
  const PlayButton({
    super.key,
    required this.onTap,
    required this.playButtonColor,
    required this.iconColor,
  });

  /// Called when the play button is tapped.
  final VoidCallback? onTap;

  /// Background color of the play button.
  final Color playButtonColor;

  /// Color of the play button icon.
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return Consumer<PlaybackState>(
      builder: (context, state, _) {
        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(zeta.spacing.small),
            child: Container(
              width: zeta.spacing.xl_4,
              height: zeta.spacing.xl_4,
              decoration: BoxDecoration(
                color: onTap == null ? zeta.colors.mainDisabled : playButtonColor,
                borderRadius: BorderRadius.all(zeta.radius.full),
              ),
              child: Center(
                child: AnimatedCrossFade(
                  firstChild: Icon(ZetaIcons.play, color: iconColor),
                  secondChild: Icon(ZetaIcons.pause, color: iconColor),
                  duration: ZetaAnimationLength.veryFast,
                  crossFadeState: state.playing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(ColorProperty('playButtonColor', playButtonColor))
      ..add(ColorProperty('iconColor', iconColor));
  }
}
