import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/pages/assets/illustrations_example.dart';
import 'package:zeta_example/pages/components/accordion_example.dart';
import 'package:zeta_example/pages/components/avatar_rail_example.dart';
import 'package:zeta_example/pages/components/avatar_example.dart';
import 'package:zeta_example/pages/components/badges_example.dart';
import 'package:zeta_example/pages/components/banner_example.dart';
import 'package:zeta_example/pages/components/bottom_sheet_example.dart';
import 'package:zeta_example/pages/components/breadcrumb_example.dart';
import 'package:zeta_example/pages/components/button_example.dart';
import 'package:zeta_example/pages/components/card_example.dart';
import 'package:zeta_example/pages/components/chat_item_example.dart';
import 'package:zeta_example/pages/components/checkbox_example.dart';
import 'package:zeta_example/pages/components/chip_example.dart';
import 'package:zeta_example/pages/components/comms_button_example.dart';
import 'package:zeta_example/pages/components/contact_item_example.dart';
import 'package:zeta_example/pages/components/date_input_example.dart';
import 'package:zeta_example/pages/components/dialog_example.dart';
import 'package:zeta_example/pages/components/dialpad_example.dart';
import 'package:zeta_example/pages/components/dropdown_example.dart';
import 'package:zeta_example/pages/components/empty_state_example.dart';
import 'package:zeta_example/pages/components/global_header_example.dart';
import 'package:zeta_example/pages/components/filter_selection_example.dart';
import 'package:zeta_example/pages/components/list_example.dart';
import 'package:zeta_example/pages/components/list_item_example.dart';
import 'package:zeta_example/pages/components/navigation_bar_example.dart';
import 'package:zeta_example/pages/components/navigation_rail_example.dart';
import 'package:zeta_example/pages/components/notification_list_example.dart';
import 'package:zeta_example/pages/components/phone_input_example.dart';
import 'package:zeta_example/pages/components/radio_example.dart';
import 'package:zeta_example/pages/components/range_selector_example.dart';
import 'package:zeta_example/pages/components/screen_header_bar_example.dart';
import 'package:zeta_example/pages/components/select_input_example.dart';

