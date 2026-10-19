import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../zeta_flutter_theme.dart';

/// A widget that overrides some Zeta settings for its subtree, such as the theme mode, contrast,
/// color mode, token layer themes or breakpoint, while inheriting all other Zeta settings from the nearest
/// ancestor Zeta context.
class ZetaThemeOverride extends StatelessWidget {
  /// Constructs a [ZetaThemeOverride].
  const ZetaThemeOverride({
    super.key,
    required this.builder,
    this.themeMode,
    this.contrast,
    this.rounded,
    this.colorMode,
    this.primitivesTheme,
    this.paletteTheme,
    this.sizeTheme,
    this.typographyTheme,
    this.breakpoint,
  });

  /// The child widget subtree to apply the override to.
  final WidgetBuilder builder;

  /// The theme mode to override. If null, inherits from ancestor Zeta.
  final ThemeMode? themeMode;

  /// The contrast to override. If null, inherits from ancestor Zeta.
  final ZetaContrast? contrast;

  /// {@macro zeta-component-rounded}
  final bool? rounded;

  /// The color mode of [Zeta.tokens] to override. If null, inherits from ancestor Zeta.
  final ZetaColorMode? colorMode;

  /// The theme of the `primitives` token layer to override. If null, inherits from ancestor Zeta.
  final ZetaPrimitivesTheme? primitivesTheme;

  /// The theme of the `palette` token layer to override. If null, inherits from ancestor Zeta.
  final ZetaPaletteTheme? paletteTheme;

  /// The theme of the `size` token layer to override. If null, inherits from ancestor Zeta.
  final ZetaSizeTheme? sizeTheme;

  /// The theme of the `typography` token layer to override. If null, inherits from ancestor Zeta.
  final ZetaTypographyTheme? typographyTheme;

  /// The breakpoint of the `size` and `typography` token layers to force. If null, inherits from ancestor Zeta.
  final ZetaBreakpoint? breakpoint;

  @override
  Widget build(BuildContext context) {
    final parentZeta = Zeta.of(context);

    return ZetaProvider(
      key: ValueKey((themeMode, contrast, rounded, parentZeta.customThemeId)),
      initialContrast: contrast ?? parentZeta.contrast,
      initialRounded: rounded ?? parentZeta.roundedOverride,
      initialTheme: parentZeta.customThemeId,
      initialThemeMode: themeMode ?? parentZeta.themeMode,
      initialColorMode: colorMode ?? parentZeta.colorMode,
      initialPrimitivesTheme: primitivesTheme ?? parentZeta.primitivesTheme,
      initialPaletteTheme: paletteTheme ?? parentZeta.paletteTheme,
      initialSizeTheme: sizeTheme ?? parentZeta.sizeTheme,
      initialTypographyTheme: typographyTheme ?? parentZeta.typographyTheme,
      // The parent's breakpoint already follows the window, and this widget rebuilds when it changes.
      breakpoint: breakpoint ?? parentZeta.breakpoint,
      customThemes: ZetaProvider.of(context).customThemes,
      builder: (newContext, light, dark, themeMode) => Theme(
        data: themeMode == ThemeMode.dark ? dark : light,
        child: builder(newContext),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ThemeMode?>('themeMode', themeMode))
      ..add(EnumProperty<ZetaContrast?>('contrast', contrast))
      ..add(DiagnosticsProperty<bool?>('rounded', rounded))
      ..add(EnumProperty<ZetaColorMode?>('colorMode', colorMode))
      ..add(EnumProperty<ZetaPrimitivesTheme?>('primitivesTheme', primitivesTheme))
      ..add(EnumProperty<ZetaPaletteTheme?>('paletteTheme', paletteTheme))
      ..add(EnumProperty<ZetaSizeTheme?>('sizeTheme', sizeTheme))
      ..add(EnumProperty<ZetaTypographyTheme?>('typographyTheme', typographyTheme))
      ..add(EnumProperty<ZetaBreakpoint?>('breakpoint', breakpoint))
      ..add(ObjectFlagProperty<WidgetBuilder>.has('builder', builder));
  }
}
