// ignore_for_file: deprecated_member_use_from_same_package
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../zeta_flutter.dart';

/// Chat item widget that can be dragged to reveal contextual actions.
/// {@category Components}
class ZetaChatItem extends ZetaStatelessWidget {
  /// Creates a [ZetaChatItem]
  const ZetaChatItem({
    super.key,
    super.rounded,
    this.highlighted = false,
    this.time,
    this.timeFormat,
    required this.title,
    this.subtitle,
    this.leading,
    this.enabledWarningIcon = false,
    this.enabledNotificationIcon = false,
    this.additionalIcons = const [],
    this.count,
    this.onTap,
    this.starred,
    this.slidableActions = const [],
    this.explicitChildNodes = true,
    this.paleButtonColors,
    @Deprecated('Use slidableActions instead.' ' This variable has been replaced as of 0.12.1') this.onMenuMoreTap,
    @Deprecated('Use slidableActions instead.' ' This variable has been replaced as of 0.12.1') this.onCallTap,
    @Deprecated('Use slidableActions instead.' ' This variable has been replaced as of 0.12.1') this.onDeleteTap,
    @Deprecated('Use slidableActions instead.' ' This variable has been replaced as of 0.12.1') this.onPttTap,
  });

  /// Whether to apply different background color.
  final bool highlighted;

  /// Normally the person name.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Normally the beginning of the chat message.
  ///
  /// Typically a [Text] widget.
  final Widget? subtitle;

  /// Normally [ZetaAvatar].
  final Widget? leading;

  /// The time when the message is sent. It applies default date format - [timeFormat].
  final DateTime? time;

  /// The default date format.
  final DateFormat? timeFormat;

  /// Whether to show warning icon.
  final bool enabledWarningIcon;

  /// Whether to show notification icon.
  final bool enabledNotificationIcon;

  /// Optional icons to be displayed on the top right corder next to warning and notification icons.
  final List<Widget> additionalIcons;

  /// Count displayed on the top right corder.
  final int? count;

  /// Callback to call when tap on the list tile.
  final VoidCallback? onTap;

  /// Whether the chat list is starred.
  ///
  /// If null, the star will not be rendered.
  final bool? starred;

  /// Whether to show explicit child nodes in the semantics tree.
  final bool explicitChildNodes;

  /// Whether to apply pale color.
  ///
  /// Pale buttons was the default behavior before 0.15.2, but now buttons have darker colors by default.
  final bool? paleButtonColors;

  /// Callback for slidable action -  menu more.
  @Deprecated('Use slidableActions instead.' ' This variable has been replaced as of 0.12.1')
  final VoidCallback? onMenuMoreTap;

  /// Callback for slidable action -  call.
  @Deprecated('Use slidableActions instead.' ' This variable has been replaced as of 0.12.1')
  final VoidCallback? onCallTap;

  /// Callback for slidable action -  delete.
  @Deprecated('Use slidableActions instead.' ' This variable has been replaced as of 0.12.1')
  final VoidCallback? onDeleteTap;

  /// Callback for slidable action -  ptt.
  @Deprecated('Use slidableActions instead.' ' This variable has been replaced as of 0.12.1')
  final VoidCallback? onPttTap;

  /// List of slidable actions.
  ///
  /// The actions are displayed in the order they are provided; from left to right.
  final List<ZetaSlidableAction> slidableActions;

  DateFormat get _dateFormat => timeFormat ?? DateFormat('hh:mm a');
  String? get _count => count != null && count! > 99 ? '99+' : count?.toString();

  double _getSlidableExtend({
    required int slidableActionsCount,
    required double maxScreenWidth,
    required BuildContext context,
  }) {
    final actionWith = slidableActionsCount * Zeta.of(context).spacing.xl_10;
    final maxButtonWidth = actionWith / maxScreenWidth;
    final extend = actionWith / maxScreenWidth;
    if (extend.clamp(0, maxButtonWidth).toDouble() > 1) {
      return 1;
    }
    return extend.clamp(0, maxButtonWidth).toDouble();
  }

