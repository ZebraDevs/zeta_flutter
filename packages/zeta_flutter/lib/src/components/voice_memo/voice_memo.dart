import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

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
    this.recordingNotAllowedLabel = 'Recording not allowed.',
    this.onDiscard,
    this.onSend,
    this.canRecord = true,
    this.maxRecordingDuration = const Duration(seconds: 120),
    this.warningDuration = const Duration(seconds: 15),
  }) : assert(warningDuration < maxRecordingDuration, 'maxRecordingDuration must be greater than warningDuration');

  /// The label shown when recording a voice memo.
  ///
  /// Defaults to 'Recoding message...'.
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
  final Function(Stream<Uint8List> audioStream)? onSend;

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
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDelete', onDiscard))
      ..add(DiagnosticsProperty<bool>('canRecord', canRecord))
      ..add(DiagnosticsProperty<Duration>('maxRecordingDuration', maxRecordingDuration))
      ..add(DiagnosticsProperty<Duration>('warningDuration', warningDuration))
      ..add(StringProperty('recordingNotAllowedLabel', recordingNotAllowedLabel))
      ..add(ObjectFlagProperty<Function(Stream<Uint8List> audioStream)?>.has('onSend', onSend));
  }
}

class _ZetaVoiceMemoState extends State<ZetaVoiceMemo> {
  final _record = AudioRecorder();
  bool _canRecord = false;
  Duration? _duration;
  Stream<Uint8List>? _stream;
  bool _isRecording = false;
  bool _showWarning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.canRecord) {
        final hasPermission = await _record.hasPermission();
        if (hasPermission) {
          setState(() => _canRecord = true);
        }
      }
    });
  }

  @override
  void dispose() {
    unawaited(_record.dispose());
    super.dispose();
  }

  Future<void> startRecording() async {
    if (_canRecord) {
      _stream = await _record.startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
      _duration = Duration.zero;
      trackRecording();
    }
  }

  void trackRecording() {
    setState(() {
      _isRecording = true;
      _startedRecording = true;
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isRecording) {
        timer.cancel();
        return;
      }
      _duration = _duration! + const Duration(seconds: 1);
      if (_duration! >= widget.maxRecordingDuration - widget.warningDuration) {
        _showWarning = true;
      }
      setState(() {});
    });
  }

  Future<void> pauseRecording() async {
    if (_isRecording) {
      await _record.pause();
      setState(() => _isRecording = false);
    }
  }

  Future<void> resumeRecording() async {
    if (!_isRecording && _canRecord) {
      await _record.resume();
      trackRecording();
    }
  }

  void restartRecording() {
    _stream = null;
    _duration = Duration.zero;
    _isRecording = false;
    setState(() {});
  }

  bool _startedRecording = true;

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
                    _showWarning
                        ? widget.maxLimitLabel.replaceAll(
                            '{timer}',
                            (widget.maxRecordingDuration.inSeconds - _duration!.inSeconds).toString(),
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
              ZetaAudioVisualizer(
                isRecording: true,
                // key: _audioVisualizerKey,
                audioDuration: _duration,
                audioStream: _stream,
                maxRecordingDuration: widget.maxRecordingDuration,
              ).paddingHorizontal(zeta.spacing.xl_2),
              const SizedBox(height: 17),
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
                          onPressed: _canRecord
                              ? () {
                                  restartRecording();
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
                          onPressed: _canRecord ? restartRecording : null,
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: _canRecord ? null : zeta.colors.surfaceDisabled,
                    borderRadius: BorderRadius.all(zeta.radius.full),
                    child: InkWell(
                      borderRadius: BorderRadius.all(zeta.radius.full),
                      onTap: _canRecord
                          ? () {
                              if (_isRecording) {
                                unawaited(pauseRecording());
                              } else if (_duration != null) {
                                unawaited(resumeRecording());
                              } else {
                                unawaited(startRecording());
                              }
                            }
                          : null,
                      child: ZetaProgressCircle(
                        size: ZetaCircleSizes.l,
                        progress: _canRecord && _duration != null
                            ? _duration!.inMilliseconds / widget.maxRecordingDuration.inMilliseconds
                            : 0,
                        child: IconTheme(
                          data: IconThemeData(color: _canRecord ? zeta.colors.mainDefault : zeta.colors.mainDisabled),
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            ZetaIcons.send,
                            size: Zeta.of(context).spacing.xl_6,
                            // color: Zeta.of(context).colors.mainPrimary,
                          ),
                          color: Zeta.of(context).colors.mainPrimary,
                          onPressed: (_canRecord && _duration != null)
                              ? () {
                                  widget.onSend?.call(_stream!);
                                }
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
          if (!_canRecord)
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
