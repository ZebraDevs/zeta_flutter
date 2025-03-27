import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/utils/rounded_switch.dart';
import 'package:zeta_example/utils/theme_color_switch.dart';
import 'package:zeta_example/utils/theme_constrast_switch.dart';
import 'package:zeta_example/utils/theme_mode_switch.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

const double embeddedViewHeight = 360;

class ExampleScaffold extends StatelessWidget {
  final String name;
  final List<Widget>? children;
  final List<Widget> actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? child;
  final double paddingAll;
  final double gap;

  const ExampleScaffold({
    required this.name,
    this.children,
    this.child,
    this.actions = const [],
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.paddingAll = 16,
    this.gap = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final String? extraString = GoRouterState.of(context).extra as String?;
    if (extraString != null && extraString == 'docs' && children != null && children!.isNotEmpty) {
      final filteredChildren = children!.where((widget) => widget.key?.toString().contains('docs') ?? false).toList();
      if (filteredChildren.isEmpty) {
        filteredChildren.add(children!.first);
      }

      return LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: embeddedViewHeight,
              child: Scaffold(
                body: ConstrainedBox(
                  constraints: constraints.copyWith(maxHeight: 400, minHeight: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: constraints,
                            child: SingleChildScrollView(
                              child: Column(
                                spacing: gap,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: filteredChildren,
                              ).paddingAll(paddingAll),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: ZetaPrimitivesLight().warm.shade90,
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // x-release-please-start-version
                      'zeta_flutter v1.0.0',
                      // x-release-please-end
                      style: ZetaTextStyles.bodyMedium.copyWith(
                        color: ZetaPrimitivesLight().warm.shade30,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    FlutterLogo(
                        style: FlutterLogoStyle.horizontal, size: 120, textColor: ZetaPrimitivesLight().warm.shade30)
                  ],
                ),
              ),
            )
          ],
        );
      });
    }
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: ZetaTopAppBar(
        title: Text(name).paddingStart(8),
        actions: [
          ...actions,
          ZetaRoundedSwitch(),
          ZetaThemeModeSwitch(),
          ZetaThemeContrastSwitch(),
          ZetaThemeColorSwitch(),
        ],
      ),
      backgroundColor: colors.surface,
      bottomNavigationBar: bottomNavigationBar,
      body: SelectionArea(child: child ?? SingleChildScrollView(child: Column(children: children ?? []))),
    );
  }
}
