import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/introduction.widgetbook.dart';
import 'package:zeta_widgetbook/main.directories.g.dart';
import 'package:zeta_widgetbook/src/utils/zebra_devices.widgetbook.dart';
import 'package:zeta_widgetbook/src/utils/zeta_addon.widgetbook.dart';

const componentsPath = 'Components';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var response = '';
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
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key, required this.readme});
  final String readme;

  @override
  Widget build(BuildContext context) {
    const semanticsLight = ZetaColorsAA(primitives: ZetaPrimitivesLight());
    const semanticsDark = ZetaColorsAA(primitives: ZetaPrimitivesDark());
    return Widgetbook(
      directories: [
        WidgetbookUseCase(
          name: 'Introduction',
          builder: (BuildContext context) => IntroductionWidgetbook(readme: readme),
        ),
        ...directories,
      ],
      lightTheme: ThemeData(
        fontFamily: kZetaFontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: semanticsLight.mainPrimary,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: kZetaFontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: semanticsDark.mainPrimary,
          brightness: Brightness.dark,
          primary: semanticsDark.mainPrimary,
        ),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: '?path=introduction',
      appBuilder: (context, child) => child,
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
        InspectorAddon(),
        ZoomAddon(),
        TextScaleAddon(min: 1, max: 2.5, initialScale: 1),
        ZetaAddon(),
      ],
    );
  }
}
