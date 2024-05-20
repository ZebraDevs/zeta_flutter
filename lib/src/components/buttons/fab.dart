import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';

/// Color type for [ZetaFAB].
enum ZetaFabType {
  /// Primary color scheme. Defaults to blue.
  primary,

  /// Secondary color scheme. Defaults to yellow.
  secondary,

  /// Inverse color scheme. Defaults to dark grey.
  inverse
}

///Defines the size of the floating action button
enum ZetaFabSize {
  /// [small] 56 pixels
  small,

  /// [large] 96 pixels
  large,
}

///Zeta Floating Action Button Component.
class ZetaFAB extends StatefulWidget {
  ///Constructs [ZetaFAB].
  const ZetaFAB({
    required this.scrollController,
    required this.label,
    this.type = ZetaFabType.primary,
    this.size = ZetaFabSize.small,
    this.shape = ZetaWidgetBorder.full,
    this.icon = ZetaIcons.add_round,
    this.onPressed,
    super.key,
  });

  /// Defines the color of the button.
  ///
  /// Defaults to [ZetaFabType.primary]
  final ZetaFabType type;

  /// The Size of the button.
  ///
  /// Defaults to [ZetaFabSize.small].
  final ZetaFabSize size;

  /// The shape for the button.
  ///
  /// Defaults to [ZetaWidgetBorder.full].
  final ZetaWidgetBorder shape;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The [ZetaFAB] uses this controller to react to scroll change
  /// and shrink/expand itself
  final ScrollController scrollController;

  ///The label of the button
  final String label;

  /// Icon for the button
  ///
  /// Defaults to [ZetaIcons.add_round].
  final IconData icon;

  @override
  State<ZetaFAB> createState() => _ZetaFABState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaFabType>('buttonType', type))
      ..add(EnumProperty<ZetaFabSize>('buttonSize', size))
      ..add(EnumProperty<ZetaWidgetBorder>('buttonShape', shape))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(
        DiagnosticsProperty<ScrollController>(
          'scrollController',
          scrollController,
        ),
      )
      ..add(StringProperty('buttonLabel', label))
      ..add(DiagnosticsProperty<IconData>('buttonIcon', icon));
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
    final colors = widget.type.colors(context);
    final backgroundColor = widget.type == ZetaFabType.inverse ? colors.shade80 : colors.shade60;

    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: widget.shape.buttonShape(isExpanded: _isExpanded, size: widget.size),
        backgroundColor: backgroundColor,
        foregroundColor: backgroundColor.onColor,
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) return colors.hover;
          if (states.contains(WidgetState.pressed)) return colors.selected;
          return null;
        }),
        side: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              // TODO(thelukewalton): This removes a defualt border when focused, rather than adding a second border when focused.
              return BorderSide(color: Zeta.of(context).colors.blue.shade50, width: ZetaSpacing.x0_5);
            }
            return null;
          },
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: _isExpanded
              ? const EdgeInsets.symmetric(horizontal: ZetaSpacing.x3_5, vertical: ZetaSpacing.x3)
              : EdgeInsets.all(widget.size.padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: widget.size.iconSize),
              if (_isExpanded)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.label, style: ZetaTextStyles.labelLarge),
                  ],
                ),
            ].divide(const SizedBox(width: ZetaSpacing.x2)).toList(),
          ),
        ),
      ),
    );
  }
}

extension on ZetaFabType {
  ZetaColorSwatch colors(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    switch (this) {
      case ZetaFabType.primary:
        return zetaColors.primary;
      case ZetaFabType.secondary:
        return zetaColors.secondary;
      case ZetaFabType.inverse:
        return zetaColors.cool;
    }
  }
}

extension on ZetaWidgetBorder {
  OutlinedBorder buttonShape({required bool isExpanded, required ZetaFabSize size}) {
    if (this == ZetaWidgetBorder.full && !isExpanded) {
      return const CircleBorder();
    }
    if (this == ZetaWidgetBorder.sharp) {
      return const RoundedRectangleBorder();
    }
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        isExpanded
            ? this == ZetaWidgetBorder.full
                ? size == ZetaFabSize.small
                    ? ZetaSpacing.x7
                    : ZetaSpacing.x12
                : ZetaSpacing.x2
            : size == ZetaFabSize.small
                ? ZetaSpacing.x2
                : ZetaSpacing.x4,
      ),
    );
  }
}

extension on ZetaFabSize {
  double get iconSize => this == ZetaFabSize.small ? ZetaSpacing.x6 : ZetaSpacing.x9;
  double get padding => this == ZetaFabSize.small ? ZetaSpacing.x4 : ZetaSpacing.x7_5;
}
