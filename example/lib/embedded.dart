import 'package:flutter/material.dart';
import 'package:zeta_example/main.dart';
import 'package:zeta_example/utils/interop.dart';
import 'package:zeta_example/utils/multi_view_app.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runWidget(MultiViewApp(
    viewBuilder: (BuildContext context) {
      final int viewId = View.of(context).viewId;
      final InitialData? data = InitialData.forView(viewId);

      return ZetaExample(
        initialThemeMode: (data?.darkMode ?? false) ? ThemeMode.dark : ThemeMode.light,
        initialContrast: (data?.highContrast ?? false) ? ZetaContrast.aaa : ZetaContrast.aa,
        initialRoute: data?.route ?? '',
      );
    },
  ));
}
