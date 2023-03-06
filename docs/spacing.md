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
    return ZetaSpacing(child: ...);
  }
}
```

Spacing components can be used in multiple ways:

### ZetaSpacing() widget with named constructors.

```dart
ZetaSpacing.square(
  size: x1,
  child: Text('Example'),
),
ZetaSpacing.squish(
  size: x1,
  child: Text('Example'),
),
ZetaSpacing.stack(
  size: x1,
  child: Text('Example'),
)
ZetaSpacing.inline(
  size: x1,
  child: Text('Example'),
)
```

- Having a const constructor makes this a preferred approach to spacing.
- Can wrap any Widget.
- Padding inset around widget.

</br>

### ZetaSpacing() widget.

```dart
ZetaSpacing(
  size: x1,
  type: SpacingType.square,
  child: Text('Example'),
),
ZetaSpacing(
  size: x1,
  type: SpacingType.squish,
  child: Text('Example'),
),
ZetaSpacing(
  size: x1,
  type: SpacingType.stack,
  child: Text('Example'),
),
ZetaSpacing(
  size: x1,
  type: SpacingType.inline,
  child: Text('Example'),
),
```

- Having a const constructor makes this a preferred approach to spacing.
- Can wrap any Widget.
- Padding inset around widget.

</br>

### SpacingSize extension on double.

```dart
Container(
  padding: x1.square,
  margin: x10.squish,
  child: Text('Example'),
),
Container(
  padding: x1.stack,
  margin: x10.inline,
  child: Text('Example'),
),
```

- Should be used with defined sizes: x0, x1,... or xxs, xs,... (although can be used on any double).
- Can be used for either padding or margin
- Can be wrapped around any Widget.

</br>

### SpacingWidget extension on Widget.

```dart
Text('Example').square(x1),
Text('Example').squish(x1),
Text('Example').stack(x1),
Text('Example').inline(x1),
```

- Should be used with defined sizes: x0, x1,... or xxs, xs,... (although can be used on any double).
- Padding inset around widget.
- Can be applied to any widget.
