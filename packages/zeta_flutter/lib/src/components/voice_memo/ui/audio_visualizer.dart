import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../../../zeta_flutter.dart';
import '../state/audio_helpers.dart';
import '../state/audio_visualizer_helpers.dart';
import 'play_button.dart';
import 'waveform.dart';

/// Audio Visualizer used within the [ZetaVoiceMemo] component.
class ZetaAudioVisualizer extends ZetaStatefulWidget {
  /// Constructs a [ZetaAudioVisualizer].
  const ZetaAudioVisualizer({
    super.key,
    super.rounded,
    this.assetPath,
    this.url,
    this.deviceFilePath,
    this.backgroundColor,
    this.foregroundColor,
    this.tertiaryColor,
    this.playButtonColor,
    this.audioDuration,
    this.onPause,
    this.onPlay,
    this.errorMessage = 'Audio cannot be played',
  })  : assert(
          assetPath != null || url != null || deviceFilePath != null,
          'Audio source required: provide assetPath, url, or deviceFilePath',
        ),
        audioStream = null,
        isRecording = false,
        maxRecordingDuration = null,
        recordConfig = null;

  /// Constructs a [ZetaAudioVisualizer] for [ZetaVoiceMemo].
  const ZetaAudioVisualizer.voiceMemo({
    required this.isRecording,
    this.maxRecordingDuration,
    this.recordConfig,
    this.onPlay,
    this.onPause,
    super.key,
    super.rounded,
    this.audioStream,
    this.audioDuration,
    this.errorMessage = 'Audio cannot be played',
  })  : assetPath = null,
        url = null,
        deviceFilePath = null,
        backgroundColor = null,
        foregroundColor = null,
        tertiaryColor = null,
        playButtonColor = null;

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
  final RecordConfig? recordConfig;

  /// Callback when the play button is pressed.
  final VoidCallback? onPlay;

  /// Callback when the pause button is pressed.
  final VoidCallback? onPause;

  /// Error message to display when audio can not be played.
  final String errorMessage;

  @override
  State<ZetaAudioVisualizer> createState() => ZetaAudioVisualizerState();

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
      ..add(DiagnosticsProperty<RecordConfig>('recordConfig', recordConfig))
      ..add(StringProperty('errorMessage', errorMessage));
  }
}

/// State for the audio visualizer component.
///
/// This should not be called directly, and is only public for state management reasons.
class ZetaAudioVisualizerState extends State<ZetaAudioVisualizer> {
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

  /// Clears the recorded audio from the state.
  void clearVisualizerAudio() {
    _audioChunks.clear();
    _amplitudesNotifier.value = [];
    _playbackLocationVis = 0;
  }

