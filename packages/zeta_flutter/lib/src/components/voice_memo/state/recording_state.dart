import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:record/record.dart';
import '../voice_memo.dart';
import 'playback_state.dart';

/// State class for managing audio recording in the [ZetaVoiceMemo].
class RecordingState extends ChangeNotifier {
  /// Constructs a [RecordingState].
  RecordingState({
    required this.recordConfig,
    required this.maxRecordingDuration,
    required this.warningDuration,
    required this.loudnessMultiplier,
    required this.playbackState,
  }) {
    unawaited(
      _record.hasPermission().then((b) {
        _canRecord = b;
        notifyListeners();
      }),
    );
  }

  /// Configuration for the audio recording
  ///
  /// See Record package for more information.
  final RecordConfig recordConfig;

  /// Maximum duration for recording.
  final Duration maxRecordingDuration;

  /// Duration for which a warning is shown before reaching the maximum recording duration.
  final Duration warningDuration;

  /// Multiplier for loudness visualization.
  final double loudnessMultiplier;

  /// State of the audio playback
  final PlaybackState playbackState;

  Uint8List? _rawAudioChunks;
  Timer? _recordingTimer;
  bool? _canRecord;
  final AudioRecorder _record = AudioRecorder();

  /// Whether recording is allowed (based on permissions)
  bool get canRecord => _canRecord ?? false;

  bool _isRecording = false;

  /// Whether the audio is currently being recorded.
  bool get isRecording => _isRecording;
  set isRecording(bool value) {
    if (value != _isRecording) {
      _isRecording = value;
      notifyListeners();
    }
  }

  Duration? _duration;

  /// The current duration of the recording.
  Duration? get duration => _duration;
  set duration(Duration? value) {
    if (value?.inMilliseconds != _duration?.inMilliseconds) {
      _duration = value;
      notifyListeners();
    }
  }

  bool _showWarning = false;

  /// Whether the UI should show the warning about reaching the maximum recording duration.
  bool get showWarning => _showWarning;
  set showWarning(bool value) {
    if (value != _showWarning) {
      _showWarning = value;
      notifyListeners();
    }
  }

  Stream<Uint8List>? _stream;

  /// The stream of audio.
  Stream<Uint8List>? get stream => _stream;
  set stream(Stream<Uint8List>? value) {
    _stream = value;
    _rawAudioChunks = Uint8List(0);
    _stream?.listen((onData) {
      if (_rawAudioChunks == null || _rawAudioChunks!.isEmpty) {
        _rawAudioChunks = onData;
      } else {
        final prev = _rawAudioChunks!;
        final combined = Uint8List(prev.length + onData.length)
          ..setAll(0, prev)
          ..setAll(prev.length, onData);
        _rawAudioChunks = combined;
      }
    });
  }

  /// Dispose of resources
  @override
  void dispose() {
    resetRecording();
    unawaited(_record.dispose());
    super.dispose();
  }

  /// Reset recording state
  void resetRecording() {
    unawaited(_stream?.drain<void>());
    _stream = null;
    _showWarning = false;
    _duration = null;
    _recordingTimer?.cancel();
    _isRecording = false;
    _recordingTimer = null;
    _rawAudioChunks = null;
    unawaited(_record.cancel());
    notifyListeners();
  }

  /// Start recording audio
  Future<void> startRecording() async {
    if (!canRecord) return;
    stream = await _record.startStream(recordConfig);
    duration = Duration.zero;
    startTrackingDuration();
  }

  /// Start tracking recording duration
  void startTrackingDuration() {
    isRecording = true;
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isRecording || _duration == null) {
        timer.cancel();
        return;
      }
      duration = _duration! + const Duration(milliseconds: 100);
      if (_duration! >= maxRecordingDuration - warningDuration) {
        showWarning = true;
      }
      if (_duration! >= maxRecordingDuration) {
        unawaited(pauseRecording());
        showWarning = false;
      }
    });
  }

  /// Pause recording
  Future<void> pauseRecording() async {
    if (_isRecording) {
      await _record.pause();
      isRecording = false;
      _recordingTimer?.cancel();
      if (_rawAudioChunks != null) {
        await playbackState.loadAudio(
          audioChunks: [_rawAudioChunks!],
          recordConfig: recordConfig,
        );
        await playbackState.resetPlayback();
      }
    }
    showWarning = false;
  }

  /// Resume recording
  Future<void> resumeRecording() async {
    if (!_isRecording && canRecord) {
      await _record.resume();
      playbackState.duration = null;
      startTrackingDuration();
    }
  }
}
