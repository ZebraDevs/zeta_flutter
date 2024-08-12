import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// A Zeta Design primary tab bar.
/// {@category Components}
class ZetaTabBar extends TabBar {
  /// Creates a Zeta Design primary tab bar.
  ZetaTabBar({
    required BuildContext context,
    required List<ZetaTab> super.tabs,
    TabAlignment super.tabAlignment = TabAlignment.center,
    @Deprecated('Use disabled instead. ' 'enabled is deprecated as of 0.11.0') bool enabled = true,
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
              color: Zeta.of(context).colors.main.primary,
              width: onTap != null ? Zeta.of(context).spacing.minimum : Zeta.of(context).spacing.none,
            ),
            borderRadius: Zeta.of(context).radii.none,
          ),
          splashFactory: null,
          labelStyle: ZetaTextStyles.labelLarge.copyWith(
            color: onTap != null ? Zeta.of(context).colors.main.defaultColor : Zeta.of(context).colors.main.disabled,
          ),
          unselectedLabelStyle: ZetaTextStyles.labelLarge.copyWith(
            color: onTap != null ? Zeta.of(context).colors.main.subtle : Zeta.of(context).colors.main.disabled,
          ),
        );
}
