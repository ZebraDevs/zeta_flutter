import 'dart:async';
import 'dart:io';
import 'dart:math';

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
    final bytes = await File(fileUri.toFilePath()).readAsBytes();
    return _parseWav(bytes, linesNeeded);
  } catch (e, stackTrace) {
    debugPrint('Error extracting WAV amplitudes: $e\nStack trace: $stackTrace');
    return null;
  }
}

List<double> _decodePCM(List<int> audioBytes, int bitsPerSample, int numChannels) {
  final bytesPerSample = bitsPerSample ~/ 8;
  return List.generate(audioBytes.length ~/ (bytesPerSample * numChannels), (i) {
    final sampleStart = i * bytesPerSample * numChannels;
    return List.generate(numChannels, (channel) {
          final channelStart = sampleStart + channel * bytesPerSample;
          return List.generate(bytesPerSample, (byteIndex) => audioBytes[channelStart + byteIndex] << (byteIndex * 8))
              .reduce((a, b) => a | b)
              .toSigned(bitsPerSample)
              .toDouble();
        }).reduce((a, b) => a + b) /
        numChannels;
  });
}

Future<List<double>> _parseWav(Uint8List bytes, int linesNeeded) async {
  final audioFormat = bytes[20] | (bytes[21] << 8);
  if (audioFormat != 1) throw UnsupportedError('Unsupported WAV format: Only PCM is supported');

  final numChannels = bytes[22] | (bytes[23] << 8);
  final bitsPerSample = bytes[34] | (bytes[35] << 8);
  final dataOffset = _findDataChunkOffset(bytes);
  final audioBytes = bytes.sublist(dataOffset);

  if (linesNeeded <= 0 || linesNeeded > audioBytes.length ~/ ((bitsPerSample ~/ 8) * numChannels)) {
    throw RangeError('Invalid linesNeeded value: $linesNeeded');
  }

  return _groupAndNormalizeSamples(
    _decodePCM(audioBytes, bitsPerSample, numChannels),
    linesNeeded,
  );
}

int _findDataChunkOffset(Uint8List bytes) {
  for (int i = 36; i < bytes.length - 8; i += 2) {
    if (bytes.sublist(i, i + 4).everyIndexed((index, value) => value == [0x64, 0x61, 0x74, 0x61][index])) {
      return i + 8;
    }
  }
  return 44; // Default offset for PCM WAV files
}

List<double> _groupAndNormalizeSamples(List<double> samples, int groupsCount) {
  final groupSize = samples.length ~/ groupsCount;
  final groups = List.generate(groupsCount, (i) => samples.skip(i * groupSize).take(groupSize).reduce(max));
  final maxAmplitude = groups.reduce(max);

  return maxAmplitude == 0 ? List.filled(groupsCount, 0) : groups.map((e) => e / maxAmplitude).toList();
}

extension<E> on List<E> {
  bool everyIndexed(bool Function(int index, E value) test) {
    for (int i = 0; i < length; i++) {
      if (!test(i, this[i])) return false;
    }
    return true;
  }
}
