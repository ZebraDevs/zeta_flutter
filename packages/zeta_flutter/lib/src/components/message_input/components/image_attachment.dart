import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';

/// Attachment item for displaying image files.
class ImageAttachment extends ZetaStatelessWidget {
  /// Creates an [ImageAttachment] widget.
  const ImageAttachment({super.key, required this.file});

  /// The file to be displayed.
  final File file;

  @override
  Widget build(BuildContext context) {
    final ZetaSpacing spacing = Zeta.of(context).spacing;
    final size = spacing.xl_8 + spacing.medium;

    return ClipRRect(
      borderRadius: BorderRadius.circular(spacing.medium),
      child: Image(
        image: FileImage(file),
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('file', file));
  }
}