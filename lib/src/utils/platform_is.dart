// The content of this file is adapted from Mike Rydstrom:
// https://gist.github.com/rydmike/1771fe24c050ebfe792fa309371154d8

import 'universal_platform_web.dart' if (dart.library.io) 'universal_platform_vm.dart';

/// A universal platform checker.
///
/// Can be used to check active physical Flutter platform on all platforms.
///
/// To check what host platform the app is running on use:
///
/// * PlatformIs.android
/// * PlatformIs.iOS
/// * PlatformIs.macOS
/// * PlatformIs.windows
/// * PlatformIs.linux
/// * PlatformIs.fuchsia
///
/// To check the device type use:
///
/// * PlatformIs.mobile  (Android or iOS)
/// * PlatformIs.desktop (Windows, macOS or Linux)
///
/// Currently Fuchsia is not considered mobile nor desktop, even if it
/// might be so in the future.
///
/// To check if the Flutter application is running on Web you can use:
///
/// * PlatformIs.web
///
/// Alternatively the Flutter foundation compile time constant kIsWeb also
/// works well for that.
///
/// The platform checks are supported independently on web. You can use
/// PlatformIs windows, iOS, macOS, Android and Linux to check what the host
/// platform is when you are running a Flutter Web application.
///
/// Checking if we are running on a Fuchsia host in a Web browser, is not yet fully
/// supported. If running in a Web browser on Fuchsia, PlatformIs.web will be true, but
/// PlatformIs.fuchsia will be false. Future versions, when Fuchsia is released,
/// may fix this.
class PlatformIs {
  PlatformIs._();

  /// Web
  static bool get web => const UniversalPlatform().web;

  /// Mac OS desktop
  static bool get macOS => const UniversalPlatform().macOS;

  /// Windows desktop
  static bool get windows => const UniversalPlatform().windows;

  /// Linux desktop
  static bool get linux => const UniversalPlatform().linux;

  /// Android
  static bool get android => const UniversalPlatform().android;

  /// iOS
  static bool get iOS => const UniversalPlatform().iOS;

  /// Fuchsia
  static bool get fuchsia => const UniversalPlatform().fuchsia;

  /// Mobile (Android or iOS)
  static bool get mobile => PlatformIs.iOS || PlatformIs.android;

  /// Desktop (Windows, macOS, Linux)
  static bool get desktop => PlatformIs.macOS || PlatformIs.windows || PlatformIs.linux;
}

/// Abstract platform interface.
abstract interface class AbstractPlatform {
  /// Web
  bool get web;

  /// Mac OS
  bool get macOS;

  /// Windows
  bool get windows;

  /// Linux
  bool get linux;

  /// Android
  bool get android;

  /// iOS
  bool get iOS;

  /// Fuchsia
  bool get fuchsia;
}
