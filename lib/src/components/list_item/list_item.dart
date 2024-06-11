import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// A single row that typically contains some text as well as a leading or trailing widgets.
class ZetaListItem<T> extends StatelessWidget {
  /// Creates a [ZetaListItem].
  const ZetaListItem({
    required this.primaryText,
    this.secondaryText,
    this.leading,
    this.onTap,
    this.trailing,
    this.value,
    super.key,
  });

  ZetaListItem.toggle({
    super.key,
    required this.primaryText,
    this.secondaryText,
    this.leading,
    this.value,
    ValueChanged<bool?>? onChanged,
  })  : trailing = ZetaSwitch(
          value: value as bool,
          onChanged: onChanged,
          variant: ZetaSwitchType.android,
        ),
        onTap = (() => onChanged?.call(!value));

  ZetaListItem.checkbox({
    super.key,
    required this.primaryText,
    this.secondaryText,
    this.leading,
    this.value,
    bool rounded = true,
    ValueChanged<bool>? onChanged,
    bool useIndeterminate = false,
  })  : trailing = ZetaCheckbox(
          value: value as bool,
          onChanged: onChanged,
          useIndeterminate: useIndeterminate,
          rounded: rounded,
        ),
        onTap = (() => onChanged?.call(!value));

  ZetaListItem.radio({
    super.key,
    required this.primaryText,
    required T this.value,
    this.secondaryText,
    this.leading,
    T? groupValue,
    ValueChanged<T?>? onChanged,
  })  : trailing = ZetaRadio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        onTap = (() => onChanged?.call(value));

  /// A Widget to display before the title;
  final Widget? leading;

  final T? value;

  /// Called when user taps on the [ZetaListItem].
  final VoidCallback? onTap;

  /// The primary text of the [ZetaListItem].
  final String primaryText;

  /// The primary text of the [ZetaListItem].
  final String? secondaryText;

  /// A widget to display after the title.
  final Widget? trailing;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget>('leading', leading))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<Widget>('trailing', trailing))
      ..add(StringProperty('label', primaryText));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Zeta.of(context).colors.surfaceDefault,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ZetaSpacing.large,
            vertical: secondaryText != null ? ZetaSpacing.medium : ZetaSpacing.xl_1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    if (leading != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          right: ZetaSpacing.small,
                        ),
                        child: leading,
                      ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            primaryText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (secondaryText != null)
                            Text(
                              secondaryText!,
                              style: ZetaTextStyles.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: ZetaSpacing.large,
                  ),
                  child: trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
