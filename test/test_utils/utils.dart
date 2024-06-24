import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

String getCurrentPath(String component, {String type = 'components'}) {
  return join(Directory.current.path, 'test', 'src', type, component, 'golden');
}

extension Util on DiagnosticPropertiesBuilder {
  dynamic finder(String finder) {
    return properties.where((p) => p.name == finder).map((p) => p.toDescription()).first;
  }
}
