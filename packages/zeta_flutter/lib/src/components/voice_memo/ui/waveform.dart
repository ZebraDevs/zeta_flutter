import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../../../zeta_flutter.dart';
import '../state/audio_helpers.dart';

/// The visual waveform used in [ZetaAudioVisualizer] and [ZetaVoiceMemo.
class Waveform extends StatefulWidget {
  /// Constructs a [Waveform].
  const Waveform({
    super.key,
    this.playedColor,
    this.unplayedColor,
    this.playbackPosition,
    this.onInteraction,
    this.audioFile,
    this.recordingValues,
    this.recordConfig,
    this.loudnessMultiplier,
    this.audioChunks,
  });

  /// The color of the waveform's bar elements after they have been played.
  final Color? playedColor;

  /// The color of the waveform's bar elements before they have been played.
  final Color? unplayedColor;

  /// The current playback location of the waveform.
  final ValueNotifier<double>? playbackPosition;

  /// Callback for interaction events on the waveform.
  final void Function(Offset)? onInteraction;

  /// Link to the file for which the wave form is generated.
  final Uri? audioFile;

  /// Stream of PCM bytes (Uint8List) representing the recording audio data.
  final Stream<Uint8List>? recordingValues;

  /// Config used to record the voice memo.
  final RecordConfig? recordConfig;

  /// Multiplier for the loudness of the waveform visualization during recording.
  final int? loudnessMultiplier;

  /// PCM WAV audio chunks used for the waveform visualization.
  final Uint8List? audioChunks;

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
      ..add(DiagnosticsProperty<ValueNotifier<double>>('playbackPosition', playbackPosition))
      ..add(DiagnosticsProperty<Stream<Uint8List>?>('recordingValues', recordingValues))
      ..add(DiagnosticsProperty<RecordConfig?>('recordConfig', recordConfig))
      ..add(IntProperty('loudnessMultiplier', loudnessMultiplier))
      ..add(IterableProperty<Iterable<Uint8List?>>('audioChunks', audioChunks as Iterable<Iterable<Uint8List?>>?));
  }
}

class _WaveformState extends State<Waveform> {
  List<double> _amplitudes = List.empty(growable: true);
  bool _isLoading = false;
  bool _isSeeking = false;
  late final VoidCallback _playbackListener;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _playbackListener = () {
      if (mounted) setState(() {});
    };
    widget.playbackPosition?.addListener(_playbackListener);
  }

  @override
  void dispose() {
    widget.playbackPosition?.removeListener(_playbackListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Waveform oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.recordingValues != null && oldWidget.recordingValues == null) {
      widget.recordingValues!.listen((pcmBytes) {
        final config = widget.recordConfig;
        final numChannels = config?.numChannels ?? 1;
        const bitsPerSample = 16;
        const bytesPerSample = bitsPerSample ~/ 8;
        final samples = <double>[];
        for (int i = 0; i + (bytesPerSample * numChannels - 1) < pcmBytes.length; i += bytesPerSample * numChannels) {
          double sum = 0;
          for (int ch = 0; ch < numChannels; ch++) {
            final int offset = i + ch * bytesPerSample;
            int sample = pcmBytes[offset] | (pcmBytes[offset + 1] << 8);
            sample = sample.toSigned(16);
            sum += sample.toDouble();
          }
          samples.add(sum / numChannels);
        }
        if (samples.isNotEmpty) {
          final sumSquares = samples.fold<double>(0, (a, b) => a + b * b);
          var rms = sqrt(sumSquares / samples.length) / 32768.0;
          // Boost the loudness for better visualization
          rms *= widget.loudnessMultiplier ?? 1;
          _amplitudes.add(rms.clamp(0.0, 1.0));
        } else {
          _amplitudes.add(0);
        }
        setState(() {});
        // Scroll to end after new amplitude is added
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        });
      });
    }
  }

  bool _alsoLoading = false;

  Future<void> getAmplitudes() async {
    if (widget.audioFile != null && widget.audioFile!.path.isNotEmpty && !_alsoLoading) {
      _amplitudes = await extractAudioAmplitudes(widget.audioFile!, _amplitudes.length);
      _isLoading = true;
      _alsoLoading = false;
    } else if (widget.audioChunks != null) {
      _amplitudes = await parseWavToAmplitudes(widget.audioChunks!, _amplitudes.length);
      _isLoading = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) => widget.onInteraction?.call(details.localPosition),
      onHorizontalDragEnd: (_) => setState(() => _isSeeking = false),
      onHorizontalDragStart: (_) => setState(() => _isSeeking = true),
      onTapDown: (details) => widget.onInteraction?.call(details.localPosition),
      child: LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final linesNeeded = constraints.maxWidth ~/ 4;

            if (context.mounted &&
                !_isLoading &&
                (_amplitudes.length != linesNeeded) &&
                (widget.audioFile != null || widget.audioChunks != null)) {
              _isLoading = true;
              setState(() => _amplitudes = List.filled(linesNeeded, 0, growable: true));
              unawaited(getAmplitudes());
            }
          });

          return SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: widget.audioFile == null ? MainAxisAlignment.end : MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (constraints.maxWidth - (_amplitudes.length * 4) > 0)
                  SizedBox(width: constraints.maxWidth - (_amplitudes.length * 4)),
                ...List.generate(
                  _amplitudes.length,
                  (index) {
                    final amplitude = _amplitudes[index];
                    return AnimatedContainer(
                      key: ValueKey(index),
                      duration: _isSeeking
                          ? Duration.zero
                          : widget.playbackPosition?.value == 0
                              ? ZetaAnimationLength.verySlow
                              : ZetaAnimationLength.veryFast,
                      width: ZetaBorders.medium,
                      height: (amplitude * zeta.spacing.xl_4).clamp(ZetaBorders.small, zeta.spacing.xl_4),
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: ((widget.playbackPosition?.value ?? 0) > (index / _amplitudes.length)) ||
                                (widget.audioFile == null && widget.audioChunks == null)
                            ? widget.playedColor
                            : widget.unplayedColor,
                        borderRadius: BorderRadius.all(zeta.radius.full),
                      ),
                    );
                  },
                ),
              ],
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