  Widget? get _formatLeading {
    if (leading.runtimeType == ZetaAvatar) {
      return (leading! as ZetaAvatar).copyWith(size: ZetaAvatarSize.m);
    }
    return leading;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final actions = [...slidableActions];

    // coverage:ignore-start
    if (onMenuMoreTap != null) {
      actions.add(ZetaSlidableAction.menuMore(onPressed: onMenuMoreTap));
    }
    if (onCallTap != null) {
      actions.add(ZetaSlidableAction.call(onPressed: onCallTap));
    }
    if (onPttTap != null) {
      actions.add(ZetaSlidableAction.ptt(onPressed: onPttTap));
    }
    if (onDeleteTap != null) {
      actions.add(ZetaSlidableAction.delete(onPressed: onDeleteTap));
    }
    // coverage:ignore-end

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Semantics(
        button: true,
        child: SelectionContainer.disabled(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Slidable(
                enabled: actions.isNotEmpty,
                endActionPane: actions.isEmpty
                    ? null
                    : ActionPane(
                        extentRatio: _getSlidableExtend(
                          slidableActionsCount: actions.length,
                          maxScreenWidth: constraints.maxWidth,
                          context: context,
                        ),
                        motion: const ScrollMotion(),
                        children: paleButtonColors != null
                            ? actions.map((action) => action.copyWith(paleColor: paleButtonColors)).toList()
                            : actions,
                      ),
                child: ColoredBox(
                  color: highlighted ? colors.surfaceSelected : colors.surfaceDefault,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      child: Semantics(
                        explicitChildNodes: explicitChildNodes,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Zeta.of(context).spacing.medium,
                            vertical: Zeta.of(context).spacing.small,
                          ),
                          child: Row(
                            children: [
                              if (leading != null) _formatLeading!,
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: Zeta.of(context).spacing.medium),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          if (highlighted)
                                            Container(
                                              margin: EdgeInsets.only(right: Zeta.of(context).spacing.minimum),
                                              height: Zeta.of(context).spacing.small,
                                              width: Zeta.of(context).spacing.small,
                                              decoration: BoxDecoration(
                                                color: colors.mainPrimary,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: DefaultTextStyle(
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: (highlighted
                                                            ? ZetaTextStyles.labelLarge
                                                            : ZetaTextStyles.bodyMedium)
                                                        .copyWith(color: colors.mainDefault),
                                                    child: title,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    if (time != null)
                                                      Text(
                                                        _dateFormat.format(time!),
                                                        style: ZetaTextStyles.bodyXSmall,
                                                      ),
                                                    IconTheme(
                                                      data: IconThemeData(
                                                        size: Zeta.of(context).spacing.large,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          ...additionalIcons,
                                                          if (enabledNotificationIcon)
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                left: Zeta.of(context).spacing.minimum,
                                                              ),
                                                              child: ZetaIcon(
                                                                ZetaIcons.error,
                                                                color: colors.mainSubtle,
                                                              ),
                                                            ),
                                                          if (enabledWarningIcon)
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                left: Zeta.of(context).spacing.minimum,
                                                              ),
                                                              child: Icon(
                                                                Icons.circle_notifications,
                                                                color: colors.surfaceNegative,
                                                              ),
                                                            ),
                                                          if (_count != null)
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                left: Zeta.of(context).spacing.minimum,
                                                              ),
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal: Zeta.of(context).spacing.small,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: colors.mainPrimary,
                                                                borderRadius: Zeta.of(context).radius.full,
                                                              ),
                                                              child: Text(
                                                                _count!,
                                                                style: ZetaTextStyles.labelSmall.copyWith(
                                                                  color: colors.mainInverse,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          if (subtitle != null)
                                            Flexible(
                                              child: DefaultTextStyle(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: ZetaTextStyles.bodySmall.copyWith(
                                                  color: colors.mainSubtle,
                                                ),
                                                child: subtitle!,
                                              ),
                                            ),
                                          if (starred != null)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: Zeta.of(context).spacing.minimum,
                                              ),
                                              child: ZetaIcon(
                                                starred! ? ZetaIcons.star : ZetaIcons.star_outline,
                                                color: starred! ? colors.mainSecondary : null,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            },
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('highlighted', highlighted))
      ..add(DiagnosticsProperty<DateTime?>('time', time))
      ..add(DiagnosticsProperty<DateFormat?>('timeFormat', timeFormat))
      ..add(DiagnosticsProperty<bool>('enabledWarningIcon', enabledWarningIcon))
      ..add(DiagnosticsProperty<bool>('enabledNotificationIcon', enabledNotificationIcon))
      ..add(IntProperty('count', count))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool?>('starred', starred))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onMenuMoreTap', onMenuMoreTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onCallTap', onCallTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDeleteTap', onDeleteTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPttTap', onPttTap))
      ..add(DiagnosticsProperty<bool>('explicitChildNodes', explicitChildNodes))
      ..add(DiagnosticsProperty<bool>('paleButtonColors', paleButtonColors));
  }
}

enum _ZetaSlidableActionType { menuMore, call, ptt, delete, custom }

extension on _ZetaSlidableActionType {
  Color getMainColor(BuildContext context) {
    final colors = Zeta.of(context).colors;
    switch (this) {
      case _ZetaSlidableActionType.menuMore:
        return colors.surfaceInfo;
      case _ZetaSlidableActionType.call:
        return colors.surfacePositive;
      case _ZetaSlidableActionType.ptt:
        return colors.surfacePrimary;
      case _ZetaSlidableActionType.delete:
        return colors.surfaceNegative;
      case _ZetaSlidableActionType.custom:
        return colors.surfacePrimary;
    }
  }

