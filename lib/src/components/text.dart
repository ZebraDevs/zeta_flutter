import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';
import '../tokens.dart' as tokens;

/// {@template zeta-component-text}
/// ZetaText component.
///
/// Applies Zeta style to text, including fontFamily, size, lineHeight, spacing and other modifiers.
///
/// {@endtemplate}
/// See also:
/// * [Text].
class ZetaText extends StatelessWidget {
  static const double _defaultChMultiplier = 66;

  /// Text styles for Zeta.
  ///
  /// {@macro zeta-theme}
  static TextTheme textTheme = TextTheme(
    displayLarge: zetaDisplayLarge,
    displayMedium: zetaDisplayMedium,
    displaySmall: zetaDisplaySmall,
    headlineLarge: zetaHeadingLarge,
    headlineMedium: zetaHeadingMedium,
    headlineSmall: zetaHeadingSmall,
    titleLarge: zetaTitleLarge,
    titleMedium: zetaTitleMedium,
    titleSmall: zetaTitleSmall,
    bodyLarge: zetaBodyLarge,
    bodyMedium: zetaBodyMedium,
    bodySmall: zetaBodySmall,
    labelLarge: zetaLabelLarge,
    labelMedium: zetaLabelMedium,
    labelSmall: zetaLabelSmall,
  );

  /// Builds text theme for app based on an instance of [ZetaColors].
  static TextTheme withColor(Color color) {
    return TextTheme(
      displayLarge: zetaDisplayLarge.copyWith(color: color),
      displayMedium: zetaDisplayMedium.copyWith(color: color),
      displaySmall: zetaDisplaySmall.copyWith(color: color),
      headlineLarge: zetaHeadingLarge.copyWith(color: color),
      headlineMedium: zetaHeadingMedium.copyWith(color: color),
      headlineSmall: zetaHeadingSmall.copyWith(color: color),
      titleLarge: zetaTitleLarge.copyWith(color: color),
      titleMedium: zetaTitleMedium.copyWith(color: color),
      titleSmall: zetaTitleSmall.copyWith(color: color),
      bodyLarge: zetaBodyLarge.copyWith(color: color),
      bodyMedium: zetaBodyMedium.copyWith(color: color),
      bodySmall: zetaBodySmall.copyWith(color: color),
      labelLarge: zetaLabelLarge.copyWith(color: color),
      labelMedium: zetaLabelMedium.copyWith(color: color),
      labelSmall: zetaLabelSmall.copyWith(color: color),
    );
  }

  /// {@template zeta-type-body-xs}
  /// Smallest body text.
  ///
  /// Used for UI components and UI content design.
  ///
  /// {@endtemplate}
  static TextStyle zetaBodyXSmall = const TextStyle(
    fontSize: tokens.Dimensions.x3,
    fontWeight: FontWeight.w400,
    height: tokens.Dimensions.x3 / tokens.Dimensions.x4,
  );

  /// {@template zeta-type-body-s}
  /// Small body text.
  ///
  /// Used for UI components and UI content design.
  ///
  /// See also:
  /// * [TextTheme.bodySmall].
  /// {@endtemplate}
  static TextStyle zetaBodySmall = const TextStyle(
    fontSize: tokens.Dimensions.x3_5,
    fontWeight: FontWeight.w400,
    height: 18 / 14,
  );

  /// {@template zeta-type-body-m}
  /// Medium body text.
  ///
  /// Used for overall content.
  ///
  /// See also:
  /// * [TextTheme.bodyMedium].
  /// {@endtemplate}
  static TextStyle zetaBodyMedium = const TextStyle(
    fontSize: tokens.Dimensions.x4,
    fontWeight: FontWeight.w400,
    height: tokens.Dimensions.x6 / tokens.Dimensions.x4,
  );

  /// {@template zeta-type-body-l}
  /// Large body text.
  ///
  /// Used for UI components and UI content design.
  ///
  /// See also:
  /// * [TextTheme.bodyLarge].
  /// {@endtemplate}
  static TextStyle zetaBodyLarge = const TextStyle(
    fontSize: tokens.Dimensions.x5,
    fontWeight: FontWeight.w400,
    height: tokens.Dimensions.x6 / tokens.Dimensions.x5,
  );

