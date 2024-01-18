import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/pages/accordion_example.dart';
import 'package:zeta_example/pages/app_bar_example/app_bar_example.dart';
import 'package:zeta_example/pages/app_bar_example/default_app_bar.dart';
import 'package:zeta_example/pages/app_bar_example/negative_app_bar.dart';
import 'package:zeta_example/pages/app_bar_example/positive_app_bar.dart';
import 'package:zeta_example/pages/app_bar_example/warning_app_bar.dart';
import 'package:zeta_example/pages/avatar_example.dart';
import 'package:zeta_example/pages/badge_example.dart';
import 'package:zeta_example/pages/bottom_sheet.dart';
import 'package:zeta_example/pages/button_example.dart';
import 'package:zeta_example/pages/color_example.dart';
import 'package:zeta_example/pages/checkbox_example.dart';
import 'package:zeta_example/pages/fab_example/fab_example.dart';
import 'package:zeta_example/pages/fab_example/primary_fab.dart';
import 'package:zeta_example/pages/chip_example.dart';
import 'package:zeta_example/pages/menu_items_example.dart';
import 'package:zeta_example/pages/in_page_banner_example.dart';
import 'package:zeta_example/pages/password_input_example.dart';
import 'package:zeta_example/pages/priority_pill_example.dart';
import 'package:zeta_example/pages/icons_example.dart';
import 'package:zeta_example/pages/indicator_example.dart';
import 'package:zeta_example/pages/status_label_example.dart';
import 'package:zeta_example/pages/tag_example.dart';
import 'package:zeta_example/pages/theme/typography_example.dart';
import 'package:zeta_example/pages/workcloud_indicator_example.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class Component {
  final String name;
  final WidgetBuilder pageBuilder;
  final List<Component> children;

  Component(this.name, this.pageBuilder, [this.children = const []]);
}

final List<Component> components = [
  Component(ColorExample.name, (context) => const ColorExample()),
  Component(AvatarExample.name, (context) => const AvatarExample()),
  Component(IconsExample.name, (context) => const IconsExample()),
  Component(IndicatorExample.name, (context) => const IndicatorExample()),
  Component(LabelExample.name, (context) => const LabelExample()),
  Component(TagExample.name, (context) => const TagExample()),
  Component(BadgeExample.name, (context) => const BadgeExample()),
  Component(PriorityPillExample.name, (context) => const PriorityPillExample()),
  Component(WorkcloudIndicatorExample.name, (context) => const WorkcloudIndicatorExample()),
  Component(AppBarExample.name, (context) => const AppBarExample(), [
    Component(DefaultAppBarExample.name, (context) => const DefaultAppBarExample()),
    Component(PositiveAppBarExample.name, (context) => const PositiveAppBarExample()),
    Component(WarningAppBarExample.name, (context) => const WarningAppBarExample()),
    Component(NegativeAppBarExample.name, (context) => const NegativeAppBarExample()),
  ]),
  Component(CheckBoxExample.name, (context) => const CheckBoxExample()),
  Component(InPageBannerExample.name, (context) => const InPageBannerExample()),
  Component(AccordionExample.name, (context) => const AccordionExample()),
  Component(ButtonExample.name, (context) => const ButtonExample()),
  Component(FABExample.name, (context) => const FABExample(), [
    Component(FabPrimarySmallCircle.name, (context) => const FabPrimarySmallCircle()),
    Component(FabPrimarySmallRounded.name, (context) => const FabPrimarySmallRounded()),
    Component(FabPrimarySecondSmallSharp.name, (context) => const FabPrimarySecondSmallSharp()),
    Component(FabPrimarySecondLargeCircle.name, (context) => const FabPrimarySecondLargeCircle()),
    Component(FabInverseLargeRounded.name, (context) => const FabInverseLargeRounded()),
    Component(FabInverseLargeSharp.name, (context) => const FabInverseLargeSharp()),
  ]),
  Component(MenuItemsExample.name, (context) => const MenuItemsExample()),
  Component(ChipExample.name, (context) => const ChipExample()),
  Component(PasswordInputExample.name, (context) => const PasswordInputExample()),
  Component(BottomSheetExample.name, (context) => const BottomSheetExample()),
];

final List<Component> theme = [
  Component(TypographyExample.name, (context) => TypographyExample()),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'Home',
      builder: (_, __) => const Home(),
      routes: [
        ...[...components, ...theme].map(
          (e) => GoRoute(
            path: e.name,
            name: e.name,
            builder: (_, __) => e.pageBuilder.call(_),
            routes: e.children
                .map((f) => GoRoute(path: f.name, name: f.name, builder: (_, __) => f.pageBuilder(_)))
                .toList(),
          ),
        )
      ],
    ),
  ],
);

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _components = components..sort((a, b) => a.name.compareTo(b.name));
    final _theme = theme..sort((a, b) => a.name.compareTo(b.name));

    return ExampleScaffold(
      name: 'Zeta',
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              title: Text('Widgets'),
              backgroundColor: Zeta.of(context).colors.warm.shade30,
              children: _components
                  .map((item) => ListTile(title: Text(item.name), onTap: () => context.go('/${item.name}')))
                  .toList(),
            ),
            ExpansionTile(
              title: Text('Theme'),
              backgroundColor: Zeta.of(context).colors.warm.shade30,
              children: _theme
                  .map((item) => ListTile(title: Text(item.name), onTap: () => context.go('/${item.name}')))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
