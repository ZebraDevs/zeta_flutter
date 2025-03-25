import 'package:flutter/material.dart';
import 'package:zeta_example/utils/rounded_switch.dart';
import 'package:zeta_example/utils/theme_color_switch.dart';
import 'package:zeta_example/utils/theme_constrast_switch.dart';
import 'package:zeta_example/utils/theme_mode_switch.dart';
import 'package:zeta_flutter/zeta_components.dart';
import 'package:zeta_flutter/zeta_utils.dart';

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
    final colors = Theme.of(context).colorScheme;

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
      body: SelectionArea(child: child),
    );
  }
}
