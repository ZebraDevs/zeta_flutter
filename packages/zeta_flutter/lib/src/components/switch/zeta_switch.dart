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
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-41&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/switch/zetaswitch/web
///
// TODO(UX-1137): Add web icon support.
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
  ///
  /// {@macro zeta-widget-change-disable}
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
    if (PlatformIs.android) return ZetaSwitchType.android;
    if (PlatformIs.iOS) return ZetaSwitchType.ios;
    return ZetaSwitchType.web;
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
      trackOutlineWidth: const WidgetStatePropertyAll(0),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return zetaColors.surfaceDisabled;
        } else if (states.contains(WidgetState.selected)) {
          return zetaColors.mainPrimary;
        } else {
          return zetaColors.mainDisabled;
        }
      }),
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled) ? zetaColors.mainDisabled : zetaColors.mainInverse,
      ),
      value: value ?? false,
      onChanged: onChanged,
      thumbSize: _variant == ZetaSwitchType.web ? Size.square(Zeta.of(context).spacing.xl_2) : null,
    );
  }
}
