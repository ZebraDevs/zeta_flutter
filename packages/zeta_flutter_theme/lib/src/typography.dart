import 'package:flutter/material.dart';

import '../zeta_flutter_theme.dart';

/// Typography in Zeta style.
///
/// We have decided to adopt IBM Plex Sans typeface for our digital solutions.
/// This new typeface is clean, distinctive and designed for digital world use cases.
/// The typeface is free and available in multiple languages, making it ideal for localization.
/// More info can be found at: www.ibm.com/plex
@Deprecated('Please use Zeta.of(context).textStyles instead.')
class ZetaTextStyles {
  /// Largest of the display styles.
  ///
  /// {@template zeta-text-display}
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  /// {@endtemplate}
  static const TextStyle displayLarge = TextStyle(
    fontSize: 52,
    fontWeight: FontWeight.w300,
    height: 60 / 52,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Middle size of the display styles.
  ///
  /// {@macro zeta-text-display}
  static const TextStyle displayMedium = TextStyle(
    fontSize: 44,
    fontWeight: FontWeight.w300,
    height: 52 / 44,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Smallest of the display styles.
  ///
  /// {@macro zeta-text-display}
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w300,
    height: 40 / 36,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Largest of the headline styles.
  ///
  ///{@template zeta-text-headline}
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  /// {@endtemplate}
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 36 / 32,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Middle size of the headline styles.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle heading2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 32 / 28,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Smallest of the headline styles.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 28 / 24,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Largest of the title styles.
  ///
  /// {@template zeta-text-title}
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  /// {@endtemplate}
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 24 / 20,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Middle size of the title styles.
  ///
  /// {@macro zeta-text-title}
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Smallest of the title styles.
  ///
  /// {@macro zeta-text-title}
  static const TextStyle titleSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Largest of the body styles.
  ///
  /// {@template zeta-text-body}
  /// Body styles are used for longer passages of text.
  /// {@endtemplate}
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 24 / 20,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Middle size of the body styles.
  ///
  /// {@macro zeta-text-body}
  ///
  /// The default Text style for [Zeta].
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Small size of the body styles.
  ///
  /// {@macro zeta-text-body}
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 18 / 14,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Smallest of the body styles.
  ///
  /// {@macro zeta-text-body}
  static const TextStyle bodyXSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Largest of the label styles.
  ///
  /// {@template zeta-text-label}
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  /// {@endtemplate}
  ///
  /// Used for text on `ZetaButton`.
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Middle size of the label styles.
  ///
  /// {@macro zeta-text-label}
  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    fontFamily: kZetaFontFamily,
  );

  /// Small size of the label styles.
  ///
  /// {@macro zeta-text-label}
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Label text style used specifically for Indicator.
  ///
  /// {@macro zeta-text-label}
  static const TextStyle labelIndicator = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 14 / 12,
    fontFamily: kZetaFontFamily,
    letterSpacing: 0,
  );

  /// Largest heading style.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle h1 = heading1;

  /// Second largest heading style.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle h2 = heading2;

  /// Third largest heading style.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle h3 = heading3;

  /// Fourth largest heading style.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle h4 = titleLarge;

  /// Fifth largest heading style.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle h5 = titleMedium;

  /// Sixth largest heading style.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle h6 = titleSmall;
}

/// [Zeta.of(context).textStyles] combined into a [TextTheme].
@Deprecated('Please use Zeta.of(context).textStyles instead.')
const TextTheme zetaTextTheme = TextTheme(
  displayLarge: ZetaTextStyles.displayLarge,
  displayMedium: ZetaTextStyles.displayMedium,
  displaySmall: ZetaTextStyles.displaySmall,
  headlineLarge: ZetaTextStyles.heading1,
  headlineMedium: ZetaTextStyles.heading2,
  headlineSmall: ZetaTextStyles.heading3,
  titleLarge: ZetaTextStyles.titleLarge,
  titleMedium: ZetaTextStyles.titleMedium,
  titleSmall: ZetaTextStyles.titleSmall,
  bodyLarge: ZetaTextStyles.bodyLarge,
  bodyMedium: ZetaTextStyles.bodyMedium,
  bodySmall: ZetaTextStyles.bodySmall,
  labelLarge: ZetaTextStyles.labelLarge,
  labelMedium: ZetaTextStyles.labelMedium,
  labelSmall: ZetaTextStyles.labelSmall,
);

