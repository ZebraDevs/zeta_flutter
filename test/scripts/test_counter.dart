import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

String getGroupName(MethodInvocation node) {
  return node.argumentList.arguments.first
      .toString()
      .replaceAll("'", '')
      .replaceAll(r'$componentName ', '')
      .replaceAll(' Tests', '');
}

String getTestName(MethodInvocation node) {
  return node.argumentList.arguments.first.toString().replaceAll("'", '');
}

String getMethodName(MethodInvocation node) {
  return node.methodName.name;
}

bool hasNullParent(MethodInvocation node) {
  return node.parent!.parent!.thisOrAncestorMatching((node) => node is MethodInvocation) == null;
}

bool methodIsOneOf(List<String> methods, MethodInvocation node) {
  return methods.contains(node.methodName.name);
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  String capitalizeEachWord() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }
}

String getComponentNameFromTestPath(String path) {
  return path.split(r'\').last.split('_test').first.replaceAll('_', ' ').capitalizeEachWord();
}

class TestGroupVisitor extends RecursiveAstVisitor<void> {
  final List<Map<String, dynamic>> groups = [];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (hasNullParent(node)) {
      if (methodIsOneOf(['group'], node)) {
        final groupName = getGroupName(node);
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
      } else if (methodIsOneOf(['testWidgets', 'test', 'goldenTest', 'debugFillPropertiesTest'], node)) {
        final testName = getTestName(node);

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

// Visitor to extract test names
class TestVisitor extends RecursiveAstVisitor<void> {
  TestVisitor(this.tests);

  final List<Map<String, dynamic>> tests;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (methodIsOneOf(['testWidgets', 'test'], node)) {
      final testName = getTestName(node);
      tests.add({
        'name': testName,
      });
    } else if (methodIsOneOf(['debugFillPropertiesTest'], node)) {
      tests.add({
        'name': getMethodName(node),
      });
    } else if (methodIsOneOf(['goldenTest'], node)) {
      tests.add({
        'name': node.toString(),
      });
    }

    super.visitMethodInvocation(node);
  }
}

String generateMDX(Map<String, Map<String, int>> testCount) {
  final List<String> groupNames = [
    'Accessibility',
    'Content',
    'Dimensions',
    'Styling',
    'Interaction',
    'Golden',
    'Performance',
    'unorganised',
  ];

  final List<String> data = [
    '| Component | Accessibility | Content | Dimensions | Styling | Interaction | Golden | Performance | Unorganised | Total Tests |',
    '| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |',
  ];

  testCount.forEach((filePath, groups) {
    final componentName = getComponentNameFromTestPath(filePath);
    final totalTests = groups.values.fold(0, (previousValue, element) => previousValue + element);
    int otherGroups = 0;
    groups.forEach((key, value) {
      if (!groupNames.contains(key)) {
        otherGroups += value;
      }
    });
    otherGroups += groups['unorganised'] ?? 0;

    data.add(
      '| $componentName | ${groups['Accessibility'] ?? 0} | ${groups['Content'] ?? 0} | ${groups['Dimensions'] ?? 0} | ${groups['Styling'] ?? 0} | ${groups['Interaction'] ?? 0} | ${groups['Golden'] ?? 0} | ${groups['Performance'] ?? 0} | $otherGroups | $totalTests |',
    );
  });

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

  testCount.forEach((filePath, groups) {
    groups.forEach((key, value) {
      if (!groupNames.contains(key)) {
        groupTotals['unorganised'] = groupTotals['unorganised']! + value;
      } else {
        groupTotals[key] = groupTotals[key]! + value;
      }
    });
  });

  data.add(
    '| Total Tests | ${groupTotals['Accessibility']} | ${groupTotals['Content']} | ${groupTotals['Dimensions']} | ${groupTotals['Styling']} | ${groupTotals['Interaction']} | ${groupTotals['Golden']} | ${groupTotals['Performance']} | ${groupTotals['unorganised']} | ${groupTotals.values.fold(0, (previousValue, element) => previousValue + element)} |',
  );

  return data.join('\n');
}

void main() async {
  // check for output directory and create if it doesn't exist
  final outputDirectory = Directory('test/output');
  if (!outputDirectory.existsSync()) {
    await outputDirectory.create(recursive: true);
  }

  // get all test files
  final testDirectory = Directory('test/src/components');
  final testFiles =
      testDirectory.listSync(recursive: true).where((entity) => entity is File && entity.path.endsWith('_test.dart'));
  final Map<String, List<Map<String, dynamic>>> testGroups = {};

  // parse each test file and extract test groups
  for (final FileSystemEntity file in testFiles) {
    final contents = await File(file.path).readAsString();

    final parseResult = parseString(content: contents);
    final visitor = TestGroupVisitor();
    parseResult.unit.visitChildren(visitor);
    testGroups[file.path] = visitor.groups;
  }

  // write test groups to file
  // final jsonOutputGroups = jsonEncode(testGroups);
  // final outputFileGroups = File('${outputDirectory.path}/test_groups.json');
  // await outputFileGroups.writeAsString(jsonOutputGroups);

  final Map<String, Map<String, int>> testCount = {};

  // count the number of tests in each group
  testGroups.forEach((filePath, groups) {
    final Map<String, int> groupCounts = {};
    for (final group in groups) {
      final groupName = group['group'] as String;
      final tests = group['tests'] as List;
      groupCounts[groupName] = tests.length;
    }
    testCount[filePath] = groupCounts;
  });

  // write test counts to file
  // final jsonOutput = jsonEncode(testCount);
  // final outputFile = File('${outputDirectory.path}/test_counts.json');
  // await outputFile.writeAsString(jsonOutput);

  // generate MDX table
  final mdxOutput = generateMDX(testCount);
  final mdxFile = File('${outputDirectory.path}/test_table.mdx');
  await mdxFile.writeAsString(mdxOutput);
}



/** TODO: 
 * - Abstract the code into functions
 * - Add comments
 * - Add error handling
 * - GITHUB ACTION TO RUN THE SCRIPT
 * */ 
