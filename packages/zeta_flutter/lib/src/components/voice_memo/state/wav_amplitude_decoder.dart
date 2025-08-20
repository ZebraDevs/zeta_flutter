import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../../../zeta_flutter.dart';

/// WAV amplitude extractor implementation.
class WavAmplitudeDecoder implements AudioAmplitudeDecoder {
  static const int _defaultWavHeaderOffset = 44;
  static const int _wavHeaderSearchStart = 36;
  static const int _wavHeaderChunkSize = 8;
  static const List<int> _wavDataChunkMarker = [0x64, 0x61, 0x74, 0x61]; // "data" in ASCII

  @override
  bool supports(Uint8List bytes) {
    // Check for 'RIFF' and 'WAVE' headers
    return bytes.length > 36 &&
        bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x41 &&
        bytes[10] == 0x56 &&
        bytes[11] == 0x45;
  }

  @override
  Future<List<double>> extractAmplitudes(Uint8List bytes, int linesNeeded) async {
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

  int _findDataChunkOffset(Uint8List bytes) {
    for (int i = _wavHeaderSearchStart; i < bytes.length - _wavHeaderChunkSize; i += 2) {
      if (bytes.sublist(i, i + 4).everyIndexed((index, value) => value == _wavDataChunkMarker[index])) {
        return i + _wavHeaderChunkSize;
      }
    }
    return _defaultWavHeaderOffset;
  }

  List<double> _groupAndNormalizeSamples(List<double> samples, int groupsCount) {
    final groupSize = samples.length ~/ groupsCount;
    final groups = List.generate(groupsCount, (i) => samples.skip(i * groupSize).take(groupSize).reduce(max));
    final maxAmplitude = groups.reduce(max);

    return maxAmplitude == 0 ? List.filled(groupsCount, 0) : groups.map((e) => e / maxAmplitude).toList();
  }
}
