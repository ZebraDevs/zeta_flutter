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

  /// If it is rounded.
  final bool? rounded;

  @override
  Widget build(BuildContext context) {
    final parentZeta = Zeta.of(context);
    return ZetaProvider(
      initialContrast: contrast ?? parentZeta.contrast,
      initialRounded: rounded ?? parentZeta.rounded,
      initialTheme: parentZeta.customThemeId,
      initialThemeMode: themeMode ?? parentZeta.themeMode,
      customThemes: parentZeta.customThemes,
      // rounded: parentZeta.rounded,
      // contrast: contrast ?? parentZeta.contrast,
      // themeMode: themeMode ?? parentZeta.themeMode,
      // customThemeId: parentZeta.customThemeId,
      // // customPrimitives: parentZeta.primitives,
      // // customSemantics: parentZeta.semantics, TODO(thelukewalton): Fix this to allow overrides of customPrimitives and customSemantics
      // textStyles: parentZeta.textStyles,
      // child: Builder(
      builder: (context, light, dark, themeMode) {
        return Theme(data: themeMode.isDark ? dark : light, child: child);
      },
      // ),
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

/// Dark theme example from SYNC
// import 'package:comms/app/app.dart';
// import 'package:comms/widgets/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:zds_flutter/zds_flutter.dart';

// class ZetaDarkTheme extends StatelessWidget {
//   const ZetaDarkTheme({super.key, required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     final zeta = context.zeta;
//     // final themeData = zeta.themeData;
//     return ZetaProvider(
//       // initialThemeData: themeData,
//       initialThemeMode: ThemeMode.dark,
//       initialContrast: zeta.contrast,
//       builder: (BuildContext context, ThemeData light, ThemeData dark, ThemeMode themeMode) {
//         return Theme(data: buildSyncTheme(light, dark, isDark: true), child: child);
//       },
//     );
//   }
// }
