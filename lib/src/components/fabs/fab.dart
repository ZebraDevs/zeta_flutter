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
  inverse;

  Color _backgroundColor(ZetaColors colors) {
    switch (this) {
      case ZetaFabType.primary:
        return colors.statePrimaryEnabled;
      case ZetaFabType.secondary:
        return colors.stateSecondaryEnabled;
      case ZetaFabType.inverse:
        return colors.stateInverseEnabled;
    }
  }

  Color _foregroundColor(ZetaColors colors) {
    switch (this) {
      case ZetaFabType.secondary:
        return colors.mainDefault;
      case ZetaFabType.primary:
      case ZetaFabType.inverse:
        return colors.mainInverse;
    }
  }

  Color _hoverColor(ZetaColors colors) {
    switch (this) {
      case ZetaFabType.primary:
        return colors.statePrimaryHover;
      case ZetaFabType.secondary:
        return colors.stateSecondaryHover;
      case ZetaFabType.inverse:
        return colors.stateInverseHover;
    }
  }

  Color _selectedColor(ZetaColors colors) {
    switch (this) {
      case ZetaFabType.primary:
        return colors.statePrimarySelected;
      case ZetaFabType.secondary:
        return colors.stateSecondarySelected;
      case ZetaFabType.inverse:
        return colors.stateInverseSelected;
    }
  }

  Color _iconColors(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    switch (this) {
      case ZetaFabType.primary:
      case ZetaFabType.inverse:
        return zetaColors.mainInverse;
      case ZetaFabType.secondary:
        return zetaColors.mainDefault;
    }
  }
}

///Defines the size of the floating action button
enum ZetaFabSize {
  /// [small] 56 pixels
  small,

  /// [large] 96 pixels
  large;

  /// Size of icon based on Fab size
  double iconSize(BuildContext context) => {
        ZetaFabSize.small: Zeta.of(context).spacing.xl_2,
        ZetaFabSize.large: Zeta.of(context).spacing.xl_5,
      }[this]!;

  /// Padding based on Fab size
  double padding(BuildContext context) => {
        ZetaFabSize.small: Zeta.of(context).spacing.large,
        ZetaFabSize.large: Zeta.of(context).spacing.minimum * 7.5, // TODO(UX-1202): ZetaSpacingBase
      }[this]!;
}

/// Zeta Floating Action Button Component.
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21816-4283&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/buttons/floating-action-button
class ZetaFAB extends StatefulWidget {
  ///Constructs [ZetaFAB].
  const ZetaFAB({
    this.label,
    this.scrollController,
    this.onPressed,
    this.type = ZetaFabType.primary,
    this.size = ZetaFabSize.small,
    this.shape = ZetaWidgetBorder.full,
    this.icon = ZetaIcons.add,
    bool? expanded,
    @Deprecated('Please use expanded instead. ' 'Deprecated in 0.15.0') bool? initiallyExpanded,
    this.focusNode,
    super.key,
  }) : expanded = expanded ?? initiallyExpanded ?? label != null;

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
  /// Defaults to [ZetaIcons.add].
  final IconData icon;

  /// Whether the FAB starts as expanded.
  ///
  /// If [scrollController] or [label] are null, this is the permanent state of the FAB.
  ///
  /// If the [label] is not null, the FAB will initialize as expanded.
  final bool expanded;

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
      ..add(DiagnosticsProperty<bool>('initiallyExpanded', expanded))
      ..add(DiagnosticsProperty<FocusNode>('focusNode', focusNode));
  }
}

class _ZetaFABState extends State<ZetaFAB> {
  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final Color backgroundColor = widget.type._backgroundColor(colors);
    final Color foregroundColor = widget.type._foregroundColor(colors);
    final Color backgroundColorHover = widget.type._hoverColor(colors);
    final Color backgroundColorSelected = widget.type._selectedColor(colors);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          onPressed: widget.onPressed,
          focusNode: widget.focusNode,
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStatePropertyAll(
              widget.shape.buttonShape(isExpanded: widget.expanded, size: widget.size, context: context),
            ),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return colors.stateDisabledDisabled;
              }
              if (states.contains(WidgetState.pressed)) {
                return backgroundColorSelected;
              }
              if (states.contains(WidgetState.hovered)) {
                return backgroundColorHover;
              }
              return backgroundColor;
            }),
            side: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.focused)) {
                  // TODO(UX-1134): This removes a defualt border when focused, rather than adding a second border when focused.
                  return BorderSide(color: Zeta.of(context).colors.borderPrimary, width: ZetaBorders.medium);
                }
                return null;
              },
            ),
          ),
          child: AnimatedContainer(
            duration: ZetaAnimationLength.normal,
            child: Padding(
              padding: widget.expanded
                  ? EdgeInsets.symmetric(
                      horizontal: Zeta.of(context).spacing.large,
                      vertical: Zeta.of(context).spacing.medium,
                    )
                  : EdgeInsets.all(widget.size.padding(context)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ZetaIcon(
                    widget.icon,
                    size: widget.size.iconSize(context),
                    color: widget.onPressed != null
                        ? widget.type._iconColors(context)
                        : Zeta.of(context).colors.mainDisabled,
                  ),
                  if (widget.expanded && widget.label != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.label!,
                          style: ZetaTextStyles.labelLarge.apply(color: foregroundColor),
                        ),
                      ],
                    ),
                ].divide(SizedBox(width: Zeta.of(context).spacing.small)).toList(),
              ),
            ),
          ),
        ),
        if (!widget.expanded && widget.label != null)
          Container(
            margin: EdgeInsets.only(top: Zeta.of(context).spacing.minimum),
            width: 100, // TODODE: Is there a better way to do this?
            alignment: Alignment.center,
            child: Text(
              widget.label!,
              style: ZetaTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

extension on ZetaWidgetBorder {
  OutlinedBorder buttonShape({required bool isExpanded, required ZetaFabSize size, required BuildContext context}) {
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
                    ? Zeta.of(context).spacing.xl_3
                    : Zeta.of(context).spacing.xl_8
                : Zeta.of(context).spacing.small
            : size == ZetaFabSize.small
                ? Zeta.of(context).spacing.small
                : Zeta.of(context).spacing.large,
      ),
    );
  }
}
