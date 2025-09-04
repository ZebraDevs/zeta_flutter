// Print allowed as this is a
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'utils.dart';

const testCategories = [
  'Accessibility',
  'Content',
  'Dimensions',
  'Styling',
  'Interaction',
  'Golden',
  'Performance',
  'Unorganised',
];

/// A visitor that recursively visits AST nodes to identify and process test groups.
///
/// This class extends `RecursiveAstVisitor<void>` and overrides necessary methods
/// to traverse the abstract syntax tree (AST) of Dart code. It is specifically
/// designed to locate and handle test groups within the code, which are typically
/// defined using the `group` function in test files.
///
/// By implementing this visitor, you can analyze the structure of your test files,
/// extract information about test groups, and perform any required operations on them.
/// This can be useful for generating reports, performing static analysis, or
/// automating certain tasks related to your test suite.
class TestGroupVisitor extends RecursiveAstVisitor<void> {
  /// A list of maps containing test group names and their corresponding tests.
  final List<Map<String, dynamic>> groups = [];

  /// Visits a method invocation node in the abstract syntax tree (AST).
  ///
  /// This method is typically used in the context of traversing or analyzing
  /// Dart code. It processes a [MethodInvocation] node, which represents
  /// a method call in the source code.
  ///
  /// [node] - The [MethodInvocation] node to visit.
  /// The method checks if the method invocation is one of the following:
  /// - `group`
  /// - `testWidgets`
  /// - `test`
  /// - `goldenTest`
  /// - `debugFillPropertiesTest`
  /// Then it extracts the group name and test names from the method invocation.
  ///
  /// - Parameter node: The [MethodInvocation] node to visit.
  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.hasNullParentNode()) {
      if (node.methodIsOneOf(['group'])) {
        final groupName = node.getGroupName();
        final groupBody = node.argumentList.arguments.last;

        final tests = <Map<String, dynamic>>[];

        if (groupBody is FunctionExpression) {
          final body = groupBody.body;
          if (body is BlockFunctionBody) {
            body.block.visitChildren(TestVisitor(tests));
          }
        }

        groups.add({'group': groupName, 'tests': tests});
      } else if (node.methodIsOneOf(['testWidgets', 'test', 'goldenTest', 'debugFillPropertiesTest'])) {
        final testName = node.getTestName();

        if (groups.any((el) => el['group'] == 'unorganised')) {
          final unorganisedGroup = groups.firstWhere((el) => el['group'] == 'unorganised');
          (unorganisedGroup['tests'] as List).add({'name': testName});
        } else {
          groups.add({
            'group': 'unorganised',
            'tests': [
              {'name': testName},
            ],
          });
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}

/// A visitor class that extends `RecursiveAstVisitor<void>` to traverse
/// the Abstract Syntax Tree (AST) of Dart code. This class is specifically
/// designed to extract test names from test files.
///
/// The `TestVisitor` class overrides necessary methods to visit nodes
/// in the AST and identify test definitions. It collects the names of
/// the tests, which can then be used for various purposes such as
/// generating test reports or running specific tests.
///
class TestVisitor extends RecursiveAstVisitor<void> {
  /// Creates a new instance of the `TestVisitor` class.
  const TestVisitor(this.tests);

  /// A list of maps containing test names and their corresponding data.
  final List<Map<String, dynamic>> tests;

  /// Visits a method invocation node in the abstract syntax tree (AST).
  /// This method checks if the method invocation is one of the following:
  /// - `testWidgets`
  /// - `test`
  /// - `goldenTest`
  /// - `debugFillPropertiesTest`
  /// Then it extracts the test name from the method invocation.
  ///
  /// [node] - The [MethodInvocation] node to visit.
  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodIsOneOf(['testWidgets', 'test'])) {
      final testName = node.getTestName();
      tests.add({'name': testName});
    } else if (node.methodIsOneOf(['debugFillPropertiesTest'])) {
      tests.add({'name': node.getMethodName()});
    } else if (node.methodIsOneOf(['goldenTest'])) {
      tests.add({'name': node.toString()});
    }

    super.visitMethodInvocation(node);
  }
}

