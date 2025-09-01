import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';
import '../../utils/file_type_checker.dart';

/// A widget that displays a file attachment in the Attachments Bar
class FileAttachment extends StatelessWidget {
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

    final isImage = FileTypeChecker.isImage(file);
    final isVideo = FileTypeChecker.isVideo(file);
    final isDocument = FileTypeChecker.isDocument(file);
    final isAudio = FileTypeChecker.isAudio(file);

    Widget dialogImage = const SizedBox();
    if (isImage) dialogImage = Image.file(file);
    if (isVideo) {
      dialogImage = FutureBuilder<ImageProvider>(
        future: FileTypeChecker.getVideoThumbnail(file),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Image(
              image: snapshot.data!,
            );
          } else {
            return const SizedBox(
              width: 200,
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    }

    // TODO: implement document and audio attachments

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
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: colors.mainLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            if (isVideo)
              FutureBuilder<ImageProvider<Object>>(
                future: FileTypeChecker.getVideoThumbnail(file),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        image: snapshot.data!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return const SizedBox(
                      width: 56,
                      height: 56,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }
                },
              )
            else if (isImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: FileImage(file),
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
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
                    size: 16,
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
