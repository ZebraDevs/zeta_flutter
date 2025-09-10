import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';
import '../utils/file_type_checker.dart';

/// Attachment item for displaying document files.
class DocumentAttachment extends ZetaStatelessWidget {
  /// Creates a [DocumentAttachment] widget.
  const DocumentAttachment({
    super.key,
    required this.file,
  });

  /// The file to be displayed.
  final File file;

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return Container(
      decoration: BoxDecoration(
        color: colors.mainLight,
        border: Border.all(color: colors.borderDefault),
        borderRadius: BorderRadius.circular(spacing.medium),
      ),
      padding: EdgeInsets.only(right: spacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: spacing.small),
            child: Text(file.path.split('/').last, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          Row(
            children: [
              FileTypeChecker.getFileIcon(context, file),
              SizedBox(width: spacing.minimum),
              Flexible(child: Text(file.path.split('.').last.toUpperCase(), maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('file', file));
  }
}
