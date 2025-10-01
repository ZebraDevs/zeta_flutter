import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zeta_example/pages/components/accordion_example.dart' deferred as accordion_example;
import 'package:zeta_example/pages/components/avatar_rail_example.dart' deferred as avatar_rail_example;
import 'package:zeta_example/pages/components/avatar_example.dart' deferred as avatar_example;
import 'package:zeta_example/pages/components/badges_example.dart' deferred as badges_example;
import 'package:zeta_example/pages/components/banner_example.dart' deferred as banner_example;
import 'package:zeta_example/pages/components/bottom_sheet_example.dart' deferred as bottom_sheet_example;
import 'package:zeta_example/pages/components/breadcrumb_example.dart' deferred as breadcrumb_example;
import 'package:zeta_example/pages/components/button_example.dart' deferred as button_example;
import 'package:zeta_example/pages/components/card_example.dart' deferred as card_example;
import 'package:zeta_example/pages/components/chat_item_example.dart' deferred as chat_item_example;
import 'package:zeta_example/pages/components/checkbox_example.dart' deferred as checkbox_example;
import 'package:zeta_example/pages/components/chip_example.dart' deferred as chip_example;
import 'package:zeta_example/pages/components/comms_button_example.dart' deferred as comms_button_example;
import 'package:zeta_example/pages/components/contact_item_example.dart' deferred as contact_item_example;
import 'package:zeta_example/pages/components/date_input_example.dart' deferred as date_input_example;
import 'package:zeta_example/pages/components/dialog_example.dart' deferred as dialog_example;
import 'package:zeta_example/pages/components/dialpad_example.dart' deferred as dialpad_example;
import 'package:zeta_example/pages/components/dropdown_example.dart' deferred as dropdown_example;
import 'package:zeta_example/pages/components/empty_state_example.dart' deferred as empty_state_example;
import 'package:zeta_example/pages/components/global_header_example.dart' deferred as global_header_example;
import 'package:zeta_example/pages/components/filter_selection_example.dart' deferred as filter_selection_example;
import 'package:zeta_example/pages/components/list_example.dart' deferred as list_example;
import 'package:zeta_example/pages/components/list_item_example.dart' deferred as list_item_example;
import 'package:zeta_example/pages/components/navigation_bar_example.dart' deferred as navigation_bar_example;
import 'package:zeta_example/pages/components/navigation_rail_example.dart' deferred as navigation_rail_example;
import 'package:zeta_example/pages/components/notification_list_example.dart' deferred as notification_list_example;
import 'package:zeta_example/pages/components/phone_input_example.dart' deferred as phone_input_example;
import 'package:zeta_example/pages/components/radio_example.dart' deferred as radio_example;
import 'package:zeta_example/pages/components/range_selector_example.dart' deferred as range_selector_example;
import 'package:zeta_example/pages/components/screen_header_bar_example.dart' deferred as screen_header_bar_example;
import 'package:zeta_example/pages/components/select_input_example.dart' deferred as select_input_example;
import 'package:zeta_example/pages/components/search_bar_example.dart' deferred as search_bar_example;
import 'package:zeta_example/pages/components/segmented_control_example.dart' deferred as segmented_control_example;
import 'package:zeta_example/pages/components/slider_example.dart' deferred as slider_example;
import 'package:zeta_example/pages/components/stepper_example.dart' deferred as stepper_example;
import 'package:zeta_example/pages/components/stepper_input_example.dart' deferred as stepper_input_example;
import 'package:zeta_example/pages/components/switch_example.dart' deferred as switch_example;
import 'package:zeta_example/pages/components/snackbar_example.dart' deferred as snackbar_example;
import 'package:zeta_example/pages/components/tabs_example.dart' deferred as tabs_example;
import 'package:zeta_example/pages/components/pagination_example.dart' deferred as pagination_example;
import 'package:zeta_example/pages/components/text_input_example.dart' deferred as text_input_example;
import 'package:zeta_example/pages/components/tile_button_example.dart' deferred as tile_button_example;
import 'package:zeta_example/pages/components/time_input_example.dart' deferred as time_input_example;
import 'package:zeta_example/pages/components/tooltip_example.dart' deferred as tooltip_example;
import 'package:zeta_example/pages/components/top_app_bar_example.dart' deferred as top_app_bar_example;
import 'package:zeta_example/pages/components/voice_memo_example.dart' deferred as voice_memo_example;
import 'package:zeta_example/pages/components/password_input_example.dart' deferred as password_input_example;
import 'package:zeta_example/pages/components/progress_example.dart' deferred as progress_example;

