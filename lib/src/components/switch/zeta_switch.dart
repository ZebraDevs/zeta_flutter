import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'material_switch.dart';

const _sizeAndroid = Size(48, 24);
const _sizeIOS = Size(56, 32);

/// Zeta Switch.
///
/// Switch can turn an option on or off.
class ZetaSwitch extends StatelessWidget {
  /// Constructor for [ZetaSwitch].
  const ZetaSwitch({
    super.key,
    this.value = false,
    this.onChanged,
  });

  /// Determines whether the switch is on or off.
  final bool? value;

  /// Called when the value of the switch should change.
  final ValueChanged<bool?>? onChanged;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('value', value: value, ifTrue: 'on', ifFalse: 'off', showName: true))
      ..add(ObjectFlagProperty<ValueChanged<bool>>('onChanged', onChanged, ifNull: 'disabled'));
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    return MaterialSwitch(
      size: Platform.isIOS ? _sizeIOS : _sizeAndroid,
      trackOutlineWidth: const MaterialStatePropertyAll(0),
      trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return zetaColors.cool.shade30;
        } else {
          return states.contains(MaterialState.selected) ? zetaColors.primary : zetaColors.cool.shade50;
        }
      }),
      thumbColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled) ? zetaColors.cool.shade50 : zetaColors.cool.shade20,
      ),
      value: value ?? false,
      onChanged: onChanged,
    );
  }
}