  /// {@template zeta-type-label-s}
  /// Small label text.
  ///
  /// Used for UI components and UI content.
  ///
  /// See also:
  /// * [TextTheme.labelSmall].
  /// {@endtemplate}
  static TextStyle zetaLabelSmall = const TextStyle(
    fontSize: tokens.Dimensions.x3,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x4 / tokens.Dimensions.x3,
  );

  /// {@template zeta-type-label-m}
  /// Medium label text.
  ///
  /// Used for UI components and UI content.
  ///
  /// See also:
  /// * [TextTheme.labelMedium].
  /// {@endtemplate}
  static TextStyle zetaLabelMedium = const TextStyle(
    fontSize: tokens.Dimensions.x3_5,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x3_5 / tokens.Dimensions.x5,
  );

  /// {@template zeta-type-label-l}
  /// Large label text.
  ///
  /// Used for UI components and UI content.
  ///
  /// See also:
  /// * [TextTheme.labelLarge].
  /// {@endtemplate}
  static TextStyle zetaLabelLarge = const TextStyle(
    fontSize: tokens.Dimensions.x4,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x4 / tokens.Dimensions.x6,
  );

  /// {@template zeta-type-title-s}
  /// Heading 6 / Small title text.
  ///
  /// Used for UI components and UI content design.
  ///
  /// See also:
  /// * [TextTheme.titleSmall].
  /// {@endtemplate}
  static TextStyle zetaTitleSmall = const TextStyle(
    fontSize: tokens.Dimensions.x3,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x4 / tokens.Dimensions.x3,
  );

  /// {@template zeta-type-title-m}
  /// Heading 5 / Medium title text.
  ///
  /// Used for UI components and UI content design.
  ///
  /// See also:
  /// * [TextTheme.titleMedium].
  /// {@endtemplate}
  static TextStyle zetaTitleMedium = const TextStyle(
    fontSize: tokens.Dimensions.x4,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x5 / tokens.Dimensions.x4,
  );

// TODO(tokens): How to add color and font family here?
// Both can be changed at runtime so can;t be const.
// But also how do we access them without state?

  /// {@template zeta-type-title-l}
  /// Heading 4 / Large title text.
  ///
  /// Used for UI sections and landing pages.
  ///
  /// See also:
  /// * [TextTheme.titleLarge].
  /// {@endtemplate}
  static TextStyle zetaTitleLarge = const TextStyle(
    fontSize: tokens.Dimensions.x5,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x4 / tokens.Dimensions.x5,
  );

  /// {@template zeta-type-heading-s}
  /// Heading 3 text.
  ///
  /// Used for UI sections and landing pages.
  ///
  /// See also:
  /// * [TextTheme.headlineSmall].
  /// {@endtemplate}
  static TextStyle zetaHeadingSmall = const TextStyle(
    fontSize: tokens.Dimensions.x6,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x7 / tokens.Dimensions.x6,
  );

  /// {@template zeta-type-heading-m}
  /// Heading 2 text.
  ///
  /// Used for UI sections and landing pages.
  ///
  /// See also:
  /// * [TextTheme.headlineMedium].
  /// {@endtemplate}
  static TextStyle zetaHeadingMedium = const TextStyle(
    fontSize: tokens.Dimensions.x7,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x8 / tokens.Dimensions.x7,
  );

  /// {@template zeta-type-heading-l}
  /// Heading 1 text.
  ///
  /// Used for UI sections and landing pages.
  /// See also:
  /// * [TextTheme.headlineLarge].
  /// {@endtemplate}
  static TextStyle zetaHeadingLarge = const TextStyle(
    fontSize: tokens.Dimensions.x8,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x9 / tokens.Dimensions.x8,
  );

  /// {@template zeta-type-display-s}
  /// Small display text.
  ///
  /// Used for landing page intros and sections.
  ///
  /// See also:
  /// * [TextTheme.displaySmall].
  /// {@endtemplate}
  static TextStyle zetaDisplaySmall = zetaHeadingSmall;

  /// {@template  zeta-type-display-m}
  /// Medium display text.
  ///
  /// Used for landing page intros and sections.
  ///
  /// See also:
  /// * [TextTheme.displayMedium].
  /// {@endtemplate}
  static TextStyle zetaDisplayMedium = zetaHeadingMedium;

