// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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
  final encoded = UriCoder.encodeOnce(fileName);
  return Uri.parse(Uri.encodeFull('assets/assets/$encoded'));
}

Future<ByteData> loadAsset(String path) => rootBundle.load(path);

extension UriCoder on Uri {
  static String encodeOnce(String uri) {
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
}

Future<Uri> fetchToMemory(String fileName) async {
  if (kIsWeb) {
    final uri = _sanitizeURLForWeb(fileName);
    // We rely on browser caching here. Once the browser downloads this file,
    // the native side implementation should be able to access it from cache.
    await http.get(uri);
    return uri;
  }
  const FileSystem fileSystem = LocalFileSystem();
  final tempDir = await getTempDir();
  final filePath = '$tempDir$fileName';
  final file = fileSystem.file(filePath);

  // Check if the file already exists
  if (await file.exists()) {
    return file.uri;
  }

  // Read local asset from rootBundle and store it
  final byteData = await loadAsset(fileName);
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer.asUint8List());

  return file.uri;
}

Future<Uri> downloadAudioFileToLocal(String url) async {
  const FileSystem fileSystem = LocalFileSystem();
  final tempDir = await getTempDir();

  final encodedUrl = UriCoder.encodeOnce(url);
  final filePath = '$tempDir/$encodedUrl';
  final file = fileSystem.file(filePath);

  // Check if the file already exists
  if (await file.exists()) {
    return file.uri;
  } else {
    // Download the file if it doesn't exist
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to download audio file');
    }

    await file.create(recursive: true);
    await file.writeAsBytes(response.bodyBytes);

    return file.uri;
  }
}

Future<String> getTempDir() async => (await getTemporaryDirectory()).path;
