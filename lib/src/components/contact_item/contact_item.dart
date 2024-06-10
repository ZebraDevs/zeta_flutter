import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// A single row that contains avatar, title and subtitle.
class ZetaContactItem extends StatelessWidget {
  /// Constructs [ZetaContactItem].
  const ZetaContactItem({
    required this.title,
    required this.leading,
    required this.subtitle,
    this.enabledDivider = true,
    this.onTap,
    super.key,
  });

  /// The main text to be displayed on the top.
  final Widget title;

  /// Normally an Avatar
  final Widget leading;

  /// Text to be displayed under [title].
  final Widget subtitle;

  /// Callback to be called onTap.
  final VoidCallback? onTap;

  /// Whether to display a divider at the bottom.
  final bool enabledDivider;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        border: enabledDivider
            ? Border(
                bottom: BorderSide(color: colors.borderDisabled),
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(
              top: ZetaSpacing.small,
              bottom: ZetaSpacing.small,
              left: ZetaSpacing.xl_2,
            ),
            child: Row(
              children: [
                leading,
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: ZetaSpacing.medium),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: ZetaTextStyles.bodyMedium.copyWith(
                            color: colors.textDefault,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          child: title,
                        ),
                        DefaultTextStyle(
                          style: ZetaTextStyles.bodySmall.copyWith(
                            color: colors.textSubtle,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          child: subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('enabledDivider', enabledDivider));
  }
}
