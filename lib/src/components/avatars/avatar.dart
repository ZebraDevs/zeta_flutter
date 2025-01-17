import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';

/// [ZetaAvatar] size
enum ZetaAvatarSize {
  /// [xxxl] 200 pixels
  xxxl,

  /// [xxl] 120 pixels
  xxl,

  /// [xl] 80 pixels
  xl,

  /// [l] 64 pixels
  l,

  /// [m] 48 pixels
  m,

  /// [s] 40 pixels
  s,

  /// [xs] 36 pixels
  xs,

  /// [xxs] 32 pixels
  xxs,

  /// [xxxs] 24 pixels
  xxxs;

  /// Returns the calculated pixel size for the [ZetaAvatarSize].
  double _pixelSize(BuildContext context) => ZetaAvatar.pixelSize(context, this);

  double get _borderSize => switch (this) {
        ZetaAvatarSize.xxxl => 11.12,
        ZetaAvatarSize.xxl => 6.67,
        ZetaAvatarSize.xl => 4.45,
        ZetaAvatarSize.l => 3.56,
        ZetaAvatarSize.m => 2.66,
        ZetaAvatarSize.s => 2.22,
        ZetaAvatarSize.xs => 2,
        ZetaAvatarSize.xxs => 1.78,
        ZetaAvatarSize.xxxs => 1.33,
      };

  double _fontSize(BuildContext context) => ZetaAvatar.fontSize(context, this);

  TextStyle _labelStyle(BuildContext context) => switch (this) {
        ZetaAvatarSize.xxxl => ZetaTextStyles.displaySmall,
        ZetaAvatarSize.xxl => ZetaTextStyles.bodyLarge,
        ZetaAvatarSize.xl => ZetaTextStyles.bodyLarge,
        ZetaAvatarSize.l => ZetaTextStyles.bodyMedium,
        ZetaAvatarSize.m => ZetaTextStyles.bodySmall,
        ZetaAvatarSize.s => ZetaTextStyles.bodyXSmall,
        ZetaAvatarSize.xs => ZetaTextStyles.bodyXSmall,
        ZetaAvatarSize.xxs => ZetaTextStyles.bodyXSmall,
        ZetaAvatarSize.xxxs => ZetaTextStyles.bodyXSmall,
      };
}

/// An avatar is a visual representation of a user or entity.
///
/// It is recommended to use [ZetaAvatar] with [ZetaAvatarBadge] for status and notification badges, but any widget can be used.
///
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=20816-388
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/avatar/avatar
class ZetaAvatar extends ZetaStatelessWidget {
  /// Constructor for [ZetaAvatar]
  const ZetaAvatar({
    super.key,
    this.size = ZetaAvatarSize.xl,
    this.image,
    this.initials,
    this.backgroundColor,
    this.lowerBadge,
    this.upperBadge,
    this.borderColor,
    this.semanticLabel,
    this.semanticUpperBadgeLabel,
    this.semanticLowerBadgeLabel,
    this.initialTextStyle,
    this.label,
    this.labelTextStyle,
    this.labelMaxLines = 1,
    this.onTap,
  });

  /// Constructor for [ZetaAvatar] with image.
  const ZetaAvatar.image({
    super.key,
    this.size = ZetaAvatarSize.xl,
    this.image,
    this.lowerBadge,
    this.upperBadge,
    this.borderColor,
    this.semanticLabel = 'avatar',
    this.semanticUpperBadgeLabel = 'upperBadge',
    this.semanticLowerBadgeLabel = 'lowerBadge',
    this.label,
    this.labelTextStyle,
    this.labelMaxLines = 1,
    this.onTap,
  })  : backgroundColor = null,
        initials = null,
        initialTextStyle = null;

  /// Constructor for [ZetaAvatar] with initials.
  const ZetaAvatar.initials({
    super.key,
    required this.initials,
    this.size = ZetaAvatarSize.xl,
    this.lowerBadge,
    this.upperBadge,
    this.borderColor,
    this.backgroundColor,
    this.semanticLabel = 'avatar',
    this.semanticUpperBadgeLabel = 'upperBadge',
    this.semanticLowerBadgeLabel = 'lowerBadge',
    this.initialTextStyle,
    this.label,
    this.labelTextStyle,
    this.labelMaxLines = 1,
    this.onTap,
  }) : image = null;