import 'package:zeta_example/pages/assets/illustrations_example.dart' deferred as illustrations_example;
import 'package:zeta_example/pages/assets/icons_example.dart' deferred as icons_example;

import 'package:zeta_example/pages/theme/color_example.dart' deferred as color_example;
import 'package:zeta_example/pages/theme/radius_example.dart' deferred as radius_example;
import 'package:zeta_example/pages/theme/spacing_example.dart' deferred as spacing_example;
import 'package:zeta_example/pages/theme/typography_example.dart' deferred as typography_example;

import 'package:zeta_example/widgets.dart' show ExampleScaffold;
import 'package:zeta_flutter/zeta_flutter.dart' show ZetaAccordion, Nothing, ZetaAccordionItem, Zeta, SpacingWidget;

class Component<T> {
  final T name;
  final WidgetBuilder pageBuilder;
  final List<Component<T>> children;
  Component(this.name, this.pageBuilder, [this.children = const []]);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final GoRouter router = GoRouter(routes: routes);

final routes = [
  GoRoute(
    path: '/',
    name: 'Home',
    builder: (_, __) => const Home(),
    routes: [
      ...componentExampleNames.entries.map(
        (e) => GoRoute(
          path: e.key.name,
          builder: (_, __) => FutureBuilder(
              future: e.value.loader(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return e.value.pageBuilder.call(_);
              }),
        ),
      ),
      ...themeExampleNames.entries.map(
        (e) => GoRoute(
          path: e.key.name,
          builder: (_, __) => FutureBuilder(
              future: e.value.loader(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return e.value.pageBuilder.call(_);
              }),
        ),
      ),
      ...assetExampleNames.entries.map(
        (e) => GoRoute(
          path: e.key.name,
          builder: (_, __) => FutureBuilder(
              future: e.value.loader(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return e.value.pageBuilder.call(_);
              }),
        ),
      ),
    ],
  )
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                children: componentExampleNames.entries.map((e) {
                  return ZetaAccordionItem.navigation(
                    title: e.value.name,
                    onTap: () => context.go('/${e.key.name}'),
                  );
                }).toList(),
              ),
            ),
            ZetaAccordionItem(
              title: 'Assets',
              child: ZetaAccordion(
                children: assetExampleNames.entries.map((e) {
                  return ZetaAccordionItem.navigation(
                    title: e.value.name,
                    onTap: () => context.go('/${e.key.name}'),
                  );
                }).toList(),
              ),
            ),
            ZetaAccordionItem(
              title: 'Theme',
              child: ZetaAccordion(
                children: themeExampleNames.entries.map((e) {
                  return ZetaAccordionItem.navigation(
                    title: e.value.name,
                    onTap: () => context.go('/${e.key.name}'),
                  );
                }).toList(),
              ),
            ),
          ],
        ).paddingAll(Zeta.of(context).spacing.medium),
      ),
    );
  }
}

