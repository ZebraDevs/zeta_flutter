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
  xxxs,
}

/// An avatar is a visual representation of a user or entity.
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=20816-388
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/avatar
class ZetaAvatar extends ZetaStatelessWidget {
  /// Constructor for [ZetaAvatar]
  const ZetaAvatar({
    super.key,
    this.size = ZetaAvatarSize.m,
    this.image,
    this.initials,
    this.backgroundColor,
    this.badge,
    this.showRing = false,
    this.semanticLabel = 'avatar',
    this.semanticBadgeLabel,
    this.initialTextStyle,
    this.onClose,
    this.semanticCloseLabel,
  });

  /// Constructor for [ZetaAvatar] with image.
  const ZetaAvatar.image({
    super.key,
    this.size = ZetaAvatarSize.m,
    this.image,
    this.badge,
    this.showRing = false,
    this.semanticLabel = 'avatar',
    this.semanticBadgeLabel,
    this.semanticCloseLabel,
    this.onClose,
  })  : backgroundColor = null,
        initials = null,
        initialTextStyle = null;

  /// Constructor for [ZetaAvatar] with initials.
  const ZetaAvatar.initials({
    super.key,
    required this.initials,
    this.size = ZetaAvatarSize.m,
    this.badge,
    this.showRing = false,
    this.backgroundColor,
    this.semanticLabel = 'avatar',
    this.semanticBadgeLabel,
    this.semanticCloseLabel,
    this.onClose,
    this.initialTextStyle,
  }) : image = null;

