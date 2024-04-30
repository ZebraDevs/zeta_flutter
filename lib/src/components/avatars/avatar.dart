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

/// ZetaAvatar component
class ZetaAvatar extends StatelessWidget {
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
  });

  /// Constructor for [ZetaAvatar] with image.
  const ZetaAvatar.image({
    super.key,
    this.size = ZetaAvatarSize.xl,
    this.image,
    this.lowerBadge,
    this.upperBadge,
    this.borderColor,
  })  : backgroundColor = null,
        initials = null;

  /// Constructor for [ZetaAvatar] with initials.
  const ZetaAvatar.initials({
    super.key,
    required this.initials,
    this.size = ZetaAvatarSize.xl,
    this.lowerBadge,
    this.upperBadge,
    this.borderColor,
    this.backgroundColor,
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
  final ZetaAvatarBadge? lowerBadge;

  /// Notification Badge shown at top right corner of avatar.
  final ZetaAvatarBadge? upperBadge;

  bool get _showPlaceholder => image == null && (initials == null || initials!.isEmpty);

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    final borderSize = size.borderSize;
    final sizePixels = size.pixelSize;
    final contentSizePixels = size.pixelSize;

    final innerChild = image ??
        (initials != null
            ? Center(
                child: Text(
                  size == ZetaAvatarSize.xs ? initials!.substring(0, 1) : initials!,
                  style: TextStyle(
                    fontSize: size.fontSize,
                    letterSpacing: 0,
                    color: backgroundColor?.onColor,
                  ),
                ),
              )
            : null);

    final innerContent = ClipRRect(
      borderRadius: ZetaRadius.full,
      child: innerChild,
    );

    return Stack(
      children: [
        Container(
          width: sizePixels,
          height: sizePixels,
          decoration: BoxDecoration(
            border: borderColor != null ? Border.all(color: borderColor!, width: 0) : null,
            borderRadius: ZetaRadius.full,
            color: backgroundColor ?? (_showPlaceholder ? zetaColors.surfacePrimary : zetaColors.cool.shade20),
          ),
          child: borderColor != null
              ? Container(
                  width: contentSizePixels,
                  height: contentSizePixels,
                  decoration: BoxDecoration(
                    color: backgroundColor ?? zetaColors.surfaceHovered,
                    border: Border.all(color: borderColor!, width: borderSize),
                    borderRadius: ZetaRadius.full,
                  ),
                  child: ClipRRect(
                    borderRadius: ZetaRadius.full,
                    child: innerContent,
                  ),
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: ZetaRadius.full,
                    color: backgroundColor ?? zetaColors.surfaceHovered,
                  ),
                  child: ClipRRect(
                    borderRadius: ZetaRadius.full,
                    child: innerContent,
                  ),
                ),
        ),
        if (upperBadge != null)
          Positioned(
            right: 0,
            child: upperBadge!.copyWith(
              size: size,
            ),
          ),
        if (lowerBadge != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: lowerBadge!.copyWith(
              size: size,
            ),
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaAvatarSize>('size', size))
      ..add(DiagnosticsProperty<String?>('name', initials))
      ..add(DiagnosticsProperty<ZetaAvatarBadge>('specialStatus', lowerBadge))
      ..add(DiagnosticsProperty<ZetaAvatarBadge?>('badge', upperBadge))
      ..add(DiagnosticsProperty<Color?>('backgroundColor', backgroundColor))
      ..add(ColorProperty('statusColor', borderColor));
  }
}

extension on ZetaAvatarSize {
  double get pixelSize {
    switch (this) {
      case ZetaAvatarSize.xxxl:
        return ZetaSpacing.x50;
      case ZetaAvatarSize.xxl:
        return ZetaSpacing.x30;
      case ZetaAvatarSize.xl:
        return ZetaSpacing.x20;
      case ZetaAvatarSize.l:
        return ZetaSpacing.x16;
      case ZetaAvatarSize.m:
        return ZetaSpacing.x12;
      case ZetaAvatarSize.s:
        return ZetaSpacing.x10;
      case ZetaAvatarSize.xs:
        return ZetaSpacing.x9;
      case ZetaAvatarSize.xxs:
        return ZetaSpacing.x8;
      case ZetaAvatarSize.xxxs:
        return ZetaSpacing.x6;
    }
  }

  double get borderSize {
    switch (this) {
      case ZetaAvatarSize.xxxl:
        return 11;
      case ZetaAvatarSize.xxl:
      case ZetaAvatarSize.xl:
      case ZetaAvatarSize.l:
      case ZetaAvatarSize.m:
        return ZetaSpacing.x1;

      case ZetaAvatarSize.s:
      case ZetaAvatarSize.xs:
      case ZetaAvatarSize.xxs:
      case ZetaAvatarSize.xxxs:
        return ZetaSpacing.x0_5;
    }
  }

  double get fontSize {
    return pixelSize * 4 / 9;
  }
}

/// Enum of types for [ZetaAvatarBadge]
enum ZetaAvatarBadgeType {
  /// Shows an icon on [ZetaAvatarBadge]. Defaults to [ZetaIcons.star_round].
  icon,

  /// Shows a number on [ZetaAvatarBadge] from provided [ZetaAvatarBadge.value].
  notification,
}

/// ZetaAvatarBadge component

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
    this.icon = ZetaIcons.star_round,
    this.iconColor,
  })  : value = null,
        size = ZetaAvatarSize.xxxl,
        type = ZetaAvatarBadgeType.icon;

  /// Constructs [ZetaAvatarBadge] with notifications

  const ZetaAvatarBadge.notification({
    super.key,
    required this.value,
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
    final backgroundColor = type == ZetaAvatarBadgeType.notification ? colors.negative : color;
    final badgeSize = _getContainerSize();
    final borderSize = _getBorderSize();
    final paddedSize = badgeSize + ZetaSpacing.x1;

    final innerContent = Container(
      margin: const EdgeInsets.all(0.01),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: ZetaRadius.full,
      ),
      child: value != null
          ? Center(
              child: Text(
                value! > 99 ? '99+' : '$value',
                style: TextStyle(
                  color: backgroundColor?.onColor,
                  fontSize: ((10 / 12) * badgeSize) - 2,
                  height: 1,
                ),
              ),
            )
          : icon != null
              ? Icon(
                  icon,
                  size: badgeSize - borderSize,
                  color: iconColor ?? backgroundColor?.onColor,
                )
              : null,
    );

    return Container(
      width: type == ZetaAvatarBadgeType.icon ? paddedSize : badgeSize * 1.8,
      height: type == ZetaAvatarBadgeType.icon ? paddedSize : badgeSize,
      decoration: BoxDecoration(
        borderRadius: ZetaRadius.full,
        border: type != ZetaAvatarBadgeType.notification
            ? Border.all(
                width: borderSize,
                color: Zeta.of(context).colors.surfacePrimary,
              )
            : null,
      ),
      child: Center(child: innerContent),
    );
  }

  double _getContainerSize() {
    return size.pixelSize / 3;
  }

  double _getBorderSize() {
    return size.pixelSize / 48;
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
