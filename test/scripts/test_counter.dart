import 'dart:convert';
import 'dart:io';

enum TestGroups {
  accessibility,
  content,
  dimensions,
  styling,
  interaction,
  golden,
  performance,
}

void main() async {
  final testDirectory = Directory('test/src/components');
  final outputDirectory = Directory('test/output');
  if (!outputDirectory.existsSync()) {
    await outputDirectory.create(recursive: true);
  }

  final testFiles =
      testDirectory.listSync(recursive: true).where((entity) => entity is File && entity.path.endsWith('_test.dart'));
  final Map<String, Map<String, int>> testCounts = {};

  for (final FileSystemEntity file in testFiles) {
    final String content = await File(file.path).readAsString();
    final Map<String, int> testGroups = _extractTestGroups(content);
    testCounts[file.path] = testGroups;
  }

  final jsonOutput = jsonEncode(testCounts);
  final outputFile = File('${outputDirectory.path}/test_counts.json');
  await outputFile.writeAsString(jsonOutput);

  print('Test counts saved to ${outputFile.path}');
}

Map<String, int> _extractTestGroups(String content) {
  final Map<String, int> testGroups = {};
  final groupRegex = RegExp(r"group\('([^']+)'");
  final testRegex = RegExp(r"testWidgets\('([^']+)'");
  final goldenTestRegex = RegExp(r'goldenTest\(');
  final debugFillPropertiesRegex = RegExp(r'debugFillPropertiesTests\(');

  final groupMatches = groupRegex.allMatches(content);
  for (var groupMatch in groupMatches) {
    final groupName = groupMatch.group(1);
    print('groupMatch: $groupMatch');
    if (groupName != null) {
      final groupContent = content.substring(groupMatch.end).split('group(').first;
      print('groupContent: $groupContent');

      final testMatches = testRegex.allMatches(groupContent).toList() +
          goldenTestRegex.allMatches(groupContent).toList() +
          debugFillPropertiesRegex.allMatches(groupContent).toList();
      if (!TestGroups.values
          .map((el) => el.name)
          .contains(groupName.split('Name').last.trim().split('Tests').first.trim().toLowerCase())) {
        testGroups['unorganised'] = testMatches.length;
        return testGroups;
      }
      testGroups[groupName.split('Name').last.trim()] = testMatches.length;
    }
  }

  return testGroups;
}
