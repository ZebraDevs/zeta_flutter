import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../zeta_flutter.dart';
import 'action_button.dart';

/// Camera button for capturing images
class ImageButton extends StatelessWidget {
  /// Creates a [ImageButton].
  const ImageButton({
    super.key,
    this.onCapture,
  });

  /// Callback for when an image is captured.
  final ValueChanged<File>? onCapture;

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (image != null && onCapture != null) {
      onCapture!(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      icon: ZetaIcons.camera,
      onPressed: onCapture != null ? () => _pickImage(context) : null,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ValueChanged<File>>.has('onCapture', onCapture));
  }
}
