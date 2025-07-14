// Documentation not needed for internal components
// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Shared accordion item UI component to eliminate code duplication
class AccordionItemUI extends StatelessWidget {
  const AccordionItemUI({
    required this.item,
    required this.isExpanded,
    required this.isSelected,
    required this.expandSemanticLabel,
    required this.collapseSemanticLabel,
    this.wholeTileTap,
    this.leftTap,
    this.rightTap,
    super.key,
  });

  final ZetaAccordionItem item;
  final bool isExpanded;
  final bool isSelected;
  final VoidCallback? wholeTileTap;
  final VoidCallback? leftTap;
  final VoidCallback? rightTap;
  final String expandSemanticLabel;
  final String collapseSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            // onTapHint: isExpanded ? collapseSemanticLabel : expandSemanticLabel,
            child: InkWell(
              hoverColor: zeta.colors.surfaceHover,
              onTap: wholeTileTap,
              child: IconTheme(
                data: IconThemeData(color: zeta.colors.mainDefault),
                child: Row(
                  children: [
                    // Leading icon (expansion chevron for selectable items with child)
                    if (item.isSelectable && item.child != null)
                      Semantics(
                        label: isExpanded ? collapseSemanticLabel : expandSemanticLabel,
                        child: InkWell(
                          onTap: leftTap,
                          borderRadius: (item.rounded ?? zeta.rounded) ? BorderRadius.all(zeta.radius.rounded) : null,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              zeta.spacing.large,
                              zeta.spacing.medium,
                              zeta.spacing.small,
                              zeta.spacing.medium,
                            ),
                            child: AnimatedRotation(
                              turns: isExpanded ? 0.25 : 0.0,
                              duration: ZetaAnimationLength.normal,
                              child: const Icon(ZetaIcons.chevron_right),
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(width: zeta.spacing.large),

                    // Title section
                    Expanded(
                      child: InkWell(
                        onTap: rightTap,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: zeta.spacing.large),
                                child: Text(item.title, style: zeta.textStyles.h4),
                              ),
                            ),
                            // Trailing icon
                            if (item.isNavigation)
                              const Icon(ZetaIcons.chevron_right)
                            else if (item.isSelectable)
                              Icon(
                                isSelected ? ZetaIcons.check_mark : null,
                                color: zeta.colors.mainPrimary,
                              )
                            else if (item.child != null)
                              AnimatedRotation(
                                turns: isExpanded ? 0.5 : 0.0,
                                duration: ZetaAnimationLength.normal,
                                child: const Icon(ZetaIcons.expand_more),
                              ),
                            SizedBox(width: zeta.spacing.large),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (item.header != null)
            Padding(
              padding: EdgeInsets.fromLTRB(
                zeta.spacing.large,
                zeta.spacing.none,
                zeta.spacing.large,
                zeta.spacing.large,
              ),
              child: item.header,
            ),
          // Expandable content
          if (item.child != null)
            AnimatedSize(
              duration: ZetaAnimationLength.normal,
              curve: Curves.easeInOut,
              child: ClipRect(
                child: AnimatedAlign(
                  alignment: Alignment.topCenter,
                  heightFactor: isExpanded ? 1.0 : 0.0,
                  duration: ZetaAnimationLength.normal,
                  curve: Curves.easeInOut,
                  child: Container(
                    padding: EdgeInsets.all(zeta.spacing.large),
                    child: item.child,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isExpanded', isExpanded))
      ..add(DiagnosticsProperty<bool>('isSelected', isSelected))
      ..add(ObjectFlagProperty<VoidCallback?>.has('wholeTileTap', wholeTileTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('leftTap', leftTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('rightTap', rightTap))
      ..add(StringProperty('expandSemanticLabel', expandSemanticLabel))
      ..add(StringProperty('collapseSemanticLabel', collapseSemanticLabel));
  }
}
