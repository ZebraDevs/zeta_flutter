import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'file_attachment.dart';

/// A bar that displays the list of attachments above the message input field.
class AttachmentsBar extends StatefulWidget {
  /// Creates an [AttachmentsBar] widget.
  const AttachmentsBar({
    super.key,
    required this.attachments,
    required this.onCloseAttachment,
  });

  /// A list of files to display
  final List<File> attachments;

  /// Callback function to be called when an attachment is closed.
  final ValueChanged<int> onCloseAttachment;

  @override
  State<AttachmentsBar> createState() => _AttachmentsBarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<File>('attachments', attachments))
      ..add(ObjectFlagProperty<ValueChanged<int>>.has('onCloseAttachment', onCloseAttachment));
  }
}

class _AttachmentsBarState extends State<AttachmentsBar> {
  @override
  Widget build(BuildContext context) {
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.large,
          vertical: spacing.small,
        ),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            widget.attachments.length,
            (int i) => FileAttachment(
              file: widget.attachments[i],
              index: i,
              onClose: widget.onCloseAttachment,
            ),
          ).gap(spacing.medium),
        ),
      ),
    );
  }
}
