import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'utils/utils.dart';

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

        groups.add({
          'group': groupName,
          'tests': tests,
        });
      } else if (node.methodIsOneOf(['testWidgets', 'test', 'goldenTest', 'debugFillPropertiesTest'])) {
        final testName = node.getTestName();

        if (groups.any((el) => el['group'] == 'unorganised')) {
          final unorganisedGroup = groups.firstWhere((el) => el['group'] == 'unorganised');
          (unorganisedGroup['tests'] as List).add({
            'name': testName,
          });
        } else {
          groups.add({
            'group': 'unorganised',
            'tests': [
              {
                'name': testName,
              },
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
  TestVisitor(this.tests);

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
      tests.add({
        'name': testName,
      });
    } else if (node.methodIsOneOf(['debugFillPropertiesTest'])) {
      tests.add({
        'name': node.getMethodName(),
      });
    } else if (node.methodIsOneOf(['goldenTest'])) {
      tests.add({
        'name': node.toString(),
      });
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
String generateMD(Map<String, Map<String, int>> testCount) {
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

  final List<String> data = [
    '| Component | Accessibility | Content | Dimensions | Styling | Interaction | Golden | Performance | Unorganised | Total Tests |',
    '| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |',
  ]
    ..addComponentRows(testCount, groupTotals)
    ..addCategoryTotalRow(testCount, groupTotals);

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
    final Map<String, int> groupCounts = {};
    for (final group in groups) {
      final groupName = group['group'] as String;
      final tests = group['tests'] as List;
      groupCounts[groupName] = tests.length;
    }
    testCount[filePath] = groupCounts;
  });
  return testCount;
}

void main() async {
  // check for output directory and create if it doesn't exist
  final Directory outputDirectory = await outputPath('test/scripts/output');

  // get all test files
  final Iterable<FileSystemEntity> testFiles = getTestFiles('test/src/components');

  // parse each test file and extract test groups
  final TestGroups testGroups = await parseTestFiles(testFiles);

  // write test groups to file
  // await writeJSONToFile('${outputDirectory.path}/test_groups.json', testGroups);

  // count the number of tests in each group
  final TestCount testCount = countTests(testGroups);

  // write test counts to file
  // await writeJSONToFile('${outputDirectory.path}/test_counts.json', testCount);

  // generate MD table
  await writeMDToFile('${outputDirectory.path}/test_table.md', generateMD(testCount));

  // ignore: avoid_print
  print('Test table generated successfully!');
}
