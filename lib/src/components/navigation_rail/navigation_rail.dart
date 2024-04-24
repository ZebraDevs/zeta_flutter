import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// [ZetaNavigationRail]
class ZetaNavigationRail extends StatefulWidget {
  /// Constructor for [ZetaNavigationRail].
  const ZetaNavigationRail({
    super.key,
    required this.items,
    this.selectedIndex,
    this.onSelect,
    this.rounded = true,
    this.margin = const EdgeInsets.all(ZetaSpacing.x5),
    this.itemSpacing = const EdgeInsets.only(bottom: ZetaSpacing.xxs),
    this.itemPadding,
    this.wordWrap,
  });

  /// Required list of navigation items.
  final List<ZetaNavigationRailItem> items;

  /// Initially selected item form the list of `items`.
  final int? selectedIndex;

  /// Called when an item is selected.
  final void Function(int)? onSelect;

  /// Determines if the items are rounded (default) or sharp.
  final bool rounded;

  /// The margin around the [ZetaNavigationRail].
  /// Default is:
  /// ```
  /// const EdgeInsets.all(ZetaSpacing.x5)
  /// ```
  final EdgeInsets margin;

  /// The spacing between items in [ZetaNavigationRail].
  /// Default is:
  /// ```
  /// const EdgeInsets.only(bottom: ZetaSpacing.xxs)
  /// ```
  final EdgeInsets itemSpacing;

  /// The padding within an item in [ZetaNavigationRail].
  /// Default is:
  /// ```
  /// const EdgeInsets.symmetric(
  ///   horizontal: ZetaSpacing.xs,
  ///   vertical: ZetaSpacing.s,
  /// ),
  /// ```
  final EdgeInsets? itemPadding;

  /// Determines if words in items' labels should be wrapped on separate lines.
  /// Default is `true`.
  final bool? wordWrap;

  @override
  State<ZetaNavigationRail> createState() => _ZetaNavigationRailState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(IntProperty('selectedIndex', selectedIndex))
      ..add(ObjectFlagProperty<void Function(int p1)?>.has('onSelect', onSelect))
      ..add(IterableProperty<ZetaNavigationRailItem>('items', items))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DiagnosticsProperty<EdgeInsets>('itemSpacing', itemSpacing))
      ..add(DiagnosticsProperty<EdgeInsets?>('itemPadding', itemPadding))
      ..add(DiagnosticsProperty<bool>('wordWrap', wordWrap));
  }
}

class _ZetaNavigationRailState extends State<ZetaNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: IntrinsicWidth(
        child: Column(
          children: [
            for (int i = 0; i < widget.items.length; i++)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: widget.itemSpacing,
                      child: _ZetaNavigationRailItemContent(
                        label: widget.items[i].label,
                        icon: widget.items[i].icon,
                        selected: widget.selectedIndex == i,
                        disabled: widget.items[i].disabled,
                        onTap: () => widget.onSelect?.call(i),
                        rounded: widget.rounded,
                        padding: widget.itemPadding,
                        wordWrap: widget.wordWrap,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ZetaNavigationRailItemContent extends StatelessWidget {
  const _ZetaNavigationRailItemContent({
    required this.label,
    this.icon,
    this.selected = false,
    this.disabled = false,
    this.onTap,
    this.rounded = true,
    this.padding,
    this.wordWrap,
  });

  final String label;
  final Widget? icon;
  final bool selected;
  final bool disabled;
  final VoidCallback? onTap;
  final bool rounded;
  final EdgeInsets? padding;
  final bool? wordWrap;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return MouseRegion(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: disabled ? null : onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: disabled
                ? null
                : selected
                    ? zeta.colors.blue.shade10
                    : null,
            borderRadius: rounded ? ZetaRadius.rounded : null,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: ZetaSpacing.x16,
              minHeight: ZetaSpacing.x16,
            ),
            child: SelectionContainer.disabled(
              child: Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(
                      horizontal: ZetaSpacing.xs,
                      vertical: ZetaSpacing.s,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      IconTheme(
                        data: IconThemeData(
                          color: disabled
                              ? zeta.colors.cool.shade50
                              : selected
                                  ? zeta.colors.textDefault
                                  : zeta.colors.cool.shade70,
                          size: 24,
                        ),
                        child: icon!,
                      ),
                    Text(
                      (wordWrap ?? true) ? label.replaceAll(' ', '\n') : label,
                      textAlign: TextAlign.center,
                      style: ZetaTextStyles.titleSmall.copyWith(
                        color: disabled
                            ? zeta.colors.cool.shade50
                            : selected
                                ? zeta.colors.textDefault
                                : zeta.colors.cool.shade70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(DiagnosticsProperty<EdgeInsets?>('padding', padding))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool?>('wordWrap', wordWrap));
  }
}

/// [ZetaNavigationRailItem]
class ZetaNavigationRailItem {
  /// Constructor for [ZetaNavigationRailItem].
  const ZetaNavigationRailItem({
    required this.label,
    this.icon,
    this.disabled = false,
  });

  /// Item's label.
  final String label;

  /// Optional item's icon.
  final Widget? icon;

  /// Indicates that this navigation item is inaccessible.
  final bool disabled;
}
