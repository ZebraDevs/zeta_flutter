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

/// Menu Item component, typically used as body of [ZetaBottomSheet].
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21541-2225
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/bottom-sheet
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
        final radius = Zeta.of(context).radius;

        final Widget text = DefaultTextStyle(
          style:
              Zeta.of(context).textStyles.labelLarge.apply(color: _enabled ? colors.mainDefault : colors.mainDisabled),
          child: label,
        );

        switch (type) {
          case ZetaMenuItemType.horizontal:
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: Zeta.of(context).spacing.xl_8),
              child: InkWell(
                borderRadius: BorderRadius.all(radius.rounded),
                onTap: _onTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Zeta.of(context).spacing.large,
                    vertical: Zeta.of(context).spacing.medium,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (leading != null)
                              Padding(
                                padding: EdgeInsets.only(right: Zeta.of(context).spacing.small),
                                child: IconTheme(
                                  data: _iconThemeData(colors, _enabled, Zeta.of(context).spacing.xl_2),
                                  child: leading!,
                                ),
                              ),
                            Expanded(child: text),
                          ],
                        ),
                      ),
                      if (trailing != null)
                        IconTheme(
                          data: _iconThemeData(colors, _enabled, Zeta.of(context).spacing.xl_2),
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
              borderRadius: BorderRadius.all(radius.rounded),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Zeta.of(context).spacing.large,
                  vertical: Zeta.of(context).spacing.medium,
                ),
                child: Column(
                  children: [
                    if (leading != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: Zeta.of(context).spacing.medium),
                        child: IconTheme(
                          data: _iconThemeData(colors, _enabled, Zeta.of(context).spacing.xl_4),
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
        color: enabled ? colors.mainSubtle : colors.mainDisabled,
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
