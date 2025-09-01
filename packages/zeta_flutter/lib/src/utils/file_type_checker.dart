import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:mime/mime.dart';

/// File type enumeration
enum FileType {
  image,
  video,
  document,
  audio,
  other,
}

/// A utility class for checking file types.
class FileTypeChecker {
  static const List<String> _imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp',
    'webp',
    'tiff',
    'svg',
    'ico',
    'heic',
    'heif',
  ];

  static const List<String> _videoExtensions = [
    'mp4',
    'avi',
    'mov',
    'wmv',
    'flv',
    'webm',
    'mkv',
    '3gp',
    'm4v',
    'f4v',
    'asf',
    'rm',
    'rmvb',
  ];

  static const List<String> _documentExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt',
    'rtf',
    'odt',
    'ods',
    'odp',
    'csv',
  ];

  static const List<String> _audioExtensions = ['mp3', 'wav', 'flac', 'aac', 'ogg', 'wma', 'm4a', 'aiff', 'au'];

  /// Check file type using extension
  static FileType getFileTypeByExtension(File file) {
    final extension = file.path.split('.').last.toLowerCase();

    if (_imageExtensions.contains(extension)) return FileType.image;
    if (_videoExtensions.contains(extension)) return FileType.video;
    if (_documentExtensions.contains(extension)) return FileType.document;
    if (_audioExtensions.contains(extension)) return FileType.audio;

    return FileType.other;
  }

  /// Check file type using MIME type
  // static FileType getFileTypeByMime(File file) {
  //   final mimeType = lookupMimeType(file.path);

  //   if (mimeType == null) return FileType.other;

  //   if (mimeType.startsWith('image/')) return FileType.image;
  //   if (mimeType.startsWith('video/')) return FileType.video;
  //   if (mimeType.startsWith('audio/')) return FileType.audio;
  //   if (mimeType.startsWith('application/') || mimeType.startsWith('text/')) {
  //     return FileType.document;
  //   }

  //   return FileType.other;
  // }

  /// Convenience methods
  /// returns true if the file has an image extension (.png, .jpg, etc.)
  static bool isImage(File file) => getFileTypeByExtension(file) == FileType.image;

  /// returns true if the file has an video extension (.mp4, .avi, etc.)
  static bool isVideo(File file) => getFileTypeByExtension(file) == FileType.video;

  /// returns true if the file has a document extension (.pdf, .docx, etc.)
  static bool isDocument(File file) => getFileTypeByExtension(file) == FileType.document;

  /// returns true if the file has an audio extension (.mp3, .wav, etc.)
  static bool isAudio(File file) => getFileTypeByExtension(file) == FileType.audio;

  /// Generate a thumbnail from a video file
  static Future<ImageProvider> getVideoThumbnail(File videoFile) async {
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoFile.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 780,
        quality: 75,
      );

      if (uint8list != null) {
        return MemoryImage(uint8list);
      } else {
        // Return a default video icon if thumbnail generation fails
        throw Exception('Failed to generate thumbnail');
      }
    } catch (e) {
      // Return a default video icon if thumbnail generation fails
      throw Exception('Failed to generate thumbnail: $e');
    }
  }
}