  /// Constructor for [ZetaAvatar] with initials from a full name.
  ZetaAvatar.fromName({
    super.key,
    required String name,
    this.size = ZetaAvatarSize.xl,
    this.lowerBadge,
    this.upperBadge,
    this.borderColor,
    this.backgroundColor,
    this.semanticLabel = 'avatar',
    this.semanticUpperBadgeLabel = 'upperBadge',
    this.semanticLowerBadgeLabel = 'lowerBadge',
    this.initialTextStyle,
    this.label,
    this.labelTextStyle,
    this.labelMaxLines = 1,
    this.onTap,
  })  : image = null,
        initials = name.initials;

  /// The size of the [ZetaAvatar]
  final ZetaAvatarSize size;

  /// Image to display for avatar.
  ///
  /// [image] takes priority over [initials].
  final Widget? image;

  /// String to display initials.
  final String? initials;

  /// Background color.
  final Color? backgroundColor;

  /// Shows border around the avatar
  final Color? borderColor;

  /// Status badge shown at lower right corner of avatar.
  final Widget? lowerBadge;

  /// Notification Badge shown at top right corner of avatar.
  final Widget? upperBadge;

  /// Value passed into wrapping [Semantics] widget.
  ///
  /// {@template zeta-widget-semantic-label}
  /// This label is used by accessibility frameworks (e.g. TalkBack on Android) to describe the component.
  /// {@endtemplate}
  final String? semanticLabel;

  /// Value passed into wrapping [Semantics] widget for lower badge.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLowerBadgeLabel;

  /// Value passed into wrapping [Semantics] widget for upper badge.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticUpperBadgeLabel;

  /// Text style for initials.
  ///
  /// Defaults to:
  /// ```dart
  ///  TextStyle(
  ///   fontSize: size.fontSize,
  ///   letterSpacing: Zeta.of(context).spacing.none,
  ///   color: backgroundColor?.onColor,
  ///   fontWeight: FontWeight.w500,
  /// )
  /// ```
  final TextStyle? initialTextStyle;

  /// Label to display below the avatar.
  final String? label;

  /// Text style for label.
  final TextStyle? labelTextStyle;

  /// Maximum number of lines for label.
  final int labelMaxLines;

  /// Callback when avatar is tapped.
  final VoidCallback? onTap;

  /// Return copy of avatar with certain changed fields
  ZetaAvatar copyWith({
    ZetaAvatarSize? size,
    Widget? image,
    String? initials,
    Color? backgroundColor,
    Color? borderColor,
    Widget? lowerBadge,
    Widget? upperBadge,
    String? label,
    TextStyle? labelTextStyle,
    int? labelMaxLines,
    VoidCallback? onTap,
    Key? key,
  }) {
    return ZetaAvatar(
      size: size ?? this.size,
      image: image ?? this.image,
      initials: initials ?? this.initials,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      lowerBadge: lowerBadge ?? this.lowerBadge,
      upperBadge: upperBadge ?? this.upperBadge,
      label: label ?? this.label,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      labelMaxLines: labelMaxLines ?? this.labelMaxLines,
      onTap: onTap ?? this.onTap,
      key: key ?? this.key,
    );
  }

  bool get _showPlaceholder => image == null && (initials == null || initials!.isEmpty);

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    final borderSize = size._borderSize;

