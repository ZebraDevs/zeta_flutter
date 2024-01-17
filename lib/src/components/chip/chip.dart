import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// The type of [ZetaChip]
enum ZetaChipType {
  /// Input Chip
  input,

  /// Filter Chip
  filter,

  /// Assist Chip
  assist,

  /// Status Chip
  status,
}

/// Component [ZetaChip]
class ZetaChip extends StatelessWidget {
  /// Constructor for the component [ZetaChip]
  const ZetaChip({
    super.key,
    required this.type,
    required this.label,
    this.leading,
    this.onDelete,
    this.selected = false,
    this.rounded = true,
  });

  /// Factory constructor for [ZetaChip] of type `input`
  factory ZetaChip.input({
    required String label,
    Widget? leading,
    VoidCallback? onDelete,
    bool rounded = true,
  }) {
    return ZetaChip(
      type: ZetaChipType.input,
      label: label,
      leading: leading,
      onDelete: onDelete,
      rounded: rounded,
    );
  }

  /// Factory constructor for [ZetaChip] of type `input`
  factory ZetaChip.assist({
    required String label,
    bool showIcon = false,
    Widget? icon,
    bool rounded = true,
  }) {
    final Widget? chipIcon = showIcon ? (icon ?? Icon(rounded ? ZetaIcons.star_round : ZetaIcons.star_sharp)) : null;
    return ZetaChip(
      type: ZetaChipType.assist,
      label: label,
      leading: chipIcon,
      rounded: rounded,
    );
  }

  /// Factory constructor for [ZetaChip] of type `status`
  factory ZetaChip.status(String label) {
    return ZetaChip(
      type: ZetaChipType.status,
      label: label,
    );
  }

  /// The type of [ZetaChip]
  final ZetaChipType type;

  /// The label on the [ZetaChip]
  final String label;

  /// The leading icon
  final Widget? leading;

  /// The delete action
  final VoidCallback? onDelete;

  /// Initial status for the `filter` chiup
  final bool selected;

  /// Sets rounded or sharp border.
  /// Default is `true`.
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final avatarSize = type == ZetaChipType.input ? 24.0 : 20.0;
    final bgColor = type == ZetaChipType.status
        ? colors.warm.shade30
        : selected
            ? colors.textDefault
            : colors.surfacePrimary;

    return Chip(
      backgroundColor: bgColor,
      label: Text(label, textAlign: TextAlign.center),
      labelStyle: type == ZetaChipType.status
          ? ZetaTextStyles.bodySmall // TODO(thelukewalton): this doesnt match styles on figma. Awaiting design refresh.
          : ZetaTextStyles.bodyMedium.apply(color: selected ? colors.textInverse : colors.textDefault),
      labelPadding: type == ZetaChipType.status
          ? const EdgeInsets.symmetric(horizontal: 10)
          : EdgeInsets.fromLTRB(
              leading == null ? 14 : 2.5,
              2,
              onDelete == null ? 14 : 2.5,
              2,
            ),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      side: BorderSide(color: type == ZetaChipType.status ? bgColor : colors.borderDefault),
      shape: RoundedRectangleBorder(
        borderRadius: rounded ? BorderRadius.circular(type == ZetaChipType.status ? 6 : 100) : BorderRadius.zero,
      ),
      clipBehavior: Clip.hardEdge,
      avatar: leading == null
          ? null
          : Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                clipBehavior: Clip.hardEdge,
                child: IconTheme(
                  data: IconThemeData(
                    color: _getAvatarColor(type, colors),
                    size: avatarSize,
                  ),
                  child: leading!,
                ),
              ),
            ),
      deleteIcon: onDelete == null
          ? null
          : Icon(
              Icons.close,
              size: 18,
              color: colors.iconDefault,
            ),
      onDeleted: onDelete,
    );
  }

  static Color _getAvatarColor(ZetaChipType type, ZetaColors colors) {
    switch (type) {
      case ZetaChipType.input:
        return colors.cool;
      case ZetaChipType.filter:
        return colors.iconInverse;
      case ZetaChipType.assist:
        return colors.iconDefault;
      case ZetaChipType.status:
        return colors.iconDefault;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaChipType>('type', type))
      ..add(DiagnosticsProperty<String>('label', label))
      ..add(DiagnosticsProperty<VoidCallback?>('onDelete', onDelete))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('selected', selected));
  }
}

/// Component [ZetaFilterChip]
class ZetaFilterChip extends StatefulWidget {
  /// Constructor for [ZetaFilterChip]
  const ZetaFilterChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onChange,
    this.rounded = true,
  });

  /// The label on the [ZetaFilterChip]
  final String label;

  /// Initial status
  final bool selected;

  /// On change
  final void Function({bool value})? onChange;

  /// Sets rounded or sharp border.
  /// Default is `true`.
  final bool rounded;

  @override
  State<ZetaFilterChip> createState() => _ZetaFilterChipState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<String>('label', label))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(DiagnosticsProperty<Function>('onChange', onChange));
  }
}

class _ZetaFilterChipState extends State<ZetaFilterChip> {
  late bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
        widget.onChange?.call(value: _selected);
      },
      child: _selected
          ? ZetaChip(
              type: ZetaChipType.filter,
              label: widget.label,
              leading: const Icon(Icons.check),
              selected: _selected,
              rounded: widget.rounded,
            )
          : ZetaChip(
              type: ZetaChipType.filter,
              label: widget.label,
              rounded: widget.rounded,
            ),
    );
  }
}
