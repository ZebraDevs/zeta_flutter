// Copyright Mike Rydstrom.
// https://gist.github.com/rydmike/1771fe24c050ebfe792fa309371154d8

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import '../../zeta_flutter.dart';

// NOTE:
// Never import this library directly in the application. The PlatformIs
// class and library uses conditional imports to only import this file on
// Web platform builds.

final html.Navigator _nav = html.window.navigator;

/// UniversalPlatform for Flutter WEB build.
///
/// We can use dart:html Navigator to get the current platform.
///
/// This function is borrowed, with minor modifications, from GetX utils library with MIT license.
/// Credits for it belong to its author Jonny Borges https://github.com/jonataslaw
/// https://github.com/jonataslaw/getx/blob/master/lib/get_utils/src/platform/platform_web.dart
class UniversalPlatform implements AbstractPlatform {
  /// Default constructor
  @override
  const UniversalPlatform();
  @override
  bool get web => true;
  @override
  bool get macOS => _nav.appVersion.contains('Mac OS') && !iOS;
  @override
  bool get windows => _nav.appVersion.contains('Win');
  @override
  bool get linux => (_nav.appVersion.contains('Linux') || _nav.appVersion.contains('x11')) && !android;
  // Source: https://developer.chrome.com/multidevice/user-agent
  @override
  bool get android => _nav.appVersion.contains('Android ');
  @override
  bool get iOS {
    // maxTouchPoints is needed to separate iPad iOS13 vs new MacOS
    return _hasMatch(_nav.platform, '/iPad|iPhone|iPod/') || (_nav.platform == 'MacIntel' && _nav.maxTouchPoints! > 1);
  }

  // Theoretically we could be in a Web browser on Fuchsia too, but
  // we have no info on how to get that info yet, so we return false.
  @override
  bool get fuchsia => false;
}

bool _hasMatch(String? value, String pattern) {
  // ignore: avoid_bool_literals_in_conditional_expressions
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}
