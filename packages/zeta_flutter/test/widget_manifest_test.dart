import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/widget_manifest.dart';

void main() {
  test('widget manifest lists the public API and tokens', () {
    final packageRoot = findZetaFlutterPackage(Directory.current);
    final manifest = jsonDecode(generateWidgetManifest(packageRoot)) as Map<String, dynamic>;

    expect(manifest['schemaVersion'], 1);
    expect(manifest['name'], 'zeta_flutter');
    expect(manifest['import'], 'package:zeta_flutter/zeta_flutter.dart');

    final widgets = manifest['widgets'] as List<dynamic>;
    expect(
      widgets.whereType<Map<String, dynamic>>().map((widget) => widget['name']),
      containsAll(<String>['ZetaButton', 'ZetaTextInput', 'ZetaIcon']),
    );

    final tokens = manifest['tokens'] as Map<String, dynamic>;
    expect(tokens['access'], 'Zeta.of(context).tokens');
    final properties = tokens['properties'] as List<dynamic>;
    expect(
      properties.whereType<Map<String, dynamic>>().map((property) => property['name']),
      containsAll(<String>['surface', 'space', 'radius', 'text']),
    );
  });
}
