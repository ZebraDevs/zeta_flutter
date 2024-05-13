import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/pages/components/accordion_example.dart';
import 'package:zeta_example/pages/components/avatar_example.dart';
import 'package:zeta_example/pages/components/badges_example.dart';
import 'package:zeta_example/pages/components/banner_example.dart';
import 'package:zeta_example/pages/components/bottom_sheet_example.dart';
import 'package:zeta_example/pages/components/breadcrumbs_example.dart';
import 'package:zeta_example/pages/components/button_example.dart';
import 'package:zeta_example/pages/components/chat_item_example.dart';
import 'package:zeta_example/pages/components/checkbox_example.dart';
import 'package:zeta_example/pages/components/chip_example.dart';
import 'package:zeta_example/pages/components/contact_item_example.dart';
import 'package:zeta_example/pages/components/date_input_example.dart';
import 'package:zeta_example/pages/components/dialog_example.dart';
import 'package:zeta_example/pages/components/dialpad_example.dart';
import 'package:zeta_example/pages/components/dropdown_example.dart';
import 'package:zeta_example/pages/components/global_header_example.dart';
import 'package:zeta_example/pages/components/filter_selection_example.dart';
import 'package:zeta_example/pages/components/list_item_example.dart';
import 'package:zeta_example/pages/components/navigation_bar_example.dart';
import 'package:zeta_example/pages/components/navigation_rail_example.dart';
import 'package:zeta_example/pages/components/phone_input_example.dart';
import 'package:zeta_example/pages/components/radio_example.dart';
import 'package:zeta_example/pages/components/screen_header_bar_example.dart';
import 'package:zeta_example/pages/components/select_input_example.dart';
import 'package:zeta_example/pages/components/search_bar_example.dart';
import 'package:zeta_example/pages/components/segmented_control_example.dart';
import 'package:zeta_example/pages/components/stepper_example.dart';
import 'package:zeta_example/pages/components/stepper_input_example.dart';
import 'package:zeta_example/pages/components/switch_example.dart';
import 'package:zeta_example/pages/components/snackbar_example.dart';
import 'package:zeta_example/pages/components/tabs_example.dart';
import 'package:zeta_example/pages/components/pagination_example.dart';
import 'package:zeta_example/pages/components/tooltip_example.dart';
import 'package:zeta_example/pages/components/top_app_bar_example.dart';
import 'package:zeta_example/pages/theme/color_example.dart';
import 'package:zeta_example/pages/components/password_input_example.dart';
import 'package:zeta_example/pages/components/progress_example.dart';
import 'package:zeta_example/pages/assets/icons_example.dart';
import 'package:zeta_example/pages/theme/radius_example.dart';
import 'package:zeta_example/pages/theme/spacing_example.dart';
import 'package:zeta_example/pages/theme/typography_example.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class Component {
  final String name;
  final WidgetBuilder pageBuilder;
  final List<Component> children;
  Component(this.name, this.pageBuilder, [this.children = const []]);
}

final List<Component> components = [
  Component(AccordionExample.name, (context) => const AccordionExample()),
  Component(TopAppBarExample.name, (context) => const TopAppBarExample()),
  Component(AvatarExample.name, (context) => const AvatarExample()),
  Component(BannerExample.name, (context) => const BannerExample()),
  Component(BadgesExample.name, (context) => const BadgesExample()),
  Component(BottomSheetExample.name, (context) => const BottomSheetExample()),
  Component(BreadCrumbsExample.name, (context) => const BreadCrumbsExample()),
  Component(ButtonExample.name, (context) => const ButtonExample()),
  Component(ChatItemExample.name, (context) => const ChatItemExample()),
  Component(CheckBoxExample.name, (context) => const CheckBoxExample()),
  Component(ChipExample.name, (context) => const ChipExample()),
  Component(ContactItemExample.name, (context) => const ContactItemExample()),
  Component(ListItemExample.name, (context) => const ListItemExample()),
  Component(NavigationBarExample.name, (context) => const NavigationBarExample()),
  Component(PaginationExample.name, (context) => const PaginationExample()),
  Component(PasswordInputExample.name, (context) => const PasswordInputExample()),
  Component(GroupHeaderExample.name, (context) => const GroupHeaderExample()),
  Component(DropdownExample.name, (context) => const DropdownExample()),
  Component(ProgressExample.name, (context) => const ProgressExample()),
  Component(SegmentedControlExample.name, (context) => const SegmentedControlExample()),
  Component(SnackBarExample.name, (context) => const SnackBarExample()),
  Component(StepperExample.name, (context) => const StepperExample()),
  Component(TabsExample.name, (context) => const TabsExample()),
  Component(DialPadExample.name, (context) => const DialPadExample()),
  Component(RadioButtonExample.name, (context) => const RadioButtonExample()),
  Component(SwitchExample.name, (context) => const SwitchExample()),
  Component(DateInputExample.name, (context) => const DateInputExample()),
  Component(PhoneInputExample.name, (context) => const PhoneInputExample()),
  Component(DialogExample.name, (context) => const DialogExample()),
  Component(SearchBarExample.name, (context) => const SearchBarExample()),
  Component(TooltipExample.name, (context) => const TooltipExample()),
  Component(NavigationRailExample.name, (context) => const NavigationRailExample()),
  Component(SelectInputExample.name, (context) => const SelectInputExample()),
  Component(ScreenHeaderBarExample.name, (context) => const ScreenHeaderBarExample()),
  Component(FilterSelectionExample.name, (context) => const FilterSelectionExample()),
  Component(StepperInputExample.name, (context) => const StepperInputExample()),
];

final List<Component> theme = [
  Component(ColorExample.name, (context) => const ColorExample()),
  Component(TypographyExample.name, (context) => const TypographyExample()),
  Component(RadiusExample.name, (context) => const RadiusExample()),
  Component(SpacingExample.name, (context) => const SpacingExample()),
];
final List<Component> assets = [
  Component(IconsExample.name, (context) => const IconsExample()),
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
        ...[
          ...components,
          ...assets,
          ...theme,
        ].map(
          (e) => GoRoute(
            path: e.name,
            name: e.name,
            builder: (_, __) => e.pageBuilder.call(_),
            routes: e.children
                .map((f) => GoRoute(
                      path: f.name,
                      name: f.name,
                      builder: (_, __) => f.pageBuilder(_),
                    ))
                .toList(),
          ),
        ),
      ],
    ),
  ],
);

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _components = components..sort((a, b) => a.name.compareTo(b.name));
    final _assets = assets..sort((a, b) => a.name.compareTo(b.name));
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
            ExpansionTile(
              title: Text('Assets'),
              backgroundColor: Zeta.of(context).colors.warm.shade30,
              children: _assets
                  .map((item) => ListTile(title: Text(item.name), onTap: () => context.go('/${item.name}')))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
