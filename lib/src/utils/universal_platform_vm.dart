// Copyright Mike Rydstrom.
// https://gist.github.com/rydmike/1771fe24c050ebfe792fa309371154d8

import 'dart:io';

import '../../zeta_flutter.dart';

// NOTE:
// Never import this library directly in the application. The PlatformIs
// class and library uses conditional imports to only import this file on
// VM platform builds.

/// UniversalPlatform for Flutter VM builds.
///
/// We are using Dart VM builds, so we use dart:io Platform to
/// get the current platform.
class UniversalPlatform implements AbstractPlatform {
  /// Default constructor.
  @override
  const UniversalPlatform();
  @override
  bool get web => false;
  @override
  bool get macOS => Platform.isMacOS;
  @override
  bool get windows => Platform.isWindows;
  @override
  bool get linux => Platform.isLinux;
  @override
  bool get android => Platform.isAndroid;
  @override
  bool get iOS => Platform.isIOS;
  @override
  bool get fuchsia => Platform.isFuchsia;
}
