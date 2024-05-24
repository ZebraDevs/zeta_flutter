import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../zeta_flutter.dart';

/// Chat item widget that can be dragged to reveal contextual actions.
class ZetaChatItem extends StatelessWidget {
  /// Creates a [ZetaChatItem]
  const ZetaChatItem({
    super.key,
    this.highlighted = false,
    this.time,
    this.timeFormat,
    required this.title,
    required this.subtitle,
    required this.leading,
    this.enabledWarningIcon = false,
    this.enabledNotificationIcon = false,
    this.additionalIcons = const [],
    this.count,
    this.onTap,
    this.starred = false,
    this.onMenuMoreTap,
    this.onCallTap,
    this.onDeleteTap,
    this.onPttTap,
  });

  /// Whether to apply different background color.
  final bool highlighted;

  /// Normally the person name.
  final Widget title;

  /// Normally the begining of the chat message.
  final Widget subtitle;

  /// Normally [ZetaAvatar].
  final Widget leading;

  /// The time when the message is sent. It applies default date format - [timeFormat].
  final DateTime? time;

  /// The dafault date format.
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
  final bool starred;

  /// Callback for slidable action -  menu more.
  final VoidCallback? onMenuMoreTap;

  /// Callback for slidable action -  call.
  final VoidCallback? onCallTap;

  /// Callback for slidable action -  delete.
  final VoidCallback? onDeleteTap;

  /// Callback for slidable action -  ptt.
  final VoidCallback? onPttTap;

  DateFormat get _dateFormat => timeFormat ?? DateFormat('hh:mm a');
  String? get _count => count != null && count! > 99 ? '99+' : count?.toString();

  double _getSlidableExtend({
    required int slidableActionsCount,
    required double maxWidth,
  }) {
    if (slidableActionsCount == 0) return 0.5;

    final actionsExtend = slidableActionsCount * ZetaSpacing.x20;
    final extend = actionsExtend / maxWidth;

    return extend > 1 ? 1 : extend;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final slidableActions = [
      if (onMenuMoreTap != null)
        _ZetaSlidableAction(
          onPressed: onMenuMoreTap,
          backgroundColor: colors.purple.shade10,
          foregroundColor: colors.purple.shade60,
          icon: ZetaIcons.more_vertical_round,
        ),
      if (onCallTap != null)
        _ZetaSlidableAction(
          onPressed: onCallTap,
          backgroundColor: colors.green.shade10,
          foregroundColor: colors.surfacePositive,
          icon: Icons.call,
        ),
      if (onPttTap != null)
        _ZetaSlidableAction(
          onPressed: onPttTap,
          backgroundColor: colors.blue.shade10,
          foregroundColor: colors.primary,
          icon: ZetaIcons.ptt_round,
        ),
      if (onDeleteTap != null)
        _ZetaSlidableAction(
          onPressed: onDeleteTap,
          backgroundColor: colors.red.shade10,
          foregroundColor: colors.surfaceNegative,
          icon: ZetaIcons.delete_round,
        ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Slidable(
          enabled: slidableActions.isNotEmpty,
          endActionPane: ActionPane(
            extentRatio: _getSlidableExtend(
              slidableActionsCount: slidableActions.length,
              maxWidth: constraints.maxWidth,
            ),
            motion: const ScrollMotion(),
            children: slidableActions,
          ),
          child: ColoredBox(
            color: highlighted ? colors.blue.shade10 : colors.surfacePrimary,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ZetaSpacing.s,
                    vertical: ZetaSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      leading,
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: ZetaSpacing.s),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (highlighted)
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: ZetaSpacing.xxs,
                                      ),
                                      height: ZetaSpacing.x2,
                                      width: ZetaSpacing.x2,
                                      decoration: BoxDecoration(
                                        color: colors.primary,
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
                                            style: (highlighted ? ZetaTextStyles.labelLarge : ZetaTextStyles.bodyMedium)
                                                .copyWith(
                                              color: colors.textDefault,
                                            ),
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
                                              data: const IconThemeData(
                                                size: ZetaSpacing.x4,
                                              ),
                                              child: Row(
                                                children: [
                                                  ...additionalIcons,
                                                  if (enabledWarningIcon)
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                        left: ZetaSpacing.xxs,
                                                      ),
                                                      child: Icon(
                                                        ZetaIcons.info_round,
                                                        color: colors.cool.shade70,
                                                      ),
                                                    ),
                                                  if (enabledWarningIcon)
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                        left: ZetaSpacing.xxs,
                                                      ),
                                                      child: Icon(
                                                        Icons.circle_notifications,
                                                        color: colors.surfaceNegative,
                                                      ),
                                                    ),
                                                  if (_count != null)
                                                    Container(
                                                      margin: const EdgeInsets.only(
                                                        left: ZetaSpacing.xxs,
                                                      ),
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: ZetaSpacing.x2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: colors.primary,
                                                        borderRadius: ZetaRadius.full,
                                                      ),
                                                      child: Text(
                                                        _count!,
                                                        style: ZetaTextStyles.labelSmall.copyWith(
                                                          color: colors.textInverse,
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: DefaultTextStyle(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: ZetaTextStyles.bodySmall.copyWith(
                                        color: colors.textSubtle,
                                      ),
                                      child: subtitle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: ZetaSpacing.xxs,
                                    ),
                                    child: Icon(
                                      starred ? ZetaIcons.star_sharp : ZetaIcons.star_outline_sharp,
                                      color: starred ? colors.yellow.shade60 : null,
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
        );
      },
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
      ..add(
        DiagnosticsProperty<bool>(
          'enabledNotificationIcon',
          enabledNotificationIcon,
        ),
      )
      ..add(IntProperty('count', count))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('starred', starred))
      ..add(
        ObjectFlagProperty<VoidCallback?>.has('onMenuMoreTap', onMenuMoreTap),
      )
      ..add(ObjectFlagProperty<VoidCallback?>.has('onCallTap', onCallTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDeleteTap', onDeleteTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPttTap', onPttTap));
  }
}

class _ZetaSlidableAction extends StatelessWidget {
  const _ZetaSlidableAction({
    required this.onPressed,
    required this.icon,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(left: ZetaSpacing.xxs),
          child: IconButton(
            onPressed: () => onPressed,
            style: IconButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: ZetaRadius.minimal,
              ),
              side: BorderSide.none,
            ),
            icon: Icon(
              icon,
              color: foregroundColor,
              size: ZetaSpacing.x8,
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
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<IconData>('icon', icon));
  }
}
