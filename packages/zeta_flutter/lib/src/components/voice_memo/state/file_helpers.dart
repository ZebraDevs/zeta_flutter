import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Uri _sanitizeURLForWeb(String fileName) {
  final uri = Uri.tryParse(fileName);
  if (uri?.isAbsolute ?? false) return uri!;

  // URL-encode for relative asset paths
  final encoded = Uri.decodeFull(fileName) != fileName ? fileName : Uri.encodeFull(fileName);
  return Uri.parse('assets/assets/$encoded');
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
  if (kIsWeb && mode == FileFetchMode.asset) {
    final uri = _sanitizeURLForWeb(fileNameOrUrl);
    // TODO(luke): does this actually work on web?
    // We rely on browser caching here. Once the browser downloads this file,
    // the native side implementation should be able to access it from cache.
    await http.get(uri);
    return uri;
  }

  final tempDir = Directory.systemTemp.path;
  final fileName = mode == FileFetchMode.url
      ? Uri.decodeFull(fileNameOrUrl) != fileNameOrUrl
          ? fileNameOrUrl
          : Uri.encodeFull(fileNameOrUrl)
      : fileNameOrUrl;
  final filePath = mode == FileFetchMode.asset ? '$tempDir$fileNameOrUrl' : '$tempDir/$fileName';
  final file = File(filePath);

  // Check if the file already exists
  if (file.existsSync()) {
    return file.uri;
  }

  if (mode == FileFetchMode.asset) {
    // Read local asset from rootBundle and store it
    final byteData = await rootBundle.load(fileNameOrUrl);
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List());
  } else {
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
