import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

extension Util on DiagnosticPropertiesBuilder {
  dynamic finder(String finder) {
    return properties.where((p) => p.name == finder).map((p) => p.toDescription()).firstOrNull;
  }

  dynamic findProperty(String propertyName) {
    return properties.firstWhereOrNull((p) => p.name == propertyName)?.value;
  }
}

class GoldenFinder {
  const GoldenFinder({required this.component, this.type = 'components'});

  final String component;
  final String type;

  Uri get uri => getFileUri('');

  Uri getFileUri(String fileName) {
    return Uri.parse(join(Directory.current.path, 'test', 'src', type, component, 'golden', fileName))
        .replace(scheme: 'file');
  }
}
