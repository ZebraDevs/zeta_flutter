# Testing Conventions Flutter Components

### Helper Functions

As you are writing tests think about helper function you could write and add them to the `test_utils/utils.dart` file. This will help you and others write tests faster and more consistently.

- For golden tests  
  `goldenTest(GoldenFiles goldenFile, Widget widget, Type widgetType, String fileName, {bool darkMode = false})`
- For debugFillProperties tests
  `debugFillPropertiesTest(Widget widget, Map<String, dynamic> debugFillProperties)`

### Groups

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
  Animation performance, rendering performance, data manupulation performance, etc.

### Testing File Template

```dart
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
        goldenTest(goldenFile, widget, widgetType, 'PNG_FILE_NAME');
    });

    group('Performance Tests', () {});
}
```

### Test Visibility Table

You can find the test visibility table at the following path: 'test/scripts/output/test_table.mdx'

To generate the table run the following command from the root of the project:

```bash
dart test/scripts/test_counter.dart
```

#### Visibility Excel Sheet

https://zebra-my.sharepoint.com/:x:/p/de7924/Ea0l7BF7AzJJoBVPrg4cIswBZRyek6iNT3zzwDcLn-5ZGg?e=NTJIZU
