import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

import 'list_scope.dart';

/// Used to apply dividers to a group of [ZetaListItem]s.
///
/// Dividers on individual list items can be hidden or shown by setting their [showDivider] property.
///
/// This wraps [ListView.builder] so it needs to be used in a widget with a constrained height.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-17&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/list-items/list-item
class ZetaList extends ZetaStatelessWidget {
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
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: ListScope(
        showDivider: showDivider,
        child: ListView.builder(
          itemBuilder: (context, i) => items[i],
          itemCount: items.length,
          addSemanticIndexes: false,
        ),
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
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-17&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/list-items/list-item
class ZetaListItem extends ZetaStatelessWidget {
  /// Creates a [ZetaListItem].
  const ZetaListItem({
    this.title,
    this.primaryText,
    this.secondaryText,
    this.primaryTextStyle,
    this.secondaryTextStyle,
    this.leading,
    this.onTap,
    this.showDivider,
    this.trailing,
    super.key,
    super.rounded,
  }) : assert(
          (title != null && primaryText == null && secondaryText == null) ||
              (title == null && primaryText != null || secondaryText != null),
          'Provide one of either title or primaryText/secondaryText',
        );

  /// Creates a [ZetaListItem] with a [ZetaSwitch] in the trailing widget space.
  ZetaListItem.toggle({
    super.key,
    super.rounded,
    this.title,
    this.primaryText,
    this.secondaryText,
    this.primaryTextStyle,
    this.secondaryTextStyle,
    this.showDivider,
    this.leading,
    bool value = false,
    ValueChanged<bool?>? onChanged,
  })  : trailing = ZetaSwitch(
          value: value,
          onChanged: onChanged,
          variant: ZetaSwitchType.android,
        ),
        onTap = (() => onChanged?.call(!value)),
        assert(
          (title != null && primaryText == null && secondaryText == null) ||
              (title == null && (primaryText != null || secondaryText != null)),
          'Provide one of either title or primaryText/secondaryText',
        );

  /// Creates a [ZetaListItem] with a [ZetaCheckbox] in the trailing widget space.
  ZetaListItem.checkbox({
    super.key,
    super.rounded,
    this.title,
    this.primaryText,
    this.secondaryText,
    this.primaryTextStyle,
    this.secondaryTextStyle,
    this.leading,
    this.showDivider,
    bool value = false,
    ValueChanged<bool>? onChanged,
    bool useIndeterminate = false,
  })  : trailing = ZetaCheckbox(
          value: value,
          onChanged: onChanged,
          useIndeterminate: useIndeterminate,
          rounded: rounded,
        ),
        onTap = (() => onChanged?.call(!value)),
        assert(
          (title != null && primaryText == null && secondaryText == null) ||
              (title == null && (primaryText != null || secondaryText != null)),
          'Provide one of either title or primaryText/secondaryText',
        );

  /// Creates a [ZetaListItem] with a [ZetaRadio] in the trailing widget space.
  ZetaListItem.radio({
    required dynamic value,
    this.title,
    this.primaryText,
    this.secondaryText,
    this.primaryTextStyle,
    this.secondaryTextStyle,
    this.leading,
    this.showDivider,
    dynamic groupValue,
    super.key,
    super.rounded,
    ValueChanged<dynamic>? onChanged,
  })  : trailing = ZetaRadio<dynamic>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        onTap = (() => onChanged?.call(value)),
        assert(
          (title != null && primaryText == null && secondaryText == null) ||
              (title == null && (primaryText != null || secondaryText != null)),
          'Provide one of either title or primaryText/secondaryText',
        );

  /// {@template list-item-leading}
  /// A widget to display before the title;
  /// {@endtemplate}
  final Widget? leading;

  /// Called when user taps on the [ZetaListItem].
  final VoidCallback? onTap;

  /// {@template list-item-title}
  /// The primary content of the list item.
  /// Cannot be provided with [primaryText] or [secondaryText].
  /// {@endtemplate}
  final Widget? title;

  /// {@template list-item-primary-text}
  /// The primary text of the [ZetaListItem].
  /// Cannot be provided with [title].
  /// {@endtemplate}
  final String? primaryText;

  /// {@template list-item-primary-text-style}
  /// The text style applied to [primaryText].
  /// {@endtemplate}
  final TextStyle? primaryTextStyle;

  /// {@template list-item-secondary-text}
  /// The secondary text of the [ZetaListItem].
  /// Cannot be provided with [title].
  /// {@endtemplate}
  final String? secondaryText;

  /// {@template list-item-secondary-text-style}
  /// The text style applied to [secondaryText].
  /// {@endtemplate}
  final TextStyle? secondaryTextStyle;

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
      ..add(DiagnosticsProperty<bool?>('showDivider', showDivider))
      ..add(DiagnosticsProperty<TextStyle?>('secondaryTextStyle', secondaryTextStyle))
      ..add(DiagnosticsProperty<TextStyle?>('primaryTextStyle', primaryTextStyle));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final listScope = ListScope.of(context);

    final divide = showDivider ?? listScope?.showDivider ?? false;
    final Widget? leadingWidget =
        leading ?? ((listScope?.indentItems ?? false) ? SizedBox(width: Zeta.of(context).spacing.xl_2) : null);

    return SelectionContainer.disabled(
      child: MergeSemantics(
        child: Material(
          color: Zeta.of(context).colors.surfaceDefault,
          child: InkWell(
            onTap: onTap,
            excludeFromSemantics: true,
            child: Container(
              constraints: BoxConstraints(minHeight: Zeta.of(context).spacing.xl_9),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: divide ? colors.borderDefault : Colors.transparent,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: Zeta.of(context).spacing.large,
                  right: Zeta.of(context).spacing.small,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          if (leadingWidget != null)
                            Padding(
                              padding: EdgeInsets.only(
                                right: Zeta.of(context).spacing.small,
                              ),
                              child: leadingWidget,
                            ),
                          Flexible(
                            child: title ??
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (primaryText != null && primaryText!.isNotEmpty)
                                      Text(
                                        primaryText!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: primaryTextStyle,
                                      ),
                                    if (secondaryText != null && secondaryText!.isNotEmpty)
                                      Text(
                                        secondaryText!,
                                        style: secondaryTextStyle ?? ZetaTextStyles.bodySmall,
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
                        padding: EdgeInsets.only(
                          left: Zeta.of(context).spacing.large,
                        ),
                        child: trailing,
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
}
