import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';
import 'action_button.dart';

/// Attachment button for picking any type of file
class AttachmentButton extends ZetaStatelessWidget {
  /// Creates an [AttachmentButton].
  const AttachmentButton({
    super.key,
    this.onAttach,
    this.allowedExtensions,
    this.allowMultiple = false,
    this.maxSize,
  });

  /// Callback for when files are selected.
  final ValueChanged<List<File>>? onAttach;

  /// Optional list of allowed file extensions (e.g., ['pdf', 'doc', 'docx']).
  /// If null, all file types are allowed.
  final List<String>? allowedExtensions;

  /// Whether to allow selecting multiple files at once.
  final bool allowMultiple;

  /// The maximum size of attachments in bytes.
  final int? maxSize;

  Future<void> _pickFiles(BuildContext context) async {
    // final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
        allowMultiple: allowMultiple,
      );

      if (result != null) {
        var files = result.paths.where((String? path) => path != null).map((String? path) => File(path!)).toList();
        // Filter by maxSize if specified
        if (maxSize != null) {
          files = files.where((file) {
            try {
              return file.lengthSync() <= maxSize!;
            } catch (_) {
              return false;
            }
          }).toList();
        }
        if (files.isNotEmpty && onAttach != null) {
          onAttach!(files);
        } else if (result.paths.isNotEmpty && files.isEmpty) {
          if (context.mounted) _displayError(context, 'Selected file(s) exceed maximum size of ${maxSize! / 1000000}MB');
        }
      }
    } catch (e) {
      if (context.mounted) _displayError(context, e);
    }
  }

  void _displayError(BuildContext context, Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      ZetaSnackBar(
        content: Text('Error picking files: $error'),
        type: ZetaSnackBarType.error,
        context: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      icon: ZetaIcons.attachment,
      onPressed: onAttach != null ? () => _pickFiles(context) : null,
      semanticLabel: 'add an attachment',
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<List<File>>>.has('onAttach', onAttach))
      ..add(IterableProperty<String>('allowedExtensions', allowedExtensions))
      ..add(FlagProperty('allowMultiple', value: allowMultiple, ifTrue: 'multiple files allowed'));
    properties.add(IntProperty('maxSize', maxSize));
  }
}
