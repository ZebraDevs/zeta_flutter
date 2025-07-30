import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'audio_helpers.dart';
import 'file_helpers.dart';

// TODO(luke): Add device media
// TODO(luke): Ensure this works on web?
// TODO(luke): Add the recording functionality

List<double> _generateDefaultAmplitudes(int linesNeeded) {
  const baseAmplitudes = [0, 0.375, 0.5, 1, 0.625, 1, 0.75, 0.75, 1, 1, 0.75, 1, 0.375, 0, 0, 0, 0, 0];
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
    this.audioStream,
    this.audioDuration,
    this.maxRecordingDuration,
  }) : assert(
          assetPath != null || url != null || deviceFilePath != null || isRecording,
          'Either assetPath, deviceFilePath, or url must be provided.',
          // ),
          // assert(
          //   (audioStream == null && audioDuration == null && maxRecordingDuration == null) ||
          //       (audioStream != null && audioDuration != null && maxRecordingDuration != null),
          //   'If audioStream is provided, audioDuration and maxRecordingDuration must also be provided.',
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

  /// A stream of audio data to visualize.
  ///
  /// Used in [ZetaVoiceMemo] when recording audio.
  ///
  /// This stream should emit integers representing audio samples.
  /// If this is provided, the [audioDuration] should also be set to indicate the
  /// maximum duration of the audio being visualized.
  final Stream<Uint8List>? audioStream;

  /// The duration of the audio stream being visualized.
  ///
  /// This must be provided when [audioStream] is provided.
  final Duration? audioDuration;

  /// The maximum duration of the audio stream being recorded.
  ///
  /// This must be provided when [audioStream] is provided.
  final Duration? maxRecordingDuration;

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
      ..add(DiagnosticsProperty<bool>('isRecording', isRecording))
      ..add(DiagnosticsProperty<Stream<Uint8List>?>('audioStream', audioStream))
      ..add(DiagnosticsProperty<Duration?>('audioDuration', audioDuration))
      ..add(DiagnosticsProperty<Duration?>('maxRecordingDuration', maxRecordingDuration));
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
  final ValueNotifier<List<double>> _amplitudesNotifier = ValueNotifier<List<double>>([]);
  Duration _currentPosition = Duration.zero;
  final GlobalKey _rowKey = GlobalKey();

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
    final List<double>? amplitudes = await extractWavAmplitudes(_localFile!, _linesNeeded!);
    if (amplitudes != null) {
      _amplitudesNotifier.value = amplitudes;
    } else {
      _amplitudesNotifier.value = _generateDefaultAmplitudes(_linesNeeded!);
    }
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

  Timer? _debouncer;

  void otherCalculateWaveform(BoxConstraints constraints) {
    final lines = (constraints.maxWidth / 4).floor();
    if (_linesNeeded != lines) {
      _linesNeeded = lines;
      unawaited(getAmplitudes());
    }
  }

  void calculateWaveform(BoxConstraints constraints) {
    if (!mounted) return;

    if (widget.audioDuration != null && _linesNeeded != null) {
      final duration = widget.audioDuration!;
      final durationPercentage = duration.inMilliseconds / (widget.maxRecordingDuration?.inMilliseconds ?? 1);
      final lines = (durationPercentage * _linesNeeded!).floor();
      final filledLines = _generateDefaultAmplitudes(lines);
      final unfilledLines = List<double>.filled(_linesNeeded! - lines, 0);
      _amplitudesNotifier.value = List.from(filledLines)..addAll(unfilledLines);
      _playbackLocationVis = (duration.inMilliseconds / widget.maxRecordingDuration!.inMilliseconds * _linesNeeded!)
          .clamp(0, _linesNeeded! - 1)
          .toInt();
    }

    final lines = (constraints.maxWidth / 4).floor();
    if (_linesNeeded == lines) return;

    _linesNeeded = lines;
    _amplitudesNotifier.value = List.generate(lines, (index) => 0.0);

    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () => unawaited(getAmplitudes()));
  }

  @override
  void initState() {
    super.initState();
    unawaited(resetPlayback());
  }

  @override
  void dispose() {
    _amplitudesNotifier.dispose();
    unawaited(_audioPlayer?.dispose());
    super.dispose();
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
    final Duration dur = widget.isRecording && widget.audioDuration != null ? widget.audioDuration! : _currentPosition;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(zeta.radius.rounded), color: bg),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          if (!widget.isRecording)
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
                builder: (BuildContext context, BoxConstraints constraints) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      calculateWaveform(constraints);
                    }
                  });

                  return ValueListenableBuilder<List<double>>(
                    valueListenable: _amplitudesNotifier,
                    builder: (BuildContext context, List<double> amplitudes, Widget? child) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          key: _rowKey,
                          children: List.generate(amplitudes.length, (index) {
                            final amplitude = amplitudes[index];
                            return AnimatedContainer(
                              key: ValueKey(index),
                              duration: const Duration(milliseconds: 100),
                              width: 2,
                              height: (amplitude * 32).clamp(2, 32),
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: (_playbackLocationVis ?? 0) > index ? fg : tertiaryColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: zeta.spacing.small, right: zeta.spacing.medium, top: 14, bottom: 14),
            child: Text(
              '${dur.inMinutes}:${(dur.inSeconds % 60).toString().padLeft(2, '0')}',
              style: zeta.textStyles.labelMedium.apply(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}
