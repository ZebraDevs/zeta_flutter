## ZetaSpacing Usage

To import ZetaSpacing into a Dart file:

```dart
import 'package:zeta_flutter/zeta_flutter.dart';
```

### Example

```dart
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaSpacingExample extends StatelessWidget{
  const ZetaSpacingExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZetaSpacing(...);
  }
}
```

### Setup

To ensure all components work as intended, applications should have ZetaTheme.zeta applied at their top level; typically within MaterialApp or wrapping its equivalent:

```dart
import 'package:flutter/material.dart';
import 'package:zeta_flutter/src/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ZetaTheme.zeta,
      builder: (context, child) => ...,
    );
  }
}
```

or

```dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeta_flutter/src/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ZetaTheme.zeta,
      child: CupertinoApp(
        builder: (context, child) => ...,
      ),
    );
  }
}
```

### ZetaSpacing

ZetaSpacing provides four options for spacing

- `square` - applies inset to all 4 sides equally.
- `squish` - applies inset to top and bottom only.
- `inline` - applies inset to start and end only.
- `inlineStart` - applies inset to start only. For LTR locales this is the left, for RTL locales this is the right.
- `inlineEnd` - applies inset to end only. For LTR locales this is the right, for RTL locales this is the left.
- `stack` - applies inset to bottom only.

These spacings should be applied with the following doubles:

- `x0` - 0
- `x1` - 4 - also `xxs`
- `x2` - 8 - also `xs`
- `x3` - 12 - also `s`
- `x4` - 16 - also `b`
- `x5` - 20
- `x6` - 24 - also `m`
- `x7` - 28
- `x8` - 32 - also `l`
- `x9` - 36
- `x10` - 40
- `x11` - 44
- `x12` - 48
- `x13` - 52
- `x14` - 58
- `x16` - 64 - also `xl`
- `x20` - 80 - also `xxl`
- `x24` - 96 - also `xxxl`

Spacing components can be used in multiple ways:

### ZetaSpacing() widget with named constructors.

```dart
const ZetaSpacing.square(
   Text('Example'),
   size: Dimensions.x1,
),
const ZetaSpacing.squish(
  Text('Example'),
  size: Dimensions.x1,
),
const ZetaSpacing.stack(
  Text('Example'),
  size: Dimensions.x1,
)
const ZetaSpacing.inline(
  Text('Example'),
  size: Dimensions.x1,
)
```

This is the preferred way to use ZetaSpacing. Having a const, named constructor makes the intuitive and efficient.

- Const constructor
- Can wrap any Widget.
- Padding inset around widget.

</br>

### ZetaSpacing() widget.

```dart
const ZetaSpacing(
  Text('Example'),
  size: Dimensions.x1,
  type: ZetaSpacingType.square,
),
const ZetaSpacing(
  Text('Example'),
  size: Dimensions.x1,
  type: ZetaSpacingType.squish,
),
const ZetaSpacing(
  Text('Example'),
  size: Dimensions.x1,
  type: ZetaSpacingType.stack,
),
const ZetaSpacing(
  Text('Example'),
  size: Dimensions.x1,
  type: ZetaSpacingType.inline,
),
```

This method is less intuitive than using the named constructor, although it does still provide a const constructor for efficiency.

- Having a const constructor makes this a preferred approach to spacing.
- Can wrap any Widget.
- Padding inset around widget.

</br>

### SpacingSize extension on double.

```dart
Container(
  padding: Dimensions.x1.square,
  margin: Dimensions.x10.squish,
  child: Text('Example'),
),
Container(
  padding: Dimensions.x1.stack,
  margin: Dimensions.x10.inline,
  child: Text('Example'),
),
```

- Should be used with defined sizes: x0, x1,... or xxs, xs,... (although can be used on any double).
- Can be used for either padding or margin.
- Can be wrapped around any Widget, or used as a parameter.

</br>

### SpacingWidget extension on Widget.

```dart
Text('Example').square(Dimensions.x1),
Text('Example').squish(Dimensions.x1),
Text('Example').stack(Dimensions.x1),
Text('Example').inline(Dimensions.x1),
Text('Example').inlineStart(Dimensions.x1),
Text('Example').inlineEnd(Dimensions.x1),
```

- Should be used with defined sizes: x0, x1,... or xxs, xs,... (although can be used on any double).
- Padding inset around widget.
- Can be applied to any widget.
