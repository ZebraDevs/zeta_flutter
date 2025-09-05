import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';
import '../utils/file_type_checker.dart';

/// Attachment item for displaying video files.
class VideoAttachment extends StatelessWidget {
  /// Creates a [VideoAttachment] widget.
  const VideoAttachment({
    super.key,
    required this.file,
  });

  /// The file to be displayed.
  final File file;

  @override
  Widget build(BuildContext context) {
    final ZetaSpacing spacing = Zeta.of(context).spacing;
    final size = spacing.xl_8 + spacing.medium;

    return FutureBuilder<ImageProvider<Object>?>(
      future: FileTypeChecker.getVideoThumbnail(file),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: snapshot.data!,
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return SizedBox(
            width: size,
            height: size,
            child: const Center(child: Icon(ZetaIcons.video)),
          );
        } else {
          return SizedBox(
            width: size,
            height: size,
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('file', file));
  }
}