import 'package:zeta_example/pages/components/search_bar_example.dart';
import 'package:zeta_example/pages/components/segmented_control_example.dart';
import 'package:zeta_example/pages/components/slider_example.dart';
import 'package:zeta_example/pages/components/stepper_example.dart';
import 'package:zeta_example/pages/components/stepper_input_example.dart';
import 'package:zeta_example/pages/components/switch_example.dart';
import 'package:zeta_example/pages/components/snackbar_example.dart';
import 'package:zeta_example/pages/components/tabs_example.dart';
import 'package:zeta_example/pages/components/pagination_example.dart';
import 'package:zeta_example/pages/components/text_input_example.dart';
import 'package:zeta_example/pages/components/tile_button_example.dart';
import 'package:zeta_example/pages/components/time_input_example.dart';
import 'package:zeta_example/pages/components/tooltip_example.dart';
import 'package:zeta_example/pages/components/top_app_bar_example.dart';
import 'package:zeta_example/pages/components/voice_memo_example.dart';
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
  Component(AssistChipExample.name, (context) => const AssistChipExample()),
  Component(AvatarBadgeExample.name, (context) => const AvatarBadgeExample()),
  Component(AvatarExample.name, (context) => const AvatarExample()),
  Component(AvatarRailExample.name, (context) => const AvatarRailExample()),
  Component(BottomSheetExample.name, (context) => const BottomSheetExample()),
  Component(BreadcrumbExample.name, (context) => const BreadcrumbExample()),
  Component(ButtonExample.name, (context) => const ButtonExample()),
  Component(ButtonGroupExample.name, (context) => const ButtonGroupExample()),
  Component(CardContainerExample.name, (context) => const CardContainerExample()),
  Component(ChatItemExample.name, (context) => const ChatItemExample()),
  Component(CheckBoxExample.name, (context) => const CheckBoxExample()),
  Component(CommsButtonExample.name, (context) => const CommsButtonExample()),
  Component(ContactItemExample.name, (context) => const ContactItemExample()),
  Component(DateInputExample.name, (context) => const DateInputExample()),
  Component(DialPadExample.name, (context) => const DialPadExample()),
  Component(DialogExample.name, (context) => const DialogExample()),
  Component(DropdownExample.name, (context) => const DropdownExample()),
  Component(EmptyStateExample.name, (context) => const EmptyStateExample()),
  Component(FabExample.name, (context) => const FabExample()),
  Component(FilterChipExample.name, (context) => const FilterChipExample()),
  Component(FilterSelectionExample.name, (context) => const FilterSelectionExample()),
  Component(GroupHeaderExample.name, (context) => const GroupHeaderExample()),
  Component(IconButtonExample.name, (context) => const IconButtonExample()),
  Component(TileButtonExample.name, (context) => const TileButtonExample()),
  Component(InPageBannerExample.name, (context) => const InPageBannerExample()),
  Component(Indicators.name, (context) => const Indicators()),
  Component(InputChipExample.name, (context) => const InputChipExample()),
  Component(Label.name, (context) => const Label()),
  Component(ListExample.name, (context) => const ListExample()),
  Component(ListItemExample.name, (context) => const ListItemExample()),
  Component(NavigationBarExample.name, (context) => const NavigationBarExample()),
  Component(NavigationRailExample.name, (context) => const NavigationRailExample()),
  Component(NotificationListItemExample.name, (context) => const NotificationListItemExample()),
  Component(PaginationExample.name, (context) => const PaginationExample()),
  Component(PasswordInputExample.name, (context) => const PasswordInputExample()),
  Component(PhoneInputExample.name, (context) => const PhoneInputExample()),
  Component(PriorityPill.name, (context) => const PriorityPill()),
  Component(ProgressBarExample.name, (context) => const ProgressBarExample()),
  Component(ProgressCircleExample.name, (context) => const ProgressCircleExample()),
  Component(RadioButtonExample.name, (context) => const RadioButtonExample()),
  Component(RangeSelectorExample.name, (context) => const RangeSelectorExample()),
  Component(ScreenHeaderBarExample.name, (context) => const ScreenHeaderBarExample()),
  Component(SearchBarExample.name, (context) => const SearchBarExample()),
  Component(SegmentedControlExample.name, (context) => const SegmentedControlExample()),
  Component(SelectInputExample.name, (context) => const SelectInputExample()),
  Component(SliderExample.name, (context) => const SliderExample()),
  Component(SnackBarExample.name, (context) => const SnackBarExample()),
  Component(StatusChipExample.name, (context) => const StatusChipExample()),
  Component(StatusLabel.name, (context) => const StatusLabel()),
  Component(StepperExample.name, (context) => const StepperExample()),
  Component(StepperInputExample.name, (context) => const StepperInputExample()),
  Component(SwitchExample.name, (context) => const SwitchExample()),
  Component(SystemBannerExample.name, (context) => const SystemBannerExample()),
  Component(TabsExample.name, (context) => const TabsExample()),
  Component(Tags.name, (context) => const Tags()),
  Component(TextInputExample.name, (context) => const TextInputExample()),
  Component(TimeInputExample.name, (context) => const TimeInputExample()),
  Component(TooltipExample.name, (context) => const TooltipExample()),
  Component(TopAppBarExample.name, (context) => const TopAppBarExample()),
  Component(VoiceMemoExample.name, (context) => const VoiceMemoExample()),
];

final List<Component> theme = [
  Component(ColorExample.name, (context) => const ColorExample()),
  Component(TypographyExample.name, (context) => const TypographyExample()),
  Component(RadiusExample.name, (context) => const RadiusExample()),
  Component(SpacingExample.name, (context) => const SpacingExample()),
];
final List<Component> assets = [
  Component(IllustrationsExample.name, (context) => const IllustrationsExample()),
  Component(IconsExample.name, (context) => const IconsExample()),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final GoRouter router = GoRouter(
  routes: routes,
);

final routes = [
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
        (e) {
          return GoRoute(
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
          );
        },
      ),
    ],
  )
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _components = components..sort((a, b) => a.name.compareTo(b.name));
    final _assets = assets..sort((a, b) => a.name.compareTo(b.name));
    final _theme = theme..sort((a, b) => a.name.compareTo(b.name));
    if (GoRouterState.of(context).extra == 'docs') {
      return Nothing();
    }

    return ExampleScaffold(
      // x-release-please-start-version
      name: 'zeta_flutter v1.0.0',
      // x-release-please-end
      child: SingleChildScrollView(
        child: ZetaAccordion(
          inCard: true,
          children: [
            ZetaAccordionItem(
              title: 'Components',
              child: ZetaAccordion(
                children: _components
                    .map((e) => ZetaAccordionItem.navigation(title: e.name, onTap: () => context.go('/${e.name}')))
                    .toList(),
              ),
            ),
            ZetaAccordionItem(
              title: 'Assets',
              child: ZetaAccordion(
                children: _assets
                    .map((e) => ZetaAccordionItem.navigation(title: e.name, onTap: () => context.go('/${e.name}')))
                    .toList(),
              ),
            ),
            ZetaAccordionItem(
              title: 'Theme',
              child: ZetaAccordion(
                children: _theme
                    .map((e) => ZetaAccordionItem.navigation(title: e.name, onTap: () => context.go('/${e.name}')))
                    .toList(),
              ),
            ),
          ],
        ).paddingAll(
          Zeta.of(context).spacing.medium,
        ),
      ),
    );
  }
}
