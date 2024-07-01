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

/// Zeta Menu Item component.
///
/// Typically used as body of [ZetaBottomSheet].
class ZetaMenuItem extends ZetaStatelessWidget {
  /// Constructor for the component [ZetaMenuItem].
  ///
  /// Typically, [ZetaMenuItem.horizontal] or [ZetaMenuItem.vertical] constructors should be used.
  const ZetaMenuItem({
    super.key,
    super.rounded,
    required this.type,
    required this.label,
    this.onTap,
    this.leading,
    this.trailing,
  });

  /// Creates horizontal menu item
  const ZetaMenuItem.horizontal({
    super.key,
    super.rounded,
    required this.label,
    this.onTap,
    this.leading,
    this.trailing,
  }) : type = ZetaMenuItemType.horizontal;

  /// Creates horizontal menu item
  const ZetaMenuItem.vertical({
    super.key,
    super.rounded,
    required this.label,
    Widget? icon,
    this.onTap,
  })  : type = ZetaMenuItemType.vertical,
        leading = icon,
        trailing = null;

  /// The type of the [ZetaMenuItem] - horizontal or vertical.
  final ZetaMenuItemType type;

  /// What to do when [ZetaMenuItem] is pressed.
  final VoidCallback? onTap;

  /// The label of the [ZetaMenuItem].
  final Widget label;

  /// The leading widget of the [ZetaMenuItem].
  ///
  /// Icon is at leading edge for [ZetaMenuItem.horizontal], and center aligned for [ZetaMenuItem.vertical].
  ///
  /// Typically an [Icon].
  final Widget? leading;

  /// The trailing widget of the [ZetaMenuItem].
  ///
  /// Only used for [ZetaMenuItem.horizontal].
  ///
  /// Typically an icon.
  final Widget? trailing;

  bool get _enabled => onTap != null;

  VoidCallback? get _onTap => _enabled ? onTap : null;

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: () {
        final colors = Zeta.of(context).colors;

        final Widget text = DefaultTextStyle(
          style: ZetaTextStyles.labelLarge.apply(color: _enabled ? colors.textDefault : colors.textDisabled),
          child: label,
        );

        switch (type) {
          case ZetaMenuItemType.horizontal:
            return ConstrainedBox(
              constraints: const BoxConstraints(minHeight: ZetaSpacing.xl_8),
              child: InkWell(
                onTap: _onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.large, vertical: ZetaSpacing.medium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (leading != null)
                              Padding(padding: const EdgeInsets.only(right: ZetaSpacing.small), child: leading),
                            Expanded(child: text),
                          ],
                        ),
                      ),
                      if (trailing != null)
                        IconTheme(
                          data: _iconThemeData(colors, _enabled, ZetaSpacing.xl_2),
                          child: trailing!,
                        ),
                    ],
                  ),
                ),
              ),
            );
          case ZetaMenuItemType.vertical:
            return InkWell(
              onTap: _onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.large, vertical: ZetaSpacing.medium),
                child: Column(
                  children: [
                    if (leading != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: ZetaSpacing.medium),
                        child: IconTheme(
                          data: _iconThemeData(colors, _enabled, ZetaSpacing.xl_4),
                          child: leading!,
                        ),
                      ),
                    text,
                  ],
                ),
              ),
            );
        }
      }(),
    );
  }

  static IconThemeData _iconThemeData(ZetaColors colors, bool enabled, double size) => IconThemeData(
        color: enabled ? colors.iconSubtle : colors.iconDisabled,
        size: size,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaMenuItemType>('type', type))
      ..add(DiagnosticsProperty<VoidCallback?>('onTap', onTap));
  }
}
