import 'package:flutter/material.dart';
import 'package:zeta_example/utils/rounded_switch.dart';
import 'package:zeta_example/utils/theme_color_switch.dart';
import 'package:zeta_example/utils/theme_constrast_switch.dart';
import 'package:zeta_example/utils/theme_mode_switch.dart';

class ExampleScaffold extends StatelessWidget {
  final String name;
  final Widget child;
  final List<Widget> actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const ExampleScaffold({
    required this.name,
    required this.child,
    this.actions = const [],
    this.floatingActionButton,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

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
      body: SelectionArea(
        child: child,
      ),
    );
  }
}
