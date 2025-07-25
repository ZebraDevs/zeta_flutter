import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Uri _sanitizeURLForWeb(String fileName) {
  final tryAbsolute = Uri.tryParse(fileName);
  if (tryAbsolute?.isAbsolute ?? false) {
    return tryAbsolute!;
  }

  // Relative Asset path
  // URL-encode twice, see:
  // https://github.com/flutter/engine/blob/2d39e672c95efc6c539d9b48b2cccc65df290cc4/lib/web_ui/lib/ui_web/src/ui_web/asset_manager.dart#L61
  // Parsing an already encoded string to an Uri does not encode it a second
  // time, so we have to do it manually:
  final encoded = _encodeOnce(fileName);
  return Uri.parse(Uri.encodeFull('assets/assets/$encoded'));
}

Future<ByteData> _loadAsset(String path) => rootBundle.load(path);

String _encodeOnce(String uri) {
  try {
    // If decoded differs, the uri was already encoded.
    final decodedUri = Uri.decodeFull(uri);
    if (decodedUri != uri) {
      return uri;
    }
  } catch (err) {
    debugPrint('Error decoding URI: $err');
  }
  return Uri.encodeFull(uri);
}

/// Enum to specify how to fetch the file: from assets or from a URL.
enum FileFetchMode {
  /// File saved as local asset in app.
  asset,

  /// File fetched from a URL.
  url
}

/// Handles file fetching for both assets and URLs to cache them locally.
Future<Uri> handleFile(String fileNameOrUrl, FileFetchMode mode) async {
  if (kIsWeb || mode == FileFetchMode.asset) {
    final uri = _sanitizeURLForWeb(fileNameOrUrl);
    // We rely on browser caching here. Once the browser downloads this file,
    // the native side implementation should be able to access it from cache.
    await http.get(uri);
    return uri;
  }

  final tempDir = Directory.systemTemp.path;
  final filePath = mode == FileFetchMode.asset ? '$tempDir$fileNameOrUrl' : '$tempDir/${_encodeOnce(fileNameOrUrl)}';
  final file = File(filePath);

  // Check if the file already exists
  if (file.existsSync()) {
    return file.uri;
  }

  if (mode == FileFetchMode.asset) {
    // Read local asset from rootBundle and store it
    final byteData = await _loadAsset(fileNameOrUrl);
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List());
  } else if (mode == FileFetchMode.url) {
    // Download the file if it doesn't exist
    final response = await http.get(Uri.parse(fileNameOrUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to download audio file');
    }

    await file.create(recursive: true);
    await file.writeAsBytes(response.bodyBytes);
  }

  return file.uri;
}
