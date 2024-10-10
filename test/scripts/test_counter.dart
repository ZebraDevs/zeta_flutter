// import 'dart:convert';
// import 'dart:io';

// enum TestGroups {
//   accessibility,
//   content,
//   dimensions,
//   styling,
//   interaction,
//   golden,
//   performance,
// }

// void main() async {
//   final testDirectory = Directory('test/src/components');
//   final outputDirectory = Directory('test/output');
//   if (!outputDirectory.existsSync()) {
//     await outputDirectory.create(recursive: true);
//   }

//   final testFiles =
//       testDirectory.listSync(recursive: true).where((entity) => entity is File && entity.path.endsWith('_test.dart'));
//   final Map<String, Map<String, int>> testCounts = {};

//   for (final FileSystemEntity file in testFiles) {
//     final String content = await File(file.path).readAsString();

//     // final List<String> content = await File(file.path).readAsLines();
//     final Map<String, int> testGroups = _extractTestGroups(content);
//     testCounts[file.path] = testGroups;
//   }

//   final jsonOutput = jsonEncode(testCounts);
//   final outputFile = File('${outputDirectory.path}/test_counts.json');
//   await outputFile.writeAsString(jsonOutput);

//   print('Test counts saved to ${outputFile.path}');
// }

// Map<String, int> _extractTestGroups(String content) {
//   final Map<String, int> testGroups = {};
//   final groupRegex = RegExp(r"group\('([^']+)'");
//   final testRegex = RegExp(r"testWidgets\('([^']+)'");
//   final goldenTestRegex = RegExp(r'goldenTest\(');
//   final debugFillPropertiesRegex = RegExp(r'debugFillPropertiesTests\(');

//   final groupMatches = groupRegex.allMatches(content);
//   for (var groupMatch in groupMatches) {
//     final groupName = groupMatch.group(1);
//     print('groupMatch: $groupMatch');
//     if (groupName != null) {
//       final groupContent = content.substring(groupMatch.end).split('});\r\n  });').first;
//       print('groupContent: $groupName + $groupContent');

//       final testMatches = testRegex.allMatches(groupContent).toList() +
//           goldenTestRegex.allMatches(groupContent).toList() +
//           debugFillPropertiesRegex.allMatches(groupContent).toList();
//       if (!TestGroups.values
//           .map((el) => el.name)
//           .contains(groupName.split('Name').last.trim().split('Tests').first.trim().toLowerCase())) {
//         testGroups['unorganised'] = testMatches.length;
//         return testGroups;
//       }
//       testGroups[groupName.split('Name').last.trim()] = testMatches.length;
//     }
//   }

//   return testGroups;
// }

// void main() async {
//   final outputDirectory = Directory('test/output');
//   if (!outputDirectory.existsSync()) {
//     await outputDirectory.create(recursive: true);
//   }
//   const filePath = 'test/src/components/accordion/accordion_test.dart';
//   final file = File(filePath);
//   final contents = await file.readAsString();
//   final groupRegex = RegExp(r"group\('(.+?)', \(\) \{([\s\S]*?)\}\);", multiLine: true);
//   // final groupRegex = RegExp(r"group\('(.+?)', \(\) \{([\s\S]+?)\}\);", multiLine: true);
//   // final testRegex = RegExp(r"testWidgets\('(.+?)', \((.+?)\) async \{([\s\S]+?)\}\);", multiLine: true);
//   // final testRegex = RegExp(r"testWidgets\('(.+?)', \((.+?)\) async \{([\s\S]*?)\}\);", multiLine: true);
//   final testRegex = RegExp(r"testWidgets\('([^']+)'");

//   final groups = <Map<String, dynamic>>[];

//   for (final groupMatch in groupRegex.allMatches(contents)) {
//     final groupName = groupMatch.group(1);
//     final groupBody = groupMatch.group(0);
//     print('$groupName:::: $groupBody');
//     // final l = groupMatch.group(0);
//     // print('groupMatch: $l');

//     final tests = <Map<String, dynamic>>[];

//     for (final testMatch in testRegex.allMatches(groupBody!)) {
//       final testName = testMatch.group(0);
//       // final testBody = testMatch.group(3);
//       // print('$testName');

//       // final steps = testBody!.split(';').map((step) => step.trim()).where((step) => step.isNotEmpty).toList();

