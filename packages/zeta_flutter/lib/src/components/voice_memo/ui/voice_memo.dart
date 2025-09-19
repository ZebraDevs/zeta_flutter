import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../../../zeta_flutter.dart';
import '../state/playback_state.dart';
import '../state/recording_state.dart';
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
    this.sendActionIcon = ZetaIcons.send,
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
  });

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

  /// The icon to show on the trailing action
  ///
  /// {@macro zeta-widget-translations}
  final IconData sendActionIcon;

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
  final void Function(Uint8List audioStream)? onSend;

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
  final double loudnessMultiplier;

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
      ..add(ObjectFlagProperty<void Function(Uint8List audioStream)?>.has('onSend', onSend))
      ..add(DiagnosticsProperty<RecordConfig>('recordConfig', recordConfig))
      ..add(DoubleProperty('loudnessMultiplier', loudnessMultiplier))
      ..add(DiagnosticsProperty<IconData>('sendActionIcon', sendActionIcon));
  }
}

class _ZetaVoiceMemoState extends State<ZetaVoiceMemo> {
  Key _visualizerKey = UniqueKey();
  String _voiceMemoLabel(RecordingState state, PlaybackState playbackState) {
    if (state.showWarning) {
      final secondsLeft = state.maxRecordingDuration.inSeconds - (state.duration?.inSeconds ?? 0);
      return widget.maxLimitLabel.replaceAll('{timer}', secondsLeft.toString());
    } else if (playbackState.playing) {
      return widget.playingLabel;
    } else if (state.duration != null && state.duration!.inMilliseconds > 0) {
      return widget.sendMessageLabel;
    } else {
      return widget.recordingLabel;
    }
  }

  Future<void> _clearAudio(BuildContext context, {bool discard = false}) async {
    context.read<RecordingState>().resetRecording();
    context.read<PlaybackState>().reset();
    setState(() => _visualizerKey = UniqueKey());
    if (discard) widget.onDiscard?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlaybackState>(
      create: (_) => PlaybackState(),
      builder: (context, _) => ChangeNotifierProvider<RecordingState>(
        create: (context) => RecordingState(
          recordConfig: widget.recordConfig,
          maxRecordingDuration: widget.maxRecordingDuration,
          warningDuration: widget.warningDuration,
          loudnessMultiplier: widget.loudnessMultiplier,
          playbackState: context.read<PlaybackState>(),
        ),
        builder: (context, _) => Consumer2<RecordingState, PlaybackState>(
          builder: (context, state, playbackState, _) {
            final zeta = Zeta.of(context);
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(zeta.radius.rounded),
                color: zeta.colors.surfaceDefault,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: zeta.spacing.xl_2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.showWarning)
                            Icon(
                              ZetaIcons.error_outline,
                              size: zeta.spacing.large,
                              color: zeta.colors.mainNegative,
                            ),
                          Text(
                            _voiceMemoLabel(state, playbackState),
                            style: zeta.textStyles.labelSmall.copyWith(
                              color: state.showWarning ? zeta.colors.mainNegative : zeta.colors.mainSubtle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: zeta.spacing.xl_2),
                      ZetaAudioVisualizer(
                        key: _visualizerKey,
                        isRecording: state.isRecording || state.duration == null,
                        rounded: widget.rounded,
                      ).paddingHorizontal(zeta.spacing.xl_2),
                      SizedBox(height: zeta.spacing.xl),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ZetaBorders.medium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                spacing: zeta.spacing.small,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      ZetaIcons.delete,
                                      size: zeta.spacing.xl_6,
                                      color: zeta.colors.mainNegative,
                                    ),
                                    padding: EdgeInsets.all(zeta.spacing.minimum),
                                    onPressed: state.canRecord ? () => _clearAudio(context, discard: true) : null,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      ZetaIcons.refresh,
                                      size: zeta.spacing.xl_6,
                                      color: zeta.colors.mainDefault,
                                    ),
                                    padding: EdgeInsets.all(zeta.spacing.minimum),
                                    onPressed: state.canRecord ? () => _clearAudio(context) : null,
                                  ),
                                ],
                              ),
                            ),
                            const RecordingControl(),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(widget.sendActionIcon, size: zeta.spacing.xl_6),
                                    padding: EdgeInsets.all(zeta.spacing.minimum),
                                    color: zeta.colors.mainPrimary,
                                    onPressed: (state.canRecord &&
                                            state.duration != null &&
                                            playbackState.audioChunks != null &&
                                            !state.isRecording)
                                        ? () => widget.onSend?.call(playbackState.audioChunks!)
                                        : null,
                                    disabledColor: zeta.colors.mainDisabled,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).paddingHorizontal(zeta.spacing.large),
                      ),
                      SizedBox(height: zeta.spacing.xl_2),
                    ],
                  ),
                  if (!state.canRecord || !widget.canRecord)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(zeta.radius.rounded),
                          color: zeta.colors.surfaceDefault.withAlpha(200),
                        ),
                        child: Center(child: Text(widget.recordingNotAllowedLabel)),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
