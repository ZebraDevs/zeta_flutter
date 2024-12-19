import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../avatars/avatar.dart';

/// A stateless widget that represents an avatar rail in the Zeta application.
///
/// The `ZetaAvatarRail` widget is used to display a horizontal rail of avatars,
/// typically used for navigation or selection purposes within the application.
///
/// This widget does not maintain any state and relies on its parent and children widgets to
/// provide the necessary data and handle interactions.
///
/// Example usage:
///
/// ```dart
/// ZetaAvatarRail(
///   avatars: [
///    ZetaAvatar.initials(
///       key: Key('avatar1'),
///       initials: 'AZ',
///       onTap: () => print('Avatar tapped'),
///       label: 'Archie',
///     ),
///     ZetaAvatar.initials(
///       key: Key('avatar2'),
///       initials: 'BY',
///       onTap: () => print('Avatar tapped'),
///       label: 'Beth',
///     ),
///     ZetaAvatar.initials(
///       key: Key('avatar3'),
///       initials: 'CX',
///       onTap: () => print('Avatar tapped'),
///       label: 'Carla',
///     ),
///   ]
/// )
/// ```
///
/// See also:
///
///  * [StatelessWidget], which is the superclass of this widget.
///  * [ZetaAvatar], which is used within this rail to represent individual avatars.
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=20816-388
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/avatar/avatar-rail
class ZetaAvatarRail extends StatelessWidget {
  ///
  const ZetaAvatarRail({
    super.key,
    this.size,
    required this.avatars,
    this.labelTextStyle,
    this.labelMaxLines = 1,
    this.onTap,
    this.gap,
  });

  /// A list of `ZetaAvatar` objects representing the avatars to be displayed.
  final List<ZetaAvatar> avatars;

  /// The size of the [ZetaAvatar]s
  final ZetaAvatarSize? size;

  /// The text style to be applied to the label of the [ZetaAvatar]s.
  final TextStyle? labelTextStyle;

  /// The maximum number of lines to be displayed in the label of the [ZetaAvatar]s.
  final int labelMaxLines;

  /// A callback function to be executed when an [ZetaAvatar] is tapped.
  /// The function receives the key of the tapped [ZetaAvatar] as a parameter.
  /// If no key is provided, the index of the [ZetaAvatar] in the list is used.
  final void Function(Key)? onTap;

  /// The gap between the avatars.
  /// Defaults to 'Zeta.of(context).spacing.small)
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final avatar in avatars)
                avatar.copyWith(
                  size: size,
                  labelTextStyle: labelTextStyle,
                  labelMaxLines: labelMaxLines,
                  onTap: () => onTap?.call(key ?? Key(avatars.indexOf(avatar).toString())),
                  key: key ?? Key(avatars.indexOf(avatar).toString()),
                ),
            ].gap(gap ?? Zeta.of(context).spacing.small),
          ),
        ),
      ],
    );
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextStyle?>('labelTextStyle', labelTextStyle))
      ..add(EnumProperty<ZetaAvatarSize?>('size', size))
      ..add(IntProperty('labelMaxLines', labelMaxLines))
      ..add(ObjectFlagProperty<void Function(Key p1)?>.has('onTap', onTap))
      ..add(DoubleProperty('gap', gap));
  }
}
