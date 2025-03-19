import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/utils/rounded_switch.dart';
import 'package:zeta_example/utils/theme_color_switch.dart';
import 'package:zeta_example/utils/theme_constrast_switch.dart';
import 'package:zeta_example/utils/theme_mode_switch.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ExampleScaffold extends StatelessWidget {
  final String name;
  final List<Widget>? children;
  final List<Widget> actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? child;

  const ExampleScaffold({
    required this.name,
    this.children,
    this.child,
    this.actions = const [],
    this.floatingActionButton,
    this.bottomNavigationBar,
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
        return Center(
          child: ConstrainedBox(
            constraints: constraints,
            // height: 400,
            // width: constraints.maxWidth,
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: filteredChildren,
                        ).paddingAll(16),
                      ),
                    ),
                  ),
                  Container(
                    color: ZetaPrimitivesLight().warm.shade100,
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // x-release-please-start-version
                            'zeta_flutter v0.20.2',
                            // x-release-please-end
                            style: ZetaTextStyles.bodyMedium.copyWith(color: ZetaPrimitivesLight().warm.shade30),
                          ),
                          FlutterLogo(
                              style: FlutterLogoStyle.horizontal,
                              size: 120,
                              textColor: ZetaPrimitivesLight().warm.shade30)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    }
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        centerTitle: false,
        title: Text(name),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
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
