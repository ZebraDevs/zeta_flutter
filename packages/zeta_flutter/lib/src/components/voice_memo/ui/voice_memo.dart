import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../../../zeta_flutter.dart';
import '../state/playback_manager.dart';
import '../state/recording_manager.dart';
import 'recording_control.dart';

export 'audio_visualizer.dart';

/// A slide-up sheet that appears when recording a voice message in chat. It shows the recording time, waveform, and buttons to stop, send, or cancel the memo.
class ZetaVoiceMemo extends ZetaStatefulWidget {
  /// Constructs a [ZetaVoiceMemo].
  const ZetaVoiceMemo({
    super.key,
    super.rounded,
    this.recordingLabel = 'Recording message...',
    this.maxLimitLabel = 'Recording message {timer} seconds left...',
    this.sendMessageLabel = 'Send message?',
    this.playingLabel = 'Playing...',
    this.recordingNotAllowedLabel = 'Recording not allowed.',
    this.onDiscard,
    this.onSend,
    this.canRecord = true,
    this.maxRecordingDuration = const Duration(seconds: 120),
    this.warningDuration = const Duration(seconds: 15),
    this.recordConfig = const RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: 16000,
      numChannels: 1,
      bitRate: 64000,
    ),
    this.loudnessMultiplier = 10,
  }) : assert(warningDuration < maxRecordingDuration, 'maxRecordingDuration must be greater than warningDuration');

  /// The label shown when recording a voice memo.
  ///
  /// Defaults to 'Recording message...'.
  ///
  /// {@template zeta-widget-translations}
  /// Zeta does not currently support translations, so this label should be passed in with the correct translation for the current locale.
  /// {@endtemplate}
  final String recordingLabel;

  /// The label shown when the voice memo exceeds the maximum limit.
  ///
  /// This label can show a countdown of when the voice memo will stop recording if it exceeds the limit.
  /// To do this, place {timer} in the label string. This will be replaced with the timer in seconds.
  ///
  /// For example: "Recording message {timer} seconds left...".
  ///
  /// {@macro zeta-widget-translations}
  final String maxLimitLabel;

  /// The label shown on the button to send the voice memo.
  ///
  /// {@macro zeta-widget-translations}
  final String sendMessageLabel;

  /// The label shown when the voice memo is playing.
  ///
  /// Defaults to 'Playing...'
  ///
  /// {@macro zeta-widget-translations}
  final String playingLabel;

  /// The label shown when recording is not allowed. Typically this will be due to permissions issues, but that is not always the case.
  ///
  /// Defaults to 'Recording not allowed'.
  ///
  /// {@macro zeta-widget-translations}
  final String recordingNotAllowedLabel;

  /// Callback for when the delete button is pressed.
  final VoidCallback? onDiscard;

  /// Callback for when the send button is pressed.
  final void Function(Stream<Uint8List> audioStream)? onSend;

  /// Whether the user can record a voice memo.
  final bool canRecord;

  /// The maximum duration for the voice memo recording.
  ///
  /// Defaults to 120 seconds.
  final Duration maxRecordingDuration;

  /// The duration from the end of the recording to when the warning should be shown.
  ///
  /// Defaults to 15 seconds.
  ///
  /// This is used to show a warning to the user that the recording is about to end.
  final Duration warningDuration;

  /// Configuration for audio recorder from [Record] package.
  ///
  /// For the package to work correctly, audio *must* be [AudioEncoder.pcm16bits].
  /// This is a limitation of the package currently.
  /// If you require a different format, please submit a PR!
  ///
  /// See [Record](https://pub.dev/packages/record).
  final RecordConfig recordConfig;

  /// Multiplier for the loudness of the waveform visualization during recording.
  ///
  /// If the waveform visualization is too small, increasing this value can help amplify the sound.
  final int loudnessMultiplier;

  @override
  State<ZetaVoiceMemo> createState() => _ZetaVoiceMemoState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('recordingLabel', recordingLabel))
      ..add(StringProperty('maxLimitLabel', maxLimitLabel))
      ..add(StringProperty('sendMessageLabel', sendMessageLabel))
      ..add(StringProperty('playingLabel', playingLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDelete', onDiscard))
      ..add(DiagnosticsProperty<bool>('canRecord', canRecord))
      ..add(DiagnosticsProperty<Duration>('maxRecordingDuration', maxRecordingDuration))
      ..add(DiagnosticsProperty<Duration>('warningDuration', warningDuration))
      ..add(StringProperty('recordingNotAllowedLabel', recordingNotAllowedLabel))
      ..add(ObjectFlagProperty<void Function(Stream<Uint8List> audioStream)?>.has('onSend', onSend))
      ..add(DiagnosticsProperty<RecordConfig>('recordConfig', recordConfig))
      ..add(IntProperty('loudnessMultiplier', loudnessMultiplier));
  }
}

