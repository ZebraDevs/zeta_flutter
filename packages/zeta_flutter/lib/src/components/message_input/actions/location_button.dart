import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../../../zeta_flutter.dart';
import 'action_button.dart';

/// Location button for sending precise or approximate location
class LocationButton extends StatelessWidget {
  /// Creates a [LocationButton].
  const LocationButton({
    super.key,
    this.onLocationCapture,
  });

  /// Callback for when a location is captured.
  final ValueChanged<LocationData>? onLocationCapture;

  Future<void> _getLocation(BuildContext context) async {
    final Location location = Location();
    final LocationData locationData = await location.getLocation();

    if (onLocationCapture != null) {
      onLocationCapture?.call(locationData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      icon: ZetaIcons.pin,
      onPressed: onLocationCapture != null ? () => _getLocation(context) : null,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ValueChanged<LocationData>>.has('onLocationCapture', onLocationCapture));
  }
}