  Color getBackgroundColor(BuildContext context, {bool pale = false}) {
    final colors = Zeta.of(context).colors;
    if (pale) {
      switch (this) {
        case _ZetaSlidableActionType.menuMore:
          return colors.surfaceInfoSubtle;
        case _ZetaSlidableActionType.call:
          return colors.surfacePositiveSubtle;
        case _ZetaSlidableActionType.ptt:
          return colors.surfacePrimarySubtle;
        case _ZetaSlidableActionType.delete:
          return colors.surfaceNegativeSubtle;
        case _ZetaSlidableActionType.custom:
          return colors.surfacePrimarySubtle;
      }
    } else {
      return getMainColor(context);
    }
  }

  Color getForegroundColor(BuildContext context, {bool pale = false}) {
    final colors = Zeta.of(context).colors;
    if (pale) {
      switch (this) {
        case _ZetaSlidableActionType.menuMore:
          return colors.surfaceInfo;
        case _ZetaSlidableActionType.call:
          return colors.surfacePositive;
        case _ZetaSlidableActionType.ptt:
          return colors.surfacePrimary;
        case _ZetaSlidableActionType.delete:
          return colors.surfaceNegative;
        case _ZetaSlidableActionType.custom:
          return colors.surfacePrimary;
      }
    } else {
      return colors.surfaceDefault;
    }
  }
}

/// Slidable action widget for [ZetaChatItem].
class ZetaSlidableAction extends StatelessWidget {
  /// Constructs a [ZetaSlidableAction].
  const ZetaSlidableAction({
    super.key,
    this.onPressed,
    required this.icon,
    this.color,
    this.customForegroundColor,
    this.customBackgroundColor,
    this.semanticLabel,
    this.paleColor = false,
  }) : _type = _ZetaSlidableActionType.custom;

  const ZetaSlidableAction._({
    super.key,
    this.onPressed,
    required this.icon,
    this.color,
    this.customForegroundColor,
    this.customBackgroundColor,
    this.semanticLabel,
    this.paleColor = false,
    _ZetaSlidableActionType? type,
  }) : _type = type ?? _ZetaSlidableActionType.custom;

  /// Constructs a More menu [ZetaSlidableAction].
  const ZetaSlidableAction.menuMore({
    super.key,
    this.onPressed,
    this.semanticLabel = 'More',
    this.paleColor = false,
  })  : icon = ZetaIcons.more_vertical,
        color = null,
        customForegroundColor = null,
        customBackgroundColor = null,
        _type = _ZetaSlidableActionType.menuMore;

