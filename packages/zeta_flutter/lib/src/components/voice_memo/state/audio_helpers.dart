import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:record/record.dart';

import '../../../../zeta_flutter.dart';

import 'wav_header.dart';

const int _defaultWavHeaderOffset = 44;
const int _wavHeaderSearchStart = 36;
const int _wavHeaderChunkSize = 8;
const List<int> _wavDataChunkMarker = [0x64, 0x61, 0x74, 0x61]; // "data" in ASCII

/// If the waveform can not be generated, fallback to a loop of this.
const List<double> fallbackAmps = [0, 0.375, 0.5, 1, 0.625, 1, 0.75, 0.75, 1, 1, 0.75, 1, 0.375, 0, 0, 0, 0, 0];

/// Abstract interface for extracting amplitudes from audio files.
abstract class AudioAmplitudeExtractor {
  /// Returns true if this extractor supports the given file bytes and/or URI.
  bool supports(Uri fileUri, Uint8List bytes);

  /// Extracts normalized amplitudes for visualization.
  Future<List<double>> extractAmplitudes(Uint8List bytes, int linesNeeded);
}

/// WAV amplitude extractor implementation.
class WavAmplitudeExtractor implements AudioAmplitudeExtractor {
  @override
  bool supports(Uri fileUri, Uint8List bytes) {
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
  Future<List<double>> extractAmplitudes(Uint8List bytes, int linesNeeded) => parseWavToAmplitudes(bytes, linesNeeded);
}

final List<AudioAmplitudeExtractor> _extractors = [
  WavAmplitudeExtractor(),
  // Add more extractors here in the future
];

/// Factory method to extract amplitudes from any supported audio file.
Future<List<double>> extractAudioAmplitudes(Uri fileUri, int linesNeeded) async {
  try {
    Uint8List bytes;
    if (kIsWeb) {
      if (fileUri.isScheme('http') || fileUri.isScheme('https')) {
        final response = await http.get(fileUri);
        if (response.statusCode != 200) throw Exception('Failed to load audio file from network');
        bytes = response.bodyBytes;
      } else {
        final response = await http.get(fileUri);
        bytes = response.bodyBytes;
      }
    } else {
      if (fileUri.path.startsWith('assets') || fileUri.path.startsWith('/assets')) {
        bytes = (await rootBundle.load(fileUri.path)).buffer.asUint8List();
      } else {
        bytes = await File(fileUri.toFilePath()).readAsBytes();
      }
    }
    final extractor = _extractors.firstWhere(
      (e) => e.supports(fileUri, bytes),
      orElse: () => throw UnsupportedError('No amplitude extractor found for this file type.'),
    );
    return await extractor.extractAmplitudes(bytes, linesNeeded);
  } catch (e, _) {
    debugPrint('Error extracting audio amplitudes: $e');
    return List<double>.generate(linesNeeded, (i) => fallbackAmps[i % fallbackAmps.length]);
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

/// Returns amplitude values needed for [ZetaAudioVisualizer].
Future<List<double>> parseWavToAmplitudes(Uint8List bytes, int linesNeeded) async {
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

/// Creates a header for given PCM WAV audio data
Uint8List generatePCMWavHeader(List<Uint8List> audioChunks, RecordConfig recordConfig) {
  if (audioChunks.isNotEmpty) {
    final totalAudioBytes = audioChunks.fold<int>(0, (sum, chunk) => sum + chunk.length);
    final bytesPerSample = 2 * recordConfig.numChannels;
    final samples = totalAudioBytes ~/ bytesPerSample;

    return PCMWavHeader(
      channels: recordConfig.numChannels,
      sampleRate: recordConfig.sampleRate,
      samples: samples,
    ).header;
  }

  return Uint8List(0);
}
