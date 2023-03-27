import 'package:widgetbook_models/src/devices/device.dart';
import 'package:widgetbook_models/src/devices/device_size.dart';
import 'package:widgetbook_models/src/devices/resolution.dart';

/// Collection of Zebra devices.
class Zebra {
  /// Zebra EC50/EC55.
  static const Device ec50 = Device.mobile(
    name: 'EC50',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 480, height: 854),
      scaleFactor: 2,
    ),
  );

  /// Zebra EC30.
  static const Device ec30 = Device.mobile(
    name: 'EC30',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 720, height: 1280),
      scaleFactor: 2,
    ),
  );
  //TODO: Make more device models
}
