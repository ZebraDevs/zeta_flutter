import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_utils/test_app.dart';

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

void goldenTest(GoldenFiles goldenFile, Widget widget, Type widgetType, String fileName, {bool darkMode = false}) {
  testWidgets('$fileName golden', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestApp(
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        home: widget,
      ),
    );

    await expectLater(
      find.byType(widgetType),
      matchesGoldenFile(goldenFile.getFileUri(fileName)),
    );
  });
}

BuildContext getBuildContext(WidgetTester tester, Type type) {
  return tester.element(find.byType(type));
}
