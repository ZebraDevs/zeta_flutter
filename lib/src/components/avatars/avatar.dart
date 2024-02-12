import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// [ZetaAvatar] size
enum ZetaAvatarSize {
  /// [xl] 64 pixels
  xl,

  /// [l] 48 pixels
  l,

  /// [m] 40 pixels
  m,

  /// [s] 32 pixels
  s,

  /// [xs] 24 pixels
  xs,
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
  final ZetaIndicator? lowerBadge;

  /// Notification Badge shown at top right corner of avatar.
  final ZetaIndicator? upperBadge;

  bool get _showPlaceholder => image == null && (initials == null || initials!.isEmpty);

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    final borderSize = size.borderSize;
    final sizePixels = size.pixelSize;
    final contentSizePixels = size.pixelSize - (borderColor != null ? size.borderSize * 2 : 0);

    final innerContent = ClipRRect(
      borderRadius: BorderRadius.circular(64),
      clipBehavior: Clip.hardEdge,
      child: image ??
          (_showPlaceholder
              ? Container(
                  transform: Matrix4.translationValues(-contentSizePixels * 0.2, -contentSizePixels * 0.1, 0),
                  child: IconTheme(
                    data: IconThemeData(
                      color: Zeta.of(context).colors.cool,
                      size: contentSizePixels * 1.4,
                    ),
                    child: const Icon(ZetaIcons.user_round),
                  ),
                )
              : Center(
                  child: Text(
                    size == ZetaAvatarSize.xs ? initials!.substring(0, 1) : initials!,
                    style: TextStyle(fontSize: size.fontSize, letterSpacing: -0.5),
                  ),
                )),
    );

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(upperBadge == null && lowerBadge == null ? 0 : 3),
          width: sizePixels,
          height: sizePixels,
          decoration: BoxDecoration(
            border: borderColor != null ? Border.all(color: borderColor!, width: borderSize / ZetaSpacing.x0_5) : null,
            borderRadius: ZetaRadius.full,
            color: backgroundColor ?? (_showPlaceholder ? zetaColors.surfacePrimary : zetaColors.cool.shade20),
          ),
          child: borderColor != null
              ? Container(
                  width: contentSizePixels,
                  height: contentSizePixels,
                  decoration: BoxDecoration(
                    color: _showPlaceholder ? backgroundColor ?? zetaColors.surfaceHovered : null,
                    border: Border.all(color: zetaColors.surfacePrimary, width: borderSize / ZetaSpacing.x0_5),
                    borderRadius: ZetaRadius.full,
                  ),
                  child: ClipRRect(borderRadius: ZetaRadius.full, clipBehavior: Clip.hardEdge, child: innerContent),
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: ZetaRadius.full,
                    color: backgroundColor ?? zetaColors.surfaceHovered,
                  ),
                  child: innerContent,
                ),
        ),
        if (upperBadge != null)
          Positioned(
            right: 1,
            child: upperBadge!.copyWith(size: size.indicatorSize),
          ),
        if (lowerBadge != null)
          Positioned(
            right: 1,
            bottom: 1,
            child: lowerBadge!.copyWith(size: size.indicatorSize),
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
      ..add(DiagnosticsProperty<ZetaIndicator>('specialStatus', lowerBadge))
      ..add(DiagnosticsProperty<ZetaIndicator?>('badge', upperBadge))
      ..add(DiagnosticsProperty<Color?>('backgroundColor', backgroundColor))
      ..add(ColorProperty('statusColor', borderColor));
  }
}

extension on ZetaAvatarSize {
  double get pixelSize {
    switch (this) {
      case ZetaAvatarSize.xl:
        return ZetaSpacing.x16;
      case ZetaAvatarSize.l:
        return ZetaSpacing.x12;
      case ZetaAvatarSize.m:
        return ZetaSpacing.x10;
      case ZetaAvatarSize.s:
        return ZetaSpacing.x8;
      case ZetaAvatarSize.xs:
        return ZetaSpacing.x6;
    }
  }

  ZetaWidgetSize get indicatorSize {
    switch (this) {
      case ZetaAvatarSize.xl:
      case ZetaAvatarSize.l:
      case ZetaAvatarSize.m:
        return ZetaWidgetSize.large;
      case ZetaAvatarSize.s:
        return ZetaWidgetSize.medium;

      case ZetaAvatarSize.xs:
        return ZetaWidgetSize.small;
    }
  }

  double get borderSize {
    switch (this) {
      case ZetaAvatarSize.xl:
      case ZetaAvatarSize.l:
      case ZetaAvatarSize.m:
        return ZetaSpacing.x1;

      case ZetaAvatarSize.s:
      case ZetaAvatarSize.xs:
        return ZetaSpacing.x0_5;
    }
  }

  double get fontSize {
    switch (this) {
      case ZetaAvatarSize.xl:
        return ZetaSpacing.x5;
      case ZetaAvatarSize.l:
        return ZetaSpacing.x4;
      case ZetaAvatarSize.m:
        return ZetaSpacing.x3_5;
      case ZetaAvatarSize.s:
      case ZetaAvatarSize.xs:
        return ZetaSpacing.x3;
    }
  }
}
