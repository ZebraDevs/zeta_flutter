import 'dart:io';

import 'widget_manifest.dart';

void main(List<String> args) {
  final start = args.isEmpty ? Directory.current : Directory(args.first);
  final packageRoot = findZetaFlutterPackage(start);
  final json = generateWidgetManifest(packageRoot);
  final outputPath = '${packageRoot.path}${Platform.pathSeparator}widget-manifest.json';
  File(outputPath).writeAsStringSync(json);
  stdout.writeln('Wrote $outputPath (${json.length} bytes)');
}