  /// {@template  zeta-type-display-l}
  /// Large display text.
  ///
  /// Used for landing page intros.
  /// See also:
  /// * [TextTheme.displayLarge].
  /// {@endtemplate}
  static TextStyle zetaDisplayLarge = zetaHeadingLarge;

  /// Gets approximate char width based on width of O in IBM Plex Sans
  ///
  /// Only works for IBM Plex.
  static double _ch({double multiplier = _defaultChMultiplier, TextStyle? style}) {
    final setStyle = style ?? zetaBodyMedium;
    const plexCh = 0.6;

    return multiplier * plexCh * (setStyle.fontSize ?? tokens.Dimensions.x3);
  }

  /// The text to be displayed.
  ///
  /// See also:
  /// * [Text.data].
  final String? data;

  /// The style applied to the text.
  ///
  /// Defaults to [zetaBodyMedium].
  ///
  /// See also:
  /// * [Text.style].
  final TextStyle? style;

  /// Sets text color.
  ///
  /// See also:
  /// * [TextStyle.color].
  final Color? textColor;

  /// Max width of Text box using [_ch]. Not measured in dp / px.
  ///
  /// [_ch] approximates width of a character using O as basis, so a maxWidth of 60 theoretically returns a max width containing 60 characters.
  ///
  /// Only works with 'IBM Plex Sans'.
  final double? maxWidth;

  /// Font size override.
  ///
  /// {@template zeta-text-override}
  /// Optional as this should be set using [style].
  /// {@endtemplate}
  /// See also:
  /// * [TextStyle.fontSize].
  final double? fontSize;

  /// Font weight override.
  ///
  /// {@macro zeta-text-override}
  ///
  /// See also:
  /// * [TextStyle.fontWeight].
  final FontWeight? fontWeight;

  /// Font style override, used to set text to _italic_.
  ///
  ///
  ///
  /// See also:
  /// * [TextStyle.fontStyle].
  /// * [FontStyle.italic].
  final FontStyle? fontStyle;

  /// Sets all text to uppercase.
  ///
  /// See also:
  /// * [String.toUpperCase].
  final bool upperCase;

  /// Decoration override, used to apply decorations such as underline.
  ///
  /// See also:
  /// * [TextDecoration.underline].
  /// * [TextDecoration].
  final TextDecoration? decoration;

  /// Text direction, used to set text to either Left to Right or Right to Left.
  ///
  /// See also:
  /// * [TextDirection.values].
  final TextDirection textDirection;

  /// Sets padding top to 0.
  ///
  /// Set to true when this text is first in a list.
  final bool first;

  /// Sets padding bottom to 0.
  ///
  /// Set to true when this text is last in a list.
  final bool last;

  /// Sets the line height to 1 and spacing to 0.
  ///
  /// Defaults to false.
  final bool resetHeight;

  /// Constructor for [ZetaText].
  const ZetaText(
    this.data, {
    this.style,
    this.resetHeight = false,
    this.textColor,
    this.fontSize,
    this.maxWidth,
    this.fontWeight,
    this.fontStyle,
    this.upperCase = false,
    this.decoration,
    this.textDirection = TextDirection.ltr,
    this.first = false,
    this.last = false,
    super.key,
  });

  EdgeInsets get _padding {
    if (resetHeight || (first && last)) return tokens.Dimensions.x0.squish;

    return EdgeInsets.only(
      top: first ? tokens.Dimensions.x0 : tokens.Dimensions.x2,
      bottom: last ? tokens.Dimensions.x0 : tokens.Dimensions.x2,
    );
  }

