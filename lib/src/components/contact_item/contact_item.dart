import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// A single row that contains avatar, title and subtitle.
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24828-46282&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/list-items/contact-item
class ZetaContactItem extends ZetaStatelessWidget {
  /// Constructs [ZetaContactItem].
  const ZetaContactItem({
    super.key,
    super.rounded,
    required this.title,
    required this.leading,
    required this.subtitle,
    this.enabledDivider = true,
    this.onTap,
    this.explicitChildNodes = true,
  });

  /// The main text to be displayed on the top.
  final Widget title;

  /// Normally a [ZetaAvatar].
  final Widget leading;

  /// Text to be displayed under [title].
  final Widget subtitle;

  /// Callback to be called onTap.
  final VoidCallback? onTap;

  /// Whether to display a divider at the bottom.
  final bool enabledDivider;

  /// Whether to use explicit child nodes for [Semantics].
  final bool explicitChildNodes;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Semantics(
        button: true,
        child: SelectionContainer.disabled(
          child: Material(
            color: colors.surfaceDefault,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: enabledDivider ? Border(bottom: BorderSide(color: colors.borderDisabled)) : null,
              ),
              child: InkWell(
                onTap: onTap,
                child: Semantics(
                  explicitChildNodes: explicitChildNodes,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Zeta.of(context).spacing.small,
                      bottom: Zeta.of(context).spacing.small,
                      left: Zeta.of(context).spacing.xl_2,
                    ),
                    child: Row(
                      children: [
                        leading,
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: Zeta.of(context).spacing.medium),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultTextStyle(
                                  style: ZetaTextStyles.bodyMedium.copyWith(
                                    color: colors.mainDefault,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  child: title,
                                ),
                                DefaultTextStyle(
                                  style: ZetaTextStyles.bodySmall.copyWith(
                                    color: colors.mainSubtle,
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
      ..add(DiagnosticsProperty<bool>('enabledDivider', enabledDivider))
      ..add(DiagnosticsProperty<bool>('explicitChildNodes', explicitChildNodes));
  }
}
