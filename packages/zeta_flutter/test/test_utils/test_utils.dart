import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

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
  Future<void> Function(WidgetTester)? setUp,
  Future<void> Function(WidgetTester)? beforeComparison,
}) {
  testWidgets('$fileName golden', (WidgetTester tester) async {
    final computedType = widgetType ?? widget.runtimeType;
    if (setUp != null) {
      await setUp(tester);
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
void meetsAccessabilityGuidelinesTest(
  Widget widget, {
  ThemeMode themeMode = ThemeMode.system,
  Size? screenSize,
  bool? rounded,
  Future<void> Function(WidgetTester)? setUp,
  Future<void> Function(WidgetTester)? beforeTest,
}) {
  testWidgets('meets accessibility requirements', (WidgetTester tester) async {
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
      ),
    );

    if (beforeTest != null) {
      await beforeTest(tester);
    }

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));

    handle.dispose();
  });
}
