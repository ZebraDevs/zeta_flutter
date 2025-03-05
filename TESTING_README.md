## Directory structure {#directory-structure-flutter}

Test files are stored in the top-level `tests` folder. Each test file should replicate the directory structure of the corresponding component in the `lib` directory to ensure consistency and easy navigation.
For example, if your component is located at `lib/src/components/buttons/button.dart`, the test should be placed at `test/src/components/buttons/button_test.dart`.

## Test groups {#test-groups-flutter}

Each test file should follow a consistent pattern, organizing tests into groups for Accessibility, Content, Dimensions, Styling, Interaction, Golden, and Performance.
While not every group needs to be populated for each component, they should be included as necessary to thoroughly validate the component's behavior and quality.

- **Accessibility Tests**  
  Semantic labels, touch areas, contrast ratios, etc.

- **Content Tests**  
  Finds the widget, parameter statuses, etc.  
  Checking for the value of props and attributes of the widget. Checking for the presence of widgets.

- **Dimensions Tests**  
  Size, padding, margin, alignment, etc.  
  getSize().

- **Styling Tests**  
  Rendered colors, fonts, borders, radii etc.
  Checking the style of widgets and child widgets.

- **Interaction Tests**  
  Gesture recognizers, taps, drags, etc.
  For example, using a boolean to check if the widgets interaction function runs.

- **Golden Tests**  
  Compares the rendered widget with the golden file. Use the `goldenTest()` function from test_utils/utils.dart.

- **Performance Tests**  
  Animation performance, rendering performance, data manipulation performance, etc.

## Testing file template {#testing-file-template-flutter}

```dart title="Groups should exist for Accessibility, Content, Dimensions, Styling, Interaction, Golden, and Performance."
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
    const String parentFolder = 'ENTER_PARENT_FOLDER (e.g. button)';

    const goldenFile = GoldenFiles(component: parentFolder);
    setUpAll(() {
        goldenFileComparator = TolerantComparator(goldenFile.uri);
    });

    group('Accessibility Tests', () {});

    group('Content Tests', () {
      final debugFillProperties = {
        '': '',
      };
      debugFillPropertiesTest(
        widget,
        debugFillProperties,
      );
    });

    group('Dimensions Tests', () {});

    group('Styling Tests', () {});

    group('Interaction Tests', () {});

    group('Golden Tests', () {
        goldenTest(goldenFile, widget, 'PNG_FILE_NAME');
    });

    group('Performance Tests', () {});
}
```

## Golden testing {#golden-testing-flutter}

Golden testing is a technique in software development that verifies the visual appearance of UI components by capturing a “golden” image of the component in its ideal state. This image serves as a reference for future tests, allowing any visual changes or regressions to be easily identified.

When conducting golden tests, aim to create tests for each unique variation of a component, including:

- Different states (e.g., active, disabled)
- Various themes or styles
- Different sizes or configurations

This approach ensures that all possible visual appearances of the component are captured and can be verified for consistency.

For Flutter golden tests, set up the testing framework as follows:

1. **Initialize the Golden File Reference**: Define the reference for the golden file (as shown in line 4 below).

2. **Set Up a Custom Comparator**: Use lines 6-8 to configure a custom comparator, which compares the saved images to the rendered output. This setup remains consistent across all tests.

3. **Use the goldenTest Helper Method**: Lines 12-19 demonstrate how to utilize this method, which requires the golden file reference, the code to render, and the test file’s name.

Before executing the tests, run `flutter test --update-goldens` within your test directory to populate the golden directory; you should only do this for newly created tests. This command ensures your golden images are up-to-date and reflect the intended visual state.

```dart showLineNumbers title="Set up code required for golden testing"
void main(){
  const String parentFolder = 'componentName'; // i.e. Button

  const goldenFile = GoldenFiles(component: parentFolder);

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

   //...

  group('Golden Tests', () {
   goldenTest(
         goldenFile,
         const ZetaComponentName(prop1: '1', prop2: '2'),
         'component_name_prop11_prop22',
      );
   // Create cases for all variances
  });

}
```

## Helper functions {#helper-functions-flutter}

As you are writing tests think about helper function you could write and add them to the `test_utils/utils.dart` file. This will help you and others write tests faster and more consistently.

- For golden tests  
  `goldenTest(GoldenFiles goldenFile, Widget widget, Type widgetType, String fileName, {bool darkMode = false})`
- For debugFillProperties tests
  `debugFillPropertiesTest(Widget widget, Map<String, dynamic> debugFillProperties)`

## Guidelines {#guidelines-flutter}

- Use descriptive test names.
- Test one thing per test.
- Mock dependencies using `mockito`.
- Write tests for edge cases.
