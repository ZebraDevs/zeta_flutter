// Documentation not required as this is an internal file.
// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'audio_helpers.dart';

class AudioVisualizerHelpers {
  static Future<void> getAmplitudes({
    required AudioPlaybackManager playbackManager,
    required int? linesNeeded,
    required List<Uint8List> audioChunks,
    required ValueNotifier<List<double>> amplitudesNotifier,
  }) async {
    if (playbackManager.localFile == null || linesNeeded == null || linesNeeded <= 0 || audioChunks.isNotEmpty) {
      return;
    }
    final amplitudes = await extractWavAmplitudes(playbackManager.localFile!, linesNeeded);
    amplitudesNotifier.value = amplitudes ?? AudioWaveformCalculator.generateDefaultAmplitudes(linesNeeded);
  }

  static void updatePlaybackLocation({
    required AudioPlaybackManager playbackManager,
    required int? linesNeeded,
    required void Function(int) setPlaybackLocation,
    required Duration position,
  }) {
    if (playbackManager.duration == null || linesNeeded == null) return;
    setPlaybackLocation(
      AudioWaveformCalculator.calculatePlaybackPosition(
        currentPosition: position,
        totalDuration: playbackManager.duration,
        linesNeeded: linesNeeded,
      ),
    );
  }

  static Future<void> calculateWaveform({
    required bool mounted,
    required BoxConstraints constraints,
    required Duration? audioDuration,
    required List<Uint8List> audioChunks,
    required RecordConfig? recordConfig,
    required int? linesNeeded,
    required ValueNotifier<List<double>> amplitudesNotifier,
    required bool isRecording,
    required Duration? maxRecordingDuration,
    required void Function(int) setLinesNeeded,
    required void Function(int) setPlaybackLocation,
    Timer? debouncer,
    required void Function(Timer?) setDebouncer,
    required Future<void> Function() getAmplitudes,
  }) async {
    if (!mounted) return;
    final lines = (constraints.maxWidth / 4).floor();
    if (audioDuration != null && audioChunks.isNotEmpty) {
      if (linesNeeded != lines) setLinesNeeded(lines);
      final waveforms = await AudioWaveformCalculator.calculateRecordingWaveform(
        audioChunks: audioChunks,
        recordConfig: recordConfig!,
        linesNeeded: lines,
        audioDuration: audioDuration,
        maxRecordingDuration: maxRecordingDuration!,
        isRecording: isRecording,
      );
      amplitudesNotifier.value = waveforms;
      if (isRecording) setPlaybackLocation(lines - 1);
      return;
    }
    if (linesNeeded == lines) return;
    setLinesNeeded(lines);
    amplitudesNotifier.value = List.generate(lines, (index) => 0.0);
    debouncer?.cancel();
    setDebouncer(Timer(const Duration(milliseconds: 500), () => getAmplitudes()));
  }

  static void onVisualizerInteraction({
    required GlobalKey rowKey,
    required AudioPlaybackManager playbackManager,
    required int? linesNeeded,
    required Offset position,
  }) {
    final box = rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (playbackManager.duration == null || linesNeeded == null || box == null) return;
    final seekPosition = AudioWaveformCalculator.calculateSeekPosition(
      gesturePosition: position,
      visualizerWidth: box.size.width,
      totalDuration: playbackManager.duration,
    );
    unawaited(playbackManager.seek(seekPosition));
  }

  static Future<void> togglePlayback({
    required bool playing,
    required VoidCallback? onPlay,
    required VoidCallback? onPause,
    required AudioPlaybackManager playbackManager,
    required void Function({required bool playing}) setPlaying,
  }) async {
    if (playing) {
      onPause?.call();
      await playbackManager.pause();
    } else {
      onPlay?.call();
      await playbackManager.play();
    }
    setPlaying(playing: !playing);
  }
}