  /// Constructs a Call [ZetaSlidableAction].
  const ZetaSlidableAction.call({
    super.key,
    this.onPressed,
    this.semanticLabel = 'Call',
    this.paleColor = false,
  })  : icon = ZetaIcons.phone,
        color = null,
        customForegroundColor = null,
        customBackgroundColor = null,
        _type = _ZetaSlidableActionType.call;

  /// Constructs a PTT [ZetaSlidableAction].
  const ZetaSlidableAction.ptt({
    super.key,
    this.onPressed,
    this.semanticLabel = 'PTT',
    this.paleColor = false,
  })  : icon = ZetaIcons.ptt,
        color = null,
        customForegroundColor = null,
        customBackgroundColor = null,
        _type = _ZetaSlidableActionType.ptt;

  /// Constructs a Delete [ZetaSlidableAction].
  const ZetaSlidableAction.delete({
    super.key,
    this.onPressed,
    this.semanticLabel = 'Delete',
    this.paleColor = false,
  })  : icon = ZetaIcons.delete,
        color = null,
        customForegroundColor = null,
        customBackgroundColor = null,
        _type = _ZetaSlidableActionType.delete;

  final _ZetaSlidableActionType _type;

  /// Callback to call when the action is pressed.
  ///
  /// {@macro zeta-widget-change-disable}
  final VoidCallback? onPressed;

  /// Icon to be displayed.
  final IconData icon;

  /// Foreground color of the icon.
  ///
  /// If [color] is not provided, [customBackgroundColor] must also be provided.
  ///
  /// If [color] is provided, [customForegroundColor] and [customBackgroundColor] take precedence.
  final Color? customForegroundColor;

  /// Background color of the action.
  ///
  /// If [color] is not provided, [customBackgroundColor] must also be provided.
  ///
  /// If [color] is provided, [customForegroundColor] and [customBackgroundColor] take precedence.
  final Color? customBackgroundColor;

  /// Color swatch used for the action.
  ///
  /// If provided, [customForegroundColor] and [customBackgroundColor] take precedence.
  final ZetaColorSwatch? color;

  /// Semantic label for the action.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  /// Whether to apply pale color.
  final bool paleColor;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = customBackgroundColor ??
        (color != null
            ? paleColor
                ? color!.shade10
                : color!.shade60
            : _type.getBackgroundColor(context, pale: paleColor));
    final Color foregroundColor = customForegroundColor ??
        (color != null
            ? paleColor
                ? Zeta.of(context).colors.surfaceDefault
                : color!.shade10
            : _type.getForegroundColor(context, pale: paleColor));

    return Expanded(
      child: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.only(left: Zeta.of(context).spacing.minimum),
          child: Semantics(
            label: semanticLabel,
            container: true,
            button: true,
            excludeSemantics: true,
            child: IconButton(
              onPressed: () => onPressed?.call(),
              style: IconButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                shape: RoundedRectangleBorder(borderRadius: Zeta.of(context).radius.minimal),
                side: BorderSide.none,
              ),
              icon: ZetaIcon(icon, size: Zeta.of(context).spacing.xl_4),
            ),
          ),
        ),
      ),
    );
  }

  /// Creates a copy of this [ZetaSlidableAction] but with the given fields replaced with the new values.
  ZetaSlidableAction copyWith({
    VoidCallback? onPressed,
    IconData? icon,
    Color? customForegroundColor,
    Color? customBackgroundColor,
    ZetaColorSwatch? color,
    String? semanticLabel,
    bool? paleColor,
  }) {
    return ZetaSlidableAction._(
      key: key,
      onPressed: onPressed ?? this.onPressed,
      icon: icon ?? this.icon,
      customForegroundColor: customForegroundColor ?? this.customForegroundColor,
      customBackgroundColor: customBackgroundColor ?? this.customBackgroundColor,
      color: color ?? this.color,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      paleColor: paleColor ?? this.paleColor,
      type: _type,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(DiagnosticsProperty<bool>('paleColor', paleColor))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(ColorProperty('color', color))
      ..add(ColorProperty('customBackgroundColor', customBackgroundColor))
      ..add(ColorProperty('customForegroundColor', customForegroundColor))
      ..add(DiagnosticsProperty<IconData>('icon', icon));
  }
}
