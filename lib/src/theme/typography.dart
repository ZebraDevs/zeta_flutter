import 'package:flutter/material.dart';
import '../../zeta_flutter.dart';

/// Typography in Zeta style.
///
/// We have decided to adopt IBM Plex Sans typeface for our digital solutions.
/// This new typeface is clean, distinctive and designed for digital world use cases.
/// The typeface is free and available in multiple languages, making it ideal for localization.
/// More info can be found at: www.ibm.com/plex
class ZetaTextStyles {
  /// Largest of the display styles.
  ///
  /// {@template zeta-text-display}
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  /// {@endtemplate}
  static const TextStyle displayLarge = TextStyle(fontSize: 52, fontWeight: FontWeight.w300, height: 64 / 52);

  /// Middle size of the display styles.
  ///
  /// {@macro zeta-text-display}
  static const TextStyle displayMedium = TextStyle(fontSize: 42, fontWeight: FontWeight.w300, height: 56 / 42);

  /// Smallest of the display styles.
  ///
  /// {@macro zeta-text-display}
  static const TextStyle displaySmall = TextStyle(fontSize: 36, fontWeight: FontWeight.w300, height: 48 / 36);

  /// Largest of the headline styles.
  ///
  ///{@template zeta-text-headline}
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  /// {@endtemplate}
  static const TextStyle heading1 = TextStyle(fontSize: 32, fontWeight: FontWeight.w500, height: 36 / 32);

  /// Middle size of the headline styles.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle heading2 = TextStyle(fontSize: 28, fontWeight: FontWeight.w500, height: 32 / 28);

  /// Smallest of the headline styles.
  ///
  /// {@macro zeta-text-headline}
  static const TextStyle heading3 = TextStyle(fontSize: 24, fontWeight: FontWeight.w500, height: 32 / 24);

  /// Largest of the title styles.
  ///
  /// {@template zeta-text-title}
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  /// {@endtemplate}
  static const TextStyle titleLarge = TextStyle(fontSize: 32, fontWeight: FontWeight.w500, height: 20 / 28);

  /// Middle size of the title styles.
  ///
  /// {@macro zeta-text-title}
  static const TextStyle titleMedium = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 24 / 18);

  /// Smallest of the title styles.
  ///
  /// {@macro zeta-text-title}
  static const TextStyle titleSmall = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 24 / 16);

  /// Largest of the body styles.
  ///
  /// {@template zeta-text-body}
  /// Body styles are used for longer passages of text.
  /// {@endtemplate}
  static const TextStyle bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 16 / 24);

  /// Middle size of the body styles.
  ///
  /// {@macro zeta-text-body}
  ///
  /// The default Text style for [Zeta].
  static const TextStyle bodyMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 20 / 14);

  /// Smallest of the body styles.
  ///
  /// {@macro zeta-text-body}
  static const TextStyle bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 16 / 12);

  /// Largest of the label styles.
  ///
  /// {@template zeta-text-label}
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  /// {@endtemplate}
  ///
  /// Used for text on [ZetaButton].
  static const TextStyle labelLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 24 / 16);

  /// Middle size of the label styles.
  ///
  /// {@macro zeta-text-label}
  static const TextStyle labelMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20 / 14);

  /// Small size of the label styles.
  ///
  /// {@macro zeta-text-label}
  static const TextStyle labelSmall = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 16 / 12);

  /// Label text style used specifically for Indicator.
  /// {@macro zeta-text-label}
  static const TextStyle labelIndicator = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 14 / 12);

  /// Smallest of the label styles.
  ///
  /// {@macro zeta-text-label}
  static const TextStyle labelTiny = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 14 / 11);
}

/// [ZetaTextStyles] combined into a [TextTheme].
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