  double? get _fontSize {
    if (fontSize == null) return null;
    if (fontSize == tokens.Dimensions.x3_5) {
      return tokens.Dimensions.x4 / tokens.Dimensions.x3_5;
    }

    return ((fontSize ?? 1) + tokens.Dimensions.x1) / (fontSize ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle thisStyle = (style ?? ZetaText.zetaBodyMedium).copyWith(
      fontSize: style?.fontSize,
      fontWeight: style?.fontWeight,
      height: style?.height,
    );

    String data = this.data ?? '';
    final Color color = textColor ?? Zeta.of(context).colors.textDefault;

    thisStyle = thisStyle.copyWith(
      fontSize: (fontSize ?? thisStyle.fontSize ?? tokens.Typography.defaultTextSize) *
          MediaQuery.of(context).textScaleFactor,
      height: _fontSize,
      fontWeight: fontWeight,
      decoration: decoration ?? TextDecoration.none,
      fontStyle: fontStyle,
      color: color,
    );

    if (resetHeight) thisStyle = thisStyle.copyWith(height: 1);
    if (upperCase) data = data.toUpperCase();

    return Padding(
      padding: _padding,
      child: maxWidth == null
          ? Text(data, style: thisStyle, textDirection: textDirection)
          : Align(
              alignment: textDirection == TextDirection.rtl ? Alignment.centerRight : Alignment.centerLeft,
              child: SizedBox(
                width: maxWidth == null ? null : _ch(multiplier: maxWidth ?? 0, style: thisStyle),
                child: Text(data, style: thisStyle, textDirection: textDirection),
              ),
            ),
    );
  }

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-body-xs}
  ZetaText.bodyXSmall(
    this.data, {
    this.resetHeight = false,
    this.maxWidth,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    super.key,
  }) : style = zetaBodyXSmall;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-body-s}
  ZetaText.bodySmall(
    this.data, {
    this.resetHeight = false,
    this.maxWidth,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    super.key,
  }) : style = zetaBodySmall;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-body-m}
  ZetaText.bodyMedium(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaBodyMedium;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-body-l}
  ZetaText.bodyLarge(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaBodyLarge;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-label-s}
  ZetaText.labelSmall(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    super.key,
    this.maxWidth,
  }) : style = zetaLabelSmall;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-label-m}
  ZetaText.labelMedium(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaLabelMedium;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-label-l}
  ZetaText.labelLarge(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaLabelLarge;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-title-s}
  ZetaText.titleSmall(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaTitleSmall;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-title-m}
  ZetaText.titleMedium(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaTitleMedium;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-title-l}
  ZetaText.titleLarge(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaTitleLarge;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-heading-s}
  ZetaText.headingSmall(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaHeadingSmall;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-heading-m}
  ZetaText.headingMedium(
    this.data, {
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.resetHeight = false,
    this.maxWidth,
    super.key,
  }) : style = zetaHeadingMedium;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-heading-l}
  ZetaText.headingLarge(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaHeadingLarge;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-display-s}
  ZetaText.displaySmall(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaDisplaySmall;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-display-m}
  ZetaText.displayMedium(
    this.data, {
    this.resetHeight = false,
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.maxWidth,
    super.key,
  }) : style = zetaDisplayMedium;

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-display-l}
  ZetaText.displayLarge(
    this.data, {
    this.decoration,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.first = false,
    this.last = false,
    this.textColor,
    this.textDirection = TextDirection.ltr,
    this.upperCase = false,
    this.resetHeight = false,
    this.maxWidth,
    super.key,
  }) : style = zetaDisplayLarge;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('data', data));
    properties.add(DiagnosticsProperty<TextStyle?>('style', style));
    properties.add(ColorProperty('textColor', textColor));
    properties.add(DoubleProperty('maxWidth', maxWidth));
    properties.add(DoubleProperty('fontSize', fontSize));
    properties.add(DiagnosticsProperty<FontWeight?>('fontWeight', fontWeight));
    properties.add(EnumProperty<FontStyle?>('fontStyle', fontStyle));
    properties.add(DiagnosticsProperty<bool>('upperCase', upperCase));
    properties.add(DiagnosticsProperty<TextDecoration?>('decoration', decoration));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection));
    properties.add(DiagnosticsProperty<bool>('first', first));
    properties.add(DiagnosticsProperty<bool>('last', last));
    properties.add(DiagnosticsProperty<bool>('resetHeight', resetHeight));
  }
}

/// Extension to add Zeta's extra small text size.
extension XSmall on TextTheme {
  /// Smallest body text size.
  TextStyle? get bodyXSmall {
    return ZetaText.zetaBodyXSmall;
  }
}
