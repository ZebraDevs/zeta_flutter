// Ignored as the breakpoint values are here for reference.
// ignore_for_file: unused_field

import 'package:flutter/widgets.dart';

/// Enum to define device types.
enum DeviceType {
  /// A device with width between 240 and 479.
  mobilePortrait,

  /// A device with width between 480 and 767.
  mobileLandscape,

  /// A device with width between 768 and 991.
  tablet,

  /// A device with width between 992 and 1279.
  desktop,

  /// A device with width between 1280 and 1439.
  desktopL,

  /// A device with width between 1440 and 1920.
  desktopXL,
}

/// Utils to determine the [DeviceType] from some box constraints.
extension BreakpointLocal on BoxConstraints {
  /// Determines the [DeviceType] from some box constraints.
  ///
  /// Typically used within a [LayoutBuilder].
  ///
  /// Returns based on the constrains locally to the widget, rather than the whole screen.
  DeviceType get deviceType {
    return _resolveDeviceType(maxWidth);
  }
}

/// Utils to determine the [DeviceType] from the current context.
extension BreakpointFull on BuildContext {
  /// Determines the [DeviceType] from the current context.
  ///
  /// Returns based on the full size of the screen, so can be inaccurate in certain scenarios.
  DeviceType get deviceType {
    return _resolveDeviceType(MediaQuery.of(this).size.width);
  }
}

DeviceType _resolveDeviceType(double width) {
  if (width <= _Breakpoints._mobilePortraitMax) {
    return DeviceType.mobilePortrait;
  } else if (width <= _Breakpoints._mobileLandscapeMax) {
    return DeviceType.mobileLandscape;
  } else if (width <= _Breakpoints._tabletMax) {
    return DeviceType.tablet;
  } else if (width <= _Breakpoints._desktopMax) {
    return DeviceType.desktop;
  } else if (width <= _Breakpoints._desktopLMax) {
    return DeviceType.desktopL;
  } else {
    return DeviceType.desktopXL;
  }
}

class _Breakpoints {
  static const _mobilePortraitMin = 240;
  static const _mobilePortraitMax = 479;
  static const _mobileLandscapeMin = 480;
  static const _mobileLandscapeMax = 767;
  static const _tabletMin = 768;
  static const _tabletMax = 991;
  static const _desktopMin = 992;
  static const _desktopMax = 1279;
  static const _desktopLMin = 1280;
  static const _desktopLMax = 1439;
  static const _desktopXLMin = 1440;
  static const _desktopXLMax = 1920;
}
