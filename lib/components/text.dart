import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../tokens.dart' as tokens;
import 'spacing.dart';

/// Determine whether to show mobile text for heading / display.
extension ResponsiveBreak on DeviceType {
  /// Determine whether to show mobile text for heading / display.
  bool get responsiveText {
    return name == 'mobileLandscape' || name == 'mobilePortrait';
  }
}

/// Extension to add [mobileStyle] to [TextStyle].
extension Responsive on TextStyle {
  /// Gets a responsive variant of a Zeta TextStyle.
  ///
  /// Variants exist for Zeta Heading and Display TextStyles, otherwise the TextStyle is returned unchanged.
  TextStyle get mobileStyle {
    final Map<TextStyle, TextStyle> responsiveMap = {
      ZetaText.zetaHeadingSmall: ZetaText.zetaHeadingSmallResponsive,
      ZetaText.zetaHeadingMedium: ZetaText.zetaHeadingMediumResponsive,
      ZetaText.zetaHeadingLarge: ZetaText.zetaHeadingLargeResponsive,
      ZetaText.zetaDisplaySmall: ZetaText.zetaDisplaySmallResponsive,
      ZetaText.zetaDisplayMedium: ZetaText.zetaDisplayMediumResponsive,
      ZetaText.zetaDisplayLarge: ZetaText.zetaDisplayLargeResponsive,
    };

    return responsiveMap[this] ?? this;
  }
}

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
  static const TextTheme textTheme = TextTheme(
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

  /// Buids text theme for app based on an instance of [ZetaColors].
  static TextTheme textThemeBuilder(ZetaColors colors) {
    return TextTheme(
      displayLarge: zetaDisplayLarge.copyWith(color: colors.textDefault),
      displayMedium: zetaDisplayMedium.copyWith(color: colors.textDefault),
      displaySmall: zetaDisplaySmall.copyWith(color: colors.textDefault),
      headlineLarge: zetaHeadingLarge.copyWith(color: colors.textDefault),
      headlineMedium: zetaHeadingMedium.copyWith(color: colors.textDefault),
      headlineSmall: zetaHeadingSmall.copyWith(color: colors.textDefault),
      titleLarge: zetaTitleLarge.copyWith(color: colors.textDefault),
      titleMedium: zetaTitleMedium.copyWith(color: colors.textDefault),
      titleSmall: zetaTitleSmall.copyWith(color: colors.textDefault),
      bodyLarge: zetaBodyLarge.copyWith(color: colors.textDefault),
      bodyMedium: zetaBodyMedium.copyWith(color: colors.textDefault),
      bodySmall: zetaBodySmall.copyWith(color: colors.textDefault),
      labelLarge: zetaLabelLarge.copyWith(color: colors.textDefault),
      labelMedium: zetaLabelMedium.copyWith(color: colors.textDefault),
      labelSmall: zetaLabelSmall.copyWith(color: colors.textDefault),
    );
  }

  /// Returns responsive text style.
  ///
  /// Should only be used on [DeviceType.mobileLandscape] and [DeviceType.mobilePortrait].
  ///
  /// Automatically applied in [ZetaText] but must be applied manually otherwise.
  static const TextTheme textThemeMobile = TextTheme(
    displayLarge: zetaDisplayLargeResponsive,
    displayMedium: zetaDisplayMediumResponsive,
    displaySmall: zetaDisplaySmallResponsive,
    headlineLarge: zetaHeadingLargeResponsive,
    headlineMedium: zetaHeadingMediumResponsive,
    headlineSmall: zetaHeadingSmallResponsive,
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

  /// {@template zeta-type-body-s}
  /// Smallest body text.
  ///
  /// Used for UI components and UI content design.
  ///
  /// See also:
  /// * [TextTheme.bodySmall].
  /// {@endtemplate}
  static const TextStyle zetaBodySmall = TextStyle(
    fontSize: tokens.Dimensions.x3,
    fontWeight: FontWeight.w400,
    height: tokens.Dimensions.x4 / tokens.Dimensions.x3,
  );

  /// {@template zeta-type-body-m}
  /// Medium body text.
  ///
  /// Used for overall content.
  ///
  /// See also:
  /// * [TextTheme.bodyMedium].
  /// {@endtemplate}
  static const TextStyle zetaBodyMedium = TextStyle(
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
  static const TextStyle zetaBodyLarge = TextStyle(
    fontSize: tokens.Dimensions.x5,
    fontWeight: FontWeight.w400,
    height: tokens.Dimensions.x7 / tokens.Dimensions.x5,
  );

  /// {@template zeta-type-label-s}
  /// Small label text.
  ///
  /// Used for UI components and UI content.
  ///
  /// See also:
  /// * [TextTheme.labelSmall].
  /// {@endtemplate}
  static const TextStyle zetaLabelSmall = TextStyle(
    fontSize: tokens.Dimensions.x3,
    fontWeight: FontWeight.w500,
    height: 1,
  );

  /// {@template zeta-type-label-m}
  /// Medium label text.
  ///
  /// Used for UI components and UI content.
  ///
  /// See also:
  /// * [TextTheme.labelMedium].
  /// {@endtemplate}
  static const TextStyle zetaLabelMedium = TextStyle(
    fontSize: tokens.Dimensions.x4,
    fontWeight: FontWeight.w500,
    height: 1,
  );

  /// {@template zeta-type-label-l}
  /// Large label text.
  ///
  /// Used for UI components and UI content.
  ///
  /// See also:
  /// * [TextTheme.labelLarge].
  /// {@endtemplate}
  static const TextStyle zetaLabelLarge = TextStyle(
    fontSize: tokens.Dimensions.x5,
    fontWeight: FontWeight.w500,
    height: 1,
  );

  /// {@template zeta-type-title-s}
  /// Small title text.
  ///
  /// Used for UI components and UI content design.
  ///
  /// See also:
  /// * [TextTheme.titleSmall].
  /// {@endtemplate}
  static const TextStyle zetaTitleSmall = TextStyle(
    fontSize: tokens.Dimensions.x3,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x4 / tokens.Dimensions.x3,
  );

  /// {@template zeta-type-title-m}
  /// Medium title text.
  ///
  /// Used for UI components and UI content design.
  ///
  /// See also:
  /// * [TextTheme.titleMedium].
  /// {@endtemplate}
  static const TextStyle zetaTitleMedium = TextStyle(
    fontSize: tokens.Dimensions.x4,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x5 / tokens.Dimensions.x4,
  );

  /// {@template zeta-type-title-l}
  /// Large title text.
  ///
  /// Used for UI sections and landing pages.
  ///
  /// See also:
  /// * [TextTheme.titleLarge].
  /// {@endtemplate}
  static const TextStyle zetaTitleLarge = TextStyle(
    fontSize: tokens.Dimensions.x5,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x5 / tokens.Dimensions.x6,
  );

  /// {@template zeta-type-heading-s}
  /// Heading 3 text.
  ///
  /// Used for UI sections and landing pages.
  ///
  /// See also:
  /// * [TextTheme.headlineSmall].
  /// {@endtemplate}
  static const TextStyle zetaHeadingSmall = TextStyle(
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
  static const TextStyle zetaHeadingMedium = TextStyle(
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
  static const TextStyle zetaHeadingLarge = TextStyle(
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
  static const TextStyle zetaDisplaySmall = TextStyle(
    fontSize: tokens.Dimensions.x9,
    fontWeight: FontWeight.w300,
    height: tokens.Dimensions.x9 / tokens.Dimensions.x10,
  );

  /// {@template  zeta-type-display-m}
  /// Medium display text.
  ///
  /// Used for landing page intros and sections.
  ///
  /// See also:
  /// * [TextTheme.displayMedium].
  /// {@endtemplate}
  static const TextStyle zetaDisplayMedium = TextStyle(
    fontSize: tokens.Dimensions.x11,
    fontWeight: FontWeight.w300,
    height: tokens.Dimensions.x12 / tokens.Dimensions.x11,
  );

  /// {@template  zeta-type-display-l}
  /// Large display text.
  ///
  /// Used for landing page intros.
  /// See also:
  /// * [TextTheme.displayLarge].
  /// {@endtemplate}
  static const TextStyle zetaDisplayLarge = TextStyle(
    fontSize: tokens.Dimensions.x13,
    fontWeight: FontWeight.w300,
    height: tokens.Dimensions.x14 / tokens.Dimensions.x13,
  );

  /// {@template zeta-type-description}
  /// Description text.
  ///
  /// This size falls off the mini unit scale, to meet very specific criteria, and forced to be used for single line text only. It never changes line height even in component design.
  ///
  /// Used for UI components and UI content design.
  /// {@endtemplate}
  static const TextStyle zetaDescription = TextStyle(
    fontSize: tokens.Dimensions.x3_5,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x4 / tokens.Dimensions.x3_5,
  );

  /// {@macro zeta-type-responsive}
  ///
  /// {@macro zeta-type-heading-s}
  static const TextStyle zetaHeadingSmallResponsive = TextStyle(
    fontSize: tokens.Dimensions.x5,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x6 / tokens.Dimensions.x5,
  );

  /// {@macro zeta-type-responsive}
  ///
  /// {@macro zeta-type-heading-m}
  static const TextStyle zetaHeadingMediumResponsive = TextStyle(
    fontSize: tokens.Dimensions.x6,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x7 / tokens.Dimensions.x6,
  );

  /// {@macro zeta-type-responsive}
  ///
  /// {@macro zeta-type-heading-l}
  static const TextStyle zetaHeadingLargeResponsive = TextStyle(
    fontSize: tokens.Dimensions.x7,
    fontWeight: FontWeight.w500,
    height: tokens.Dimensions.x8 / tokens.Dimensions.x7,
  );

  /// {@macro zeta-type-responsive}
  ///
  /// {@macro zeta-type-display-s}
  static const TextStyle zetaDisplaySmallResponsive = TextStyle(
    fontSize: tokens.Dimensions.x8,
    fontWeight: FontWeight.w300,
    height: tokens.Dimensions.x9 / tokens.Dimensions.x8,
  );

  /// {@macro zeta-type-responsive}
  ///
  /// {@macro zeta-type-display-m}
  static const TextStyle zetaDisplayMediumResponsive = TextStyle(
    fontSize: tokens.Dimensions.x9,
    fontWeight: FontWeight.w300,
    height: tokens.Dimensions.x10 / tokens.Dimensions.x9,
  );

  /// {@template zeta-type-responsive}
  /// Responsive text style, used for [DeviceType.mobileLandscape] and [DeviceType.mobilePortrait].
  /// {@endtemplate}
  ///
  /// {@macro zeta-type-display-l}
  static const TextStyle zetaDisplayLargeResponsive = TextStyle(
    fontSize: tokens.Dimensions.x11,
    fontWeight: FontWeight.w300,
    height: tokens.Dimensions.x12 / tokens.Dimensions.x11,
  );

  /// Gets approximate char width based on width of O in IBM Plex Sans
  ///
  /// Only works for IBM Plex.
  static double ch({double multiplier = _defaultChMultiplier, TextStyle style = zetaBodyMedium}) {
    const plexCh = 0.6;

    return multiplier * plexCh * (style.fontSize ?? tokens.Dimensions.x3);
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
  final TextStyle style;

  /// Sets text color.
  ///
  /// See also:
  /// * [TextStyle.color].
  final Color? textColor;

  /// Max width of Text box using [ch]. Not measured in dp / px.
  ///
  /// [ch] approximates width of a character using O as basis, so a maxWidth of 60 theoretically returns a max width containing 60 characters.
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
    this.style = ZetaText.zetaBodyMedium,
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
    const TextStyle tempTextStyle = ZetaText.zetaBodyMedium;
    final TextStyle thisStyle = tempTextStyle.copyWith(
      fontSize: style.fontSize,
      fontWeight: style.fontWeight,
      height: style.height,
    );

    String data = this.data ?? '';
    final Color color = textColor ?? ZetaColors.of(context).textDefault;
    TextStyle textStyle = context.deviceType.responsiveText ? thisStyle.mobileStyle : thisStyle;

    textStyle = textStyle.copyWith(
      fontSize: (fontSize ?? textStyle.fontSize ?? tokens.Typography.defaultTextSize) *
          MediaQuery.of(context).textScaleFactor,
      height: _fontSize,
      fontWeight: fontWeight,
      decoration: decoration ?? TextDecoration.none,
      fontStyle: fontStyle,
      color: color,
    );

    if (resetHeight) textStyle = textStyle.copyWith(height: style == ZetaText.zetaDescription ? null : 1);
    if (upperCase) data = data.toUpperCase();

    return Padding(
      padding: _padding,
      child: maxWidth == null
          ? Text(data, style: textStyle, textDirection: textDirection)
          : Align(
              alignment: textDirection == TextDirection.rtl ? Alignment.centerRight : Alignment.centerLeft,
              child: SizedBox(
                width: maxWidth == null ? null : ch(multiplier: maxWidth ?? 0, style: textStyle),
                child: Text(data, style: textStyle, textDirection: textDirection),
              ),
            ),
    );
  }

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-body-s}
  const ZetaText.bodySmall(
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
  const ZetaText.bodyMedium(
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
  const ZetaText.bodyLarge(
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
  const ZetaText.labelSmall(
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
  const ZetaText.labelMedium(
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
  const ZetaText.labelLarge(
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
  const ZetaText.titleSmall(
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
  const ZetaText.titleMedium(
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
  const ZetaText.titleLarge(
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
  const ZetaText.headingSmall(
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
  const ZetaText.headingMedium(
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
  const ZetaText.headingLarge(
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
  const ZetaText.displaySmall(
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
  const ZetaText.displayMedium(
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
  const ZetaText.displayLarge(
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

  /// {@macro zeta-component-text}
  ///
  /// {@macro zeta-type-description}
  const ZetaText.description(
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
  }) : style = zetaDescription;
}
