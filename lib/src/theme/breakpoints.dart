// ignore_for_file: unused_element

import 'package:flutter/widgets.dart';

const _mobilePortraitMin = 240;
const _mobilePortraitMax = 479;

const _mobileLandscapeMin = 480;
const _mobileLandscapeMax = 767;

const _tabletMin = 768;
const _tabletMax = 991;

const _desktopMin = 992;
const _desktopMax = 1279;

const _desktopLMin = 1280;
const _desktopLMax = 1439;

const _desktopXLMin = 1440;
const _desktopXLMax = 1920;

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

/// Utils to determine the [DeviceType] from the current context.
extension Breakpoint on BoxConstraints {
  /// Determines the [DeviceType] from the current context.
  DeviceType get deviceType {
    final width = maxWidth;

    if (width <= _mobilePortraitMax) {
      return DeviceType.mobilePortrait;
    } else if (width <= _mobileLandscapeMax) {
      return DeviceType.mobileLandscape;
    } else if (width <= _tabletMax) {
      return DeviceType.tablet;
    } else if (width <= _desktopMax) {
      return DeviceType.desktop;
    } else if (width <= _desktopLMax) {
      return DeviceType.desktopL;
    } else {
      return DeviceType.desktopXL;
    }
  }
}
// /// Utils to determine the [DeviceType] from the current context.
// extension Breakpoint on BuildContext {
//   /// Determines the [DeviceType] from the current context.
//   DeviceType get deviceType {
//     final width = MediaQuery.of(this).size.width;

//     if (width <= _mobilePortraitMax) {
//       return DeviceType.mobilePortrait;
//     } else if (width <= _mobileLandscapeMax) {
//       return DeviceType.mobileLandscape;
//     } else if (width <= _tabletMax) {
//       return DeviceType.tablet;
//     } else if (width <= _desktopMax) {
//       return DeviceType.desktop;
//     } else if (width <= _desktopLMax) {
//       return DeviceType.desktopL;
//     } else {
//       return DeviceType.desktopXL;
//     }
//   }
// }
