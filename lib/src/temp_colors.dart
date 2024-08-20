import 'package:flutter/material.dart';

import '../zeta_flutter.dart';

/// Colors to be removed at v1.0.0
@Deprecated('Removed in v1.0.0')
extension TempColors on ZetaSemanticColors {
  /// Primary color swatch.
  ///
  /// Defaults to [ZetaColorBase.blue].
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Removed in v1.0.0')
  ZetaColorSwatch get primary => primitives.blue;

  /// Secondary color used in app.
  ///
  /// Defaults to [ZetaColorBase.yellow]
  ///
  /// Maps to [ColorScheme.secondary].
  @Deprecated('Removed in v1.0.0')
  ZetaColorSwatch get secondary => primitives.yellow;

  /// Secondary color used in app.
  ///
  /// Defaults to `ZetaColors.red.60`.
  ///
  /// Maps to [ColorScheme.error].
  @Deprecated('Removed in v1.0.0')
  ZetaColorSwatch get error => primitives.red;

  /// Cool  color swatch.
  ///
  /// Defaults to [ZetaColorBase.cool].
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Removed in v1.0.0')
  ZetaColorSwatch get cool => primitives.cool;

  /// Warm  color swatch.
  ///
  /// Defaults to [ZetaColorBase.warm].
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Removed in v1.0.0')
  ZetaColorSwatch get warm => primitives.warm;

  /// Pure color swatch.
  ///
  /// Defaults to [ZetaColorBase.pure].
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Removed in v1.0.0')
  ZetaPureColorSwatch get pure => primitives.pure;

  /// White color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// Defaults to [ZetaColorBase.white].
  @Deprecated('Removed in v1.0.0')
  Color get white => primitives.pure.shade0;

  /// Shadow color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// Defaults to [ZetaColorBase.black].
  @Deprecated('Removed in v1.0.0')
  Color get black => primitives.pure.shade1000;

  /// Surface color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// * Light mode: `ZetaColors.black`
  /// * Dark mode: `ZetaColors.white`.
  @Deprecated('Use surface.primary instead. ' 'Removed in v1.0.0')
  Color get surfacePrimary => surface.primary;

  /// Secondary surface color.
  ///
  /// * `ZetaColors.cool.10`.
  @Deprecated('Use surface.secondary instead. ' 'Removed in v1.0.0')
  Color get surfaceSecondary => surface.secondary;

  /// Tertiary surface color.
  ///
  /// Maps to [ColorScheme.surface] and [ThemeData.scaffoldBackgroundColor]
  ///
  /// * `ZetaColors.warm.10`.
  @Deprecated('Removed in v1.0.0')
  Color get surfaceTertiary => primitives.warm.shade10;

  /// Default text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// {@template zeta-color-dark}
  /// Color swatches are inverted if [ZetaColors.brightness] is Dark.
  /// {@endtemplate}
  @Deprecated('Use main.defaultColor instead. ' 'Removed in v1.0.0')
  Color get textDefault => main.defaultColor;

  /// Subtle text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.70`.
  ///
  /// Maps to [ColorScheme.onSurface].
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use main.subtle instead. ' 'Removed in v1.0.0')
  Color get textSubtle => main.subtle;

  /// Disabled text / icon color.
  ///
  /// Defaults to `ZetaColors.cool.50`.
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use main.disabledColor instead. ' 'Removed in v1.0.0')
  Color get textDisabled => main.disabled;

  /// Inverse text / icon color.
  ///
  /// Used for text that is not on [ColorScheme.surface] or [ThemeData.scaffoldBackgroundColor].
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use main.inverse instead. ' 'Removed in v1.0.0')
  Color get textInverse => main.inverse;

  /// Default icon color.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use main.defaultColor instead. ' 'Removed in v1.0.0')
  Color get iconDefault => main.defaultColor;

  /// Subtle icon color.
  ///
  /// Defaults to `ZetaColors.cool.70`.
  ///
  /// Maps to [ColorScheme.onSurface].
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use main.subtle instead. ' 'Removed in v1.0.0')
  Color get iconSubtle => main.subtle;

  /// Disabled icon color.
  ///
  /// Defaults to `ZetaColors.cool.50`.
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use main.disabled instead. ' 'Removed in v1.0.0')
  Color get iconDisabled => main.disabled;

  /// Inverse icon color.
  ///
  /// Used for text that is not on [ColorScheme.surface] or [ThemeData.scaffoldBackgroundColor].
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use main.inverse instead. ' 'Removed in v1.0.0')
  Color get iconInverse => main.inverse;

  ///  Default Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.defaultColor instead. ' 'Removed in v1.0.0')
  Color get surfaceDefault => surface.defaultColor;

  ///  Default-inverse Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.defaultInverse instead. ' 'Removed in v1.0.0')
  Color get surfaceDefaultInverse => surface.defaultInverse;

  ///  Hover Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.hover instead. ' 'Removed in v1.0.0')
  Color get surfaceHover => surface.hover;

  ///  Selected Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.selected instead. ' 'Removed in v1.0.0')
  Color get surfaceSelected => surface.selected;

  ///  Selected-hover Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.selectedHover instead. ' 'Removed in v1.0.0')
  Color get surfaceSelectedHover => surface.selectedHover;

  ///  Disabled Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.disabledColor instead. ' 'Removed in v1.0.0')
  Color get surfaceDisabled => surface.disabled;

  ///  Cool Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.cool instead. ' 'Removed in v1.0.0')
  Color get surfaceCool => surface.cool;

  ///  Warm Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.warm instead. ' 'Removed in v1.0.0')
  Color get surfaceWarm => surface.warm;

