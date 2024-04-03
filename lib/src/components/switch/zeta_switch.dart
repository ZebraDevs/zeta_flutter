import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'material_switch.dart';

const _sizeAndroid = Size(48, 24);
const _sizeIOS = Size(56, 32);
const _sizeWeb = Size(64, 32);

/// Variants of [ZetaSwitch].
enum ZetaSwitchType {
  /// 64 x 32
  web,

  /// 48 x 24
  android,

  /// 56 x 32
  ios,
}

/// Zeta Switch.
///
/// Switch can turn an option on or off.
///
/// Switch has styles for Android, iOS and Web.
// TODO(switch): Add web icon support.
class ZetaSwitch extends StatelessWidget {
  /// Constructor for [ZetaSwitch].
  const ZetaSwitch({
    super.key,
    this.value = false,
    this.onChanged,
    this.variant,
  });

  /// Determines whether the switch is on or off.
  final bool? value;

  /// Called when the value of the switch should change.
  final ValueChanged<bool?>? onChanged;

  /// Variant of switch for different platforms.
  ///
  /// Defaults to match the platform, or falls back to web.
  final ZetaSwitchType? variant;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('value', value: value, ifTrue: 'on', ifFalse: 'off', showName: true))
      ..add(ObjectFlagProperty<ValueChanged<bool>>('onChanged', onChanged, ifNull: 'disabled'))
      ..add(EnumProperty<ZetaSwitchType?>('variant', variant));
  }

  ZetaSwitchType get _variant {
    if (variant != null) return variant!;
    if (kIsWeb) return ZetaSwitchType.web;
    return switch (Platform.operatingSystem) {
      'ios' => ZetaSwitchType.ios,
      'android' => ZetaSwitchType.android,
      _ => ZetaSwitchType.web,
    };
  }

  Size get _size {
    return switch (_variant) {
      ZetaSwitchType.ios => _sizeIOS,
      ZetaSwitchType.android => _sizeAndroid,
      _ => _sizeWeb,
    };
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    return MaterialSwitch(
      size: _size,
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
      thumbSize: _variant == ZetaSwitchType.web ? const Size.square(ZetaSpacing.m) : null,
    );
  }
}
