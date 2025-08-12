import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/introduction.dart';
import 'package:zeta_widgetbook/main.directories.g.dart';
import 'package:zeta_widgetbook/src/utils/zebra_devices.dart';
import 'package:zeta_widgetbook/src/utils/zeta_addon.dart';

const componentsPath = 'Components';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var response = '';
  try {
    response = (await http.get(
            Uri.parse('https://raw.githubusercontent.com/ZebraDevs/zeta_flutter/main/packages/zeta_flutter/README.md')))
        .body;
  } catch (e) {
    debugPrint('Can not read readme');
  } finally {
    runApp(WidgetbookApp(readme: response));
  }
}

@widgetbook.App(cloudAddonsConfigs: {})
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
        ViewportAddon([
          Viewports.none,
          WindowsViewports.desktop,
          MacosViewports.macbookPro,
          IosViewports.iPad,
          IosViewports.iPhone13,
          AndroidViewports.samsungGalaxyS20,
          ZebraViewports.ec30,
          ZebraViewports.ec50,
        ]),
        InspectorAddon(),
        ZoomAddon(),
        TextScaleAddon(min: 1, max: 2.5, initialScale: 1),
        ZetaAddon(ZetaAddonData()),
        SemanticsAddon(),
      ],
    );
  }
}
