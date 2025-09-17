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
    this.rounded,
  });

  /// The child widget subtree to apply the override to.
  final Widget child;

  /// The theme mode to override. If null, inherits from ancestor Zeta.
  final ThemeMode? themeMode;

  /// The contrast to override. If null, inherits from ancestor Zeta.
  final ZetaContrast? contrast;

  /// {@macro zeta-component-rounded}
  final bool? rounded;

  @override
  Widget build(BuildContext context) {
    final parentZeta = Zeta.of(context);

    return ZetaProvider(
      key: ValueKey('$themeMode-$contrast-$rounded-${parentZeta.customThemeId}'),
      initialContrast: contrast ?? parentZeta.contrast,
      initialRounded: rounded ?? parentZeta.rounded,
      initialTheme: parentZeta.customThemeId,
      initialThemeMode: themeMode ?? parentZeta.themeMode,
      customThemes: ZetaProvider.of(context).customThemes,
      builder: (context, light, dark, themeMode) => child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ThemeMode?>('themeMode', themeMode))
      ..add(EnumProperty<ZetaContrast?>('contrast', contrast))
      ..add(DiagnosticsProperty<bool?>('rounded', rounded));
  }
}
