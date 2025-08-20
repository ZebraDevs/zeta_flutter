// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:record/record.dart';

class RecordingState extends ChangeNotifier {
  RecordingState({
    required this.recordConfig,
    required this.maxRecordingDuration,
    required this.warningDuration,
  }) {
    unawaited(
      _record.hasPermission().then((b) {
        _canRecord = b;
        notifyListeners();
      }),
    );
  }

  final RecordConfig recordConfig;
  final AudioRecorder _record = AudioRecorder();
  final Duration maxRecordingDuration;
  final Duration warningDuration;

  Uint8List? rawAudioChunks;
  Timer? _recordingTimer;
  bool? _canRecord;

  /// Whether recording is allowed (based on permissions)
  bool get canRecord => _canRecord ?? false;

  bool _isRecording = false;
  bool get isRecording => _isRecording;
  set isRecording(bool value) {
    if (value != _isRecording) {
      _isRecording = value;
      notifyListeners();
    }
  }

  Duration? _duration;
  Duration? get duration => _duration;
  set duration(Duration? value) {
    if (value != _duration && value?.inMilliseconds != _duration?.inMilliseconds) {
      _duration = value;
      notifyListeners();
    }
  }

  bool _showWarning = false;
  bool get showWarning => _showWarning;
  set showWarning(bool value) {
    if (value != _showWarning) {
      _showWarning = value;
      notifyListeners();
    }
  }

  Stream<Uint8List>? _stream;
  Stream<Uint8List>? get stream => _stream;
  set stream(Stream<Uint8List>? value) {
    _stream = value;
    rawAudioChunks = Uint8List(0);
    _stream?.listen((onData) {
      final prev = rawAudioChunks ?? Uint8List(0);
      final combined = Uint8List(prev.length + onData.length)
        ..setAll(0, prev)
        ..setAll(prev.length, onData);
      rawAudioChunks = combined;
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
    rawAudioChunks = null;
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
    }
    showWarning = false;
  }

  /// Resume recording
  Future<void> resumeRecording() async {
    if (!_isRecording && canRecord) {
      await _record.resume();
      startTrackingDuration();
    }
  }
}
