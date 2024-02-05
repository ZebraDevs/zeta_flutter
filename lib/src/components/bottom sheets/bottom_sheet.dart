import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Component [ZetaBottomSheet]
class ZetaBottomSheet extends StatelessWidget {
  /// Constructor for [ZetaBottomSheet].
  const ZetaBottomSheet({
    super.key,
    this.title,
    this.body,
    this.centerTitle = true,
  });

  /// The title of [ZetaBottomSheet].
  final String? title;

  /// Whether title should be center or left aligned.
  ///
  /// Defaults to true (center aligned).
  final bool centerTitle;

  /// The content of [ZetaBottomSheet].
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        ZetaSpacing.x5,
        0,
        ZetaSpacing.x5,
        ZetaSpacing.x5,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(ZetaSpacing.x6),
          topRight: Radius.circular(ZetaSpacing.x6),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            child: SizedBox(
              height: ZetaSpacing.x9,
              child: Padding(
                padding: const EdgeInsets.only(top: ZetaSpacing.x2),
                child: Icon(
                  Icons.maximize_rounded,
                  size: ZetaSpacing.x16,
                  color: colors.surfaceDisabled,
                ),
              ),
            ),
          ),
          if (title != null)
            Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Text(
                title!,
                style: ZetaTextStyles.titleMedium,
              ),
            ),
          Material(
            color: colors.surfaceSecondary,
            child: body ?? const SizedBox(),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<String?>('title', title))
      ..add(DiagnosticsProperty<bool>('centerTitle', centerTitle));
  }
}

/// Function to show [ZetaBottomSheet].
///
/// Uses [showModalBottomSheet] for functionality, but with Zeta styling and simplified functionality.
Future<T?> showZetaBottomSheet<T>({
  required BuildContext context,
  String? title,
  Widget? body,
  bool centerTitle = true,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (BuildContext context) => ZetaBottomSheet(
      title: title,
      body: body,
      centerTitle: centerTitle,
    ),
  );
}
