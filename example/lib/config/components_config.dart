import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zeta_example/pages/components/accordion_example.dart' deferred as accordion_example;
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
import 'package:zeta_example/pages/components/time_input_example.dart' deferred as time_input_example;
import 'package:zeta_example/pages/components/tooltip_example.dart' deferred as tooltip_example;
import 'package:zeta_example/pages/components/top_app_bar_example.dart' deferred as top_app_bar_example;
import 'package:zeta_example/pages/components/voice_memo_example.dart' deferred as voice_memo_example;
import 'package:zeta_example/pages/components/password_input_example.dart' deferred as password_input_example;
import 'package:zeta_example/pages/components/progress_example.dart' deferred as progress_example;

const String accordionRoute = 'Accordion';
const String avatarRoute = 'Avatar/Avatar';
const String statusBadgeRoute = 'Avatar/StatusBadge';
const String avatarRailRoute = 'Avatar/AvatarRail';
const String badgesStatusLabelRoute = 'Badges/StatusLabel';
const String badgesPriorityPillRoute = 'Badges/PriorityPill';
const String badgesLabelRoute = 'Badges/Label';
const String badgesIndicatorRoute = 'Badges/Indicator';
const String badgesTagRoute = 'Badges/Tag';
const String bannerSystemRoute = 'SystemBanner';
const String bannerInPageRoute = 'InPageBanner';
const String bottomSheetRoute = 'BottomSheet';
const String breadcrumbRoute = 'Breadcrumb';
const String buttonRoute = 'Buttons/Button';
const String iconButtonRoute = 'Buttons/IconButton';
const String buttonGroupRoute = 'ButtonGroup';
const String fabRoute = 'FAB';
const String cardContainerRoute = 'Cards/CardContainer';
const String chatListItemRoute = 'ChatListItem';
const String checkboxRoute = 'Checkbox';
const String chipAssistRoute = 'ChipsAssistChip';
const String chipFilterRoute = 'Chips/FilterChip';
const String chipInputRoute = 'Chips/InputChip';
const String chipStatusRoute = 'Chips/StatusChip';
const String commsButtonRoute = 'CommsButtons';
const String contactListItemRoute = 'ContactListItem';
const String dateInputRoute = 'DateInput';
const String dialogRoute = 'Dialog';
const String dialPadRoute = 'DialPad';
const String dropdownMenuRoute = 'DropdownMenu';
const String emptyStateRoute = 'EmptyState';
const String filterSelectionBarRoute = 'FilterSelectionBar';
const String globalHeaderRoute = 'GlobalHeader';
const String listRoute = 'List';
const String listItemRoute = 'ListItem';
const String navigationBarRoute = 'NavigationBar';
const String navigationRailRoute = 'NavigationRail';
const String notificationListItemRoute = 'NotificationListItem';
const String paginationRoute = 'Pagination';
const String passwordInputRoute = 'PasswordInput';
const String phoneInputRoute = 'PhoneInput';
const String progressBarRoute = 'ProgressIndicator/ProgressBar';
const String progressCircleRoute = 'ProgressIndicator/ProgressCircle';
const String radioButtonRoute = 'RadioButton';
const String rangeSelectorRoute = 'RangeSelector';
const String screenHeaderBarRoute = 'ScreenHeaderBar';
const String searchBarRoute = 'SearchBar';
const String segmentedControlRoute = 'SegmentedControl';
const String selectInputRoute = 'SelectInput';
const String sliderRoute = 'Slider/Slider';
const String snackbarRoute = 'SnackBar';
const String stepperRoute = 'Stepper';
const String stepperInputRoute = 'StepperInput';
const String switchRoute = 'Switch';
const String tabsRoute = 'Tabs';
const String textInputRoute = 'TextInput';
const String tileButtonRoute = 'Buttons/TileButton';
const String timeInputRoute = 'TimeInput';
const String tooltipRoute = 'Tooltip';
const String topAppBarRoute = 'TopAppBar';
const String voiceMemoRoute = 'VoiceMemo';

class ExampleWrap {
  final WidgetBuilder pageBuilder;
  final Future<void> Function() loader;

  ExampleWrap({required this.pageBuilder, required this.loader});
}