    final innerChild = image ??
        (initials != null
            ? Center(
                child: FittedBox(
                  child: Text(
                    initials!,
                    style: initialTextStyle ??
                        TextStyle(
                          fontSize: size._fontSize(context),
                          letterSpacing: Zeta.of(context).spacing.none,
                          color: backgroundColor?.onColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              )
            : null);

    final innerContent = ClipRRect(
      borderRadius: Zeta.of(context).radius.full,
      child: innerChild,
    );

    final pSize = size._pixelSize(context);

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Semantics(
        value: semanticLabel,
        child: SelectionContainer.disabled(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  MouseRegion(
                    cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: pSize,
                        height: pSize,
                        decoration: BoxDecoration(
                          border: borderColor != null ? Border.all(color: borderColor!, width: 0) : null,
                          shape: BoxShape.circle,
                          color: backgroundColor ??
                              (_showPlaceholder ? zetaColors.surfacePrimary : zetaColors.primitives.cool.shade20),
                        ),
                        child: borderColor != null
                            ? Container(
                                width: pSize,
                                height: pSize,
                                decoration: BoxDecoration(
                                  color: backgroundColor ?? zetaColors.surfaceHover,
                                  border: Border.all(color: borderColor!, width: borderSize),
                                  shape: BoxShape.circle,
                                ),
                                child: innerContent,
                              )
                            : DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: backgroundColor ?? zetaColors.surfaceHover,
                                ),
                                child: innerContent,
                              ),
                      ),
                    ),
                  ),
                  if (upperBadge != null)
                    Positioned(
                      right: Zeta.of(context).spacing.none,
                      child: Semantics(
                        value: semanticLowerBadgeLabel,
                        child: upperBadge.runtimeType == ZetaAvatarBadge
                            ? (upperBadge! as ZetaAvatarBadge).copyWith(size: size)
                            : upperBadge,
                      ),
                    ),
                  if (lowerBadge != null)
                    Positioned(
                      right: Zeta.of(context).spacing.none,
                      bottom: Zeta.of(context).spacing.none,
                      child: Semantics(
                        value: semanticLowerBadgeLabel,
                        child: lowerBadge.runtimeType == ZetaAvatarBadge
                            ? (lowerBadge! as ZetaAvatarBadge).copyWith(size: size)
                            : lowerBadge,
                      ),
                    ),
                ],
              ),
              if (label != null)
                SizedBox(
                  height: Zeta.of(context).spacing.minimum,
                ),
              if (label != null)
                SizedBox(
                  width: pSize,
                  child: Text(
                    label!,
                    style: labelTextStyle ??
                        size._labelStyle(context).copyWith(
                              color: zetaColors.mainSubtle,
                            ),
                    maxLines: labelMaxLines,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaAvatarSize>('size', size))
      ..add(DiagnosticsProperty<String?>('name', initials))
      ..add(DiagnosticsProperty<Widget>('lowerBadge', lowerBadge))
      ..add(DiagnosticsProperty<Widget?>('upperBadge', upperBadge))
      ..add(DiagnosticsProperty<Color?>('backgroundColor', backgroundColor))
      ..add(ColorProperty('statusColor', borderColor))
      ..add(StringProperty('semanticUpperBadgeValue', semanticUpperBadgeLabel))
      ..add(StringProperty('semanticValue', semanticLabel))
      ..add(StringProperty('semanticLowerBadgeValue', semanticLowerBadgeLabel))
      ..add(DiagnosticsProperty<TextStyle>('initialTextStyle', initialTextStyle))
      ..add(DiagnosticsProperty<TextStyle?>('labelTextStyle', labelTextStyle))
      ..add(StringProperty('label', label))
      ..add(IntProperty('labelMaxLines', labelMaxLines))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap));
  }

  /// Returns pixel size for [ZetaAvatarSize]
  static double pixelSize(BuildContext context, ZetaAvatarSize size) {
    switch (size) {
      case ZetaAvatarSize.xxxl:
        return Zeta.of(context).spacing.minimum * 50; // TODO(UX-1202): ZetaSpacingBase
      // return ZetaSpacingBase.x50;
      case ZetaAvatarSize.xxl:
        return Zeta.of(context).spacing.minimum * 30; // TODO(UX-1202): ZetaSpacingBase
      // return ZetaSpacingBase.x30;
      case ZetaAvatarSize.xl:
        return Zeta.of(context).spacing.xl_10;
      case ZetaAvatarSize.l:
        return Zeta.of(context).spacing.xl_9;
      case ZetaAvatarSize.m:
        return Zeta.of(context).spacing.xl_8;
      case ZetaAvatarSize.s:
        return Zeta.of(context).spacing.xl_6;
      case ZetaAvatarSize.xs:
        return Zeta.of(context).spacing.xl_5;
      case ZetaAvatarSize.xxs:
        return Zeta.of(context).spacing.xl_4;
      case ZetaAvatarSize.xxxs:
        return Zeta.of(context).spacing.xl_2;
    }
  }

  /// Font size for initials
  static double fontSize(BuildContext context, ZetaAvatarSize size) {
    return pixelSize(context, size) * 4 / 9;
  }
}

