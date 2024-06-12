import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

class _DivderScope extends InheritedWidget {
  const _DivderScope({required super.child, required this.showDivider});

  final bool showDivider;

  static _DivderScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_DivderScope>();
  }

  @override
  bool updateShouldNotify(_DivderScope oldWidget) => oldWidget.showDivider != showDivider;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('showDivider', showDivider));
  }
}

/// Used to apply dividers to a group of [ZetaListItem]s.
///
/// Dividers on individual list items can be hidden or shown by setting their [showDivider] property.
///
/// This wraps [ListView.builder] so it needs to be used in a widget with a constrained height.
class ZetaList extends StatelessWidget {
  /// Creates a new [ZetaList].
  const ZetaList({
    required this.items,
    this.showDivider = true,
    super.key,
  });

  /// The list of [ZetaListItem]s to be shown in the list.
  final List<ZetaListItem> items;

  /// Shows/hides the divider between lists.
  /// Defaults to true.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return _DivderScope(
      showDivider: showDivider,
      child: ListView.builder(
        itemBuilder: (context, i) => items[i],
        itemCount: items.length,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('showDivider', showDivider));
  }
}

/// A single row that typically contains some text as well as a leading or trailing widgets.
///
/// To create list items with a [ZetaSwitch], [ZetaCheckbox], or [ZetaRadio], use the [ZetaListItem.toggle], [ZetaListItem.checkbox] or the [ZetaListItem.radio] named constructors respectively.
class ZetaListItem extends StatelessWidget {
  /// Creates a [ZetaListItem].
  const ZetaListItem({
    required this.primaryText,
    this.secondaryText,
    this.leading,
    this.onTap,
    this.showDivider,
    this.trailing,
    super.key,
  });

  /// Creates a [ZetaListItem] with a [ZetaSwitch] in the trailing widget space.
  ZetaListItem.toggle({
    super.key,
    required this.primaryText,
    this.secondaryText,
    this.showDivider,
    this.leading,
    bool value = false,
    ValueChanged<bool?>? onChanged,
  })  : trailing = ZetaSwitch(
          value: value,
          onChanged: onChanged,
          variant: ZetaSwitchType.android,
        ),
        onTap = (() => onChanged?.call(!value));

  /// Creates a [ZetaListItem] with a [ZetaCheckbox] in the trailing widget space.
  ZetaListItem.checkbox({
    super.key,
    required this.primaryText,
    this.secondaryText,
    this.leading,
    this.showDivider,
    bool value = false,
    bool rounded = true,
    ValueChanged<bool>? onChanged,
    bool useIndeterminate = false,
  })  : trailing = ZetaCheckbox(
          value: value,
          onChanged: onChanged,
          useIndeterminate: useIndeterminate,
          rounded: rounded,
        ),
        onTap = (() => onChanged?.call(!value));

  /// Creates a [ZetaListItem] with a [ZetaRadio] in the trailing widget space.
  ZetaListItem.radio({
    required this.primaryText,
    required dynamic value,
    this.secondaryText,
    this.leading,
    this.showDivider,
    dynamic groupValue,
    super.key,
    ValueChanged<dynamic>? onChanged,
  })  : trailing = ZetaRadio<dynamic>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        onTap = (() => onChanged?.call(value));

  /// A Widget to display before the title;
  final Widget? leading;

  /// Called when user taps on the [ZetaListItem].
  final VoidCallback? onTap;

  /// The primary text of the [ZetaListItem].
  final String primaryText;

  /// The primary text of the [ZetaListItem].
  final String? secondaryText;

  /// A widget to display after the title.
  final Widget? trailing;

  /// Adds a border to the bottom of the list item.
  final bool? showDivider;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget>('leading', leading))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<Widget>('trailing', trailing))
      ..add(StringProperty('label', primaryText))
      ..add(StringProperty('secondaryText', secondaryText))
      ..add(DiagnosticsProperty<bool?>('showDivider', showDivider));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final divide = showDivider ?? _DivderScope.of(context)?.showDivider ?? false;

    return Container(
      constraints: const BoxConstraints(minHeight: ZetaSpacing.xl_9),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: divide ? colors.borderDefault : Colors.transparent,
          ),
        ),
      ),
      child: Material(
        color: Zeta.of(context).colors.surfaceDefault,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.large),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      if (leading != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            right: ZetaSpacing.small,
                          ),
                          child: leading,
                        ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              primaryText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (secondaryText != null && secondaryText!.isNotEmpty)
                              Text(
                                secondaryText!,
                                style: ZetaTextStyles.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: ZetaSpacing.large,
                    ),
                    child: trailing,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
