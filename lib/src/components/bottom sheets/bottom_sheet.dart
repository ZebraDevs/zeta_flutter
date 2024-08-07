import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Bottom sheets are surfaces containing supplementary content that are anchored to the bottom of the screen.
///
/// To display a [ZetaBottomSheet], use the [showZetaBottomSheet] function.
///
/// Content should typically consist of a [List] of [ZetaMenuItem]s.
/// {@category Components}
class ZetaBottomSheet extends ZetaStatelessWidget {
  /// Constructor for [ZetaBottomSheet].
  const ZetaBottomSheet({
    super.key,
    super.rounded,
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

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          ZetaSpacing.xl_1,
          ZetaSpacing.none,
          ZetaSpacing.xl_1,
          ZetaSpacing.xl_1,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceSecondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(ZetaSpacing.xl_2),
            topRight: Radius.circular(ZetaSpacing.xl_2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: SizedBox(
                height: ZetaSpacing.xl_5,
                child: Padding(
                  padding: const EdgeInsets.only(top: ZetaSpacing.small),
                  child: ZetaIcon(
                    Icons.maximize,
                    size: ZetaSpacing.xl_9,
                    color: colors.surfaceDisabled,
                  ),
                ),
              ),
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.medium, vertical: ZetaSpacing.xl_2),
                child: Align(
                  alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: Text(
                    title!,
                    style: ZetaTextStyles.titleMedium,
                  ),
                ),
              ),
            Material(
              color: colors.surfaceSecondary,
              child: body ?? const Nothing(),
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
