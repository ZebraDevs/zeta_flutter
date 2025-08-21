import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../../zeta_flutter.dart';
import '../components/voice_memo/state/wav_amplitude_decoder.dart';

/// If the waveform can not be generated, fallback to a loop of this.
const List<double> _fallback = [0, 0.375, 0.5, 1, 0.625, 1, 0.75, 0.75, 1, 1, 0.75, 1, 0.375, 0, 0, 0, 0, 0];

/// Interface for defining audio amplitude decoders, used to create the waveforms in [ZetaVoiceMemo] and [ZetaAudioVisualizer].
abstract class AudioAmplitudeDecoder {
  /// Returns true if this decoder supports the given file bytes, typically by reading the header content.
  bool supports(Uint8List bytes);

  /// Extracts normalized amplitudes for visualization.
  Future<List<double>> extractAmplitudes(Uint8List bytes, int linesNeeded);
}

/// List of all audio amplitude decoders.
final List<AudioAmplitudeDecoder> _allDecoders = [WavAmplitudeDecoder()];

/// Factory method to extract amplitudes from file bytes
Future<List<double>> extractAudioAmplitudesFromBytes(Uint8List bytes, int linesNeeded) =>
    _extractAmplitudes(bytes, linesNeeded);

/// Factory method to extract amplitudes from any supported audio file.
Future<List<double>> extractAudioAmplitudesFromFile(Uri fileUri, int linesNeeded) async {
  late Uint8List bytes;
  if (kIsWeb) {
    final response = await http.get(fileUri);
    if (response.statusCode != 200) throw Exception('Failed to load audio file from network');
    bytes = response.bodyBytes;
  } else if (fileUri.path.startsWith('assets')) {
    bytes = (await rootBundle.load(fileUri.path)).buffer.asUint8List();
  } else {
    bytes = await File(fileUri.toFilePath()).readAsBytes();
  }
  return _extractAmplitudes(bytes, linesNeeded);
}

Future<List<double>> _extractAmplitudes(Uint8List bytes, int linesNeeded) async {
  try {
    final extractor = _allDecoders.firstWhere(
      (e) => e.supports(bytes),
      orElse: () => throw UnsupportedError('No amplitude extractor found for this file type.'),
    );
    return await extractor.extractAmplitudes(bytes, linesNeeded);
  } catch (e) {
    debugPrint('Error extracting audio amplitudes: $e');
    return List<double>.generate(linesNeeded, (i) => _fallback[i % _fallback.length]);
  }
}
