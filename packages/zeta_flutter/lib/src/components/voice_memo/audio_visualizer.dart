import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'audio_helpers.dart';
import 'file_helpers.dart';

// TODO(luke): Add device media
// TODO(luke): Ensure this works on web?
// TODO(luke): Add the recording functionality
// TODO(luke): Reduce how often re renders happen when the screen size is changing.

// NOTE: The following TODOs are nice to haves but will not be implemented unless requested
// TODO(design): Animate the bars from left to right to make it look more natural
// TODO(design): Add a basic loading indicator

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
    this.backgroundColor,
    this.foregroundColor,
    this.tertiaryColor,
    this.playButtonColor,
    this.deviceFilePath,
    this.isRecording = false,
  }) : assert(
          assetPath != null || url != null || deviceFilePath != null || isRecording,
          'Either assetPath, deviceFilePath, or url must be provided.',
        );

  /// The path of a local audio asset to visualize.
  final String? assetPath;

  /// The URL of a remote audio asset to visualize.
  ///
  /// This will download the audio file to a local cache and visualize it.
  /// The file will be cached and reused on subsequent calls.
  final String? url;

  /// The path to a local audio file on the device to visualize.
  final String? deviceFilePath;

  /// The background color of the component.
  ///
  /// Defaults to [ZetaColors.surfaceHover] if not provided.
  final Color? backgroundColor;

  /// The foreground color of the component - used for the bars in the visualizer.
  ///
  /// Defaults to [ZetaColors.mainDefault] if not provided.
  final Color? foregroundColor;

  /// The color used for the audio visualizer bars before they have been played.
  ///
  /// Defaults to [ZetaColors.mainLight] if not provided.
  final Color? tertiaryColor;

  /// The color used for the play button in the visualizer.
  ///
  /// Defaults to [ZetaColors.mainPrimary] if not provided.
  final Color? playButtonColor;

  /// Whether the audio visualizer is currently recording.
  ///
  /// This is used within the [ZetaVoiceMemo] component.
  final bool isRecording;

  @override
  State<ZetaAudioVisualizer> createState() => _ZetaAudioVisualizerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('assetPath', assetPath))
      ..add(StringProperty('url', url))
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(ColorProperty('tertiaryColor', tertiaryColor))
      ..add(StringProperty('deviceFilePath', deviceFilePath))
      ..add(ColorProperty('playButtonColor', playButtonColor))
      ..add(DiagnosticsProperty<bool>('isRecording', isRecording));
  }
}

class _ZetaAudioVisualizerState extends State<ZetaAudioVisualizer> {
  // Current location shown in the visualizer
  int? _playbackLocationVis;
  double _playbackLocation = 0;
  AudioPlayer? _audioPlayer;
  Uri? _localFile;
  Duration? _duration;
  bool _playing = false;
  int? _linesNeeded;
  List<double> _amplitudes = [];
  final GlobalKey _rowKey = GlobalKey();
  Duration _currentPosition = Duration.zero;

  Future<void> _initializeAudioPlayer() async {
    _audioPlayer ??= AudioPlayer();
    _audioPlayer!.onPlayerComplete.listen((_) => resetPlayback());
    _audioPlayer!.onPositionChanged.listen(_updatePlaybackLocation);
  }

  Future<void> _loadLocalFile() async {
    if (widget.assetPath != null) {
      _localFile = await handleFile(widget.assetPath!, FileFetchMode.asset);
    } else if (widget.url != null) {
      _localFile = await handleFile(widget.url!, FileFetchMode.url);
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
      _playbackLocationVis = (localPosition * _linesNeeded!).clamp(1, _linesNeeded! - 1).toInt();
      _currentPosition = position;
      if (_playbackLocationVis! >= _linesNeeded!) {
        _playbackLocationVis = _linesNeeded! - 1;
      }
      if (_playbackLocationVis! < 0) {
        _playbackLocationVis = 0;
      }
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
  void didUpdateWidget(covariant ZetaAudioVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.assetPath != oldWidget.assetPath || widget.url != oldWidget.url) {
      unawaited(resetPlayback());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    unawaited(_initializeAudioPlayer());
    if (_localFile == null) {
      unawaited(_loadLocalFile());
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    // Reset playback when the app is reassembled (hot reload)
    unawaited(resetPlayback());
  }

  void onVisualizerInteraction(Offset position, BuildContext context) {
    final box = _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (_duration == null || _linesNeeded == null || box == null) {
      return;
    }
    setState(() => _playbackLocation = position.dx / box.size.width);
    unawaited(_audioPlayer?.seek(Duration(milliseconds: (_duration!.inMilliseconds * _playbackLocation).round())));
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    final fg = widget.foregroundColor ?? zeta.colors.mainDefault;
    final bg = widget.backgroundColor ?? zeta.colors.surfaceHover;
    final playButtonColor = widget.playButtonColor ?? zeta.colors.mainPrimary;
    final tertiaryColor = widget.tertiaryColor ?? zeta.colors.mainLight;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(zeta.radius.rounded),
        color: bg,
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
                  color: playButtonColor,
                  borderRadius: BorderRadius.all(zeta.radius.full),
                ),
                child: Center(
                  child: AnimatedCrossFade(
                    firstChild: Icon(ZetaIcons.play, color: bg),
                    secondChild: Icon(ZetaIcons.pause, color: bg),
                    duration: const Duration(milliseconds: 100),
                    crossFadeState: _playing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragUpdate: (details) => onVisualizerInteraction(details.localPosition, context),
              onTapDown: (details) => onVisualizerInteraction(details.localPosition, context),
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
                    mainAxisSize: MainAxisSize.min,
                    key: _rowKey,
                    children: _amplitudes.mapIndexed<Widget>(
                      (int index, double amplitude) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          width: 2,
                          height: (amplitude * 32).clamp(2, 32),
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: (_playbackLocationVis ?? 0) > index ? fg : tertiaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: zeta.spacing.small, right: zeta.spacing.medium),
            child: Text(
              '${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: zeta.textStyles.labelMedium.apply(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}