  ///  Primary-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.primarySubtle instead. ' 'Removed in v1.0.0')
  Color get surfacePrimarySubtle => surface.primarySubtle;

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.avatar.blue instead. ' 'Removed in v1.0.0')
  Color get surfaceAvatarBlue => surface.avatar.blue;

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.avatar.green instead. ' 'Removed in v1.0.0')
  Color get surfaceAvatarGreen => surface.avatar.green;

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.avatar.orange instead. ' 'Removed in v1.0.0')
  Color get surfaceAvatarOrange => surface.avatar.orange;

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.avatar.pink instead. ' 'Removed in v1.0.0')
  Color get surfaceAvatarPink => surface.avatar.pink;

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.avatar.purple instead. ' 'Removed in v1.0.0')
  Color get surfaceAvatarPurple => surface.avatar.purple;

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.avatar.teal instead. ' 'Removed in v1.0.0')
  Color get surfaceAvatarTeal => surface.avatar.teal;

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.avatar.yellow instead. ' 'Removed in v1.0.0')
  Color get surfaceAvatarYellow => surface.avatar.yellow;

  ///  Secondary-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.secondarySubtle instead. ' 'Removed in v1.0.0')
  Color get surfaceSecondarySubtle => surface.secondarySubtle;

  ///  Positive Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.positive instead. ' 'Removed in v1.0.0')
  Color get surfacePositive => surface.positive;

  ///  Positive-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.positiveSubtle instead. ' 'Removed in v1.0.0')
  Color get surfacePositiveSubtle => surface.positiveSubtle;

  ///  Warning Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.warning instead. ' 'Removed in v1.0.0')
  Color get surfaceWarning => surface.warning;

  ///  Warning-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.warningSubtle instead. ' 'Removed in v1.0.0')
  Color get surfaceWarningSubtle => surface.warningSubtle;

  ///  Negative Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.negative instead. ' 'Removed in v1.0.0')
  Color get surfaceNegative => surface.negative;

  ///  Negative-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.negativeSubtle instead. ' 'Removed in v1.0.0')
  Color get surfaceNegativeSubtle => surface.negativeSubtle;

  ///  Info Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.info instead. ' 'Removed in v1.0.0')
  Color get surfaceInfo => surface.info;

  ///  Info-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use surface.infoSubtle instead. ' 'Removed in v1.0.0')
  Color get surfaceInfoSubtle => surface.infoSubtle;

  ///  Default Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.defaultColor instead. ' 'Removed in v1.0.0')
  Color get borderDefault => border.defaultColor;

  ///  Subtle Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.subtle instead. ' 'Removed in v1.0.0')
  Color get borderSubtle => border.subtle;

  ///  Hover Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.hover instead. ' 'Removed in v1.0.0')
  Color get borderHover => border.hover;

  ///  Selected Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.selected instead. ' 'Removed in v1.0.0')
  Color get borderSelected => border.selected;

  ///  Disabled Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.disabledColor instead. ' 'Removed in v1.0.0')
  Color get borderDisabled => border.disabled;

  ///  Pure Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.pure instead. ' 'Removed in v1.0.0')
  Color get borderPure => border.pure;

  ///  Primary-main Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.primaryMain instead. ' 'Removed in v1.0.0')
  Color get borderPrimaryMain => border.primaryMain;

  ///  Primary Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.primary instead. ' 'Removed in v1.0.0')
  Color get borderPrimary => border.primary;

  ///  Secondary Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.secondary instead. ' 'Removed in v1.0.0')
  Color get borderSecondary => border.secondary;

  ///  Positive Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.positive instead. ' 'Removed in v1.0.0')
  Color get borderPositive => border.positive;

  ///  Warning Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.warning instead. ' 'Removed in v1.0.0')
  Color get borderWarning => border.warning;

  ///  Negative Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.negative instead. ' 'Removed in v1.0.0')
  Color get borderNegative => border.negative;

  ///  Info Border Color
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use border.info instead. ' 'Removed in v1.0.0')
  Color get borderInfo => border.info;

  /// Blue color swatch
  ///
  /// Defaults to [ZetaColorBase.blue]
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use primitives.blue instead. ' 'Removed in v1.0.0')
  ZetaColorSwatch get blue => primitives.blue;

  /// Green color swatch
  ///
  /// Defaults to [ZetaColorBase.green]
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use primitives.green instead. ' 'Removed in v1.0.0')
  ZetaColorSwatch get green => primitives.green;

  /// Red color swatch
  ///
  /// Defaults to [ZetaColorBase.red]
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use primitives.red instead. ' 'Removed in v1.0.0')
  ZetaColorSwatch get red => primitives.red;

  /// Orange color swatch
  ///
  /// Defaults to [ZetaColorBase.orange]
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use primitives.orange instead. ' 'Removed in v1.0.0')
  ZetaColorSwatch get orange => primitives.orange;

  /// Purple color swatch
  ///
  /// Defaults to [ZetaColorBase.purple]
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use primitives.purple instead. ' 'Removed in v1.0.0')
  ZetaColorSwatch get purple => primitives.purple;

  /// Yellow color swatch
  ///
  /// Defaults to [ZetaColorBase.yellow]
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use primitives.yellow instead. ' 'Removed in v1.0.0')
  ZetaColorSwatch get yellow => primitives.yellow;

  /// Teal color swatch
  ///
  /// Defaults to [ZetaColorBase.teal]
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use primitives.teal instead. ' 'Removed in v1.0.0')
  ZetaColorSwatch get teal => primitives.teal;

  /// Pink color swatch
  ///
  /// Defaults to [ZetaColorBase.pink]
  ///
  /// {@macro zeta-color-dark}
  @Deprecated('Use primitives.pink instead. ' 'Removed in v1.0.0')
  ZetaColorSwatch get pink => primitives.pink;
}
