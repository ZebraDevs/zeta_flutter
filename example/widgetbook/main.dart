import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import 'pages/assets/icon_widgetbook.dart';
import 'pages/components/accordion_widgetbook.dart';
import 'pages/components/dropdown_list_item_widgetbook.dart';
import 'pages/components/notification_list_item_widgetbook.dart';
import 'pages/components/slider_widgetbook.dart';
import 'pages/components/text_input_widgetbook.dart';
import 'pages/components/top_app_bar_widgetbook.dart';
import 'pages/components/avatar_rail_widgetbook.dart';
import 'pages/components/avatar_widgetbook.dart';
import 'pages/components/badges_widgetbook.dart';
import 'pages/components/banner_widgetbook.dart';
import 'pages/components/bottom_sheet_widgetbook.dart';
import 'pages/components/breadcrumb_widgetbook.dart';
import 'pages/components/button_widgetbook.dart';
import 'pages/components/chat_item_widgetbook.dart';
import 'pages/components/checkbox_widgetbook.dart';
import 'pages/components/chip_widgetbook.dart';
import 'pages/components/comms_button_widgetbook.dart';
import 'pages/components/contact_item_widgetbook.dart';
import 'pages/components/date_input_widgetbook.dart';
import 'pages/components/dial_pad_widgetbook.dart';
import 'pages/components/dialog_widgetbook.dart';
import 'pages/components/dropdown_widgetbook.dart';
import 'pages/components/global_header_widgetbook.dart';
import 'pages/components/filter_selection_widgetbook.dart';
import 'pages/components/in_page_banner_widgetbook.dart';
import 'pages/components/list_item_widgetbook.dart';
import 'pages/components/navigation_bar_widgetbook.dart';
import 'pages/components/navigation_rail_widgetbook.dart';
import 'pages/components/pagination_widgetbook.dart';
import 'pages/components/password_input_widgetbook.dart';
import 'pages/components/phone_input_widgetbook.dart';
import 'pages/components/progress_widgetbook.dart';
import 'pages/components/radio_widgetbook.dart';
import 'pages/components/range_selector_widgetbook.dart';
import 'pages/components/screen_header_bar_widgetbook.dart';
import 'pages/components/search_bar_widgetbook.dart';
import 'pages/components/segmented_control_widgetbook.dart';
import 'pages/components/select_input_widgetbook.dart';
import 'pages/components/stepper_input_widgetbook.dart';
import 'pages/components/stepper_widgetbook.dart';
import 'pages/components/switch_widgetbook.dart';
import 'pages/components/snack_bar_widgetbook.dart';
import 'pages/components/tabs_widgetbook.dart';
import 'pages/components/time_input_widgetbook.dart';
import 'pages/components/tooltip_widgetbook.dart';
import 'pages/introduction.dart';
import 'pages/theme/color_widgetbook.dart';
import 'pages/theme/radius_widgetbook.dart';
import 'pages/theme/spacing_widgetbook.dart';
import 'pages/theme/typography_widgetbook.dart';
import 'utils/zebra.dart';
import 'package:http/http.dart' as http;
import 'utils/zeta_addon.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String response = '';
  try {
    response =
        (await http.get(Uri.parse('https://raw.githubusercontent.com/ZebraDevs/zeta_flutter/main/README.md'))).body;
  } catch (e) {
    debugPrint('Can not read readme');
  } finally {
    runApp(HotReload(readme: response));
  }
}

class HotReload extends StatefulWidget {
  final String readme;
  const HotReload({super.key, required this.readme});

  @override
  State<HotReload> createState() => _HotReloadState();
}

