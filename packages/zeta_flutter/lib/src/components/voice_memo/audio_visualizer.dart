import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../../zeta_flutter.dart';
import 'audio_helpers.dart';

// TODO(luke): Add device media
// TODO(luke): Ensure this works on web?

/// Audio Visualizer used within the [ZetaVoiceMemo] component.
class ZetaAudioVisualizer extends ZetaStatefulWidget {
  /// Constructs a [ZetaAudioVisualizer].
  const ZetaAudioVisualizer({
    super.key,
    super.rounded,
    this.assetPath,
    this.url,
    this.deviceFilePath,
    this.audioStream,
    this.backgroundColor,
    this.foregroundColor,
    this.tertiaryColor,
    this.playButtonColor,
    this.isRecording = false,
    this.audioDuration,
    this.maxRecordingDuration,
    this.recordConfig = const RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      bitRate: 16000,
      sampleRate: 16000,
      numChannels: 1,
    ),
    // Callbacks
    this.onPause,
    this.onPlay,
  }) : assert(
          assetPath != null || url != null || deviceFilePath != null || audioStream != null || isRecording,
          'Audio source required: provide assetPath, url, deviceFilePath, audioStream, or set isRecording=true',
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

  /// A stream of audio data to visualize.
  ///
  /// Used in [ZetaVoiceMemo] when recording audio. This stream should emit
  /// integers representing audio samples. If this is provided, the [audioDuration]
  /// should also be set to indicate the maximum duration of the audio being visualized.
  final Stream<Uint8List>? audioStream;

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

  /// The duration of the audio stream being visualized.
  ///
  /// This must be provided when [audioStream] is provided.
  final Duration? audioDuration;

  /// The maximum duration of the audio stream being recorded.
  ///
  /// This must be provided when [audioStream] is provided.
  final Duration? maxRecordingDuration;

  /// Configuration for audio recorder from [Record] package.
  ///
  /// For the package to work correctly, audio *must* be [AudioEncoder.pcm16bits].
  /// This is a limitation of the package currently.
  /// If you require a different format, please submit a PR!
  ///
  /// See [Record](https://pub.dev/packages/record).
  final RecordConfig recordConfig;

  // Callbacks

  /// Callback when the play button is pressed.
  final VoidCallback? onPlay;

  /// Callback when the pause button is pressed.
  final VoidCallback? onPause;

  @override
  State<ZetaAudioVisualizer> createState() => _ZetaAudioVisualizerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('assetPath', assetPath))
      ..add(StringProperty('url', url))
      ..add(StringProperty('deviceFilePath', deviceFilePath))
      ..add(DiagnosticsProperty<bool>('isRecording', isRecording))
      ..add(DiagnosticsProperty<Stream<Uint8List>?>('audioStream', audioStream))
      ..add(DiagnosticsProperty<Duration?>('audioDuration', audioDuration))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPlay', onPlay))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPause', onPause))
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(ColorProperty('tertiaryColor', tertiaryColor))
      ..add(ColorProperty('playButtonColor', playButtonColor))
      ..add(DiagnosticsProperty<Duration?>('maxRecordingDuration', maxRecordingDuration))
      ..add(DiagnosticsProperty<RecordConfig>('recordConfig', recordConfig));
  }
}

class _ZetaAudioVisualizerState extends State<ZetaAudioVisualizer> {
  late final AudioPlaybackManager _playbackManager = AudioPlaybackManager();
  final ValueNotifier<List<double>> _amplitudesNotifier = ValueNotifier<List<double>>([]);
  final GlobalKey _rowKey = GlobalKey();
  final List<Uint8List> _audioChunks = [];