/// Typography in Zeta style.
///
/// We have decided to adopt IBM Plex Sans typeface for our digital solutions.
/// This new typeface is clean, distinctive and designed for digital world use cases.
/// The typeface is free and available in multiple languages, making it ideal for localization.
/// More info can be found at: www.ibm.com/plex
class ZetaTextStyle {
  /// Constructor for [ZetaTextStyle].
  const ZetaTextStyle({this.fontFamily = kZetaFontFamily, this.textColor});

  /// Custom font family for the text styles.
  ///
  /// Defaults to IBM Plex.
  final String fontFamily;

  /// Custom text color for the text styles.
  ///
  /// Defaults to the current theme color.
  final Color? textColor;

  /// Applies the given [color] to the text styles.
  ZetaTextStyle applyColor(Color color) {
    return ZetaTextStyle(
      fontFamily: fontFamily,
      textColor: color,
    );
  }

  /// Largest of the display styles.
  ///
  /// {@template zeta-text-display}
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  /// {@endtemplate}
  TextStyle get displayLarge => TextStyle(
        fontSize: 52,
        fontWeight: FontWeight.w300,
        height: 60 / 52,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Middle size of the display styles.
  ///
  /// {@macro zeta-text-display}
  TextStyle get displayMedium => TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.w300,
        height: 52 / 44,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Smallest of the display styles.
  ///
  /// {@macro zeta-text-display}
  TextStyle get displaySmall => TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w300,
        height: 40 / 36,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Largest of the headline styles.
  ///
  ///{@template zeta-text-headline}
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  /// {@endtemplate}
  TextStyle get heading1 => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 36 / 32,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Middle size of the headline styles.
  ///
  /// {@macro zeta-text-headline}
  TextStyle get heading2 => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 32 / 28,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Smallest of the headline styles.
  ///
  /// {@macro zeta-text-headline}
  TextStyle get heading3 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 28 / 24,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Largest of the title styles.
  ///
  /// {@template zeta-text-title}
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  /// {@endtemplate}
  TextStyle get titleLarge => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 24 / 20,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Middle size of the title styles.
  ///
  /// {@macro zeta-text-title}
  TextStyle get titleMedium => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 20 / 16,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Smallest of the title styles.
  ///
  /// {@macro zeta-text-title}
  TextStyle get titleSmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Largest of the body styles.
  ///
  /// {@template zeta-text-body}
  /// Body styles are used for longer passages of text.
  /// {@endtemplate}
  TextStyle get bodyLarge => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 24 / 20,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Middle size of the body styles.
  ///
  /// {@macro zeta-text-body}
  ///
  /// The default Text style for [Zeta].
  TextStyle get bodyMedium => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Small size of the body styles.
  ///
  /// {@macro zeta-text-body}
  TextStyle get bodySmall => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 18 / 14,
        fontFamily: fontFamily,
        color: textColor,
        letterSpacing: 0,
      );

  /// Smallest of the body styles.
  ///
  /// {@macro zeta-text-body}
  TextStyle get bodyXSmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Largest of the label styles.
  ///
  /// {@template zeta-text-label}
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  /// {@endtemplate}
  ///
  /// Used for text on `ZetaButton`.
  TextStyle get labelLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 24 / 16,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Middle size of the label styles.
  ///
  /// {@macro zeta-text-label}
  TextStyle get labelMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Small size of the label styles.
  ///
  /// {@macro zeta-text-label}
  TextStyle get labelSmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Label text style used specifically for Indicator.
  ///
  /// {@macro zeta-text-label}
  TextStyle get labelIndicator => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 14 / 12,
        fontFamily: fontFamily,
        color: textColor,
      );

  /// Largest heading style.
  ///
  /// {@macro zeta-text-headline}
  TextStyle get h1 => heading1;

  /// Second largest heading style.
  ///
  /// {@macro zeta-text-headline}
  TextStyle get h2 => heading2;

  /// Third largest heading style.
  ///
  /// {@macro zeta-text-headline}
  TextStyle get h3 => heading3;

  /// Fourth largest heading style.
  ///
  /// {@macro zeta-text-headline}
  TextStyle get h4 => titleLarge;

  /// Fifth largest heading style.
  ///
  /// {@macro zeta-text-headline}
  TextStyle get h5 => titleMedium;

  /// Sixth largest heading style.
  ///
  /// {@macro zeta-text-headline}
  TextStyle get h6 => titleSmall;

  /// [Zeta.of(context).textStyles] combined into a [TextTheme].
  TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: heading1,
        headlineMedium: heading2,
        headlineSmall: heading3,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
