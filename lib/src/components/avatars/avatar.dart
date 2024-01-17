import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// [ZetaAvatar] type
enum ZetaAvatarType {
  /// [image] shows a picture or a placeholder
  image,

  /// [initials] shows one or two letters
  initials,
}

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
  /// [image] and [imageUrl] are used with [type] `ZetaAvatarType.image`
  /// [initials] and [name] are used with [type] `ZetaAvatarType.initials`
  /// If none provided, a placeholder is displayed, which defaults to `ZetaIcons.avatar`,
  /// but can be customized via [placeholderIcon] and [placeholderColor].
  ZetaAvatar({
    super.key,
    required this.type,
    this.size = ZetaAvatarSize.xl,
    this.image,
    this.imageUrl,
    this.initials,
    this.name,
    this.backgroundColor,
    this.placeholderIcon,
    this.placeholderColor,
    this.showStatus = false,
    this.statusPrimaryColor,
    this.statusSecondaryColor,
    this.specialStatus,
    this.badge,
  }) {
    _sizePixels = getSizePixels(size);
    _borderSize = _getBorderSize(size);
    _initialsToShow =
        initials?.isEmpty ?? true ? _getInitialsFromName(name) : initials!.substring(0, initials!.length > 1 ? 2 : 1);
  }

  /// Constructor for [ZetaAvatar] of type `image`
  factory ZetaAvatar.image({
    ZetaAvatarSize size = ZetaAvatarSize.xl,
    ImageProvider? image,
    String? imageUrl,
    String? initials,
    String? name,
    Color? backgroundColor,
    Icon? placeholderIcon,
    Color? placeholderColor,
    bool showStatus = false,
    Color? statusPrimaryColor,
    Color? statusSecondaryColor,
    ZetaIndicator? specialStatus,
    ZetaIndicator? badge,
  }) =>
      ZetaAvatar(
        type: ZetaAvatarType.image,
        size: size,
        image: image,
        imageUrl: imageUrl,
        initials: initials,
        name: name,
        backgroundColor: backgroundColor,
        placeholderIcon: placeholderIcon,
        placeholderColor: placeholderColor,
        showStatus: showStatus,
        statusPrimaryColor: statusPrimaryColor,
        statusSecondaryColor: statusSecondaryColor,
        specialStatus: specialStatus,
        badge: badge,
      );

  /// Constructor for [ZetaAvatar] of type `initials`
  factory ZetaAvatar.initials({
    ZetaAvatarSize size = ZetaAvatarSize.xl,
    ImageProvider? image,
    String? imageUrl,
    String? initials,
    String? name,
    Color? backgroundColor,
    Icon? placeholderIcon,
    Color? placeholderColor,
    bool showStatus = false,
    Color? statusPrimaryColor,
    Color? statusSecondaryColor,
    ZetaIndicator? specialStatus,
    ZetaIndicator? badge,
  }) =>
      ZetaAvatar(
        type: ZetaAvatarType.initials,
        size: size,
        image: image,
        imageUrl: imageUrl,
        initials: initials,
        name: name,
        backgroundColor: backgroundColor,
        placeholderIcon: placeholderIcon,
        placeholderColor: placeholderColor,
        showStatus: showStatus,
        statusPrimaryColor: statusPrimaryColor,
        statusSecondaryColor: statusSecondaryColor,
        specialStatus: specialStatus,
        badge: badge,
      );

  /// The type of the [ZetaAvatar] - image or initials
  final ZetaAvatarType type;

  /// The size of the [ZetaAvatar]
  final ZetaAvatarSize size;

  /// The `ImageProvider` for the type `image`
  final ImageProvider? image;

  /// The URL for the type `image`
  final String? imageUrl;

  /// The initials for the type `initials`
  final String? initials;

  /// Initials could be retrieved from `name`
  final String? name;

  /// Background color.
  final Color? backgroundColor;

  /// Placeholder icon
  final Icon? placeholderIcon;

  /// Placeholder color
  final Color? placeholderColor;

  /// Shows border around the avatar
  /// See also [statusPrimaryColor] and [statusSecondaryColor]
  final bool showStatus;

  /// Color for the outer border, if [showStatus] is `true`
  final Color? statusPrimaryColor;

  /// Color for the inner border, if [showStatus] is `true`
  final Color? statusSecondaryColor;

  /// Show [ZetaIndicator] at the lower right corner
  final ZetaIndicator? specialStatus;

  /// Show [ZetaIndicator] at the upper right corner
  final ZetaIndicator? badge;

  late final double _sizePixels;
  late final double _borderSize;
  late final String _initialsToShow;

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    final innerContent = _InnerContent(
      type: type,
      size: size,
      sizePixels: _sizePixels,
      borderSize: _borderSize,
      image: image,
      imageUrl: imageUrl,
      initials: _initialsToShow,
      showStatus: showStatus,
      placeholderIcon: placeholderIcon,
      placeholderColor: placeholderColor,
    );

    return Stack(
      children: [
        if (showStatus)
          Container(
            margin: EdgeInsets.all(badge == null && specialStatus == null ? 0 : 3),
            width: _sizePixels,
            height: _sizePixels,
            decoration: BoxDecoration(
              border: Border.all(
                color: statusPrimaryColor ?? zetaColors.positive,
                width: _borderSize,
              ),
              borderRadius: BorderRadius.circular(64),
            ),
            child: Container(
              width: _sizePixels - _borderSize * 2,
              height: _sizePixels - _borderSize * 2,
              decoration: BoxDecoration(
                color: type == ZetaAvatarType.initials && _initialsToShow.isNotEmpty
                    ? backgroundColor ?? zetaColors.surfaceHovered
                    : null,
                border: Border.all(
                  color: statusSecondaryColor ?? zetaColors.surfacePrimary,
                  width: _borderSize,
                ),
                borderRadius: BorderRadius.circular(64),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(64),
                clipBehavior: Clip.hardEdge,
                child: innerContent,
              ),
            ),
          )
        else
          Container(
            margin: EdgeInsets.all(badge == null && specialStatus == null ? 0 : 3),
            width: _sizePixels,
            height: _sizePixels,
            decoration: BoxDecoration(
              color: backgroundColor ?? zetaColors.surfaceHovered,
              borderRadius: BorderRadius.circular(64),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(64),
              clipBehavior: Clip.hardEdge,
              child: innerContent,
            ),
          ),
        if (badge != null)
          Positioned(
            right: 1,
            child: badge!,
          ),
        if (specialStatus != null)
          Positioned(
            right: 1,
            bottom: 1,
            child: specialStatus!,
          ),
      ],
    );
  }

  /// Returns the size of [ZetaAvatarSize] in pixels
  static double getSizePixels(ZetaAvatarSize size) {
    switch (size) {
      case ZetaAvatarSize.xl:
        return 64;
      case ZetaAvatarSize.l:
        return 48;
      case ZetaAvatarSize.m:
        return 40;
      case ZetaAvatarSize.s:
        return 32;
      case ZetaAvatarSize.xs:
        return 24;
    }
  }

  double _getBorderSize(ZetaAvatarSize size) {
    switch (size) {
      case ZetaAvatarSize.xl:
        return 2;
      case ZetaAvatarSize.l:
        return 2;
      case ZetaAvatarSize.m:
        return 1.67;
      case ZetaAvatarSize.s:
        return 1.33;
      case ZetaAvatarSize.xs:
        return 1;
    }
  }

  String _getInitialsFromName(String? name) {
    if (name == null) return '';
    final List<String> nameParts = name.split(RegExp(r'\W+'))..removeWhere((item) => item.isEmpty);
    if (nameParts.isEmpty) return '';
    return (nameParts.length > 1
            ? nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1)
            : nameParts[0].length > 1
                ? nameParts[0].substring(0, 2)
                : nameParts[0])
        .toUpperCase();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaAvatarType>('type', type))
      ..add(DiagnosticsProperty<ZetaAvatarSize>('size', size))
      ..add(DiagnosticsProperty<ImageProvider?>('image', image))
      ..add(DiagnosticsProperty<String?>('imageUrl', imageUrl))
      ..add(DiagnosticsProperty<String?>('initials', initials))
      ..add(DiagnosticsProperty<String?>('name', name))
      ..add(DiagnosticsProperty<bool>('showStatus', showStatus))
      ..add(DiagnosticsProperty<ZetaIndicator>('specialStatus', specialStatus))
      ..add(DiagnosticsProperty<ZetaIndicator?>('badge', badge))
      ..add(DiagnosticsProperty<Icon?>('placeholderIcon', placeholderIcon))
      ..add(DiagnosticsProperty<Color?>('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<Color?>('placeholderColor', placeholderColor))
      ..add(DiagnosticsProperty<Color?>('statusPrimaryColor', statusPrimaryColor))
      ..add(DiagnosticsProperty<Color?>('statusSecondaryColor', statusSecondaryColor));
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({
    required this.type,
    required this.size,
    required this.sizePixels,
    required this.borderSize,
    required this.initials,
    this.image,
    this.imageUrl,
    this.showStatus = false,
    this.placeholderIcon,
    this.placeholderColor,
  });

  final ZetaAvatarType type;
  final ZetaAvatarSize size;
  final double sizePixels;
  final double borderSize;
  final String initials;
  final ImageProvider? image;
  final String? imageUrl;
  final bool showStatus;
  final Icon? placeholderIcon;
  final Color? placeholderColor;

  @override
  Widget build(BuildContext context) {
    final placeholder = IconTheme(
      data: IconThemeData(
        color: placeholderColor ?? Zeta.of(context).colors.cool,
        size: showStatus ? sizePixels - borderSize * 4 : sizePixels,
      ),
      child: placeholderIcon ?? const Icon(ZetaIcons.avatar),
    );

    switch (type) {
      case ZetaAvatarType.image:
        return image == null
            ? imageUrl == null
                ? placeholder
                : CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => placeholder,
                    errorWidget: (_, __, ___) => placeholder,
                  )
            : Image(image: image!, fit: BoxFit.cover);
      case ZetaAvatarType.initials:
        return initials.isEmpty
            ? placeholder
            : Center(
                child: Text(
                  size == ZetaAvatarSize.xs ? initials.substring(0, 1) : initials,
                  style: TextStyle(
                    fontSize: _getFontSize(size),
                    letterSpacing: -0.5,
                  ),
                ),
              );
    }
  }

  double _getFontSize(ZetaAvatarSize size) {
    switch (size) {
      case ZetaAvatarSize.xl:
        return 28;
      case ZetaAvatarSize.l:
        return 24;
      case ZetaAvatarSize.m:
        return 20;
      case ZetaAvatarSize.s:
        return 16;
      case ZetaAvatarSize.xs:
        return 16;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaAvatarType>('type', type))
      ..add(DiagnosticsProperty<ZetaAvatarSize>('size', size))
      ..add(DiagnosticsProperty<double>('sizePixels', sizePixels))
      ..add(DiagnosticsProperty<double>('borderSize', borderSize))
      ..add(DiagnosticsProperty<ImageProvider?>('image', image))
      ..add(DiagnosticsProperty<String?>('imageUrl', imageUrl))
      ..add(DiagnosticsProperty<String?>('initials', initials))
      ..add(DiagnosticsProperty<bool>('showStatus', showStatus))
      ..add(DiagnosticsProperty<Icon?>('placeholderIcon', placeholderIcon))
      ..add(DiagnosticsProperty<Color?>('placeholderColor', placeholderColor));
  }
}
