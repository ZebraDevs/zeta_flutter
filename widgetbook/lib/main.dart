import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:http/http.dart' as http;
import 'package:zeta_widgetbook/introduction.widgetbook.dart';
import 'package:zeta_widgetbook/src/utils/zebra_devices.widgetbook.dart';
import 'package:zeta_widgetbook/src/utils/zeta_addon.widgetbook.dart';

import 'main.directories.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String response = '';
  try {
    response =
        (await http.get(Uri.parse('https://raw.githubusercontent.com/ZebraDevs/zeta_flutter/main/README.md'))).body;
  } catch (e) {
    debugPrint('Can not read readme');
  } finally {
    runApp(WidgetbookApp(readme: response));
  }
}

@widgetbook.App()
class WidgetbookApp extends StatefulWidget {
  final String readme;

  const WidgetbookApp({super.key, required this.readme});

  @override
  State<WidgetbookApp> createState() => _WidgetbookAppState();
}

class _WidgetbookAppState extends State<WidgetbookApp> {
  closeAddonsPanel(_) async {
    final renderObj = context.findRenderObject();
    final size = MediaQuery.of(context).size;
    if (size.width > 799) {
      if (renderObj is RenderBox) {
        await Future.delayed(const Duration(milliseconds: 10));
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
      directories: [
        WidgetbookUseCase(
          name: 'Introduction',
          builder: (BuildContext context) => IntroductionWidgetbook(readme: widget.readme),
        ),
        ...directories
      ],
      appBuilder: (context, child) => Builder(builder: (context) {
        return child;
        // return ColoredBox(color: Zeta.of(context).colors.surfaceDefault, child: child);
      }),
      // lightTheme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: themeMode,
      initialRoute: '?path=introduction',
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
        TextScaleAddon(scales: [1.0, 1.2, 1.4, 1.6, 1.8, 2.0], initialScale: 1),
      ],
    );
  }
}
