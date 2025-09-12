import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../zeta_flutter.dart';
import '../utils/file_type_checker.dart';
import 'document_attachment.dart';
import 'image_attachment.dart';
import 'video_attachment.dart';

/// A widget that displays a file attachment in the Attachments Bar
class FileAttachment extends ZetaStatelessWidget {
  /// Creates a [FileAttachment] widget.
  const FileAttachment({
    super.key,
    required this.file,
    required this.index,
    required this.onClose,
  });

  /// The file being displayed.
  final File file;

  /// The index of the file in the list.
  final int index;

  /// Callback function to be called when the attachment is closed.
  final ValueChanged<int> onClose;

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    final size = spacing.xl_8 + spacing.medium;

    final isImage = FileTypeChecker.isImage(file);
    final isVideo = FileTypeChecker.isVideo(file);

    Widget dialogImage = const SizedBox();
    if (isImage) dialogImage = Image.file(file);
    if (isVideo) {
      dialogImage = FutureBuilder<ImageProvider?>(
        future: FileTypeChecker.getVideoThumbnail(file),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Stack(
              children: [
                Image(
                  image: snapshot.data!,
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(128, 0, 0, 0),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(spacing.medium),
                      child: Icon(
                        ZetaIcons.video,
                        size: spacing.xl_11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
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
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    }

    return InkWell(
      onTap: () async {
        if (isImage || isVideo) {
          await showDialog<void>(
            context: context,
            builder: (_) => Dialog(
              child: dialogImage,
            ),
          );
        }
      },
      child: Container(
        width: !isVideo && !isImage ? size * 3 : size,
        height: size,
        decoration: BoxDecoration(
          color: colors.mainLight,
          borderRadius: BorderRadius.circular(spacing.medium),
        ),
        child: Stack(
          children: [
            if (isVideo) VideoAttachment(file: file),
            if (isImage) ImageAttachment(file: file),
            if (!isVideo && !isImage) DocumentAttachment(file: file),
            Positioned(
              top: 1,
              right: 1,
              child: GestureDetector(
                onTap: () async => {
                  onClose(index),
                  await SystemChannels.textInput.invokeMethod('TextInput.show'),
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.borderDefault,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(spacing.minimum),
                  child: Icon(
                    Icons.close,
                    size: spacing.large,
                    color: colors.mainDefault,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<File>('file', file))
      ..add(IntProperty('index', index))
      ..add(ObjectFlagProperty<ValueChanged<int>>.has('onClose', onClose));
  }
}
