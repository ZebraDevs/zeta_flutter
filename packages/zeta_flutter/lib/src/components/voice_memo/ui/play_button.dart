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
  });

  final bool isPlaying;
  final VoidCallback onTap;
  final Color playButtonColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(Zeta.of(context).spacing.small),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: playButtonColor,
            borderRadius: BorderRadius.all(Zeta.of(context).radius.full),
          ),
          child: Center(
            child: AnimatedCrossFade(
              firstChild: Icon(ZetaIcons.play, color: iconColor),
              secondChild: Icon(ZetaIcons.pause, color: iconColor),
              duration: const Duration(milliseconds: 100),
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
      ..add(ColorProperty('iconColor', iconColor));
  }
}