  @override
  void didUpdateWidget(covariant ZetaAudioVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.audioStream != null && oldWidget.audioStream == null) {
      widget.audioStream!.listen(_audioChunks.add);
    }
    if (!widget.isRecording && oldWidget.isRecording) {
      _playbackLocationVis = 0;
      unawaited(_resetPlayback());
    } else if (widget.isRecording && !oldWidget.isRecording) {
      unawaited(_playbackManager.pause());
    }
  }

  Future<void> _initializePlayer() async {
    await _playbackManager.initialize(
      onComplete: () {
        widget.onPause?.call();
        unawaited(_resetPlayback());
      },
      onPositionChanged: _updatePlaybackLocation,
    );
    unawaited(_resetPlayback());
  }

  Future<void> _resetPlayback() async {
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
    await AudioVisualizerHelpers.getAmplitudes(
      playbackManager: _playbackManager,
      linesNeeded: _linesNeeded,
      audioChunks: _audioChunks,
      amplitudesNotifier: _amplitudesNotifier,
    );
  }

  void _updatePlaybackLocation(Duration position) {
    AudioVisualizerHelpers.updatePlaybackLocation(
      playbackManager: _playbackManager,
      linesNeeded: _linesNeeded,
      setPlaybackLocation: (val) => setState(() => _playbackLocationVis = val),
      position: position,
    );
  }

  Future<void> _calculateWaveform(BoxConstraints constraints) async {
    await AudioVisualizerHelpers.calculateWaveform(
      mounted: mounted,
      constraints: constraints,
      audioDuration: widget.audioDuration,
      audioChunks: _audioChunks,
      recordConfig: widget.recordConfig,
      linesNeeded: _linesNeeded,
      amplitudesNotifier: _amplitudesNotifier,
      isRecording: widget.isRecording,
      maxRecordingDuration: widget.maxRecordingDuration,
      setLinesNeeded: (val) => setState(() => _linesNeeded = val),
      setPlaybackLocation: (val) => setState(() => _playbackLocationVis = val),
      debouncer: _debouncer,
      setDebouncer: (val) => _debouncer = val,
      getAmplitudes: _getAmplitudes,
    );
  }

  void _onVisualizerInteraction(Offset position) {
    AudioVisualizerHelpers.onVisualizerInteraction(
      rowKey: _rowKey,
      playbackManager: _playbackManager,
      linesNeeded: _linesNeeded,
      position: position,
    );
  }

  void _togglePlayback() {
    unawaited(
      AudioVisualizerHelpers.togglePlayback(
        playing: _playing,
        onPlay: widget.onPlay,
        onPause: widget.onPause,
        playbackManager: _playbackManager,
        setPlaying: ({required bool playing}) => setState(() => _playing = playing),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final fg = widget.foregroundColor ?? zeta.colors.mainDefault;
    final bg = widget.backgroundColor ?? zeta.colors.surfaceHover;
    final playButtonColor = widget.playButtonColor ?? zeta.colors.mainPrimary;
    final tertiaryColor = widget.tertiaryColor ?? zeta.colors.mainLight;
    final duration = widget.isRecording && widget.audioDuration != null
        ? widget.audioDuration!
        : (_playbackManager.currentPosition == Duration.zero && (_playbackManager.loadedAudio ?? false)
            ? _playbackManager.duration
            : _playbackManager.currentPosition);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(zeta.radius.rounded),
            color: bg,
          ),
          padding: EdgeInsets.all(zeta.spacing.minimum),
          child: Row(
            children: [
              AnimatedSize(
                duration: ZetaAnimationLength.fast,
                child: SizedBox(
                  width: widget.isRecording ? 0 : null,
                  child: PlayButton(
                    key: const ValueKey('playButton'),
                    isPlaying: _playing,
                    onTap: (_playbackManager.loadedAudio ?? false) ? _togglePlayback : null,
                    playButtonColor: playButtonColor,
                    iconColor: bg,
                  ),
                ),
              ),
              Expanded(
                child: Waveform(
                  playedColor: fg,
                  unplayedColor: tertiaryColor,
                  amplitudesNotifier: _amplitudesNotifier,
                  playbackLocationVis: _playbackLocationVis,
                  onInteraction: _onVisualizerInteraction,
                  onLayoutChange: _calculateWaveform,
                  key: _rowKey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: zeta.spacing.small,
                  right: zeta.spacing.medium,
                  top: zeta.spacing.large - ZetaBorders.medium,
                  bottom: zeta.spacing.large - ZetaBorders.medium,
                ),
                child: Text(
                  duration?.minutesSeconds ?? '0:00',
                  style: zeta.textStyles.labelMedium.apply(color: fg),
                ),
              ),
            ],
          ),
        ),
        if (_playbackManager.loadedAudio == false &&
            !widget.isRecording &&
            ([widget.assetPath, widget.url, widget.deviceFilePath].any((source) => source != null)))
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(zeta.radius.rounded),
                color: Zeta.of(context).colors.surfaceDefault.withAlpha(200),
              ),
              child: Center(child: Text(widget.errorMessage)),
            ),
          ),
      ],
    );
  }
}
