import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

export './assist_chip.dart';
export './filter_chip.dart';
export './input_chip.dart';

/// The type of [ZetaChip]
enum ZetaChipType {
  /// Input Chip
  input,

  /// Filter Chip
  filter,

  /// Assist Chip
  assist,
}

/// Zeta Chip component.
///
/// This covers the board functionality of [ZetaAssistChip], [ZetaFilterChip] and [ZetaInputChip].
class ZetaChip extends StatefulWidget {
  /// Constructs a [ZetaChip].
  const ZetaChip({
    super.key,
    required this.label,
    required this.type,
    this.leading,
    this.rounded = true,
    this.trailing,
    this.selected,
    this.onTap,
  });

  /// Type of [Chip].
  final ZetaChipType type;

  /// The label on the [ZetaChip]
  final String label;

  /// Leading component. Typically an [Icon].
  final Widget? leading;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Trailing component. Typically an [Icon].
  final Widget? trailing;

  /// Whether the [ZetaFilterChip] is selected.
  final bool? selected;

  /// Callback when chip is tapped.
  final ValueSetter<bool>? onTap;

  @override
  State<ZetaChip> createState() => _ZetaChipState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaChipType>('type', type))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool?>('selected', selected))
      ..add(ObjectFlagProperty<ValueSetter<bool>?>.has('onTap', onTap));
  }
}

class _ZetaChipState extends State<ZetaChip> {
  bool selected = false;

  Widget? get leading =>
      widget.leading ??
      (selected ? Icon(widget.rounded ? ZetaIcons.check_mark_round : ZetaIcons.check_mark_sharp) : null);

  @override
  void initState() {
    super.initState();
    selected = widget.selected ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final foregroundColor = selected ? colors.textInverse : colors.textDefault;
    return FilledButton(
      onPressed: () {
        if (widget.type == ZetaChipType.filter) {
          setState(() => selected = !selected);
          widget.onTap?.call(selected);
        }
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: widget.rounded ? ZetaRadius.full : ZetaRadius.none),
        ),
        textStyle: WidgetStateProperty.all(ZetaTextStyles.bodySmall),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colors.surfaceDisabled;
          }
          if (selected) {
            return colors.cool.shade90;
          }
          if (states.contains(WidgetState.pressed) || states.contains(WidgetState.dragged)) {
            return colors.surfaceSelected;
          }

          if (states.contains(WidgetState.hovered)) {
            return colors.surfaceHover;
          }

          return colors.surfacePrimary;
        }),
        foregroundColor: WidgetStateProperty.all(foregroundColor),
        mouseCursor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return SystemMouseCursors.forbidden;
          }
          if (states.contains(WidgetState.dragged)) {
            return SystemMouseCursors.grabbing;
          }
          return SystemMouseCursors.click;
        }),
        elevation: WidgetStateProperty.all(0),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(width: ZetaSpacing.x0_5, color: colors.blue.shade50);
          }
          return BorderSide(color: colors.borderDefault);
        }),
        padding: WidgetStateProperty.all(
          EdgeInsets.fromLTRB(
            widget.leading != null ? ZetaSpacing.x2_5 : ZetaSpacing.x3,
            0,
            widget.trailing != null ? ZetaSpacing.x2_5 : ZetaSpacing.x3,
            0,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null)
            IconTheme(
              data: IconThemeData(
                color: foregroundColor,
                size: ZetaSpacing.x5,
              ),
              child: leading!,
            ),
          Text(widget.label),
          if (widget.trailing != null)
            IconTheme(
              data: IconThemeData(
                color: foregroundColor,
                size: ZetaSpacing.x5,
              ),
              child: widget.trailing!,
            ),
        ].divide(const SizedBox.square(dimension: ZetaSpacing.x2)).toList(),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', widget.rounded))
      ..add(StringProperty('label', widget.label))
      ..add(EnumProperty<ZetaChipType>('type', widget.type))
      ..add(DiagnosticsProperty<bool?>('selected', widget.selected));
  }
}
