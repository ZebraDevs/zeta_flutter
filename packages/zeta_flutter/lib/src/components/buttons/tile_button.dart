import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';
import 'button_style.dart';

/// Only sharp and rounded border types for ZetaTileButton
enum ZetaTileButtonBorderType {
  /// Sharp border
  sharp,

  /// Slightly rounded border.
  rounded
}

/// Zeta Button
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=37677-15824&t=BkdCAAhFjNXxpwfK-4
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/button/zetabutton/tile-button
class ZetaTileButton extends ZetaStatelessWidget {
  ///Constructs [ZetaTileButton]
  const ZetaTileButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
    this.borderType = ZetaTileButtonBorderType.rounded,
    this.focusNode,
    this.semanticLabel,
  });

  /// Button label
  final String label;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// {@macro zeta-widget-change-disable}
  final VoidCallback? onPressed;

  /// Whether or not the button is sharp or rounded
  /// Only allows [ZetaTileButtonBorderType.sharp] or [ZetaTileButtonBorderType.rounded]
  final ZetaTileButtonBorderType? borderType;

  /// Icon of button. Goes on top of button.
  final IconData icon;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label of the button.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If this property is null, [label] will be used instead.
  final String? semanticLabel;

  /// Creates a clone.
  ZetaTileButton copyWith({
    Key? key,
    String? label,
    VoidCallback? onPressed,
    ZetaTileButtonBorderType? borderType,
    IconData? icon,
  }) {
    return ZetaTileButton(
      key: key ?? this.key,
      label: label ?? this.label,
      onPressed: onPressed ?? this.onPressed,
      borderType: borderType ?? this.borderType,
      icon: icon ?? this.icon,
    );
  }

  ZetaWidgetBorder _mapBorderType(ZetaTileButtonBorderType type) {
    switch (type) {
      case ZetaTileButtonBorderType.sharp:
        return ZetaWidgetBorder.sharp;
      case ZetaTileButtonBorderType.rounded:
        return ZetaWidgetBorder.rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: semanticLabel ?? label,
      excludeSemantics: true,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Zeta.of(context).spacing.xl_10,
          maxWidth: Zeta.of(context).spacing.xl_10,
          minHeight: Zeta.of(context).spacing.xl_10,
          minWidth: Zeta.of(context).spacing.xl_10,
        ),
        child: FilledButton(
          focusNode: focusNode,
          onPressed: onPressed,
          style: buttonStyle(
            context,
            _mapBorderType(borderType ?? ZetaTileButtonBorderType.rounded),
            ZetaButtonType.outlineSubtle,
          ),
          child: SelectionContainer.disabled(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: Zeta.of(context).spacing.xl,
                ),
                if (label.isNotEmpty)
                  Flexible(
                    child: Text(
                      label,
                      style: Zeta.of(context).textStyles.labelLarge,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ).paddingTop(Zeta.of(context).spacing.minimum),
                  ),
              ],
            ).paddingHorizontal(Zeta.of(context).spacing.medium).paddingVertical(Zeta.of(context).spacing.large),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(EnumProperty<ZetaTileButtonBorderType>('borderType', borderType))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
