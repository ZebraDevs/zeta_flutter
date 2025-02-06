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
    this.showCloseButton = true,
    this.onDismissed,
  });

  /// The title of [ZetaBottomSheet].
  final String? title;

  /// Whether title should be center or left aligned.
  ///
  /// Defaults to true (center aligned).
  final bool centerTitle;

  /// The content of [ZetaBottomSheet].
  final Widget? body;

  /// Whether to show close icon button or not.
  final bool showCloseButton;

  /// Callback when the bottom sheet is dismissed.
  ///
  /// This is _only_ called when the user closes the sheet by tapping the close button.
  ///
  /// Defaults to
  /// ```dart
  /// Navigator.of(context).pop();
  /// ```
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final text = Text(
      title ?? '',
      style: ZetaTextStyles.titleMedium,
      textAlign: centerTitle ? TextAlign.center : TextAlign.start,
    );
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
        child: Stack(
          children: [
            if (showCloseButton)
              Positioned(
                right: Zeta.of(context).spacing.medium,
                top: Zeta.of(context).spacing.small,
                child: IconButton(
                  icon: const ZetaIcon(ZetaIcons.close),
                  color: colors.iconSubtle,
                  onPressed: () {
                    if (onDismissed != null) {
                      onDismissed?.call();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  child: SizedBox(
                    height: Zeta.of(context).spacing.xl,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.surfaceDisabled,
                          borderRadius: BorderRadius.circular(
                            100, // NOTE: This radius is hardcoded in Figma, doesn't change when token values change.
                          ),
                        ),
                        height: Zeta.of(context).spacing.minimum,
                        width: Zeta.of(context).spacing.xl_6,
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
                    child: Row(
                      mainAxisAlignment: centerTitle ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: centerTitle ? Center(child: text) : text,
                        ),
                      ],
                    ),
                  ),
                Material(
                  color: colors.surfaceSecondary,
                  child: body ?? const Nothing(),
                ),
              ],
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
      ..add(DiagnosticsProperty<bool>('centerTitle', centerTitle))
      ..add(DiagnosticsProperty<bool>('showCloseButton', showCloseButton))
      ..add(ObjectFlagProperty<VoidCallback>.has('onDismissed', onDismissed));
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