/// Generates an MD (Markdown) table representation of the test counts.
///
/// The function takes a nested map where the outer map's keys are test group names,
/// and the inner map's keys are test names with their corresponding integer counts.
///
/// Example input:
/// ```dart
/// {
/// "test/src/components\\banner\\banner_test.dart": {
///   "Accessibility": 3,
///   },
/// }
/// ```
///
/// Example output:
/// ```md
/// | Component   | Accessibility | Content | Dimensions | Styling | Interaction | Golden | Performance | Unorganised | Total Tests |
/// | ----------- | ------------- | ------- | ---------- | ------- | ----------- | ------ | ----------- | ----------- | ----------- |
/// | Banner      | 3             | 0       | 0          | 0       | 0           | 0      | 0           | 0           | 3           |
/// | Total Tests | 3             | 0       | 0          | 0       | 0           | 0      | 0           | 0           | 3           |
/// ```
///
/// Parameters:
/// - `testCount`: A map where the keys are test group names and the values are maps
///   of test names with their corresponding counts.
///
/// Returns:
/// - A string in MD format representing the test counts in a table with totals.
/// Generates an MD (Markdown) table representation of the test counts, including components with no tests.
///
/// [testCount] is a map of test file paths to group counts.
/// [allComponentNames] is a set of all component names (from lib/src/components).
String generateMD(Map<String, Map<String, int>> testCount, Set<String> allComponentNames, String date, String version) {
  final Map<String, int> groupTotals = {
    'Accessibility': 0,
    'Content': 0,
    'Dimensions': 0,
    'Styling': 0,
    'Interaction': 0,
    'Golden': 0,
    'Performance': 0,
    'unorganised': 0,
  };

  String formatComponentName(String filePath) {
    final match = RegExp(r'([^/\\]+)_test\\.dart').firstMatch(filePath);

    return match != null
        ? match.group(1)!
        : filePath
              .split(RegExp(r'[\\/]'))
              .last
              .replaceAll('_test.dart', '')
              .replaceAllMapped(RegExp('(_|^)([a-zA-Z])'), (m) => ' ${m[2]!.toUpperCase()}')
              .trim();
  }

  List<String> addComponentRows(
    Map<String, Map<String, int>> testCount,
    Map<String, int> groupTotals,
    Set<String> allComponentNames,
  ) {
    final Map<String, List<String>> componentRows = {};
    final Set<String> testedComponents = {};
    for (final entry in testCount.entries) {
      final componentName = formatComponentName(entry.key);
      testedComponents.add(componentName);
      final groupCounts = entry.value;
      // Update groupTotals for each group
      for (final group in testCategories) {
        final count = groupCounts[group] ?? 0;
        groupTotals[group] = (groupTotals[group] ?? 0) + count;
      }
      final cells = [
        componentName,
        ...[for (final group in testCategories) (groupCounts[group] ?? 0).toString()],
        groupCounts.values.fold(0, (a, b) => a + b).toString(),
      ];
      componentRows[componentName] = cells;
    }
    for (final componentName in allComponentNames.difference(testedComponents)) {
      componentRows[componentName] = [componentName, ...List.filled(8, '0'), '0'];
    }
    final sortedNames = componentRows.keys.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return [for (final name in sortedNames) '| ${componentRows[name]!.join(' | ')} |'];
  }

  String addCategoryTotalRow(Map<String, Map<String, int>> testCount, Map<String, int> groupTotals) {
    int total = 0;
    final List<String> cells = ['Total Tests'];
    for (final group in testCategories) {
      final count = groupTotals[group] ?? 0;
      cells.add(count.toString());
      total += count;
    }
    cells.add(total.toString());
    return '| ${cells.join(' | ')} |';
  }

  final List<String> data = [
    '**Last updated:** $date | **Zeta Flutter version:** $version',
    '',
    '| Component | ${testCategories.join(' | ')} | Total Tests |',
    '| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |',
    ...addComponentRows(testCount, groupTotals, allComponentNames),
    addCategoryTotalRow(testCount, groupTotals),
  ];

  return data.join('\n');
}

/// Parses a collection of test files and returns a map where the keys are
/// strings and the values are lists of maps containing dynamic data.
///
/// The function takes an iterable of [FileSystemEntity] objects representing
/// the test files to be parsed. It processes these files asynchronously and
/// returns a [Future] that completes with a map. Each key in the map is a
/// string, and each value is a list of maps with string keys and dynamic values.
///
/// - Parameter testFiles: An iterable collection of [FileSystemEntity]
///   objects representing the test files to be parsed.
/// - Returns: A [Future] that completes with a map where the keys are strings
///   and the values are lists of maps containing dynamic data.
Future<TestGroups> parseTestFiles(Iterable<FileSystemEntity> testFiles) async {
  final TestGroups testGroups = {};
  for (final FileSystemEntity file in testFiles) {
    final contents = await File(file.path).readAsString();
    final parseResult = parseString(content: contents);
    final visitor = TestGroupVisitor();
    parseResult.unit.visitChildren(visitor);
    testGroups[file.path] = visitor.groups;
  }
  return testGroups;
}

/// Counts the number of tests in each test group and returns a map with the counts.
///
/// - Parameters:
///   - testGroups: A map where the keys are group names and the values are lists of test maps.
/// - Returns: A map where the keys are component names and the values are maps containing the count of tests in each test group.
Map<String, Map<String, int>> countTests(TestGroups testGroups) {
  final TestCount testCount = {};
  testGroups.forEach((filePath, groups) {
    testCount[filePath] = {for (final group in groups) group['group'] as String: (group['tests'] as List).length};
  });
  return testCount;
}

void main() async {
  // check for output directory and create if it doesn't exist
  final Directory outputDirectory = await outputPath('scripts/test-counter/output');

  // get all test files
  final Iterable<FileSystemEntity> testFiles = getTestFiles('packages/zeta_flutter/test/src/components');

  // parse each test file and extract test groups
  final TestGroups testGroups = await parseTestFiles(testFiles);

  // count the number of tests in each group
  final TestCount testCount = countTests(testGroups);

  // Get all directory names directly under lib/src/components and format them
  final allComponentNames = {
    for (final dir in Directory('packages/zeta_flutter/lib/src/components').listSync().whereType<Directory>())
      dir.path
          .split(RegExp(r'[\\/]'))
          .last
          .replaceAllMapped(RegExp('(_|^)([a-zA-Z])'), (m) => ' ${m[2]!.toUpperCase()}')
          .trim(),
  };

  // get version from pubspec.yaml
  final pubspec = await File('packages/zeta_flutter/pubspec.yaml').readAsString();
  final versionMatch = RegExp(r'version:\s*([\d\.]+)').firstMatch(pubspec);
  final version = versionMatch != null ? versionMatch.group(1) ?? 'unknown' : 'unknown';

  // get current date
  final now = DateTime.now();
  final date =
      '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

  // generate MD table
  await writeMDToFile(
    '${outputDirectory.path}/test_counts.md',
    generateMD(testCount, allComponentNames, date, version),
  );

  print('Test table generated successfully!');
}
