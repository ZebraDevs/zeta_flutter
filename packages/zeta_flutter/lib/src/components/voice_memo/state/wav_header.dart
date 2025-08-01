// Internal type, used within [ZetaVoiceMemo].

// Solution adapted from Stack Overflow. Credit to 'Richard Heap': https://stackoverflow.com/a/76885616/10292120.

import 'dart:typed_data';

/// A simple PCM WAV header generator.
/// This class generates a standard WAV header for PCM audio data.
/// It can be used to create a valid WAV file header for audio data recorded
/// using the `record` package or similar audio recording libraries.
class PCMWavHeader {
  /// Constructs a PCM WAV header for the given audio parameters.
  PCMWavHeader({required this.channels, required this.sampleRate, required this.samples});

  /// Number of audio channels (1 = mono, 2 = stereo)
  final int channels;

  /// Sample rate in Hz (e.g., 44100)
  final int sampleRate;

  /// Total number of samples
  final int samples;

  // PCM WAV format constants
  static const int _pcmFormat = 1;
  static const int _bitsPerSample = 16;
  static const int _bytesPerSample = 2;

  /// The size of the audio data in bytes
  int get dataSize => channels * samples * _bytesPerSample;

  /// Block align (bytes per sample frame)
  int get blockAlign => channels * _bytesPerSample;

  /// Byte rate (bytes per second)
  int get byteRate => sampleRate * blockAlign;

  /// Generates the complete WAV header as bytes
  Uint8List get header {
    final header = Uint8List(44); // Standard PCM WAV header size
    header.buffer.asByteData()
      // RIFF header
      ..setUint32(0, 0x46464952, Endian.little) // 'RIFF'
      ..setUint32(4, 36 + dataSize, Endian.little) // File size - 8
      ..setUint32(8, 0x45564157, Endian.little) // 'WAVE'
      // fmt chunk
      ..setUint32(12, 0x20746d66, Endian.little) // 'fmt '
      ..setUint32(16, 16, Endian.little) // fmt chunk size
      ..setUint16(20, _pcmFormat, Endian.little) // Audio format (PCM)
      ..setUint16(22, channels, Endian.little) // Number of channels
      ..setUint32(24, sampleRate, Endian.little) // Sample rate
      ..setUint32(28, byteRate, Endian.little) // Byte rate
      ..setUint16(32, blockAlign, Endian.little) // Block align
      ..setUint16(34, _bitsPerSample, Endian.little) // Bits per sample
      // data chunk
      ..setUint32(36, 0x61746164, Endian.little) // 'data'
      ..setUint32(40, dataSize, Endian.little); // Data size

    return header;
  }
}
