import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'audio_helpers.dart';
import 'file_helpers.dart';

List<double> _generateDefaultAmplitudes(int linesNeeded) {
  const baseAmplitudes = [0, 0, 0, 0, 0, 0.375, 0.5, 1, 0.625, 1, 0.75, 0.75, 1, 1, 0.75, 1, 0.375, 0, 0];
  return List<double>.generate(linesNeeded, (i) => baseAmplitudes[i % baseAmplitudes.length].toDouble());
}

/// Audio Visualizer used within the [ZetaVoiceMemo] component.
class ZetaAudioVisualizer extends ZetaStatefulWidget {
  /// Constructs a [ZetaAudioVisualizer].
  const ZetaAudioVisualizer({
    super.key,
    super.rounded,
    this.assetPath,
    this.url,
  });

  /// The path of a local audio asset to visualize.
  final String? assetPath;

  /// The URL of a remote audio asset to visualize.
  ///
  /// This will download the audio file to a local cache and visualize it.
  /// The file will be cached and reused on subsequent calls.
  final String? url;

  @override
  State<ZetaAudioVisualizer> createState() => _ZetaAudioVisualizerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('assetPath', assetPath))
      ..add(StringProperty('url', url));
  }
}

class _ZetaAudioVisualizerState extends State<ZetaAudioVisualizer> {
  int? _playbackLocation;
  AudioPlayer? _audioPlayer;
  Uri? _localFile;
  Duration? _duration;
  bool _playing = false;
  int? _linesNeeded;
  List<double> _amplitudes = [];

  Future<void> getAmplitudes() async {
    if (_localFile == null || _linesNeeded == null || _localFile!.path.isEmpty || _linesNeeded! <= 0) {
      debugPrint('Local file or linesNeeded is null.');
      return;
    }
    final amplitudes = await extractWavAmplitudes(_localFile!, _linesNeeded!);
    setState(() => _amplitudes = amplitudes ?? _generateDefaultAmplitudes(_linesNeeded!));
  }

  Future<void> resetPlayback() async {
    _playing = false;
    _audioPlayer ??= AudioPlayer();
    if (_localFile == null) {
      if (widget.assetPath != null) {
        _localFile = await fetchToMemory(widget.assetPath!);
      } else if (widget.url != null) {
        _localFile = await downloadAudioFileToLocal(widget.url!);
      }
    }
    if (_localFile != null) {
      await _audioPlayer!.setSourceUrl(_localFile!.toString());
      final duration = await _audioPlayer!.getDuration();
      setState(() => _duration = duration);
      unawaited(getAmplitudes());
    }
  }

  @override
  void initState() {
    super.initState();

    unawaited(resetPlayback());

    _audioPlayer!.onPlayerComplete.listen((_) async {
      await resetPlayback();
    });

    _audioPlayer!.onPositionChanged.listen((position) {
      if (_duration == null) return;
      setState(() {
        final x = position.inMilliseconds / _duration!.inMilliseconds;
        final y = (x * _linesNeeded!).clamp(1, _linesNeeded! - 1);
        _playbackLocation = y.toInt();
      });
    });
  }

  @override
  void dispose() {
    unawaited(_audioPlayer?.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(zeta.radius.rounded),
        color: Zeta.of(context).colors.surfaceHover,
      ),
      padding: const EdgeInsets.all(4), // TODO(tokens): token
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (_playing) {
                unawaited(_audioPlayer?.pause());
              } else {
                unawaited(_audioPlayer?.resume());
              }
              setState(() => _playing = !_playing);
            },
            child: Padding(
              padding: EdgeInsets.all(zeta.spacing.small),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: zeta.colors.mainPrimary,
                  borderRadius: BorderRadius.all(zeta.radius.full),
                ),
                child: Center(
                  child: AnimatedCrossFade(
                    firstChild: Icon(
                      ZetaIcons.play,
                      color: zeta.colors.mainInverse,
                    ),
                    secondChild: Icon(
                      ZetaIcons.pause,
                      color: zeta.colors.mainInverse,
                    ),
                    duration: const Duration(milliseconds: 100),
                    crossFadeState: _playing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    final lines = (constraints.maxWidth / 4).floor();
                    if (_linesNeeded != lines) {
                      setState(() => _linesNeeded = lines);
                      unawaited(getAmplitudes());
                    }
                  }
                });
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _amplitudes.mapIndexed<Widget>(
                    (int index, double amplitude) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: 2,
                        height: (amplitude * 32).clamp(2, 32),
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: (_playbackLocation ?? 0) > index ? zeta.colors.mainDefault : zeta.colors.mainLight,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: zeta.spacing.small, right: zeta.spacing.medium),
            child: Text(
              _duration != null
                  ? '${_duration!.inMinutes}:${(_duration!.inSeconds % 60).toString().padLeft(2, '0')}'
                  : '0:00',
              style: zeta.textStyles.labelMedium,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('playbackLocation', _playbackLocation))
      ..add(DiagnosticsProperty<Uri?>('localFile', _localFile));
  }
}
