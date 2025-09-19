import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_app.dart';

export 'test_app.dart';
export 'tolerant_comparator.dart';

/// Extensions used for testing [debugFillPropertiesTest].
@visibleForTesting
extension Util on DiagnosticPropertiesBuilder {
  /// Find a property by its name.
  dynamic finder(String finder) {
    return properties.where((p) => p.name == finder).map((p) => p.toDescription()).firstOrNull;
  }

  /// Find a property by its name.
  dynamic findProperty(String propertyName) {
    return properties.firstWhereOrNull((p) => p.name == propertyName)?.value;
  }
}

/// Golden files helper.
@visibleForTesting
class GoldenFiles {
  /// Constructs a [GoldenFiles] instance.
  const GoldenFiles({required this.component, this.type = 'components'});

  /// The component name.
  final String component;

  /// The type of component.
  final String type;

  /// The golden file uri.
  Uri get uri => getFileUri('');

  /// Gets the file uri.
  Uri getFileUri(String fileName) {
    return Uri.parse(join(Directory.current.path, 'test', 'src', type, component, 'golden', '$fileName.png'))
        .replace(scheme: 'file');
  }
}

/// Golden test helper.
@visibleForTesting
void goldenTest(
  GoldenFiles goldenFile,
  Widget widget,
  String fileName, {
  Type? widgetType,
  ThemeMode themeMode = ThemeMode.system,
  Size? screenSize,
  bool? rounded,
  bool loadFont = false,
  Future<void> Function(WidgetTester)? setUp,
  Future<void> Function(WidgetTester)? beforeComparison,
}) {
  testWidgets('$fileName golden', (WidgetTester tester) async {
    if (screenSize != null) {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = screenSize;
      addTearDown(tester.view.resetPhysicalSize);
    }

    final computedType = widgetType ?? widget.runtimeType;
    if (setUp != null) {
      await setUp(tester);
    }
    if (loadFont) {
      await loadFonts();
    }
    await tester.pumpWidget(
      TestApp(
        screenSize: screenSize,
        themeMode: themeMode,
        rounded: rounded,
        home: widget,
      ),
    );

    if (beforeComparison != null) {
      await beforeComparison(tester);
    }

    await expectLater(
      find.byType(computedType),
      matchesGoldenFile(goldenFile.getFileUri(fileName)),
    );
  });
}

/// Golden test helper.
@visibleForTesting
BuildContext getBuildContext(WidgetTester tester, Type type) {
  return tester.element(find.byType(type));
}

/// `debugFillProperties` test helper.
@visibleForTesting
void debugFillPropertiesTest(Widget widget, Map<String, dynamic> properties) {
  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    widget.debugFillProperties(diagnostics);
    debugPrint(diagnostics.properties.toString());
    properties.forEach((key, value) {
      try {
        final found = diagnostics.finder(key);
        expect(found, value);
      } catch (e) {
        debugPrint('Error on $key');
        rethrow;
      }
    });
  });
}

/// Accessibility test helper.
@visibleForTesting
void meetsAccessibilityGuidelinesTest(
  Widget widget, {
  Size? screenSize,
  bool? rounded,
  Future<void> Function(WidgetTester)? setUp,
  Future<void> Function(WidgetTester)? beforeTest,
  String? testName,
}) {
  for (final contrast in [ZetaContrast.aa, ZetaContrast.aaa]) {
    for (final themeMode in [ThemeMode.light, ThemeMode.dark]) {
      testWidgets('meets accessibility requirements $testName ${themeMode.name} ${contrast.name} ',
          (WidgetTester tester) async {
        if (screenSize != null) {
          tester.view.devicePixelRatio = 1.0;
          tester.view.physicalSize = screenSize;
          addTearDown(tester.view.resetPhysicalSize);
        }
        final SemanticsHandle handle = tester.ensureSemantics();
        if (setUp != null) {
          await setUp(tester);
        }
        await tester.pumpWidget(
          TestApp(
            screenSize: screenSize,
            themeMode: themeMode,
            rounded: rounded,
            home: widget,
            contrast: contrast,
          ),
        );

        if (beforeTest != null) {
          await beforeTest(tester);
        }

        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        if (contrast == ZetaContrast.aa) {
          await expectLater(tester, meetsGuideline(textContrastGuideline));
        } else {
          await expectLater(tester, meetsGuideline(const MinimumTextContrastGuidelineAAA()));
        }

        handle.dispose();
      });
    }
  }
}

@visibleForTesting
Future<void> loadFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final ibmPlexSans = FontLoader('packages/zeta_flutter_theme/IBMPlexSans')
    ..addFont(rootBundle.load('packages/zeta_flutter_theme/assets/fonts/IBMPlexSans-Light.otf'))
    ..addFont(rootBundle.load('packages/zeta_flutter_theme/assets/fonts/IBMPlexSans-Regular.otf'))
    ..addFont(rootBundle.load('packages/zeta_flutter_theme/assets/fonts/IBMPlexSans-Medium.otf'));
  await ibmPlexSans.load();
  final zetaIcons = FontLoader('packages/zeta_icons/zeta-icons')
    ..addFont(rootBundle.load('packages/zeta_icons/lib/assets/icons/zeta-icons-round.ttf'))
    ..addFont(rootBundle.load('packages/zeta_icons/lib/assets/icons/zeta-icons-sharp.ttf'));
  await zetaIcons.load();
}
