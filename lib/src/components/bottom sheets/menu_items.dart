import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// The type of the [ZetaMenuItem]
enum ZetaMenuItemType {
  /// [ZetaMenuItem] with icon and text in a row
  horizontal,

  /// [ZetaMenuItem] with icon and text in a column
  vertical,
}

/// Component [ZetaMenuItem].
/// It can be horizontal or vertical
class ZetaMenuItem extends StatelessWidget {
  /// Constructor for the component [ZetaMenuItem]
  const ZetaMenuItem({
    super.key,
    required this.type,
    required this.label,
    this.onTap,
    this.leadingIcon,
    this.trailingIcon,
    this.showTrailing = false,
    this.disabled = false,
  });

  /// Creates horizontal menu item
  factory ZetaMenuItem.horizontal({
    required Widget label,
    VoidCallback? onTap,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool showTrailing = false,
    bool disabled = false,
  }) {
    return ZetaMenuItem(
      type: ZetaMenuItemType.horizontal,
      label: label,
      onTap: onTap,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      showTrailing: showTrailing,
      disabled: disabled,
    );
  }

  /// Creates horizontal menu item
  factory ZetaMenuItem.vertical({
    required Widget label,
    required Widget icon,
    VoidCallback? onTap,
    bool disabled = false,
  }) {
    return ZetaMenuItem(
      type: ZetaMenuItemType.vertical,
      label: label,
      onTap: onTap,
      leadingIcon: icon,
      disabled: disabled,
    );
  }

  /// The type of the [ZetaMenuItem] - horizontal or vertical
  final ZetaMenuItemType type;

  /// What to do when [ZetaMenuItem] is pressed.
  final VoidCallback? onTap;

  /// The label of the [ZetaMenuItem]
  final Widget label;

  /// The leading icon of the [ZetaMenuItem]
  final Widget? leadingIcon;

  /// The trailing icon of the [ZetaMenuItem]
  final Widget? trailingIcon;

  /// Determines whether to show the trailing icon.
  /// Default is false.
  final bool showTrailing;

  /// Sets disabled state of [ZetaMenuItem]
  /// Default is false
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    switch (type) {
      case ZetaMenuItemType.horizontal:
        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: InkWell(
            onTap: disabled ? null : onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (leadingIcon != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconTheme(
                              data: _iconThemeData(colors, disabled, 24),
                              child: leadingIcon!,
                            ),
                          ),
                        Expanded(
                          child: DefaultTextStyle(
                            style: _defaultTextStyle(colors, disabled),
                            child: label,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showTrailing || trailingIcon != null)
                    IconTheme(
                      data: _iconThemeData(colors, disabled, 24),
                      child: trailingIcon ?? const Icon(Icons.keyboard_arrow_right),
                    ),
                ],
              ),
            ),
          ),
        );
      case ZetaMenuItemType.vertical:
        return InkWell(
          onTap: disabled ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                if (leadingIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: IconTheme(
                      data: _iconThemeData(colors, disabled, 32),
                      child: leadingIcon!,
                    ),
                  ),
                DefaultTextStyle(
                  style: _defaultTextStyle(colors, disabled),
                  child: label,
                ),
              ],
            ),
          ),
        );
    }
  }

  static TextStyle _defaultTextStyle(ZetaColors colors, bool disabled) => ZetaTextStyles.labelLarge.apply(
        color: disabled ? colors.textDisabled : colors.textDefault,
      );

  static IconThemeData _iconThemeData(ZetaColors colors, bool disabled, double size) => IconThemeData(
        color: disabled ? colors.iconDisabled : colors.iconSubtle,
        size: size,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaMenuItemType>('type', type))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('showTrailing', showTrailing))
      ..add(DiagnosticsProperty<VoidCallback?>('onTap', onTap));
  }
}
