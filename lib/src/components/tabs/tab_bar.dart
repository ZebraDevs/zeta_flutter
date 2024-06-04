import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// A Zeta Design primary tab bar.
class ZetaTabBar extends TabBar {
  /// Creates a Zeta Design primary tab bar.
  ZetaTabBar({
    required BuildContext context,
    required List<ZetaTab> super.tabs,
    TabAlignment super.tabAlignment = TabAlignment.center,
    @Deprecated('Enabled is deprecated. To disable the tab bar, set onTap to null') bool enabled = true,
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
              color: Zeta.of(context).colors.primary,
              width: onTap != null ? 4 : 0,
            ),
            borderRadius: ZetaRadius.none,
          ),
          splashFactory: null,
          labelStyle: ZetaTextStyles.labelLarge.copyWith(
            color: onTap != null ? Zeta.of(context).colors.textDefault : Zeta.of(context).colors.textDisabled,
          ),
          unselectedLabelStyle: ZetaTextStyles.labelLarge.copyWith(
            color: onTap != null ? Zeta.of(context).colors.textSubtle : Zeta.of(context).colors.textDisabled,
          ),
        );
}
