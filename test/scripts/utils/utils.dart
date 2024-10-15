import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/ast/ast.dart';

/// A typedef for a map that associates a string key with a list of maps.
/// Each map in the list contains string keys and dynamic values.
///
/// This can be used to group test cases or data sets by a specific category or identifier.
///
/// Example:
/// ```dart
/// TestGroups testGroups = "path/to/test/file_test.dart": [
/// {
///   'group': 'Accessibility',
///   'tests': [
///     {'name': 'value1'},
///     {'name': 'value2'},
///   ],
/// },
/// {
///   'group': 'Content',
///   'tests': [
///     {'name': 'value1'},
///   ],
/// },
/// };
/// ```
typedef TestGroups = Map<String, List<Map<String, dynamic>>>;

/// A typedef for a nested map structure that counts tests.
///
/// The outer map uses a `String` as the key, which represents a test file path.
/// The inner map also uses a `String` as the key, which represents a test category.
/// The value of the inner map is an `int` that represents the count of occurrences or results for that specific test category.
///
/// Example:
/// ```dart
/// TestCount testCount = {
///   "path/to/test/file_test.dart": {
///   "Accessibility": 3,
///   "Content": 2,
///   },
/// };
/// ```
typedef TestCount = Map<String, Map<String, int>>;

extension NodeExtension on MethodInvocation {
  /// Checks if the current node has a null parent node.
  ///
  /// Returns `true` if the parent node is null, otherwise `false`.
  bool hasNullParentNode() {
    return parent!.parent!.thisOrAncestorMatching((node) => node is MethodInvocation) == null;
  }

  /// Retrieves and sanitizes the name of the test group.
  ///
  /// Returns:
  ///   A [String] containing the sanitized name of the group.
  String getGroupName() {
    return argumentList.arguments.first.toString().replaceAll("'", '').replaceAll(' Tests', '');
  }

  /// Retrieves and sanitizes the name of the test.
  ///
  /// Returns:
  ///   A [String] containing the sanitized name of the test.
  String getTestName() {
    return argumentList.arguments.first.toString().replaceAll("'", '');
  }

  /// Returns the name of the method as a string.
  ///
  /// Returns:
  ///   A [String] representing the method name.
  String getMethodName() {
    return methodName.name;
  }

  /// Checks if the current method is one of the specified methods.
  ///
  /// This function takes a list of method names and checks if the current
  /// method is included in that list.
  ///
  /// - Parameter methods: A list of method names to check against.
  /// - Returns: `true` if the current method is one of the specified methods,
  ///   otherwise `false`.
  bool methodIsOneOf(List<String> methods) {
    return methods.contains(methodName.name);
  }
}

extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Returns a new string with the first letter converted to uppercase
  /// and the remaining letters unchanged.
  ///
  /// Example:
  ///
  /// ```dart
  /// String text = "hello";
  /// String capitalizedText = text.capitalize();
  /// print(capitalizedText); // Output: Hello
  /// ```
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Capitalizes the first letter of each word in a string.
  ///
  /// This method splits the string by spaces, capitalizes the first letter
  /// of each word, and then joins the words back together with spaces.
  ///
  /// Returns a new string with each word capitalized.
  String capitalizeEachWord() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }
}

