import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';
import 'list_scope.dart';

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

  /// The list of widgets to be shown in the list.
  final List<Widget> items;

  /// Shows/hides the divider between lists.
  /// Defaults to true.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return ListScope(
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

  /// {@template list-item-leading}
  /// A widget to display before the title;
  /// {@endtemplate}
  final Widget? leading;

  /// Called when user taps on the [ZetaListItem].
  final VoidCallback? onTap;

  /// {@template list-item-primary-text}
  /// The primary text of the [ZetaListItem].
  /// {@endtemplate}
  final String primaryText;

  /// {@template list-item-secondary-text}
  /// The secondary text of the [ZetaListItem].
  /// {@endtemplate}
  final String? secondaryText;

  /// A widget to display after the primary text.
  /// If this is a checkbox, radio button, or switch, use the relevant named constructor.
  final Widget? trailing;

  /// {@template list-item-show-divider}
  /// Adds a border to the bottom of the list item.
  /// If this isn't provided and the item is used in a [ZetaList], the value is fetched from the [showDivider] prop on the [ZetaList].
  /// {@endtemplate}
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
    final listScope = ListScope.of(context);

    final divide = showDivider ?? listScope?.showDivider ?? false;
    final Widget? leadingWidget =
        leading ?? ((listScope?.indentItems ?? false) ? const SizedBox(width: ZetaSpacing.xl_2) : null);

    return Material(
      color: Zeta.of(context).colors.surfaceDefault,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: ZetaSpacing.xl_9),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: divide ? colors.borderDefault : Colors.transparent,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: ZetaSpacing.large,
              right: ZetaSpacing.small,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      if (leadingWidget != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            right: ZetaSpacing.small,
                          ),
                          child: leadingWidget,
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
