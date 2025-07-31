// Internal type, used within [ZetaVoiceMemo].
// ignore_for_file: public_member_api_docs

// Solution adapted from Stack Overflow. Credit to 'Richard Heap': https://stackoverflow.com/a/76885616/10292120.

import 'dart:typed_data';

class WavHeader {
  WavHeader(
    this.tag,
    this.channels,
    this.sampleRate,
    this.bitsPerSample,
    this.blockAlign,
    this.samples,
    this.length,
  );

  // Constructor with PCM defaults
  WavHeader.pcm(
    int samples,
    int channels, {
    int sampleRate = 44100,
  }) : this(
          1, // PCM tag
          channels,
          sampleRate,
          16, // 16 bits per sample
          2 * channels, // block align
          samples,
          channels * samples * 2, // length
        );

  int get overallLength =>
      headerTemplate.length - 8 + fmtTemplate.length + factTemplate.length + dataTemplate.length + length;

  Uint8List get header {
    final bb = BytesBuilder(copy: false)
      ..add(riffHeader)
      ..add(fmtHeader)
      ..add(factHeader)
      ..add(dataHeader);
    return bb.toBytes();
  }

  List<int> get riffHeader {
    final list = Uint8List.fromList(headerTemplate);
    list.buffer.asByteData().setUint32(4, overallLength, Endian.little);
    return list;
  }

  List<int> get fmtHeader {
    final list = Uint8List.fromList(fmtTemplate);
    list.buffer.asByteData()
      ..setUint16(8, tag, Endian.little)
      ..setUint16(10, channels, Endian.little)
      ..setUint32(12, sampleRate, Endian.little)
      ..setUint32(16, channels * sampleRate * bitsPerSample ~/ 8, Endian.little)
      ..setUint16(20, blockAlign, Endian.little)
      ..setUint16(22, bitsPerSample, Endian.little);
    return list;
  }

  List<int> get factHeader {
    final list = Uint8List.fromList(factTemplate);
    list.buffer.asByteData().setUint32(8, samples, Endian.little);
    return list;
  }

  List<int> get dataHeader {
    final list = Uint8List.fromList(dataTemplate);
    list.buffer.asByteData().setUint32(4, length, Endian.little);
    return list;
  }

  final int tag;
  final int channels;
  final int sampleRate;
  final int bitsPerSample;
  final int blockAlign;
  final int samples;
  final int length;

  final headerTemplate = <int>[
    0x52, 0x49, 0x46, 0x46, // RIFF
    0, 0, 0, 0, // length placeholder
    0x57, 0x41, 0x56, 0x45, // WAVE
  ];

  final fmtTemplate = <int>[
    0x66, 0x6d, 0x74, 0x20, // fmt<space>
    0x10, 0, 0, 0, // length 16
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ];

  final factTemplate = <int>[
    // fact, length = 4
    0x66, 0x61, 0x63, 0x74, // fact
    4, 0, 0, 0, // length 4
    0, 0, 0, 0,
  ];

  final dataTemplate = <int>[
    0x64, 0x61, 0x74, 0x61, //data
    0, 0, 0, 0,
  ];
}
