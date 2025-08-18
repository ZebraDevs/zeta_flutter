import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';
import '../state/audio_helpers.dart';

/// The visual waveform used in [ZetaAudioVisualizer] and [ZetaVoiceMemo.
class Waveform extends StatefulWidget {
  /// Constructs a [Waveform].
  const Waveform({
    super.key,
    required this.playedColor,
    required this.unplayedColor,
    required this.playbackPosition,
    required this.onInteraction,
    required this.audioFile,
  });

  /// The color of the waveform's bar elements after they have been played.
  final Color playedColor;

  /// The color of the waveform's bar elements before they have been played.
  final Color unplayedColor;

  /// The current playback location of the waveform.
  final ValueNotifier<double> playbackPosition;

  /// Callback for interaction events on the waveform.
  final void Function(Offset) onInteraction;

  /// Link to the file for which the wave form is generated.
  final Uri audioFile;

  @override
  State<Waveform> createState() => _WaveformState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('playedColor', playedColor))
      ..add(ColorProperty('unplayedColor', unplayedColor))
      ..add(ObjectFlagProperty<void Function(Offset p1)>.has('onInteraction', onInteraction))
      ..add(DiagnosticsProperty<Uri>('audioFile', audioFile))
      ..add(DiagnosticsProperty<ValueNotifier<double>>('playbackPosition', playbackPosition));
  }
}

class _WaveformState extends State<Waveform> {
  List<double> _amplitudes = [];
  bool _isLoading = false;
  bool _isSeeking = false;
  late final VoidCallback _playbackListener;
  @override
  void initState() {
    super.initState();
    _playbackListener = () {
      if (mounted) setState(() {});
    };
    widget.playbackPosition.addListener(_playbackListener);
  }

  @override
  void dispose() {
    widget.playbackPosition.removeListener(_playbackListener);
    super.dispose();
  }

  Future<void> getAmplitudes() async {
    _amplitudes = (await extractWavAmplitudes(widget.audioFile, _amplitudes.length)) ??
        AudioWaveformCalculator.generateDefaultAmplitudes(_amplitudes.length);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) => widget.onInteraction(details.localPosition),
      onHorizontalDragEnd: (_) => setState(() => _isSeeking = false),
      onHorizontalDragStart: (_) => setState(() => _isSeeking = true),
      onTapDown: (details) => widget.onInteraction(details.localPosition),
      child: LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final linesNeeded = constraints.maxWidth ~/ 4;

            if (context.mounted && !_isLoading && (_amplitudes.length != linesNeeded)) {
              _isLoading = true;
              setState(() => _amplitudes = List.filled(linesNeeded, 0));
              unawaited(getAmplitudes());
            }
          });

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_amplitudes.length, (index) {
                final amplitude = _amplitudes[index];
                return AnimatedContainer(
                  key: ValueKey(index),
                  duration: _isSeeking
                      ? Duration.zero
                      : widget.playbackPosition.value == 0
                          ? ZetaAnimationLength.verySlow
                          : ZetaAnimationLength.veryFast,
                  width: ZetaBorders.medium,
                  height: (amplitude * zeta.spacing.xl_4).clamp(ZetaBorders.small, zeta.spacing.xl_4),
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: (widget.playbackPosition.value) > (index / _amplitudes.length)
                        ? widget.playedColor
                        : widget.unplayedColor,
                    borderRadius: BorderRadius.all(zeta.radius.full),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('foregroundColor', widget.playedColor))
      ..add(ColorProperty('tertiaryColor', widget.unplayedColor))
      ..add(ObjectFlagProperty<void Function(Offset p1)>.has('onInteraction', widget.onInteraction));
  }
}