final Map<String, ExampleWrap> componentExampleNames = {
  accordionRoute: ExampleWrap(
    pageBuilder: (context) => accordion_example.AccordionExample(),
    loader: accordion_example.loadLibrary,
  ),
  avatarRoute: ExampleWrap(
    pageBuilder: (context) => avatar_example.AvatarExample(),
    loader: avatar_example.loadLibrary,
  ),
  avatarRailRoute: ExampleWrap(
    pageBuilder: (context) => avatar_example.AvatarRailExample(),
    loader: avatar_example.loadLibrary,
  ),
  badgesStatusLabelRoute: ExampleWrap(
    pageBuilder: (context) => badges_example.StatusLabelExample(),
    loader: badges_example.loadLibrary,
  ),
  badgesPriorityPillRoute: ExampleWrap(
    pageBuilder: (context) => badges_example.PriorityPillExample(),
    loader: badges_example.loadLibrary,
  ),
  badgesLabelRoute: ExampleWrap(
    pageBuilder: (context) => badges_example.LabelExample(),
    loader: badges_example.loadLibrary,
  ),
  badgesIndicatorRoute: ExampleWrap(
    pageBuilder: (context) => badges_example.IndicatorExample(),
    loader: badges_example.loadLibrary,
  ),
  bannerSystemRoute: ExampleWrap(
    pageBuilder: (context) => banner_example.SystemBannerExample(),
    loader: banner_example.loadLibrary,
  ),
  bannerInPageRoute: ExampleWrap(
    pageBuilder: (context) => banner_example.InPageBannerExample(),
    loader: banner_example.loadLibrary,
  ),
  bottomSheetRoute: ExampleWrap(
    pageBuilder: (context) => bottom_sheet_example.BottomSheetExample(),
    loader: bottom_sheet_example.loadLibrary,
  ),
  breadcrumbRoute: ExampleWrap(
    pageBuilder: (context) => breadcrumb_example.BreadcrumbExample(),
    loader: breadcrumb_example.loadLibrary,
  ),
  buttonRoute: ExampleWrap(
    pageBuilder: (context) => button_example.ButtonExample(),
    loader: button_example.loadLibrary,
  ),
  iconButtonRoute: ExampleWrap(
    pageBuilder: (context) => button_example.IconButtonExample(),
    loader: button_example.loadLibrary,
  ),
  buttonGroupRoute: ExampleWrap(
    pageBuilder: (context) => button_example.ButtonGroupExample(),
    loader: button_example.loadLibrary,
  ),
  fabRoute: ExampleWrap(
    pageBuilder: (context) => button_example.FabExample(),
    loader: button_example.loadLibrary,
  ),
  cardContainerRoute: ExampleWrap(
    pageBuilder: (context) => card_example.CardContainerExample(),
    loader: card_example.loadLibrary,
  ),
  chatListItemRoute: ExampleWrap(
    pageBuilder: (context) => chat_item_example.ChatItemExample(),
    loader: chat_item_example.loadLibrary,
  ),
  checkboxRoute: ExampleWrap(
    pageBuilder: (context) => checkbox_example.CheckBoxExample(),
    loader: checkbox_example.loadLibrary,
  ),
  chipAssistRoute: ExampleWrap(
    pageBuilder: (context) => chip_example.AssistChipExample(),
    loader: chip_example.loadLibrary,
  ),
  chipFilterRoute: ExampleWrap(
    pageBuilder: (context) => chip_example.FilterChipExample(),
    loader: chip_example.loadLibrary,
  ),
  chipInputRoute: ExampleWrap(
    pageBuilder: (context) => chip_example.InputChipExample(),
    loader: chip_example.loadLibrary,
  ),
  chipStatusRoute: ExampleWrap(
    pageBuilder: (context) => chip_example.StatusChipExample(),
    loader: chip_example.loadLibrary,
  ),
  commsButtonRoute: ExampleWrap(
    pageBuilder: (context) => comms_button_example.CommsButtonExample(),
    loader: comms_button_example.loadLibrary,
  ),
  contactListItemRoute: ExampleWrap(
    pageBuilder: (context) => contact_item_example.ContactItemExample(),
    loader: contact_item_example.loadLibrary,
  ),
  dateInputRoute: ExampleWrap(
    pageBuilder: (context) => date_input_example.DateInputExample(),
    loader: date_input_example.loadLibrary,
  ),
  dialogRoute: ExampleWrap(
    pageBuilder: (context) => dialog_example.DialogExample(),
    loader: dialog_example.loadLibrary,
  ),
  dialPadRoute: ExampleWrap(
    pageBuilder: (context) => dialpad_example.DialPadExample(),
    loader: dialpad_example.loadLibrary,
  ),
  dropdownMenuRoute: ExampleWrap(
    pageBuilder: (context) => dropdown_example.DropdownExample(),
    loader: dropdown_example.loadLibrary,
  ),
  emptyStateRoute: ExampleWrap(
    pageBuilder: (context) => empty_state_example.EmptyStateExample(),
    loader: empty_state_example.loadLibrary,
  ),
  filterSelectionBarRoute: ExampleWrap(
    pageBuilder: (context) => filter_selection_example.FilterSelectionExample(),
    loader: filter_selection_example.loadLibrary,
  ),
  globalHeaderRoute: ExampleWrap(
    pageBuilder: (context) => global_header_example.GlobalHeaderExample(),
    loader: global_header_example.loadLibrary,
  ),
  listRoute: ExampleWrap(
    pageBuilder: (context) => list_example.ListExample(),
    loader: list_example.loadLibrary,
  ),
  listItemRoute: ExampleWrap(
    pageBuilder: (context) => list_item_example.ListItemExample(),
    loader: list_item_example.loadLibrary,
  ),
  navigationBarRoute: ExampleWrap(
    pageBuilder: (context) => navigation_bar_example.NavigationBarExample(),
    loader: navigation_bar_example.loadLibrary,
  ),
  navigationRailRoute: ExampleWrap(
    pageBuilder: (context) => navigation_rail_example.NavigationRailExample(),
    loader: navigation_rail_example.loadLibrary,
  ),
  notificationListItemRoute: ExampleWrap(
    pageBuilder: (context) => notification_list_example.NotificationListItemExample(),
    loader: notification_list_example.loadLibrary,
  ),
  paginationRoute: ExampleWrap(
    pageBuilder: (context) => pagination_example.PaginationExample(),
    loader: pagination_example.loadLibrary,
  ),
  passwordInputRoute: ExampleWrap(
    pageBuilder: (context) => password_input_example.PasswordInputExample(),
    loader: password_input_example.loadLibrary,
  ),
  phoneInputRoute: ExampleWrap(
    pageBuilder: (context) => phone_input_example.PhoneInputExample(),
    loader: phone_input_example.loadLibrary,
  ),
  progressBarRoute: ExampleWrap(
    pageBuilder: (context) => progress_example.ProgressBarExample(),
    loader: progress_example.loadLibrary,
  ),
  progressCircleRoute: ExampleWrap(
    pageBuilder: (context) => progress_example.ProgressCircleExample(),
    loader: progress_example.loadLibrary,
  ),
  radioButtonRoute: ExampleWrap(
    pageBuilder: (context) => radio_example.RadioButtonExample(),
    loader: radio_example.loadLibrary,
  ),
  rangeSelectorRoute: ExampleWrap(
    pageBuilder: (context) => range_selector_example.RangeSelectorExample(),
    loader: range_selector_example.loadLibrary,
  ),
  screenHeaderBarRoute: ExampleWrap(
    pageBuilder: (context) => screen_header_bar_example.ScreenHeaderBarExample(),
    loader: screen_header_bar_example.loadLibrary,
  ),
  searchBarRoute: ExampleWrap(
    pageBuilder: (context) => search_bar_example.SearchBarExample(),
    loader: search_bar_example.loadLibrary,
  ),
  segmentedControlRoute: ExampleWrap(
    pageBuilder: (context) => segmented_control_example.SegmentedControlExample(),
    loader: segmented_control_example.loadLibrary,
  ),
  selectInputRoute: ExampleWrap(
    pageBuilder: (context) => select_input_example.SelectInputExample(),
    loader: select_input_example.loadLibrary,
  ),
  sliderRoute: ExampleWrap(
    pageBuilder: (context) => slider_example.SliderExample(),
    loader: slider_example.loadLibrary,
  ),
  snackbarRoute: ExampleWrap(
    pageBuilder: (context) => snackbar_example.SnackBarExample(),
    loader: snackbar_example.loadLibrary,
  ),
  stepperRoute: ExampleWrap(
    pageBuilder: (context) => stepper_example.StepperExample(),
    loader: stepper_example.loadLibrary,
  ),
  stepperInputRoute: ExampleWrap(
    pageBuilder: (context) => stepper_input_example.StepperInputExample(),
    loader: stepper_input_example.loadLibrary,
  ),
  switchRoute: ExampleWrap(
    pageBuilder: (context) => switch_example.SwitchExample(),
    loader: switch_example.loadLibrary,
  ),
  tabsRoute: ExampleWrap(
    pageBuilder: (context) => tabs_example.TabsExample(),
    loader: tabs_example.loadLibrary,
  ),
  textInputRoute: ExampleWrap(
    pageBuilder: (context) => text_input_example.TextInputExample(),
    loader: text_input_example.loadLibrary,
  ),
  tileButtonRoute: ExampleWrap(
    pageBuilder: (context) => button_example.TileButtonExample(),
    loader: button_example.loadLibrary,
  ),
  timeInputRoute: ExampleWrap(
    pageBuilder: (context) => time_input_example.TimeInputExample(),
    loader: time_input_example.loadLibrary,
  ),
  tooltipRoute: ExampleWrap(
    pageBuilder: (context) => tooltip_example.TooltipExample(),
    loader: tooltip_example.loadLibrary,
  ),
  topAppBarRoute: ExampleWrap(
    pageBuilder: (context) => top_app_bar_example.TopAppBarExample(),
    loader: top_app_bar_example.loadLibrary,
  ),
  voiceMemoRoute: ExampleWrap(
    pageBuilder: (context) => voice_memo_example.VoiceMemoExample(),
    loader: voice_memo_example.loadLibrary,
  ),
};

final componentRoutes = componentExampleNames.entries.map(
  (e) => GoRoute(
    path: e.key,
    builder: (_, __) => FutureBuilder(
        future: e.value.loader(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (asyncSnapshot.hasError) {
            print('Error loading ${e.key}: ${asyncSnapshot.error}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Failed to load ${e.value}'),
                  SizedBox(height: 8),
                  Text('${asyncSnapshot.error}',
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            );
          }

          if (asyncSnapshot.connectionState == ConnectionState.done) {
            return e.value.pageBuilder.call(_);
          }

          return Center(child: CircularProgressIndicator());
        }),
  ),
);