class _ZetaVoiceMemoState extends State<ZetaVoiceMemo> {
  late final AudioRecordingManager _recordingManager;
  late final AudioPlaybackManager _playbackManager = AudioPlaybackManager();
  bool _showWarning = false;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _recordingManager = AudioRecordingManager(recordConfig: widget.recordConfig);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.canRecord) {
        await _recordingManager.initialize();
        setState(() {});
      }
    });
  }

  String getVoiceMemoLabel({
    required bool showWarning,
    required bool playing,
    required Duration? duration,
    required Duration maxRecordingDuration,
    required String maxLimitLabel,
    required String playingLabel,
    required String sendMessageLabel,
    required String recordingLabel,
  }) {
    if (showWarning) {
      final secondsLeft = maxRecordingDuration.inSeconds - (duration?.inSeconds ?? 0);
      return maxLimitLabel.replaceAll('{timer}', secondsLeft.toString());
    } else if (playing) {
      return playingLabel;
    } else if (duration != null && duration.inMilliseconds > 0) {
      return sendMessageLabel;
    } else {
      return recordingLabel;
    }
  }

  @override
  void dispose() {
    unawaited(_recordingManager.dispose());
    super.dispose();
  }

  Future<void> startRecording() async {
    await _recordingManager.startRecording();
    _recordingManager.startTrackingDuration(
      onDurationUpdate: () => setState(() {}),
      maxDuration: widget.maxRecordingDuration,
      warningDuration: widget.warningDuration,
      onWarning: () => setState(() => _showWarning = true),
      onMaxDurationReached: () => setState(() => _showWarning = true),
    );
  }

  Future<void> pauseRecording() async {
    await _recordingManager.pauseRecording();
    setState(() => _showWarning = false);
  }

  Future<void> resumeRecording() async {
    await _recordingManager.resumeRecording(
      onDurationUpdate: () => setState(() {}),
      maxDuration: widget.maxRecordingDuration,
      warningDuration: widget.warningDuration,
      onWarning: () => setState(() => _showWarning = true),
      onMaxDurationReached: () => setState(() => _showWarning = true),
    );
  }

  void reinitializeRecording() {
    _recordingManager.resetRecording(_playbackManager);
    setState(() => _showWarning = false);
  }

  /// Key to access the ZetaAudioVisualizer state
  GlobalKey<ZetaAudioVisualizerState> _visualizerKey = GlobalKey<ZetaAudioVisualizerState>();

  /// Completely clears all audio data and playback state (for delete button)
  Future<void> clearAudio() async {
    _recordingManager.resetRecording(_playbackManager);

    final visualizerState = _visualizerKey.currentState;
    if (visualizerState != null) {
      await visualizerState.clearVisualizerAudio();
    }
    _visualizerKey = GlobalKey();
    await _playbackManager.resetPlayback();
    setState(() {
      _showWarning = false;
      _playing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(zeta.radius.rounded),
        color: Zeta.of(context).colors.surfaceDefault,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: zeta.spacing.xl_2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Zeta.of(context).spacing.small,
                children: [
                  if (_showWarning)
                    Icon(
                      ZetaIcons.error_outline,
                      size: zeta.spacing.large,
                      color: zeta.colors.mainNegative,
                    ),
                  Text(
                    getVoiceMemoLabel(
                      showWarning: _showWarning,
                      playing: _playing,
                      duration: _recordingManager.duration,
                      maxRecordingDuration: widget.maxRecordingDuration,
                      maxLimitLabel: widget.maxLimitLabel,
                      playingLabel: widget.playingLabel,
                      sendMessageLabel: widget.sendMessageLabel,
                      recordingLabel: widget.recordingLabel,
                    ),
                    style: zeta.textStyles.labelSmall.copyWith(
                      color: _showWarning ? zeta.colors.mainNegative : zeta.colors.mainSubtle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: zeta.spacing.xl_2),
              ZetaAudioVisualizer.voiceMemo(
                key: _visualizerKey,
                isRecording: _recordingManager.isRecording || _recordingManager.duration == null,
                audioDuration: _recordingManager.duration,
                audioStream: _recordingManager.stream,
                maxRecordingDuration: widget.maxRecordingDuration,
                onPlay: () => setState(() => _playing = true),
                onPause: () => setState(() => _playing = false),
                recordConfig: widget.recordConfig,
                rounded: widget.rounded,
                loudnessMultiplier: widget.loudnessMultiplier,
              ).paddingHorizontal(zeta.spacing.xl_2),
              SizedBox(height: zeta.spacing.large + ZetaBorders.small),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            ZetaIcons.delete,
                            size: Zeta.of(context).spacing.xl_6,
                            color: Zeta.of(context).colors.mainNegative,
                          ),
                          onPressed: _recordingManager.canRecord
                              ? () async {
                                  await clearAudio();
                                  widget.onDiscard?.call();
                                }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(
                            ZetaIcons.refresh,
                            size: Zeta.of(context).spacing.xl_6,
                            color: Zeta.of(context).colors.mainDefault,
                          ),
                          onPressed: _recordingManager.canRecord
                              ? () async {
                                  await clearAudio();
                                  reinitializeRecording();
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                  RecordingControl(
                    recordingManager: _recordingManager,
                    maxRecordingDuration: widget.maxRecordingDuration,
                    onStartRecording: startRecording,
                    onPauseRecording: pauseRecording,
                    onResumeRecording: resumeRecording,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(ZetaIcons.send, size: Zeta.of(context).spacing.xl_6),
                          color: Zeta.of(context).colors.mainPrimary,
                          onPressed: (_recordingManager.canRecord && _recordingManager.duration != null)
                              ? () => widget.onSend?.call(_recordingManager.stream!)
                              : null,
                          disabledColor: Zeta.of(context).colors.mainDisabled,
                        ),
                      ],
                    ),
                  ),
                ],
              ).paddingHorizontal(zeta.spacing.large),
              SizedBox(height: zeta.spacing.xl_2),
            ],
          ),
          if (!_recordingManager.canRecord)
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
                child: Center(child: Text(widget.recordingNotAllowedLabel)),
              ),
            ),
        ],
      ),
    );
  }
}
