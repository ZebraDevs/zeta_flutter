import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../zeta_flutter.dart';
import '../state/playback_state.dart';
import '../state/recording_state.dart';

/// The visual waveform used in [ZetaAudioVisualizer] and [ZetaVoiceMemo].
class Waveform extends StatefulWidget {
  /// Constructs a [Waveform].
  const Waveform({
    super.key,
    this.playedColor,
    this.unplayedColor,
    this.onInteraction,
    this.audioFile,
    this.audioChunks,
  });

  /// The color of the waveform's bar elements after they have been played.
  final Color? playedColor;

  /// The color of the waveform's bar elements before they have been played.
  final Color? unplayedColor;

  /// Callback for interaction events on the waveform.
  final void Function(Offset)? onInteraction;

  /// Link to the file for which the wave form is generated.
  final Uri? audioFile;

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
      ..add(IterableProperty('audioChunks', audioChunks));
  }
}

class _WaveformState extends State<Waveform> {
  final List<double> _amplitudes = [];
  bool _isLoading = false;
  bool _isSeeking = false;
  bool _isListening = false;
  final ScrollController _scrollController = ScrollController();
  RecordingState? _recordingState;
  PlaybackState? _playbackState;
  late VoidCallback _streamListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_recordingState != null && !_isListening) {
        _streamListener = () async {
          if (_recordingState!.stream != null && !_isListening && context.mounted && mounted) {
            await getAmplitudes();
            setState(() => _isListening = true);
          }
        };
        _recordingState!.addListener(_streamListener);
      }
    });
  }

  @override
  void dispose() {
    _recordingState?.removeListener(_streamListener);
    super.dispose();
  }

  bool _alsoLoading = false;

  Future<void> getAmplitudes() async {
    if (widget.audioFile != null && widget.audioFile!.path.isNotEmpty && !_alsoLoading) {
      final amps = await extractAudioAmplitudesFromFile(widget.audioFile!, _amplitudes.length);
      _amplitudes
        ..clear()
        ..addAll(amps);
      _isLoading = true;
      _alsoLoading = false;
    } else if (widget.audioChunks != null) {
      final amps = await extractAudioAmplitudesFromBytes(widget.audioChunks!, _amplitudes.length);
      _amplitudes
        ..clear()
        ..addAll(amps);
      _isLoading = false;
    } else if (context.findAncestorWidgetOfExactType<Consumer2<RecordingState, PlaybackState>>() != null) {
      _recordingState ??= context.watch<RecordingState>();
      _recordingState?.stream?.listen((pcmBytes) {
        final config = _recordingState?.recordConfig;
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
        final double amplitude = samples.isNotEmpty
            ? (sqrt(samples.fold<double>(0, (a, b) => a + b * b) / samples.length) / 32768.0) *
                (_recordingState?.loudnessMultiplier ?? 1)
            : 0;
        _amplitudes.add(amplitude.clamp(0.0, 1.0));
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        });
      });
    }
  }

  Widget _makeBody(BuildContext context) {
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
              _amplitudes
                ..clear()
                ..addAll(List.filled(linesNeeded, 0, growable: true));
              setState(() {});
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
                for (int index = 0; index < _amplitudes.length; index++)
                  AnimatedContainer(
                    key: ValueKey(index),
                    duration: _isSeeking
                        ? Duration.zero
                        : _playbackState?.playbackPercent == 0
                            ? ZetaAnimationLength.verySlow
                            : ZetaAnimationLength.veryFast,
                    width: ZetaBorders.medium,
                    height: (_amplitudes[index] * zeta.spacing.xl_4).clamp(ZetaBorders.small, zeta.spacing.xl_4),
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: (_playbackState?.playbackPercent ?? 0) >
                                  (index / (_amplitudes.isEmpty ? 1 : _amplitudes.length)) ||
                              (widget.audioFile == null && widget.audioChunks == null)
                          ? widget.playedColor
                          : widget.unplayedColor,
                      borderRadius: BorderRadius.all(zeta.radius.full),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isInRecordingProvider =
        context.findAncestorWidgetOfExactType<Consumer2<RecordingState, PlaybackState>>() != null;
    return Consumer<PlaybackState>(
      builder: (context, state, _) {
        _playbackState ??= state;
        if (isInRecordingProvider) {
          return Consumer<RecordingState>(
            builder: (context, recordingState, _) {
              _recordingState ??= recordingState;
              return _makeBody(context);
            },
          );
        }
        return _makeBody(context);
      },
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