enum ComponentExampleName {
  accordion,
  avatar,
  avatarRail,
  badgesStatusLabel,
  badgesPriorityPill,
  badgesLabel,
  badgesIndicator,
  bannerSystem,
  bannerInPage,
  bottomSheet,
  breadcrumb,
  button,
  iconButton,
  buttonGroup,
  fab,
  cardContainer,
  chatListItem,
  checkbox,
  chipAssist,
  chipFilter,
  chipInput,
  chipStatus,
  commsButton,
  contactListItem,
  dateInput,
  dialog,
  dialPad,
  dropdownMenu,
  emptyState,
  filterSelectionBar,
  globalHeader,
  list,
  listItem,
  navigationBar,
  navigationRail,
  notificationListItem,
  pagination,
  passwordInput,
  phoneInput,
  progressBar,
  progressCircle,
  radioButton,
  rangeSelector,
  screenHeaderBar,
  searchBar,
  segmentedControl,
  selectInput,
  slider,
  snackbar,
  stepper,
  stepperInput,
  switchExample,
  tabs,
  textInput,
  tileButton,
  timeInput,
  tooltip,
  topAppBar,
  voiceMemo,
}

class ExampleWrap {
  final String name;
  final WidgetBuilder pageBuilder;
  final Future<void> Function() loader;

  ExampleWrap({required this.name, required this.pageBuilder, required this.loader});
}

