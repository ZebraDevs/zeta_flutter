import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../zeta_flutter.dart';
import '../state/playback_state.dart';
import '../state/recording_state.dart';
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
    this.isRecording = false,
    this.backgroundColor,
    this.foregroundColor,
    this.tertiaryColor,
    this.playButtonColor,
    this.onPause,
    this.onPlay,
    this.errorMessage = 'Audio cannot be played',
  });

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

  /// Callback when the play button is pressed.
  final VoidCallback? onPlay;

  /// Callback when the pause button is pressed.
  final VoidCallback? onPause;

  /// Error message to display when audio can not be played.
  final String errorMessage;

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
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPlay', onPlay))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPause', onPause))
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(ColorProperty('tertiaryColor', tertiaryColor))
      ..add(ColorProperty('playButtonColor', playButtonColor))
      ..add(StringProperty('errorMessage', errorMessage));
  }
}

class _ZetaAudioVisualizerState extends State<ZetaAudioVisualizer> {
  final GlobalKey _rowKey = GlobalKey();

  Widget _buildVisualizer(
    BuildContext context,
    PlaybackState state, {
    bool isRecording = false,
    Duration? recDuration,
  }) {
    final zeta = Zeta.of(context);
    final fg = widget.foregroundColor ?? zeta.colors.mainDefault;
    final bg = widget.backgroundColor ?? zeta.colors.surfaceHover;
    final playButtonColor = widget.playButtonColor ?? zeta.colors.mainPrimary;
    final tertiaryColor = widget.tertiaryColor ?? zeta.colors.mainLight;
    final duration = isRecording
        ? (recDuration ?? Duration.zero)
        : (state.playbackPercent == 0 && (state.loadedAudio ?? false)
            ? state.duration
            : Duration(milliseconds: state.playbackPercent * (state.duration?.inMilliseconds ?? 1) ~/ 1));

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
              if (!isRecording)
                AnimatedSize(
                  duration: ZetaAnimationLength.fast,
                  child: PlayButton(
                    key: const ValueKey('playButton'),
                    onTap: () async {
                      if (state.playing) {
                        widget.onPause?.call();
                        await state.pause();
                      } else {
                        widget.onPlay?.call();
                        await state.play();
                      }
                    },
                    playButtonColor: playButtonColor,
                    iconColor: bg,
                  ),
                ),
              Expanded(
                child: Stack(
                  children: [
                    if (widget.assetPath == null && widget.deviceFilePath == null && widget.url == null)
                      Positioned(child: Waveform(playedColor: fg)),
                    if (!isRecording)
                      Positioned(
                        child: ColoredBox(
                          color: bg,
                          child: Waveform(
                            playedColor: fg,
                            unplayedColor: tertiaryColor,
                            audioFile: state.localFile,
                            audioChunks: state.audioChunks,
                            onInteraction: (offset) {
                              final box = _rowKey.currentContext?.findRenderObject() as RenderBox?;
                              if (state.duration == null || box == null) return;
                              unawaited(state.seekFromPosition(offset, box.size.width, state.duration));
                            },
                            key: _rowKey,
                          ),
                        ),
                      ),
                  ],
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
        if (state.error ||
            (state.loadedAudio == false &&
                !isRecording &&
                ([widget.assetPath, widget.url, widget.deviceFilePath].any((source) => source != null))))
          Positioned.fill(
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

  @override
  Widget build(BuildContext context) {
    final isInRecordingProvider =
        context.findAncestorWidgetOfExactType<Consumer2<RecordingState, PlaybackState>>() != null;
    if (isInRecordingProvider) {
      return Consumer<RecordingState>(
        builder: (context, recordingState, _) {
          return Consumer<PlaybackState>(
            builder: (context, playbackState, __) => _buildVisualizer(
              context,
              playbackState,
              isRecording: recordingState.isRecording || recordingState.duration == null,
              recDuration: recordingState.duration,
            ),
          );
        },
      );
    } else {
      return ChangeNotifierProvider<PlaybackState>(
        create: (context) => PlaybackState(
          assetPath: widget.assetPath,
          deviceFilePath: widget.deviceFilePath,
          url: widget.url,
        ),
        child: Consumer<PlaybackState>(
          builder: (context, state, _) => _buildVisualizer(context, state),
        ),
      );
    }
  }
}