class _HotReloadState extends State<HotReload> {
  closeAddonsPanel(_) async {
    final renderObj = context.findRenderObject();
    final size = MediaQuery.of(context).size;
    if (size.width > 799) {
      if (renderObj is RenderBox) {
        await Future.delayed(Duration(milliseconds: 10));
        final pos = Offset(size.width - 50, 10);
        final hitTestResult = BoxHitTestResult();
        renderObj.hitTest(hitTestResult, position: pos);
        final entry = hitTestResult.path.firstWhere((e) => e is BoxHitTestEntry) as BoxHitTestEntry;
        final event1 = PointerDownEvent(position: pos);
        final event2 = PointerUpEvent(position: pos);

        GestureBinding.instance
          ..dispatchEvent(event1, hitTestResult)
          ..dispatchEvent(event2, hitTestResult)
          ..handleEvent(event1, entry)
          ..handleEvent(event2, entry);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(closeAddonsPanel);
  }

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appBuilder: (context, child) => child,
      initialRoute: '?path=introduction',
      directories: [
        WidgetbookUseCase(
          name: 'Introduction',
          builder: (BuildContext context) => IntroductionWidgetbook(readme: widget.readme),
        ),
        WidgetbookCategory(
          name: 'Components',
          isInitiallyExpanded: false,
          children: [
            WidgetbookComponent(
              name: 'Avatar',
              useCases: [
                WidgetbookUseCase(name: 'Avatar', builder: (context) => avatarUseCase(context)),
                WidgetbookUseCase(name: 'Avatar Rail', builder: (context) => avatarRailUseCase(context)),
              ],
            ),
            WidgetbookComponent(
              name: 'Top App Bar',
              useCases: [
                WidgetbookUseCase(name: 'Default', builder: (context) => defaultTopAppBarUseCase(context)),
                WidgetbookUseCase(name: 'Search', builder: (context) => searchTopAppBarUseCase(context)),
                WidgetbookUseCase(name: 'Extended', builder: (context) => extendedTopAppBarUseCase(context)),
              ],
            ),
            WidgetbookComponent(
              name: 'Badge',
              useCases: [
                WidgetbookUseCase(name: 'Status Label', builder: (context) => statusLabelUseCase(context)),
                WidgetbookUseCase(name: 'Priority Pill', builder: (context) => priorityPillUseCase(context)),
                WidgetbookUseCase(name: 'Label', builder: (context) => labelUseCase(context)),
                WidgetbookUseCase(name: 'Indicators', builder: (context) => indicatorsUseCase(context)),
                WidgetbookUseCase(name: 'Tags', builder: (context) => tagsUseCase(context)),
              ],
            ),
            WidgetbookComponent(
              name: 'Buttons',
              useCases: [
                WidgetbookUseCase(name: 'Button', builder: (context) => buttonUseCase(context)),
                WidgetbookUseCase(name: 'Icon Button', builder: (context) => iconButtonUseCase(context)),
                WidgetbookUseCase(
                    name: 'Floating Action Button', builder: (context) => floatingActionButtonUseCase(context)),
                WidgetbookUseCase(name: 'Group Button', builder: (context) => buttonGroupUseCase(context)),
              ],
            ),
            WidgetbookComponent(
              name: 'Chips',
              useCases: [
                WidgetbookUseCase(name: 'Filter Chip', builder: (context) => filterChipUseCase(context)),
                WidgetbookUseCase(name: 'Input Chip', builder: (context) => inputChipUseCase(context)),
                WidgetbookUseCase(name: 'Assist Chip', builder: (context) => assistChipUseCase(context)),
                WidgetbookUseCase(name: 'Status Chip', builder: (context) => statusChipUseCase(context)),
              ],
            ),
            WidgetbookComponent(
              name: 'Progress',
              useCases: [
                WidgetbookUseCase(name: 'Bar', builder: (context) => progressBarUseCase(context)),
                WidgetbookUseCase(name: 'Circle', builder: (context) => progressCircleUseCase(context))
              ],
            ),
            WidgetbookComponent(
              name: 'List Items',
              useCases: [
                WidgetbookUseCase(name: 'List Item', builder: (context) => listItemUseCase(context)),
                WidgetbookUseCase(
                  name: 'Dropdown List Item',
                  builder: (context) => dropdownListItemUseCase(context),
                ),
                WidgetbookUseCase(
                  name: 'Notification List Item',
                  builder: (context) => notificationListItemUseCase(context),
                ),
                WidgetbookUseCase(name: 'Contact Item', builder: (context) => contactItemUseCase(context)),
                WidgetbookUseCase(name: 'Chat List Item', builder: (context) => chatItemWidgetBook(context)),
              ],
            ),
            WidgetbookUseCase(name: 'Accordion', builder: (context) => accordionUseCase(context)),
            WidgetbookUseCase(name: 'Banners', builder: (context) => bannerUseCase(context)),
            WidgetbookUseCase(name: 'Bottom Sheet', builder: (context) => bottomSheetContentUseCase(context)),
            WidgetbookUseCase(name: 'Breadcrumb', builder: (context) => breadcrumbUseCase(context)),
            WidgetbookUseCase(name: 'Checkbox', builder: (context) => checkboxUseCase(context)),
            WidgetbookUseCase(name: 'Comms Button', builder: (context) => commsButtonUseCase(context)),
            WidgetbookUseCase(name: 'Date Input', builder: (context) => dateInputUseCase(context)),
            WidgetbookUseCase(name: 'Dial Pad', builder: (context) => dialPadUseCase(context)),
            WidgetbookUseCase(name: 'Dialog', builder: (context) => dialogUseCase(context)),
            WidgetbookUseCase(name: 'Filter Selection', builder: (context) => filterSelectionUseCase(context)),
            WidgetbookUseCase(name: 'Global Header', builder: (context) => globalHeaderUseCase(context)),
            WidgetbookUseCase(name: 'In Page Banners', builder: (context) => inPageBannerUseCase(context)),
            WidgetbookUseCase(name: 'Navigation Bar', builder: (context) => navigationBarUseCase(context)),
            WidgetbookUseCase(name: 'Navigation Rail', builder: (context) => navigationRailUseCase(context)),
            WidgetbookUseCase(name: 'Pagination', builder: (context) => paginationUseCase(context)),
            WidgetbookUseCase(name: 'Password Input', builder: (context) => passwordInputUseCase(context)),
            WidgetbookUseCase(name: 'Phone Input', builder: (context) => phoneInputUseCase(context)),
            WidgetbookUseCase(name: 'Radio Button', builder: (context) => radioButtonUseCase(context)),
            WidgetbookUseCase(name: 'Screen Header Bar', builder: (context) => screenHeaderBarUseCase(context)),
            WidgetbookUseCase(name: 'Search Bar', builder: (context) => searchBarUseCase(context)),
            WidgetbookUseCase(name: 'Segmented Control', builder: (context) => segmentedControlUseCase(context)),
            WidgetbookUseCase(name: 'Select Input', builder: (context) => selectInputUseCase(context)),
            WidgetbookUseCase(name: 'Slider', builder: (context) => sliderUseCase(context)),
            WidgetbookUseCase(name: 'Range Selector', builder: (context) => rangeSelectorUseCase(context)),
            WidgetbookUseCase(name: 'Snack Bar', builder: (context) => snackBarUseCase(context)),
            WidgetbookUseCase(name: 'Stepper Input', builder: (context) => stepperInputUseCase(context)),
            WidgetbookUseCase(name: 'Stepper', builder: (context) => stepperUseCase(context)),
            WidgetbookUseCase(name: 'Switch', builder: (context) => switchUseCase(context)),
            WidgetbookUseCase(name: 'Tabs', builder: (context) => tabsUseCase(context)),
            WidgetbookUseCase(name: 'Text Input', builder: (context) => textInputUseCase(context)),
            WidgetbookUseCase(name: 'Time Input', builder: (context) => timeInputUseCase(context)),
            WidgetbookUseCase(name: 'Tooltip', builder: (context) => tooltipUseCase(context)),
            WidgetbookUseCase(name: "Dropdown", builder: (context) => dropdownUseCase(context)),
          ]..sort((a, b) => a.name.compareTo(b.name)),
        ),
        WidgetbookCategory(
          name: 'Theme',
          isInitiallyExpanded: false,
          children: [
            WidgetbookUseCase(name: 'Typography', builder: (context) => typographyUseCase(context)),
            WidgetbookUseCase(name: 'Color', builder: (context) => colorUseCase(context)),
            WidgetbookUseCase(name: 'Spacing', builder: (context) => spacingUseCase(context)),
            WidgetbookUseCase(name: 'Radius', builder: (context) => radiusUseCase(context)),
          ]..sort((a, b) => a.name.compareTo(b.name)),
        ),
        WidgetbookCategory(
          name: 'Assets',
          isInitiallyExpanded: false,
          children: [
            WidgetbookUseCase(name: 'Icons', builder: (context) => iconsUseCase(context)),
          ]..sort((a, b) => a.name.compareTo(b.name)),
        ),
      ],
      addons: [
        DeviceFrameAddon(
          devices: [
            Devices.windows.wideMonitor,
            Devices.ios.iPad,
            Devices.ios.iPhone13,
            Zebra.ec30,
            Zebra.ec50,
          ],
        ),
        ZetaAddon(),
        InspectorAddon(enabled: false),
        ZoomAddon(initialZoom: 1.0),
        TextScaleAddon(min: 1, max: 2, divisions: 4, initialScale: 1),
      ],
    );
  }
}
