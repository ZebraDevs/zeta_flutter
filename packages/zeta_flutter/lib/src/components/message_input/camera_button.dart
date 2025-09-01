import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../zeta_flutter.dart';

/// Camera button for capturing images
class CameraButton extends StatelessWidget {
  /// Creates a [CameraButton].
  const CameraButton({
    super.key,
    required this.onCapture,
  });

  /// Callback for when an image is captured.
  final ValueChanged<File> onCapture;

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (image != null) {
      onCapture(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return IconButton(
      icon: Icon(
        ZetaIcons.camera,
        color: colors.mainDefault,
        size: spacing.xl_3,
      ),
      onPressed: () => _pickImage(context),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ValueChanged<File>>.has('onCapture', onCapture));
  }
}
