import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

/// This widget provides a navigation rail for navigating between different
/// sections of an app. It is designed to be used as a side navigation
/// menu and can be customized with different icons and labels for each
/// navigation item.
///
/// Should be used with [ZetaNavigationRailItem].
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-43&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/navigation-rail/zetanavigationrail/navigation-rail
class ZetaNavigationRail extends ZetaStatelessWidget {
  /// Constructor for [ZetaNavigationRail].
  const ZetaNavigationRail({
    super.key,
    super.rounded,
    required this.items,
    this.selectedIndex,
    this.onSelect,
    this.margin,
    this.itemSpacing,
    this.itemPadding,
    this.wordWrap,
    this.semanticLabel,
  });

  /// Required list of navigation items.
  final List<ZetaNavigationRailItem> items;

  /// Initially selected item form the list of `items`.
  final int? selectedIndex;

  /// Called when an item is selected.
  final void Function(int)? onSelect;

  /// The margin around the [ZetaNavigationRail].
  /// If undefined, defaults to:
  /// ```dart
  ///  EdgeInsets.all(Zeta.of(context).spacing.xl)
  /// ```
  final EdgeInsets? margin;

  /// The spacing between items in [ZetaNavigationRail].
  /// If undefined, defaults to:
  /// ```dart
  ///  EdgeInsets.only(bottom: Zeta.of(context).spacing.minimum)
  /// ```
  final EdgeInsets? itemSpacing;

  /// The padding within an item in [ZetaNavigationRail].
  /// Default is:
  /// ```dart
  ///  EdgeInsets.symmetric(
  ///   horizontal: Zeta.of(context).spacing.small,
  ///   vertical: Zeta.of(context).spacing.medium,
  /// ),
  /// ```
  final EdgeInsets? itemPadding;

  /// Determines if words in items' labels should be wrapped on separate lines.
  /// Default is `true`.
  final bool? wordWrap;

  /// Value passed to the wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

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
      ..add(DiagnosticsProperty<bool>('wordWrap', wordWrap))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Semantics(
        label: semanticLabel,
        child: Padding(
          padding: margin ?? EdgeInsets.all(Zeta.of(context).spacing.xl),
          child: IntrinsicWidth(
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++)
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: Zeta.of(context).spacing.minimum),
                          child: _ZetaNavigationRailItemContent(
                            label: items[i].label,
                            icon: items[i].icon,
                            selected: selectedIndex == i,
                            disabled: items[i].disabled,
                            onTap: () => onSelect?.call(i),
                            padding: itemPadding,
                            wordWrap: wordWrap,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ZetaNavigationRailItemContent extends ZetaStatefulWidget {
  const _ZetaNavigationRailItemContent({
    required this.label,
    this.icon,
    this.selected = false,
    this.disabled = false,
    this.onTap,
    this.padding,
    this.wordWrap,
  });

  final String label;
  final Widget? icon;
  final bool selected;
  final bool disabled;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final bool? wordWrap;

  @override
  State<_ZetaNavigationRailItemContent> createState() => _ZetaNavigationRailItemContentState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<EdgeInsets?>('padding', padding))
      ..add(DiagnosticsProperty<bool?>('wordWrap', wordWrap));
  }
}

class _ZetaNavigationRailItemContentState extends State<_ZetaNavigationRailItemContent> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return Semantics(
      button: true,
      enabled: !widget.disabled,
      child: Focus(
        onFocusChange: (focused) => setState(() => _focused = focused),
        onKeyEvent: (node, event) {
          if (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.space) {
            widget.onTap?.call();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: MouseRegion(
          cursor: widget.disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.disabled ? null : widget.onTap,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.disabled
                    ? null
                    : widget.selected
                        ? zeta.colors.stateDefaultSelected
                        : _hovered
                            ? zeta.colors.surfaceHover
                            : null,
                border: _focused ? Border.all(color: zeta.colors.borderPrimary, width: 2) : null,
                borderRadius: context.rounded ? BorderRadius.all(Zeta.of(context).radius.rounded) : null,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: Zeta.of(context).spacing.xl_9,
                  minHeight: Zeta.of(context).spacing.xl_9,
                ),
                child: SelectionContainer.disabled(
                  child: Padding(
                    padding: widget.padding ??
                        EdgeInsets.symmetric(
                          horizontal: Zeta.of(context).spacing.small,
                          vertical: Zeta.of(context).spacing.medium,
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null)
                          IconTheme(
                            data: IconThemeData(
                              color: widget.disabled
                                  ? zeta.colors.mainDisabled
                                  : widget.selected || _hovered
                                      ? zeta.colors.mainDefault
                                      : zeta.colors.mainSubtle,
                              size: Zeta.of(context).spacing.xl_2,
                            ),
                            child: widget.icon!,
                          ),
                        Text(
                          (widget.wordWrap ?? true) ? widget.label.replaceAll(' ', '\n') : widget.label,
                          textAlign: TextAlign.center,
                          style: Zeta.of(context).textStyles.titleSmall.copyWith(
                                color: widget.disabled
                                    ? zeta.colors.mainDisabled
                                    : widget.selected || _hovered
                                        ? zeta.colors.mainDefault
                                        : zeta.colors.mainSubtle,
                              ),
                        ),
                      ],
                    ),
                  ),
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
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', widget.onTap))
      ..add(DiagnosticsProperty<bool>('disabled', widget.disabled))
      ..add(DiagnosticsProperty<bool>('selected', widget.selected))
      ..add(DiagnosticsProperty<EdgeInsets?>('padding', widget.padding))
      ..add(StringProperty('label', widget.label))
      ..add(DiagnosticsProperty<bool?>('wordWrap', widget.wordWrap));
  }
}

/// Represents an item in the [ZetaNavigationRail].

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

  /// {@macro zeta-widget-disabled}
  final bool disabled;
}
