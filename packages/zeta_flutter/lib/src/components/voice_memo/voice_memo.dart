import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

export './audio_visualizer.dart';

enum ZetaVoiceMemoState {
  /// The voice memo is currently being recorded.
  recording,

  /// The voice memo has been recorded and is ready to be sent or canceled.
  recorded,

  /// The voice memo has been sent successfully.
  sent,

  /// The voice memo recording was canceled.
  canceled,
}

/// A slide-up sheet that appears when recording a voice message in chat. It shows the recording time, waveform, and buttons to stop, send, or cancel the memo.
class ZetaVoiceMemo extends StatelessWidget {
  /// Constructs a [ZetaVoiceMemo].
  const ZetaVoiceMemo({super.key});

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(zeta.radius.rounded),
        color: Zeta.of(context).colors.surfaceHover,
      ),
    );
  }
}
