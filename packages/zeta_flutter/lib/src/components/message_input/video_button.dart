import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../zeta_flutter.dart';

/// Video button for capturing videos
class VideoButton extends StatelessWidget {
  /// Creates a [VideoButton].
  const VideoButton({
    super.key,
    required this.onCapture,
  });

  /// Callback for when a video is captured.
  final ValueChanged<File> onCapture;

  Future<void> _pickVideo(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera, maxDuration: const Duration(minutes: 5));
    if (video != null) {
      onCapture(File(video.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return IconButton(
      icon: Icon(
        ZetaIcons.video,
        color: colors.mainDefault,
        size: spacing.xl_3,
      ),
      onPressed: () => _pickVideo(context),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ValueChanged<File>>.has('onCapture', onCapture));
  }
}
