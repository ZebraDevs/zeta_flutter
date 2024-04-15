import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// A single row that typically contains some text as well as a leading or trailing widgets.
class ZetaListItem extends StatelessWidget {
  /// Creates a [ZetaListItem].
  const ZetaListItem({
    required this.title,
    this.dense = false,
    this.enabled = true,
    this.enabledDivider = true,
    this.leading,
    this.onTap,
    this.selected = false,
    this.subtitle,
    this.trailing,
    super.key,
  });

  /// Dense list items have less space between widgets and use smaller [TextStyle]
  final bool dense;

  /// Whether this [ZetaListItem] is interactive.
  /// If false the [onTap] callback is inoperative.
  final bool enabled;

  /// Whether to apply divider. Normally at the bottom of the [ZetaListItem].
  final bool enabledDivider;

  /// A Widget to display before the title;
  final Widget? leading;

  /// Called when user taps on the [ZetaListItem].
  final VoidCallback? onTap;

  /// Applies selected styles. If selected is true trailing mu
  final bool selected;

  /// Additional content displayed over the title.
  /// Typically a [Text] widget.
  final Widget? subtitle;

  /// The primary content of the [ZetaListItem].
  final Widget title;

  /// A widget to display after the title.
  final Widget? trailing;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('dense', dense))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DiagnosticsProperty<bool>('enabledDivider', enabledDivider))
      ..add(DiagnosticsProperty<Widget>('leading', leading))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(DiagnosticsProperty<Widget>('subtitle', subtitle))
      ..add(DiagnosticsProperty<Widget>('title', title))
      ..add(DiagnosticsProperty<Widget>('trailing', trailing));
  }

  TextStyle get _titleTextStyle => dense ? ZetaTextStyles.titleSmall : ZetaTextStyles.titleMedium;

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    return _ListItemContainer(
      enabled: enabled,
      selected: selected,
      onTap: onTap,
      dense: dense,
      enabledDivider: enabledDivider,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                if (leading != null)
                  Padding(
                    padding: EdgeInsets.only(
                      right: dense ? ZetaSpacing.x2 : ZetaSpacing.x4,
                    ),
                    child: leading,
                  ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dense ? 0.0 : ZetaSpacing.x4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (subtitle != null)
                          DefaultTextStyle(
                            style: ZetaTextStyles.titleSmall.copyWith(
                              color: enabled ? zetaColors.textSubtle : zetaColors.textDisabled,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            child: subtitle ?? const SizedBox(),
                          ),
                        DefaultTextStyle(
                          style: _titleTextStyle.copyWith(
<<<<<<< HEAD
                            color: enabled ? zetaColors.textDefault : zetaColors.textSubtle,
=======
                            color: enabled ? zetaColors.textDefault : zetaColors.textDisabled,
>>>>>>> 7a5dabb51a06204f87ee266b98c981600fed89a9
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          child: title,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null)
            Padding(
              padding: EdgeInsets.only(
                left: dense ? ZetaSpacing.x2 : ZetaSpacing.x4,
              ),
              child: trailing,
            ),
          if (trailing == null && selected && enabled)
            Padding(
              padding: EdgeInsets.only(
                left: dense ? ZetaSpacing.x2 : ZetaSpacing.x4,
              ),
              child: Icon(
                ZetaIcons.check_mark_round,
                color: zetaColors.blue.shade60,
              ),
            ),
        ],
      ),
    );
  }
}

class _ListItemContainer extends StatelessWidget {
  const _ListItemContainer({
    required this.child,
    required this.dense,
    required this.enabled,
    required this.enabledDivider,
    required this.onTap,
    required this.selected,
  });

  final Widget child;
  final bool dense;
  final bool enabled;
  final bool enabledDivider;
  final VoidCallback? onTap;
  final bool selected;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget>('child', child))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('dense', dense))
      ..add(DiagnosticsProperty<bool>('enabledDivider', enabledDivider));
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    return AbsorbPointer(
      absorbing: !enabled,
      child: Material(
        color: enabled
            ? selected
                ? zetaColors.blue.shade10
                : zetaColors.white
            : zetaColors.surfaceDisabled,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: dense ? ZetaSpacing.x4 : ZetaSpacing.x8,
              vertical: dense ? ZetaSpacing.x2 : ZetaSpacing.x4,
            ),
            decoration: BoxDecoration(
              border: enabled && enabledDivider
                  ? Border(
                      bottom: BorderSide(
                        color: selected ? zetaColors.blue.shade40 : zetaColors.borderDefault,
                      ),
                    )
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