/// Extracts the component name from a given test file path.
///
/// This function takes a test file path as input and returns the component name
/// inferred from the path. The component name is extracted by splitting the path
/// and removing the file extension and test suffix.
///
/// Example:
/// ```dart
/// String componentName = getComponentNameFromTestPath('test/src/components/comms_button/comms_button_test.dart');
/// print(componentName); // Output: Comms Button
/// ```
///
/// - Parameter path: The file path from which to extract the component name.
/// - Returns: The component name as a string.
String getComponentNameFromTestPath(String path) {
  return path.split(r'\').last.split('_test').first.replaceAll('_', ' ').capitalizeEachWord();
}

/// Returns a [Future] that completes with a [Directory] at the specified [path].
///
/// This function takes a [String] [path] and asynchronously returns a [Directory]
/// object representing the directory at the given path.
///
/// Example:
/// ```dart
/// Directory dir = await outputPath('/path/to/directory');
/// ```
Future<Directory> outputPath(String path) async {
  final outputDirectory = Directory(path);
  if (!outputDirectory.existsSync()) {
    await outputDirectory.create(recursive: true);
  }
  return outputDirectory;
}

/// Retrieves an iterable of file system entities from the specified path.
///
/// This function takes a [path] as a string and returns an [Iterable] of
/// [FileSystemEntity] objects representing the test files located at the given path.
///
/// - Parameter path: The path to the directory from which to retrieve the files.
/// - Returns: An iterable collection of file system entities found at the specified path.
Iterable<FileSystemEntity> getTestFiles(String path) {
  final testDirectory = Directory(path);
  return testDirectory
      .listSync(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('_test.dart'));
}

/// Writes the given JSON content to a file at the specified path.
///
/// This function takes a file path and JSON content, and writes the content
/// to the file asynchronously. If the file does not exist, it will be created.
///
/// [path] The file path where the JSON content should be written.
/// [content] The JSON content to write to the file.
Future<void> writeJSONToFile(String path, dynamic content) async {
  final jsonOutputGroups = jsonEncode(content);
  final outputFileGroups = File(path);
  await outputFileGroups.writeAsString(jsonOutputGroups);
}

/// Writes the given MD data to a file at the specified path.
///
/// This function asynchronously writes the provided MD data to a file
/// located at the given path. If the file does not exist, it will be created.
///
/// [path] The file path where the MD data should be written.
/// [mdData] The MD data to write to the file.
Future<void> writeMDToFile(String path, String mdData) async {
  final mdFile = File(path);
  await mdFile.writeAsString(mdData);
}

extension ListExtension on List<String> {
  /// Adds rows of components to the specified target.
  ///
  /// This function iterates over the test count and group totals
  /// to add the component rows to the target.
  void addComponentRows(
    Map<String, Map<String, int>> testCount,
    Map<String, int> groupTotals,
  ) {
    testCount.forEach((filePath, groups) {
      final componentName = getComponentNameFromTestPath(filePath);

      int unorganisedTestsInComponent = 0;
      groups.forEach((key, value) {
        if (!groupTotals.keys.contains(key)) {
          unorganisedTestsInComponent += value;
        }
      });
      unorganisedTestsInComponent += groups['unorganised'] ?? 0;

      final totalTestsForComponent = groups.values.fold(0, (previousValue, element) => previousValue + element);

      return add(
        '| $componentName | ${groups['Accessibility'] ?? 0} | ${groups['Content'] ?? 0} | ${groups['Dimensions'] ?? 0} | ${groups['Styling'] ?? 0} | ${groups['Interaction'] ?? 0} | ${groups['Golden'] ?? 0} | ${groups['Performance'] ?? 0} | $unorganisedTestsInComponent | $totalTestsForComponent |',
      );
    });
  }

  /// Adds a total row for a category in the data table.
  ///
  /// This method calculates the total for a specific category and appends
  /// a row to the data table displaying the totals.
  void addCategoryTotalRow(
    Map<String, Map<String, int>> testCount,
    Map<String, int> groupTotals,
  ) {
    testCount.forEach((filePath, groups) {
      groups.forEach((key, value) {
        if (!groupTotals.keys.contains(key)) {
          groupTotals['unorganised'] = groupTotals['unorganised']! + value;
        } else {
          groupTotals[key] = groupTotals[key]! + value;
        }
      });
    });
    return add(
      '| Total Tests | ${groupTotals['Accessibility']} | ${groupTotals['Content']} | ${groupTotals['Dimensions']} | ${groupTotals['Styling']} | ${groupTotals['Interaction']} | ${groupTotals['Golden']} | ${groupTotals['Performance']} | ${groupTotals['unorganised']} | ${groupTotals.values.fold(0, (previousValue, element) => previousValue + element)} |',
    );
  }
}
