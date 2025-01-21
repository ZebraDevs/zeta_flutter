import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// Bottom sheets are surfaces containing supplementary content that are anchored to the bottom of the screen.
///
/// To display a [ZetaBottomSheet], use the [showZetaBottomSheet] function.
///
/// Content should typically consist of a [List] of [ZetaMenuItem]s.
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21541-2225
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/bottom-sheet
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
    final spacing = Zeta.of(context).spacing;
    final radius = Zeta.of(context).radius;

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          spacing.xl,
          spacing.none,
          spacing.xl,
          spacing.xl,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceDefault,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(spacing.xl_2),
            topRight: Radius.circular(spacing.xl_2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: Padding(
                padding: EdgeInsets.only(top: spacing.small),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.surfaceDisabled,
                    borderRadius: BorderRadius.all(radius.full),
                  ),
                ),
              ),
            ),
            if (title != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.medium,
                  vertical: spacing.xl_2,
                ),
                child: Align(
                  alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: Text(
                    title!,
                    style: ZetaTextStyles.titleMedium,
                  ),
                ),
              ),
            Material(
              color: colors.surfaceDefault,
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
///
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
