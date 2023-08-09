import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// Collection of Zebra devices.
class Zebra {
  /// Zebra EC50/EC55.
  static final ec50 = DeviceInfo.genericPhone(
    id: 'zebra-ec50',
    name: 'Zebra EC50/EC55',
    platform: TargetPlatform.android,
    screenSize: const Size(480, 854),
  );

  /// Zebra EC30.
  static final ec30 = DeviceInfo.genericPhone(
    id: 'zebra-ec30',
    name: 'Zebra EC30',
    platform: TargetPlatform.android,
    screenSize: const Size(720, 1280),
  );
  // TODO(thelukewalton): Make more device models
}