  Timer? _debouncer;
  int? _playbackLocationVis;
  int? _linesNeeded;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initializePlayer());
  }

  @override
  void dispose() {
    _amplitudesNotifier.dispose();
    unawaited(_playbackManager.dispose());
    _debouncer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ZetaAudioVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.audioStream != null && oldWidget.audioStream == null) {
      widget.audioStream!.listen(_audioChunks.add);
    }
    if (!widget.isRecording && oldWidget.isRecording) {
      _playbackLocationVis = 0;
      unawaited(resetPlayback());
    }
  }

  Future<void> _initializePlayer() async {
    await _playbackManager.initialize(
      onComplete: () {
        widget.onPause?.call();
        unawaited(resetPlayback());
      },
      onPositionChanged: _updatePlaybackLocation,
    );
    unawaited(resetPlayback());
  }

  Future<void> resetPlayback() async {
    _playing = false;
    await _playbackManager.loadAudio(
      assetPath: widget.assetPath,
      url: widget.url,
      deviceFilePath: widget.deviceFilePath,
      audioChunks: _audioChunks.isNotEmpty ? _audioChunks : null,
      recordConfig: _audioChunks.isNotEmpty ? widget.recordConfig : null,
    );
    await _playbackManager.resetPlayback();
    setState(() {});
    unawaited(_getAmplitudes());
  }

  Future<void> _getAmplitudes() async {
    if (_playbackManager.localFile == null || _linesNeeded == null || _linesNeeded! <= 0 || _audioChunks.isNotEmpty) {
      return;
    }
    final amplitudes = await extractWavAmplitudes(_playbackManager.localFile!, _linesNeeded!);
    _amplitudesNotifier.value = amplitudes ?? AudioWaveformCalculator.generateDefaultAmplitudes(_linesNeeded!);
  }

  void _updatePlaybackLocation(Duration position) {
    if (_playbackManager.duration == null || _linesNeeded == null) return;
    setState(() {
      _playbackLocationVis = AudioWaveformCalculator.calculatePlaybackPosition(
        currentPosition: position,
        totalDuration: _playbackManager.duration,
        linesNeeded: _linesNeeded!,
      );
    });
  }

  Future<void> _calculateWaveform(BoxConstraints constraints) async {
    if (!mounted) return;

    final lines = (constraints.maxWidth / 4).floor();

    if (widget.audioDuration != null && _audioChunks.isNotEmpty) {
      if (_linesNeeded != lines) _linesNeeded = lines;

      final waveforms = await AudioWaveformCalculator.calculateRecordingWaveform(
        audioChunks: _audioChunks,
        recordConfig: widget.recordConfig,
        linesNeeded: _linesNeeded!,
        audioDuration: widget.audioDuration!,
        maxRecordingDuration: widget.maxRecordingDuration!,
        isRecording: widget.isRecording,
      );

      _amplitudesNotifier.value = waveforms;
      if (widget.isRecording) _playbackLocationVis = _linesNeeded! - 1;
      return;
    }

    if (_linesNeeded == lines) return;

    _linesNeeded = lines;
    _amplitudesNotifier.value = List.generate(lines, (index) => 0.0);

    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () => unawaited(_getAmplitudes()));
  }

  void _onVisualizerInteraction(Offset position) {
    final box = _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (_playbackManager.duration == null || _linesNeeded == null || box == null) return;

    final seekPosition = AudioWaveformCalculator.calculateSeekPosition(
      gesturePosition: position,
      visualizerWidth: box.size.width,
      totalDuration: _playbackManager.duration,
    );
    unawaited(_playbackManager.seek(seekPosition));
  }

  void _togglePlayback() {
    if (_playing) {
      widget.onPause?.call();
      unawaited(_playbackManager.pause());
    } else {
      widget.onPlay?.call();
      unawaited(_playbackManager.play());
    }
    setState(() => _playing = !_playing);
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final fg = widget.foregroundColor ?? zeta.colors.mainDefault;
    final bg = widget.backgroundColor ?? zeta.colors.surfaceHover;
    final playButtonColor = widget.playButtonColor ?? zeta.colors.mainPrimary;
    final tertiaryColor = widget.tertiaryColor ?? zeta.colors.mainLight;
    final duration =
        widget.isRecording && widget.audioDuration != null ? widget.audioDuration! : _playbackManager.currentPosition;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(zeta.radius.rounded),
        color: bg,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          if (!widget.isRecording)
            _PlayButton(
              isPlaying: _playing,
              onTap: _togglePlayback,
              playButtonColor: playButtonColor,
              iconColor: bg,
            ),
          Expanded(
            child: _WaveformVisualizer(
              foregroundColor: fg,
              tertiaryColor: tertiaryColor,
              amplitudesNotifier: _amplitudesNotifier,
              playbackLocationVis: _playbackLocationVis,
              rowKey: _rowKey,
              onInteraction: _onVisualizerInteraction,
              onLayoutChange: (constraints) => unawaited(_calculateWaveform(constraints)),
              mounted: mounted,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: zeta.spacing.small,
              right: zeta.spacing.medium,
              top: 14,
              bottom: 14,
            ),
            child: Text(
              duration.minutesSeconds,
              style: zeta.textStyles.labelMedium.apply(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
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

class _WaveformVisualizer extends StatelessWidget {
  const _WaveformVisualizer({
    required this.foregroundColor,
    required this.tertiaryColor,
    required this.amplitudesNotifier,
    required this.playbackLocationVis,
    required this.rowKey,
    required this.onInteraction,
    required this.onLayoutChange,
    required this.mounted,
  });

  final Color foregroundColor;
  final Color tertiaryColor;
  final ValueNotifier<List<double>> amplitudesNotifier;
  final int? playbackLocationVis;
  final GlobalKey rowKey;
  final void Function(Offset) onInteraction;
  final void Function(BoxConstraints) onLayoutChange;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) => onInteraction(details.localPosition),
      onTapDown: (details) => onInteraction(details.localPosition),
      child: LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) onLayoutChange(constraints);
          });

          return ValueListenableBuilder<List<double>>(
            valueListenable: amplitudesNotifier,
            builder: (context, amplitudes, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  key: rowKey,
                  children: List.generate(amplitudes.length, (index) {
                    final amplitude = amplitudes[index];
                    return AnimatedContainer(
                      key: ValueKey(index),
                      duration: const Duration(milliseconds: 100),
                      width: 2,
                      height: (amplitude * 32).clamp(2, 32),
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: (playbackLocationVis ?? 0) > index ? foregroundColor : tertiaryColor,
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
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(ColorProperty('tertiaryColor', tertiaryColor))
      ..add(DiagnosticsProperty<ValueNotifier<List<double>>>('amplitudesNotifier', amplitudesNotifier))
      ..add(IntProperty('playbackLocationVis', playbackLocationVis))
      ..add(DiagnosticsProperty<GlobalKey<State<StatefulWidget>>>('rowKey', rowKey))
      ..add(ObjectFlagProperty<void Function(Offset p1)>.has('onInteraction', onInteraction))
      ..add(ObjectFlagProperty<void Function(BoxConstraints p1)>.has('onLayoutChange', onLayoutChange))
      ..add(DiagnosticsProperty<bool>('mounted', mounted));
  }
}
