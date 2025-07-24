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

  Future<void> _initializeAudioPlayer() async {
    _audioPlayer ??= AudioPlayer();
    _audioPlayer!.onPlayerComplete.listen((_) => resetPlayback());
    _audioPlayer!.onPositionChanged.listen(_updatePlaybackLocation);
  }

  Future<void> _loadLocalFile() async {
    if (widget.assetPath != null) {
      _localFile = await fetchToMemory(widget.assetPath!);
    } else if (widget.url != null) {
      _localFile = await downloadAudioFileToLocal(widget.url!);
    }
  }

  Future<void> resetPlayback() async {
    _playing = false;
    await _initializeAudioPlayer();
    if (_localFile == null) await _loadLocalFile();
    if (_localFile != null) {
      await _audioPlayer!.setSourceUrl(_localFile!.toString());
      final duration = await _audioPlayer!.getDuration();
      setState(() => _duration = duration);
      unawaited(getAmplitudes());
    }
  }

  Future<void> getAmplitudes() async {
    if (_localFile == null || _linesNeeded == null || _linesNeeded! <= 0) return;
    final amplitudes = await extractWavAmplitudes(_localFile!, _linesNeeded!);
    setState(() => _amplitudes = amplitudes ?? _generateDefaultAmplitudes(_linesNeeded!));
  }

  void _updatePlaybackLocation(Duration position) {
    if (_duration == null || _linesNeeded == null) return;
    setState(() {
      final localPosition = position.inMilliseconds / _duration!.inMilliseconds;
      _playbackLocation = (localPosition * _linesNeeded!).clamp(1, _linesNeeded! - 1).toInt();
    });
  }

  @override
  void initState() {
    super.initState();
    unawaited(resetPlayback());
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
        color: zeta.colors.surfaceHover,
      ),
      padding: const EdgeInsets.all(4),
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
                      _linesNeeded = lines;
                      _amplitudes = List.generate(lines, (index) => 0.0);
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