final Map<ComponentExampleName, ExampleWrap> componentExampleNames = {
  ComponentExampleName.accordion: ExampleWrap(
    name: 'Accordion',
    pageBuilder: (context) => accordion_example.AccordionExample(),
    loader: accordion_example.loadLibrary,
  ),
  ComponentExampleName.avatar: ExampleWrap(
    name: 'Avatar',
    pageBuilder: (context) => avatar_example.AvatarExample(),
    loader: avatar_example.loadLibrary,
  ),
  ComponentExampleName.avatarRail: ExampleWrap(
    name: 'AvatarRail',
    pageBuilder: (context) => avatar_rail_example.AvatarRailExample(),
    loader: avatar_rail_example.loadLibrary,
  ),
  ComponentExampleName.badgesStatusLabel: ExampleWrap(
    name: 'BadgesStatusLabel',
    pageBuilder: (context) => badges_example.StatusLabelExample(),
    loader: badges_example.loadLibrary,
  ),
  ComponentExampleName.badgesPriorityPill: ExampleWrap(
    name: 'BadgesPriorityPill',
    pageBuilder: (context) => badges_example.PriorityPillExample(),
    loader: badges_example.loadLibrary,
  ),
  ComponentExampleName.badgesLabel: ExampleWrap(
    name: 'BadgesLabel',
    pageBuilder: (context) => badges_example.LabelExample(),
    loader: badges_example.loadLibrary,
  ),
  ComponentExampleName.badgesIndicator: ExampleWrap(
    name: 'BadgesIndicator',
    pageBuilder: (context) => badges_example.IndicatorExample(),
    loader: badges_example.loadLibrary,
  ),
  ComponentExampleName.bannerSystem: ExampleWrap(
    name: 'BannerSystem',
    pageBuilder: (context) => banner_example.SystemBannerExample(),
    loader: banner_example.loadLibrary,
  ),
  ComponentExampleName.bannerInPage: ExampleWrap(
    name: 'BannerInPage',
    pageBuilder: (context) => banner_example.InPageBannerExample(),
    loader: banner_example.loadLibrary,
  ),
  ComponentExampleName.bottomSheet: ExampleWrap(
    name: 'BottomSheet',
    pageBuilder: (context) => bottom_sheet_example.BottomSheetExample(),
    loader: bottom_sheet_example.loadLibrary,
  ),
  ComponentExampleName.breadcrumb: ExampleWrap(
    name: 'Breadcrumb',
    pageBuilder: (context) => breadcrumb_example.BreadcrumbExample(),
    loader: breadcrumb_example.loadLibrary,
  ),
  ComponentExampleName.button: ExampleWrap(
    name: 'Button',
    pageBuilder: (context) => button_example.ButtonExample(),
    loader: button_example.loadLibrary,
  ),
  ComponentExampleName.iconButton: ExampleWrap(
    name: 'IconButton',
    pageBuilder: (context) => button_example.IconButtonExample(),
    loader: button_example.loadLibrary,
  ),
  ComponentExampleName.buttonGroup: ExampleWrap(
    name: 'ButtonGroup',
    pageBuilder: (context) => button_example.ButtonGroupExample(),
    loader: button_example.loadLibrary,
  ),
  ComponentExampleName.fab: ExampleWrap(
    name: 'Fab',
    pageBuilder: (context) => button_example.FabExample(),
    loader: button_example.loadLibrary,
  ),
  ComponentExampleName.cardContainer: ExampleWrap(
    name: 'CardContainer',
    pageBuilder: (context) => card_example.CardContainerExample(),
    loader: card_example.loadLibrary,
  ),
  ComponentExampleName.chatListItem: ExampleWrap(
    name: 'ChatListItem',
    pageBuilder: (context) => chat_item_example.ChatItemExample(),
    loader: chat_item_example.loadLibrary,
  ),
  ComponentExampleName.checkbox: ExampleWrap(
    name: 'Checkbox',
    pageBuilder: (context) => checkbox_example.CheckBoxExample(),
    loader: checkbox_example.loadLibrary,
  ),
  ComponentExampleName.chipAssist: ExampleWrap(
    name: 'ChipAssist',
    pageBuilder: (context) => chip_example.AssistChipExample(),
    loader: chip_example.loadLibrary,
  ),
  ComponentExampleName.chipFilter: ExampleWrap(
    name: 'ChipFilter',
    pageBuilder: (context) => chip_example.FilterChipExample(),
    loader: chip_example.loadLibrary,
  ),
  ComponentExampleName.chipInput: ExampleWrap(
    name: 'ChipInput',
    pageBuilder: (context) => chip_example.InputChipExample(),
    loader: chip_example.loadLibrary,
  ),
  ComponentExampleName.chipStatus: ExampleWrap(
    name: 'ChipStatus',
    pageBuilder: (context) => chip_example.StatusChipExample(),
    loader: chip_example.loadLibrary,
  ),
  ComponentExampleName.commsButton: ExampleWrap(
    name: 'CommsButton',
    pageBuilder: (context) => comms_button_example.CommsButtonExample(),
    loader: comms_button_example.loadLibrary,
  ),
  ComponentExampleName.contactListItem: ExampleWrap(
    name: 'ContactListItem',
    pageBuilder: (context) => contact_item_example.ContactItemExample(),
    loader: contact_item_example.loadLibrary,
  ),
  ComponentExampleName.dateInput: ExampleWrap(
    name: 'DateInput',
    pageBuilder: (context) => date_input_example.DateInputExample(),
    loader: date_input_example.loadLibrary,
  ),
  ComponentExampleName.dialog: ExampleWrap(
    name: 'Dialog',
    pageBuilder: (context) => dialog_example.DialogExample(),
    loader: dialog_example.loadLibrary,
  ),
  ComponentExampleName.dialPad: ExampleWrap(
    name: 'DialPad',
    pageBuilder: (context) => dialpad_example.DialPadExample(),
    loader: dialpad_example.loadLibrary,
  ),
  ComponentExampleName.dropdownMenu: ExampleWrap(
    name: 'DropdownMenu',
    pageBuilder: (context) => dropdown_example.DropdownExample(),
    loader: dropdown_example.loadLibrary,
  ),
  ComponentExampleName.emptyState: ExampleWrap(
    name: 'EmptyState',
    pageBuilder: (context) => empty_state_example.EmptyStateExample(),
    loader: empty_state_example.loadLibrary,
  ),
  ComponentExampleName.filterSelectionBar: ExampleWrap(
    name: 'FilterSelectionBar',
    pageBuilder: (context) => filter_selection_example.FilterSelectionExample(),
    loader: filter_selection_example.loadLibrary,
  ),
  ComponentExampleName.globalHeader: ExampleWrap(
    name: 'GlobalHeader',
    pageBuilder: (context) => global_header_example.GlobalHeaderExample(),
    loader: global_header_example.loadLibrary,
  ),
  ComponentExampleName.list: ExampleWrap(
    name: 'List',
    pageBuilder: (context) => list_example.ListExample(),
    loader: list_example.loadLibrary,
  ),
  ComponentExampleName.listItem: ExampleWrap(
    name: 'ListItem',
    pageBuilder: (context) => list_item_example.ListItemExample(),
    loader: list_item_example.loadLibrary,
  ),
  ComponentExampleName.navigationBar: ExampleWrap(
    name: 'NavigationBar',
    pageBuilder: (context) => navigation_bar_example.NavigationBarExample(),
    loader: navigation_bar_example.loadLibrary,
  ),
  ComponentExampleName.navigationRail: ExampleWrap(
    name: 'NavigationRail',
    pageBuilder: (context) => navigation_rail_example.NavigationRailExample(),
    loader: navigation_rail_example.loadLibrary,
  ),
  ComponentExampleName.notificationListItem: ExampleWrap(
    name: 'NotificationListItem',
    pageBuilder: (context) => notification_list_example.NotificationListItemExample(),
    loader: notification_list_example.loadLibrary,
  ),
  ComponentExampleName.pagination: ExampleWrap(
    name: 'Pagination',
    pageBuilder: (context) => pagination_example.PaginationExample(),
    loader: pagination_example.loadLibrary,
  ),
  ComponentExampleName.passwordInput: ExampleWrap(
    name: 'PasswordInput',
    pageBuilder: (context) => password_input_example.PasswordInputExample(),
    loader: password_input_example.loadLibrary,
  ),
  ComponentExampleName.phoneInput: ExampleWrap(
    name: 'PhoneInput',
    pageBuilder: (context) => phone_input_example.PhoneInputExample(),
    loader: phone_input_example.loadLibrary,
  ),
  ComponentExampleName.progressBar: ExampleWrap(
    name: 'ProgressBar',
    pageBuilder: (context) => progress_example.ProgressBarExample(),
    loader: progress_example.loadLibrary,
  ),
  ComponentExampleName.progressCircle: ExampleWrap(
    name: 'ProgressCircle',
    pageBuilder: (context) => progress_example.ProgressCircleExample(),
    loader: progress_example.loadLibrary,
  ),
  ComponentExampleName.radioButton: ExampleWrap(
    name: 'RadioButton',
    pageBuilder: (context) => radio_example.RadioButtonExample(),
    loader: radio_example.loadLibrary,
  ),
  ComponentExampleName.rangeSelector: ExampleWrap(
    name: 'RangeSelector',
    pageBuilder: (context) => range_selector_example.RangeSelectorExample(),
    loader: range_selector_example.loadLibrary,
  ),
  ComponentExampleName.screenHeaderBar: ExampleWrap(
    name: 'ScreenHeaderBar',
    pageBuilder: (context) => screen_header_bar_example.ScreenHeaderBarExample(),
    loader: screen_header_bar_example.loadLibrary,
  ),
  ComponentExampleName.searchBar: ExampleWrap(
    name: 'SearchBar',
    pageBuilder: (context) => search_bar_example.SearchBarExample(),
    loader: search_bar_example.loadLibrary,
  ),
  ComponentExampleName.segmentedControl: ExampleWrap(
    name: 'SegmentedControl',
    pageBuilder: (context) => segmented_control_example.SegmentedControlExample(),
    loader: segmented_control_example.loadLibrary,
  ),
  ComponentExampleName.selectInput: ExampleWrap(
    name: 'SelectInput',
    pageBuilder: (context) => select_input_example.SelectInputExample(),
    loader: select_input_example.loadLibrary,
  ),
  ComponentExampleName.slider: ExampleWrap(
    name: 'Slider',
    pageBuilder: (context) => slider_example.SliderExample(),
    loader: slider_example.loadLibrary,
  ),
  ComponentExampleName.snackbar: ExampleWrap(
    name: 'Snackbar',
    pageBuilder: (context) => snackbar_example.SnackBarExample(),
    loader: snackbar_example.loadLibrary,
  ),
  ComponentExampleName.stepper: ExampleWrap(
    name: 'Stepper',
    pageBuilder: (context) => stepper_example.StepperExample(),
    loader: stepper_example.loadLibrary,
  ),
  ComponentExampleName.stepperInput: ExampleWrap(
    name: 'StepperInput',
    pageBuilder: (context) => stepper_input_example.StepperInputExample(),
    loader: stepper_input_example.loadLibrary,
  ),
  ComponentExampleName.switchExample: ExampleWrap(
    name: 'SwitchExample',
    pageBuilder: (context) => switch_example.SwitchExample(),
    loader: switch_example.loadLibrary,
  ),
  ComponentExampleName.tabs: ExampleWrap(
    name: 'Tabs',
    pageBuilder: (context) => tabs_example.TabsExample(),
    loader: tabs_example.loadLibrary,
  ),
  ComponentExampleName.textInput: ExampleWrap(
    name: 'TextInput',
    pageBuilder: (context) => text_input_example.TextInputExample(),
    loader: text_input_example.loadLibrary,
  ),
  ComponentExampleName.tileButton: ExampleWrap(
    name: 'TileButton',
    pageBuilder: (context) => tile_button_example.TileButtonExample(),
    loader: tile_button_example.loadLibrary,
  ),
  ComponentExampleName.timeInput: ExampleWrap(
    name: 'TimeInput',
    pageBuilder: (context) => time_input_example.TimeInputExample(),
    loader: time_input_example.loadLibrary,
  ),
  ComponentExampleName.tooltip: ExampleWrap(
    name: 'Tooltip',
    pageBuilder: (context) => tooltip_example.TooltipExample(),
    loader: tooltip_example.loadLibrary,
  ),
  ComponentExampleName.topAppBar: ExampleWrap(
    name: 'TopAppBar',
    pageBuilder: (context) => top_app_bar_example.TopAppBarExample(),
    loader: top_app_bar_example.loadLibrary,
  ),
  ComponentExampleName.voiceMemo: ExampleWrap(
    name: 'VoiceMemo',
    pageBuilder: (context) => voice_memo_example.VoiceMemoExample(),
    loader: voice_memo_example.loadLibrary,
  ),
};