//       tests.add({
//         'name': testName,
//         // 'steps': steps,
//       });
//     }

//     groups.add({
//       'group': groupName,
//       'tests': tests,
//     });
//   }

//   final jsonOutput = jsonEncode(groups);
//   print(jsonOutput);
//   final outputFile = File('${outputDirectory.path}/test_groups.json');
//   await outputFile.writeAsString(jsonOutput);
// }

// void main() async {
//   final outputDirectory = Directory('test/output');
//   if (!outputDirectory.existsSync()) {
//     await outputDirectory.create(recursive: true);
//   }

//   const filePath = 'test/src/components/accordion/accordion_test.dart';
//   final file = File(filePath);
//   final contents = await file.readAsString();

//   final groupRegex = RegExp(r"group\('(.+?)', \(\) \{([\s\S]*?)\}\);", multiLine: true);
//   final testRegex = RegExp(r"testWidgets\('(.+?)', \((.+?)\) async \{([\s\S]*?)\}\);", multiLine: true);

//   final groups = <Map<String, dynamic>>[];

//   for (final groupMatch in groupRegex.allMatches(contents)) {
//     final groupName = groupMatch.group(1);
//     final groupBody = groupMatch.group(2);

//     final tests = <Map<String, dynamic>>[];

//     for (final testMatch in testRegex.allMatches(groupBody!)) {
//       final testName = testMatch.group(1);
//       final testBody = testMatch.group(3);

//       final steps = testBody!
//           .split(';')
//           .map((step) => step.trim())
//           .where((step) => step.isNotEmpty)
//           .toList();

//       tests.add({
//         'name': testName,
//         'steps': steps,
//       });
//     }

//     groups.add({
//       'group': groupName,
//       'tests': tests,
//     });
//   }

//   final jsonOutput = jsonEncode(groups);
//   print(jsonOutput);
// }

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

class TestOutlineVisitor extends RecursiveAstVisitor<void> {
  final List<Map<String, dynamic>> groups = [];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == 'group') {
      final groupName = node.argumentList.arguments.first.toString();
      final groupBody = node.argumentList.arguments.last;

      final tests = <Map<String, dynamic>>[];

      if (groupBody is FunctionExpression) {
        final body = groupBody.body;
        if (body is BlockFunctionBody) {
          body.block.visitChildren(TestVisitor(tests));
        }
      }

      groups.add({
        'group': groupName,
        'tests': tests,
      });
    }
    super.visitMethodInvocation(node);
  }
}

class TestVisitor extends RecursiveAstVisitor<void> {
  TestVisitor(this.tests);

  final List<Map<String, dynamic>> tests;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == 'testWidgets') {
      final testName = node.argumentList.arguments.first.toString();

      tests.add({
        'name': testName,
      });
    }
    super.visitMethodInvocation(node);
  }
}

void main() async {
  final outputDirectory = Directory('test/output');
  if (!outputDirectory.existsSync()) {
    await outputDirectory.create(recursive: true);
  }
  final testDirectory = Directory('test/src/components');
  final testFiles =
      testDirectory.listSync(recursive: true).where((entity) => entity is File && entity.path.endsWith('_test.dart'));
  final Map<String, List<Map<String, dynamic>>> testGroups = {};

  for (final FileSystemEntity file in testFiles) {
    final contents = await File(file.path).readAsString();

    final parseResult = parseString(content: contents);
    final visitor = TestOutlineVisitor();
    parseResult.unit.visitChildren(visitor);
    testGroups[file.path] = visitor.groups;
  }

  final jsonOutputGroups = jsonEncode(testGroups);
  final outputFileGroups = File('${outputDirectory.path}/test_groups.json');
  await outputFileGroups.writeAsString(jsonOutputGroups);

  final Map<String, Map<String, int>> testCount = {};

  testGroups.forEach((filePath, groups) {
    final Map<String, int> groupCounts = {};
    for (final group in groups) {
      final groupName = group['group'] as String;
      final tests = group['tests'] as List;
      groupCounts[groupName] = tests.length;
    }
    testCount[filePath] = groupCounts;
  });
  final jsonOutput = jsonEncode(testCount);
  print(jsonOutput);
  final outputFile = File('${outputDirectory.path}/test_counts.json');
  await outputFile.writeAsString(jsonOutput);
}