/// Enum of types for [ZetaAvatarBadge]
enum ZetaAvatarBadgeType {
  /// Shows an icon on [ZetaAvatarBadge]. Defaults to [ZetaIcons.star].
  icon,

  /// Shows a number on [ZetaAvatarBadge] from provided [ZetaAvatarBadge.value].
  notification,
}

// TODO(UX-1138): Can this be refactored to use ZetaIndicator?

/// Badge component used with [ZetaAvatar] as either [ZetaAvatar.upperBadge] or [ZetaAvatar.lowerBadge].
///
/// {@category Components}
///
/// Sizes and styles are managed by the parent [ZetaAvatar].
class ZetaAvatarBadge extends StatelessWidget {
  /// Constructor for [ZetaAvatarBadge]
  const ZetaAvatarBadge({
    super.key,
    this.color,
    this.type = ZetaAvatarBadgeType.notification,
    this.icon,
    this.value,
    this.iconColor,
  }) : size = ZetaAvatarSize.xxxl;

  const ZetaAvatarBadge._({
    super.key,
    required this.color,
    required this.size,
    required this.type,
    this.icon,
    this.value,
    this.iconColor,
  });

  /// Constructs [ZetaAvatarBadge] with icon
  const ZetaAvatarBadge.icon({
    super.key,
    this.color,
    this.icon = ZetaIcons.star,
    this.iconColor,
    this.size = ZetaAvatarSize.xxxl,
  })  : value = null,
        type = ZetaAvatarBadgeType.icon;

  /// Constructs [ZetaAvatarBadge] with notifications

  const ZetaAvatarBadge.notification({
    super.key,
    this.value,
  })  : size = ZetaAvatarSize.xxxl,
        icon = null,
        iconColor = null,
        color = null,
        type = ZetaAvatarBadgeType.notification;

  /// Size of badge
  final ZetaAvatarSize size;

  /// Type of badge
  final ZetaAvatarBadgeType type;

  /// Background color for badge
  final Color? color;

  /// Icon of badge
  final IconData? icon;

  /// Icon color for badge
  final Color? iconColor;

  /// Notification value for badge
  final int? value;

  /// Returns copy of [ZetaAvatarBadge]
  ZetaAvatarBadge copyWith({
    Color? color,
    ZetaAvatarSize? size,
    IconData? icon,
    Color? iconColor,
    int? value,
    ZetaAvatarBadgeType? type,
  }) {
    return ZetaAvatarBadge._(
      color: color ?? this.color,
      size: size ?? this.size,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      value: value ?? this.value,
      iconColor: iconColor ?? this.iconColor,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final Color backgroundColor =
        type == ZetaAvatarBadgeType.notification ? colors.surfaceNegative : (color ?? colors.mainPrimary);
    final badgeSize = _getContainerSize(context);
    final borderSize = _getBorderSize(context);
    final paddedSize = badgeSize + Zeta.of(context).spacing.minimum;

    final innerContent = Container(
      margin: const EdgeInsets.all(0.01),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(badgeSize / 2),
      ),
      child: value != null
          ? Center(
              child: Text(
                value! > 99 ? '99+' : '$value',
                style: TextStyle(
                  color: backgroundColor.onColor,
                  fontSize: ((10 / 12) * badgeSize) - 2,
                  height: 1,
                ),
              ),
            )
          : icon != null
              ? ZetaIcon(
                  icon,
                  size: badgeSize - borderSize,
                  color: iconColor ?? backgroundColor.onColor,
                )
              : null,
    );

    return Container(
      width: value != null
          ? value! > 9
              ? badgeSize * 1.8
              : paddedSize
          : paddedSize,
      // width: paddedSize,
      height: paddedSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: borderSize, color: Zeta.of(context).colors.surfaceDefault),
      ),
      child: innerContent,
    );
  }

  double _getContainerSize(BuildContext context) => size._pixelSize(context) / 3;

  double _getBorderSize(BuildContext context) => size._pixelSize(context) / 48;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(EnumProperty<ZetaAvatarSize>('size', size))
      ..add(EnumProperty<ZetaAvatarBadgeType>('type', type))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(ColorProperty('iconColor', iconColor))
      ..add(IntProperty('value', value));
  }
}
