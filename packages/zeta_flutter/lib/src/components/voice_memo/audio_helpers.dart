import 'dart:async';

import 'package:file/local.dart';
import 'package:flutter/foundation.dart';

/// Extracts WAV amplitudes from a file URI, normalizing them for visualization.
///
/// This function is very basic, and does not handle all WAV formats, only PCM.
///
/// The extracted amplitudes are normalized to a range of 0.0 to 1.0, where 0.5 represents the average amplitude.
/// These values should not be considered accurate for audio playback, but rather for visual representation in a waveform.
/// Extracts WAV amplitudes from a file URI, normalizing them for visualization.
///
/// This function is very basic, and does not handle all WAV formats, only PCM.
///
/// The extracted amplitudes are normalized to a range of 0.0 to 1.0, where 0.5 represents the average amplitude.
/// These values should not be considered accurate for audio playback, but rather for visual representation in a waveform.
///
/// If the presented file is not a WAV file, it will return null.
Future<List<double>?> extractWavAmplitudes(Uri fileUri, int linesNeeded) async {
  try {
    final file = const LocalFileSystem().file(fileUri.toFilePath());
    final bytes = await file.readAsBytes();

    return _parseWav(bytes, linesNeeded);
  } catch (e, stackTrace) {
    debugPrint('Error extracting WAV amplitudes: $e');
    debugPrint('Stack trace: $stackTrace');
    return null;
  }
}

List<double> _decodePCM(List<int> audioBytes, int bitsPerSample, int numChannels) {
  final bytesPerSample = bitsPerSample ~/ 8;
  final totalSamples = audioBytes.length ~/ (bytesPerSample * numChannels);
  final samples = List<double>.filled(totalSamples, 0);

  for (int i = 0; i < totalSamples; i++) {
    final sampleStart = i * bytesPerSample * numChannels;
    double sampleValue = 0;

    for (int channel = 0; channel < numChannels; channel++) {
      final channelStart = sampleStart + channel * bytesPerSample;
      int sample = 0;

      for (int byteIndex = 0; byteIndex < bytesPerSample; byteIndex++) {
        sample |= audioBytes[channelStart + byteIndex] << (byteIndex * 8);
      }

      sample = sample.toSigned(bitsPerSample);
      sampleValue += sample.toDouble();
    }

    samples[i] = sampleValue / numChannels; // Average across channels
  }

  return samples;
}

Future<List<double>> _parseWav(Uint8List bytes, int linesNeeded) async {
  // Get these values from the WAV header
  final audioFormat = bytes[20] | (bytes[21] << 8);
  final numChannels = bytes[22] | (bytes[23] << 8);
  final bitsPerSample = bytes[34] | (bytes[35] << 8);

  if (audioFormat != 1) {
    throw UnsupportedError('Unsupported WAV format: Only PCM is supported');
  }

  final dataOffset = _findDataChunkOffset(bytes);
  final audioBytes = bytes.sublist(dataOffset);
  final bytesPerSample = bitsPerSample ~/ 8;
  final totalSamples = audioBytes.length ~/ (bytesPerSample * numChannels);

  if (linesNeeded <= 0 || linesNeeded > totalSamples) {
    throw RangeError('Invalid linesNeeded value: $linesNeeded');
  }

  final audioSamples = _decodePCM(audioBytes, bitsPerSample, numChannels);
  return _groupAndNormalizeSamples(audioSamples, linesNeeded);
}

int _findDataChunkOffset(Uint8List bytes) {
  for (int i = 36; i < bytes.length - 8; i += 2) {
    if (bytes[i] == 0x64 && bytes[i + 1] == 0x61 && bytes[i + 2] == 0x74 && bytes[i + 3] == 0x61) {
      return i + 8;
    }
  }
  return 44; // Default offset for PCM WAV files
}

List<double> _groupAndNormalizeSamples(List<double> samples, int groupsCount) {
  final groupSize = samples.length ~/ groupsCount;
  final groups = List<double>.filled(groupsCount, 0);

  for (int i = 0; i < samples.length; i++) {
    final groupIndex = i ~/ groupSize;
    if (groupIndex < groupsCount) {
      groups[groupIndex] += samples[i];
    }
  }

  for (int i = 0; i < groupsCount; i++) {
    groups[i] /= groupSize;
  }

  final minAmplitude = groups.reduce((a, b) => a < b ? a : b);
  final maxAmplitude = groups.reduce((a, b) => a > b ? a : b);

  if (maxAmplitude == minAmplitude) {
    return List<double>.filled(groupsCount, 0.5);
  }

  final range = maxAmplitude - minAmplitude;
  return groups.map((e) => (e - minAmplitude) / range).toList();
}
