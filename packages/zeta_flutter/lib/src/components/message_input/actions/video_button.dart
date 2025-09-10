import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../zeta_flutter.dart';
import 'action_button.dart';

/// Video button for capturing videos
class VideoButton extends ZetaStatelessWidget {
  /// Creates a [VideoButton].
  const VideoButton({
    super.key,
    this.onCapture,
  });

  /// Callback for when a video is captured.
  final ValueChanged<File>? onCapture;

  Future<void> _pickVideo(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? video =
        await picker.pickVideo(source: ImageSource.camera, maxDuration: const Duration(minutes: 5));
    if (video != null && onCapture != null) {
      onCapture!(File(video.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      icon: ZetaIcons.video,
      onPressed: onCapture != null ? () => _pickVideo(context) : null,
      semanticLabel: 'capture a video',
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ValueChanged<File>>.has('onCapture', onCapture));
  }
}
