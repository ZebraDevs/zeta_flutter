import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// A Zeta Design primary tab bar.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-18&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/tabs/zetatabbar/tab-bar
class ZetaTabBar extends TabBar {
  /// Creates a Zeta Design primary tab bar.
  ZetaTabBar({
    required BuildContext context,
    required List<ZetaTab> super.tabs,
    TabAlignment super.tabAlignment = TabAlignment.center,
    super.isScrollable,
    super.enableFeedback,
    super.dragStartBehavior,
    super.padding,
    super.onTap,
    super.key,
  }) : super(
          indicatorSize: isScrollable ? TabBarIndicatorSize.label : TabBarIndicatorSize.tab,
          labelPadding: isScrollable ? null : EdgeInsets.zero,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Zeta.of(context).colors.mainPrimary,
              width: onTap != null ? Zeta.of(context).spacing.minimum : Zeta.of(context).spacing.none,
            ),
            borderRadius: BorderRadius.all(Zeta.of(context).radius.none),
          ),
          splashFactory: null,
          labelStyle: Zeta.of(context).textStyles.labelLarge.copyWith(
                color: onTap != null ? Zeta.of(context).colors.mainDefault : Zeta.of(context).colors.mainDisabled,
              ),
          unselectedLabelStyle: Zeta.of(context).textStyles.labelLarge.copyWith(
                color: onTap != null ? Zeta.of(context).colors.mainSubtle : Zeta.of(context).colors.mainDisabled,
              ),
          overlayColor: onTap == null ? WidgetStateProperty.all(Colors.transparent) : null,
          mouseCursor: onTap == null ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
          dividerColor: Colors.transparent,
        );
}
