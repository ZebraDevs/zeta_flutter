import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
// TODO(UX-1485): Add more Zebra devices and get correct values

/// A collection of predefined Zebra viewports.
abstract class ZebraViewports {
  /// Represents a viewport for the Zebra EC50 / EC55 device.
  static const ec50 = ViewportData(
    name: 'Zebra EC50 / EC55',
    width: 480,
    height: 854,
    pixelRatio: 2,
    platform: TargetPlatform.android,
  );

  /// Represents a viewport for the Zebra EC30 device.
  static const ec30 = ViewportData(
    name: 'Zebra EC30',
    width: 720,
    height: 1280,
    pixelRatio: 2,
    platform: TargetPlatform.android,
  );
}
