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
    this.label,
    this.scrollController,
    this.onPressed,
    this.type = ZetaFabType.primary,
    this.size = ZetaFabSize.small,
    this.shape = ZetaWidgetBorder.full,
    this.icon = ZetaIcons.add_round,
    this.initiallyExpanded,
    this.focusNode,
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
  ///
  /// {@macro zeta-widget-change-disable}
  final VoidCallback? onPressed;

  /// The [ZetaFAB] uses this controller to react to scroll change and shrink/expand itself.
  ///
  /// If null, the FAB will never change from its initial size.
  final ScrollController? scrollController;

  ///The label of the button.
  ///
  /// If null, the FAB will never grow.
  final String? label;

  /// Icon for the button
  ///
  /// Defaults to [ZetaIcons.add_round].
  final IconData icon;

  /// Whether the FAB starts as expanded.
  ///
  /// If [scrollController] or [label] are null, this is the permanent state of the FAB.
  final bool? initiallyExpanded;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  @override
  State<ZetaFAB> createState() => _ZetaFABState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaFabType>('type', type))
      ..add(EnumProperty<ZetaFabSize>('size', size))
      ..add(EnumProperty<ZetaWidgetBorder>('shape', shape))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(DiagnosticsProperty<ScrollController>('scrollController', scrollController))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(DiagnosticsProperty<bool>('initiallyExpanded', initiallyExpanded))
      ..add(DiagnosticsProperty<FocusNode>('focusNode', focusNode));
  }
}

class _ZetaFABState extends State<ZetaFAB> {
  @override
  Widget build(BuildContext context) {
    final bool isExpanded = (widget.initiallyExpanded != null ? widget.initiallyExpanded! : widget.label != null);
    final colors = widget.type.colors(context);
    final backgroundColor = widget.type == ZetaFabType.inverse ? colors.shade80 : colors.shade60;

    return FilledButton(
      onPressed: widget.onPressed,
      focusNode: widget.focusNode,
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStatePropertyAll(widget.shape.buttonShape(isExpanded: isExpanded, size: widget.size)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return Zeta.of(context).colors.surfaceDisabled;
          if (states.contains(WidgetState.hovered)) return colors.hover;
          if (states.contains(WidgetState.pressed)) return colors.selected;
          return backgroundColor;
        }),
        side: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              // TODO(thelukewalton): This removes a defualt border when focused, rather than adding a second border when focused.
              return BorderSide(color: Zeta.of(context).colors.blue.shade50, width: ZetaSpacingBase.x0_5);
            }
            return null;
          },
        ),
      ),
      child: AnimatedContainer(
        duration: ZetaAnimationLength.normal,
        child: Padding(
          padding: isExpanded
              ? const EdgeInsets.symmetric(horizontal: ZetaSpacingBase.x3_5, vertical: ZetaSpacing.medium)
              : EdgeInsets.all(widget.size.padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: widget.size.iconSize),
              if (isExpanded && widget.label != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(widget.label!, style: ZetaTextStyles.labelLarge)],
                ),
            ].divide(const SizedBox(width: ZetaSpacing.small)).toList(),
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
                    ? ZetaSpacing.xl_3
                    : ZetaSpacing.xl_8
                : ZetaSpacing.small
            : size == ZetaFabSize.small
                ? ZetaSpacing.small
                : ZetaSpacing.large,
      ),
    );
  }
}

extension on ZetaFabSize {
  double get iconSize => this == ZetaFabSize.small ? ZetaSpacing.xl_2 : ZetaSpacing.xl_5;
  double get padding => this == ZetaFabSize.small ? ZetaSpacing.large : ZetaSpacingBase.x7_5;
}
