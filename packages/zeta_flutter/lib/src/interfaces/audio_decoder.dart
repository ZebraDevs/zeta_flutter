import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../../zeta_flutter.dart';
import '../components/voice_memo/state/wav_amplitude_decoder.dart';
import '../components/voice_memo/voice_memo.dart';

/// If the waveform can not be generated, fallback to a loop of this.
const List<double> fallback = [0, 0.375, 0.5, 1, 0.625, 1, 0.75, 0.75, 1, 1, 0.75, 1, 0.375, 0, 0, 0, 0, 0];

/// Interface for defining audio amplitude decoders, used to create the waveforms in [ZetaVoiceMemo] and [ZetaAudioVisualizer].
abstract class AudioAmplitudeDecoder {
  /// Returns true if this decoder supports the given file bytes, typically by reading the header content.
  bool supports(Uint8List bytes);

  /// Extracts normalized amplitudes for visualization.
  Future<List<double>> extractAmplitudes(Uint8List bytes, int linesNeeded);
}

/// List of all audio amplitude decoders.
///
/// If you create a new decoder, add it to this list.
final List<AudioAmplitudeDecoder> allAudioAmplitudeDecoders = [
  WavAmplitudeDecoder(),
];

/// Factory method to extract amplitudes from file bytes
Future<List<double>> extractAudioAmplitudesFromBytes(Uint8List bytes, int linesNeeded) async {
  try {
    final extractor = allAudioAmplitudeDecoders.firstWhere(
      (e) => e.supports(bytes),
      orElse: () => throw UnsupportedError('No amplitude extractor found for this file type.'),
    );
    return await extractor.extractAmplitudes(bytes, linesNeeded);
  } catch (e, _) {
    debugPrint('Error extracting audio amplitudes: $e');
    return List<double>.generate(linesNeeded, (i) => fallback[i % fallback.length]);
  }
}

/// Factory method to extract amplitudes from any supported audio file.
Future<List<double>> extractAudioAmplitudesFromFile(Uri fileUri, int linesNeeded) async {
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
    final extractor = allAudioAmplitudeDecoders.firstWhere(
      (e) => e.supports(bytes),
      orElse: () => throw UnsupportedError('No amplitude extractor found for this file type.'),
    );
    return await extractor.extractAmplitudes(bytes, linesNeeded);
  } catch (e, _) {
    debugPrint('Error extracting audio amplitudes: $e');
    return List<double>.generate(linesNeeded, (i) => fallback[i % fallback.length]);
  }
}
