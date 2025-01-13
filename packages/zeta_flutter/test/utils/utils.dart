import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

import 'test_app.dart';

extension Util on DiagnosticPropertiesBuilder {
  dynamic finder(String finder) {
    return properties.where((p) => p.name == finder).map((p) => p.toDescription()).firstOrNull;
  }

  dynamic findProperty(String propertyName) {
    return properties.firstWhereOrNull((p) => p.name == propertyName)?.value;
  }
}

class GoldenFiles {
  const GoldenFiles({required this.component, this.type = 'components'});

  final String component;
  final String type;

  Uri get uri => getFileUri('');

  Uri getFileUri(String fileName) {
    return Uri.parse(join(Directory.current.path, 'test', 'src', type, component, 'golden', '$fileName.png'))
        .replace(scheme: 'file');
  }
}

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

BuildContext getBuildContext(WidgetTester tester, Type type) {
  return tester.element(find.byType(type));
}

void debugFillPropertiesTest(Widget widget, Map<String, dynamic> properties) {
  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    widget.debugFillProperties(diagnostics);

    properties.forEach((key, value) {
      try {
        expect(diagnostics.finder(key), value);
      } catch (e) {
        debugPrint('Error on $key');
        rethrow;
      }
    });
  });
}

void meetsAccessbilityGuidelinesTest(
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
