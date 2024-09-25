import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Bottom sheets are surfaces containing supplementary content that are anchored to the bottom of the screen.
///
/// To display a [ZetaBottomSheet], use the [showZetaBottomSheet] function.
///
/// Content should typically consist of a [List] of [ZetaMenuItem]s.
/// {@category Components}
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

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          Zeta.of(context).spacing.xl,
          Zeta.of(context).spacing.none,
          Zeta.of(context).spacing.xl,
          Zeta.of(context).spacing.xl,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceSecondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Zeta.of(context).spacing.xl_2),
            topRight: Radius.circular(Zeta.of(context).spacing.xl_2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: SizedBox(
                height: Zeta.of(context).spacing.xl_5,
                child: Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.small),
                  child: ZetaIcon(
                    Icons.maximize,
                    size: Zeta.of(context).spacing.xl_9,
                    color: colors.surfaceDisabled,
                  ),
                ),
              ),
            ),
            if (title != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Zeta.of(context).spacing.medium,
                  vertical: Zeta.of(context).spacing.xl_2,
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
