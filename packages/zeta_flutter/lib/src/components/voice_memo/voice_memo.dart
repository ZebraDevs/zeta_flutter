import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

export './audio_visualizer.dart';

/// A slide-up sheet that appears when recording a voice message in chat. It shows the recording time, waveform, and buttons to stop, send, or cancel the memo.
class ZetaVoiceMemo extends ZetaStatefulWidget {
  /// Constructs a [ZetaVoiceMemo].
  const ZetaVoiceMemo({
    super.key,
    this.recordingLabel = 'Recording message...',
    this.maxLimitLabel = 'Recording message {timer} seconds left...',
    this.sendMessageLabel = 'Send message?',
    this.playingLabel = 'Playing...',
    this.onDelete,
    this.onRestart,
    this.onRecord,
    this.onPauseRecording,
    this.onSend,
    this.canRecord = true,
    this.maxRecordingDuration = const Duration(seconds: 120),
    this.warningDuration = const Duration(seconds: 15),
  });

  /// The label shown when recording a voice memo.
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
  /// {@macro zeta-widget-translations}
  final String playingLabel;

  /// Callback for when the delete button is pressed.
  final VoidCallback? onDelete;

  /// Callback for when the restart button is pressed.
  final VoidCallback? onRestart;

  /// Callback for when the record button is pressed.
  final VoidCallback? onRecord;

  /// Callback for when the pause recording button is pressed.
  final VoidCallback? onPauseRecording;

  /// Callback for when the send button is pressed.
  final VoidCallback? onSend;

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
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDelete', onDelete))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onRestart', onRestart))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onRecord', onRecord))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSend', onSend))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPauseRecording', onPauseRecording))
      ..add(DiagnosticsProperty<bool>('canRecord', canRecord))
      ..add(DiagnosticsProperty<Duration>('maxRecordingDuration', maxRecordingDuration))
      ..add(DiagnosticsProperty<Duration>('warningDuration', warningDuration));
  }
}

class _ZetaVoiceMemoState extends State<ZetaVoiceMemo> {
  bool _isRecording = false;
  bool _showWarning = false;
  bool _startedRecording = true;
  final Duration _timerDuration = const Duration(seconds: 105);

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(zeta.radius.rounded),
        color: Zeta.of(context).colors.surfaceDefault,
      ),
      child: Column(
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
                _showWarning
                    ? widget.maxLimitLabel.replaceAll(
                        '{timer}',
                        Duration(
                          milliseconds: widget.maxRecordingDuration.inMilliseconds - _timerDuration.inMilliseconds,
                        ).inSeconds.toString(),
                      )
                    : _startedRecording
                        ? widget.sendMessageLabel
                        : widget.recordingLabel,
                style: zeta.textStyles.labelSmall.copyWith(
                  color: _showWarning ? zeta.colors.mainNegative : zeta.colors.mainSubtle,
                ),
              ),
            ],
          ),
          SizedBox(height: zeta.spacing.xl_2),
          const ZetaAudioVisualizer(isRecording: true).paddingHorizontal(zeta.spacing.xl_2),
          const SizedBox(height: 17),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      ZetaIcons.delete,
                      size: Zeta.of(context).spacing.xl_6,
                      color: Zeta.of(context).colors.mainNegative,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      ZetaIcons.refresh,
                      size: Zeta.of(context).spacing.xl_6,
                      color: Zeta.of(context).colors.mainDefault,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Material(
                color: widget.canRecord ? null : zeta.colors.surfaceDisabled,
                borderRadius: BorderRadius.all(zeta.radius.full),
                child: InkWell(
                  borderRadius: BorderRadius.all(zeta.radius.full),
                  onTap: widget.canRecord
                      ? () {
                          if (_isRecording) {
                            widget.onPauseRecording?.call();
                          } else {
                            widget.onRecord?.call();
                          }

                          setState(() => _isRecording = !_isRecording);
                        }
                      : null,
                  child: ZetaProgressCircle(
                    size: ZetaCircleSizes.l,
                    progress: widget.canRecord ? 0.5 : 0,
                    child: IconTheme(
                      data: IconThemeData(color: widget.canRecord ? zeta.colors.mainDefault : zeta.colors.mainDisabled),
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 150),
                        secondChild: const Icon(ZetaIcons.pause),
                        firstChild: const Icon(ZetaIcons.microphone),
                        crossFadeState: _isRecording ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 64),
                  IconButton(
                    icon: Icon(
                      ZetaIcons.send,
                      size: Zeta.of(context).spacing.xl_6,
                      color: Zeta.of(context).colors.mainPrimary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ).paddingHorizontal(zeta.spacing.large),
          SizedBox(height: zeta.spacing.xl_2),
        ],
      ),
    );
  }
}
