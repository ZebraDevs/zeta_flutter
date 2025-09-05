import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';
import 'action_button.dart';

/// Attachment button for picking any type of file
class AttachmentButton extends StatelessWidget {
  /// Creates an [AttachmentButton].
  const AttachmentButton({
    super.key,
    this.onAttach,
    this.allowedExtensions,
    this.allowMultiple = false,
  });

  /// Callback for when files are selected.
  final ValueChanged<List<File>>? onAttach;

  /// Optional list of allowed file extensions (e.g., ['pdf', 'doc', 'docx']).
  /// If null, all file types are allowed.
  final List<String>? allowedExtensions;

  /// Whether to allow selecting multiple files at once.
  final bool allowMultiple;

  Future<void> _pickFiles(BuildContext context) async {
    // final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
        allowMultiple: allowMultiple,
      );

      if (result != null) {
        final files = result.paths
            .where((String? path) => path != null)
            .map((String? path) => File(path!))
            .toList();

        if (files.isNotEmpty && onAttach != null) {
          onAttach!(files);
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
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<List<File>>>.has('onAttach', onAttach))
      ..add(IterableProperty<String>('allowedExtensions', allowedExtensions))
      ..add(FlagProperty('allowMultiple', value: allowMultiple, ifTrue: 'multiple files allowed'));
  }
}