  /// Constructor for [ZetaAvatar] with initials from a full name.
  ZetaAvatar.fromName({
    super.key,
    required String name,
    this.size = ZetaAvatarSize.m,
    this.badge,
    this.showRing = false,
    this.backgroundColor,
    this.semanticLabel = 'avatar',
    this.semanticBadgeLabel,
    this.semanticCloseLabel,
    this.initialTextStyle,
    this.onClose,
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
  final bool showRing;

  /// Status badge shown at lower right corner of avatar.
  final Widget? badge;

  /// Value passed into wrapping [Semantics] widget.
  ///
  /// {@template zeta-widget-semantic-label}
  /// This label is used by accessibility frameworks (e.g. TalkBack on Android) to describe the component.
  /// {@endtemplate}
  final String semanticLabel;

  /// Value passed into wrapping [Semantics] widget for the badge.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticBadgeLabel;

  /// Value passed into wrapping [Semantics] widget for the close icon.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticCloseLabel;

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

  final VoidCallback? onClose;

  /// Return copy of avatar with certain changed fields
  ZetaAvatar copyWith({
    ZetaAvatarSize? size,
    Widget? image,
    String? initials,
    Color? backgroundColor,
    bool? showRing,
    Widget? badge,
  }) {
    return ZetaAvatar(
      size: size ?? this.size,
      image: image ?? this.image,
      initials: initials ?? this.initials,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      showRing: showRing ?? this.showRing,
      badge: badge ?? this.badge,
    );
  }

  bool get _showPlaceholder => image == null && (initials == null || initials!.isEmpty);

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    final radius = Zeta.of(context).radius;

    final backgroundColor = this.backgroundColor ?? zetaColors.surfaceAvatarPurple;
    final borderSize = size.borderSize(context);
    final iconSize = size.iconSize(context);

    final innerChild = image ??
        (initials != null
            ? Center(
                child: Text(
                  initials!,
                  style: initialTextStyle ??
                      TextStyle(
                        fontSize: size.fontSize(context),
                        letterSpacing: Zeta.of(context).spacing.none,
                        color: backgroundColor.onColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              )
            : null);

    final innerContent = ClipRRect(
      borderRadius: radius.full,
      child: innerChild,
    );

    final pSize = size.pixelSize(context);

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Semantics(
        value: semanticLabel,
        child: SelectionContainer.disabled(
          child: Stack(
            children: [
              Container(
                width: pSize,
                height: pSize,
                decoration: BoxDecoration(
                  borderRadius: radius.full,
                  color: backgroundColor,
                  border: showRing
                      ? Border.all(
                          width: borderSize,
                          color: zetaColors.borderDefault,
                        )
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: radius.full,
                  child: innerContent,
                ),
              ),
              if (onClose != null)
                Positioned(
                  right: Zeta.of(context).spacing.none,
                  child: Semantics(
                    value: semanticCloseLabel,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: zetaColors.surfaceDefault,
                        borderRadius: radius.full,
                      ),
                      child: GestureDetector(
                        onTap: onClose,
                        child: ZetaIcon(
                          ZetaIcons.cancel,
                          size: iconSize,
                          color: zetaColors.iconDisabled,
                        ),
                      ),
                    ),
                  ),
                ),
              if (badge != null)
                Positioned(
                  right: Zeta.of(context).spacing.none,
                  bottom: Zeta.of(context).spacing.none,
                  child: Semantics(
                    value: semanticBadgeLabel,
                    child: badge,
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
      ..add(DiagnosticsProperty<Color?>('backgroundColor', backgroundColor))
      ..add(StringProperty('semanticValue', semanticLabel))
      ..add(StringProperty('semanticLowerBadgeValue', semanticBadgeLabel))
      ..add(DiagnosticsProperty<TextStyle>('initialTextStyle', initialTextStyle));
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

extension on ZetaAvatarSize {
  double pixelSize(BuildContext context) {
    return ZetaAvatar.pixelSize(context, this);
  }

  double borderSize(BuildContext context) {
    switch (this) {
      case ZetaAvatarSize.xxxl:
        return 11;
      case ZetaAvatarSize.xxl:
      case ZetaAvatarSize.xl:
      case ZetaAvatarSize.l:
      case ZetaAvatarSize.m:
        return Zeta.of(context).spacing.minimum;

      case ZetaAvatarSize.s:
      case ZetaAvatarSize.xs:
      case ZetaAvatarSize.xxs:
      case ZetaAvatarSize.xxxs:
        return ZetaBorders.medium;
    }
  }

  double iconSize(BuildContext context) {
    return pixelSize(context) / 3;
  }

  double fontSize(BuildContext context) {
    return ZetaAvatar.fontSize(context, this);
  }
}

/// Enum of types for [ZetaAvatarBadge]
@Deprecated('ZetaAvatarBadge is deprecated. Use ZetaIndicator instead. ' 'deprecated as of 0.16.0')
enum ZetaAvatarBadgeType {
  /// Shows an icon on [ZetaAvatarBadge]. Defaults to [ZetaIcons.star].
  icon,

  /// Shows a number on [ZetaAvatarBadge] from provided [ZetaAvatarBadge.value].
  notification,
}

// TODO(UX-1138): Can this be refactored to use ZetaIndicator?

/// Badge component used with [ZetaAvatar] as either [ZetaAvatar.upperBadge] or [ZetaAvatar.lowerBadge].
///
/// Sizes and styles are managed by the parent [ZetaAvatar].
@Deprecated('ZetaAvatarBadge is deprecated. Use ZetaIndicator instead. ' 'deprecated as of 0.16.0')
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
    final radius = Zeta.of(context).radius;

    final Color backgroundColor =
        type == ZetaAvatarBadgeType.notification ? colors.surfaceNegative : (color ?? colors.primary);
    final badgeSize = _getContainerSize(context);
    final borderSize = _getBorderSize(context);
    final paddedSize = badgeSize + Zeta.of(context).spacing.minimum;

    final innerContent = Container(
      margin: const EdgeInsets.all(0.01),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: radius.full,
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
      width: type == ZetaAvatarBadgeType.icon ? paddedSize : badgeSize * 1.8,
      height: type == ZetaAvatarBadgeType.icon ? paddedSize : badgeSize,
      decoration: BoxDecoration(
        borderRadius: radius.full,
        border: type != ZetaAvatarBadgeType.notification
            ? Border.all(
                width: borderSize,
                color: Zeta.of(context).colors.surfacePrimary,
              )
            : null,
      ),
      child: innerContent,
    );
  }

  double _getContainerSize(BuildContext context) {
    return size.pixelSize(context) / 3;
  }

  double _getBorderSize(BuildContext context) {
    return size.pixelSize(context) / 48;
  }

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
