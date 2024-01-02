import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// Component [ZetaBottomSheet]
class ZetaBottomSheet extends StatelessWidget {
  /// Constructor for [ZetaBottomSheet].
  const ZetaBottomSheet({
    super.key,
    this.title,
    this.titleAlignment,
    this.body,
    this.horizontalAlignment,
  });

  /// The title of [ZetaBottomSheet].
  final String? title;

  /// The alignment of the title.
  /// Default is `Alignment.center`
  final AlignmentGeometry? titleAlignment;

  /// The content of [ZetaBottomSheet].
  final Widget? body;

  /// The horizontal alignment of the [ZetaBottomSheet]'s content.
  final CrossAxisAlignment? horizontalAlignment;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final themeMode = Zeta.of(context).themeMode;
    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && PlatformDispatcher.instance.platformBrightness == Brightness.dark);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: isDark ? colors.cool.shade20 : colors.surfacePrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: horizontalAlignment ?? CrossAxisAlignment.center,
        children: [
          Align(
            child: SizedBox(
              height: 36,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(
                  Icons.maximize_rounded,
                  size: 60,
                  color: colors.surfaceDisabled,
                ),
              ),
            ),
          ),
          if (title != null)
            Align(
              alignment: titleAlignment ?? Alignment.center,
              child: Text(
                title!,
                style: ZetaText.zetaTitleLarge.copyWith(
                  color: colors.textDefault,
                  fontSize: 18,
                  height: 1.33,
                ),
              ),
            ),
          body ?? const SizedBox(),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<String?>('title', title))
      ..add(DiagnosticsProperty<AlignmentGeometry?>('titleAlignment', titleAlignment))
      ..add(EnumProperty<CrossAxisAlignment?>('horizontalAlignment', horizontalAlignment));
  }
}
