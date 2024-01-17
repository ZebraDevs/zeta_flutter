import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';

///Defines the color of the floating action button
enum ZetaFabType {
  ///[primary]
  primary,

  ///[primarySecond]
  primarySecond,

  ///[inverse]
  inverse
}

///Defines the shape of the floating action button
enum ZetaFabShape {
  ///[circle]
  circle,

  ///[rounded]
  rounded,

  ///[sharp]
  sharp
}

///Defines the size of the floating action button
enum ZetaFabSize {
  /// [small] 56 pixels
  small,

  /// [large] 96 pixels
  large,
}

///Zeta Floating Action Button Component
class ZetaFAB extends StatefulWidget {
  ///Constructs [ZetaFAB]
  const ZetaFAB({
    required this.scrollController,
    required this.buttonLabel,
    this.buttonType = ZetaFabType.primary,
    this.buttonSize = ZetaFabSize.small,
    this.buttonShape = ZetaFabShape.circle,
    this.buttonIcon = ZetaIcons.add_round,
    this.onPressed,
    this.customAnimationDuration = const Duration(milliseconds: 300),
    super.key,
  });

  ///Defines the color of the button
  ///Defaults to [ZetaFabType.primary]
  final ZetaFabType buttonType;

  ///The Size of the button
  ///Defaults to [ZetaFabSize.small]
  final ZetaFabSize buttonSize;

  ///The shape for the button
  ///Defaults to [ZetaFabShape.circle]
  final ZetaFabShape buttonShape;

  ///Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  ///The [ZetaFAB] uses this controller to react to scroll change
  ///and shrink/expand itself
  final ScrollController scrollController;

  ///The label of the button
  final String buttonLabel;

  ///Icon for the button
  ///Defaults to [ZetaIcons.add_round]
  final IconData buttonIcon;

  ///Animation Duration
  final Duration customAnimationDuration;

  @override
  State<ZetaFAB> createState() => _ZetaFABState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaFabType>('buttonType', buttonType))
      ..add(EnumProperty<ZetaFabSize>('buttonSize', buttonSize))
      ..add(EnumProperty<ZetaFabShape>('buttonShape', buttonShape))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(
        DiagnosticsProperty<ScrollController>(
          'scrollController',
          scrollController,
        ),
      )
      ..add(StringProperty('buttonLabel', buttonLabel))
      ..add(DiagnosticsProperty<IconData>('buttonIcon', buttonIcon))
      ..add(
        DiagnosticsProperty<Duration>(
          'customAnimationDuration',
          customAnimationDuration,
        ),
      );
  }
}

class _ZetaFABState extends State<ZetaFAB> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final expanded = widget.scrollController.position.userScrollDirection == ScrollDirection.reverse;
    if (_isExpanded != expanded) {
      setState(() => _isExpanded = expanded);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final colors = _FabButtonColors.fromButtonType(widget.buttonType, theme);
    final textStyle = _getTextStyle();
    final buttonSize = _getButtonSize();
    final iconSize = _getIconSize();
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: _buttonStyle(colors),
      child: AnimatedSwitcher(
        duration: widget.customAnimationDuration,
        child: _isExpanded ? _buildFABExtended(buttonSize, iconSize, textStyle) : _buildFAB(buttonSize, iconSize),
      ),
    );
  }

  Widget _buildFAB(double buttonSize, double iconSize) {
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Icon(widget.buttonIcon, size: iconSize),
    );
  }

  Widget _buildFABExtended(
    double buttonSize,
    double iconSize,
    TextStyle textStyle,
  ) {
    return Padding(
      padding: _getPadding(),
      child: SizedBox(
        height: buttonSize,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.buttonIcon, size: iconSize),
            const SizedBox(width: Dimensions.x2),
            Text(widget.buttonLabel, style: textStyle),
          ],
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle(_FabButtonColors colors) {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: _getButtonShape(),
      backgroundColor: colors.backgroundColor,
      foregroundColor: colors.foregroundColor,
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) return colors.actionColor;
        return null;
      }),
    );
  }

  OutlinedBorder _getButtonShape() {
    if (widget.buttonShape == ZetaFabShape.circle && !_isExpanded) {
      return const CircleBorder();
    }
    return RoundedRectangleBorder(
      borderRadius: _isExpanded ? _getBorderRadiusExtended() : _getBorderRadius(),
    );
  }

  BorderRadius _getBorderRadius() => widget.buttonShape == ZetaFabShape.rounded
      ? BorderRadius.circular(
          widget.buttonSize == ZetaFabSize.small ? Dimensions.x2 : Dimensions.x4,
        )
      : BorderRadius.zero;

  BorderRadius _getBorderRadiusExtended() => widget.buttonShape == ZetaFabShape.circle
      ? BorderRadius.circular(
          widget.buttonSize == ZetaFabSize.small ? Dimensions.x7 : Dimensions.x12,
        )
      : widget.buttonShape == ZetaFabShape.rounded
          ? BorderRadius.circular(Dimensions.x2)
          : BorderRadius.zero;

  TextStyle _getTextStyle() =>
      widget.buttonSize == ZetaFabSize.large ? ZetaText.zetaTitleLarge : ZetaText.zetaTitleMedium;

  double _getButtonSize() => widget.buttonSize == ZetaFabSize.small ? Dimensions.x14 : Dimensions.x24;

  double _getIconSize() => widget.buttonSize == ZetaFabSize.small ? Dimensions.x6 : Dimensions.x9;

  EdgeInsets _getPadding() => !_isExpanded
      ? EdgeInsets.zero
      : widget.buttonShape == ZetaFabShape.circle
          ? const EdgeInsets.only(right: 20, left: 20)
          : const EdgeInsets.only(right: 18, left: 18);
}

///Defines colors for FAB Components
class _FabButtonColors extends ZetaWidgetColor {
  const _FabButtonColors({
    required this.actionColor,
    required super.backgroundColor,
    required super.foregroundColor,
  });

  factory _FabButtonColors.fromButtonType(ZetaFabType buttonType, Zeta theme) {
    switch (buttonType) {
      case ZetaFabType.primary:
        return _FabButtonColors(
          backgroundColor: theme.colors.blue.shade60,
          foregroundColor: theme.colors.white,
          actionColor: theme.colors.blue.shade80,
        );
      case ZetaFabType.primarySecond:
        return _FabButtonColors(
          backgroundColor: theme.colors.yellow.lighten(16),
          foregroundColor: theme.colors.black,
          actionColor: theme.colors.yellow,
        );
      case ZetaFabType.inverse:
        return _FabButtonColors(
          backgroundColor: theme.colors.iconDefault,
          foregroundColor: theme.colors.iconInverse,
          actionColor: theme.colors.iconSubtle,
        );
    }
  }

  final Color actionColor;
}