enum ThemeExampleName {
  colors,
  typography,
  spacing,
  radius,
}

final Map<ThemeExampleName, ExampleWrap> themeExampleNames = {
  ThemeExampleName.colors: ExampleWrap(
    name: 'Colors',
    pageBuilder: (context) => color_example.ColorExample(),
    loader: color_example.loadLibrary,
  ),
  ThemeExampleName.typography: ExampleWrap(
    name: 'Typography',
    pageBuilder: (context) => typography_example.TypographyExample(),
    loader: typography_example.loadLibrary,
  ),
  ThemeExampleName.spacing: ExampleWrap(
    name: 'Spacing',
    pageBuilder: (context) => spacing_example.SpacingExample(),
    loader: spacing_example.loadLibrary,
  ),
  ThemeExampleName.radius: ExampleWrap(
    name: 'Radius',
    pageBuilder: (context) => radius_example.RadiusExample(),
    loader: radius_example.loadLibrary,
  ),
};

enum AssetExampleName {
  icons,
  illustrations,
}

final Map<AssetExampleName, ExampleWrap> assetExampleNames = {
  AssetExampleName.icons: ExampleWrap(
    name: 'Icons',
    pageBuilder: (context) => icons_example.IconsExample(),
    loader: icons_example.loadLibrary,
  ),
  AssetExampleName.illustrations: ExampleWrap(
    name: 'Illustrations',
    pageBuilder: (context) => illustrations_example.IllustrationsExample(),
    loader: illustrations_example.loadLibrary,
  ),
};
