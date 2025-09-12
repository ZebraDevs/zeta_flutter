import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../zeta_flutter_theme.dart';

/// A widget that overrides only the theme mode or contrast for its subtree,
/// while inheriting all other Zeta settings from the nearest ancestor Zeta context.
class ZetaThemeOverride extends StatelessWidget {
  /// Constructs a [ZetaThemeOverride].
  const ZetaThemeOverride({
    super.key,
    required this.child,
    this.themeMode,
    this.contrast,
  });

  /// The child widget subtree to apply the override to.
  final Widget child;

  /// The theme mode to override. If null, inherits from ancestor Zeta.
  final ThemeMode? themeMode;

  /// The contrast to override. If null, inherits from ancestor Zeta.
  final ZetaContrast? contrast;

  @override
  Widget build(BuildContext context) {
    final parentZeta = Zeta.of(context);
    return Zeta(
      rounded: parentZeta.rounded,
      contrast: contrast ?? parentZeta.contrast,
      themeMode: themeMode ?? parentZeta.themeMode,
      customThemeId: parentZeta.customThemeId,
      // customPrimitives: parentZeta.primitives,
      // customSemantics: parentZeta.semantics, TODO(thelukewalton): Fix this to allow overrides of customPrimitives and customSemantics
      textStyles: parentZeta.textStyles,
      child: Builder(
        builder: (context) {
          print(
              'ZetaThemeOverride build with themeMode: ${Zeta.of(context).themeMode}, contrast: ${Zeta.of(context).contrast}');
          return child;
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ThemeMode?>('themeMode', themeMode))
      ..add(EnumProperty<ZetaContrast?>('contrast', contrast));
  }
}
