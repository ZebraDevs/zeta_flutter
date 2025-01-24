# Zeta Utils

Utility classes and functions used by zeta_flutter from Zebra Technologies.

These utils are a part of the Zeta Design System, and can be used either on their own or with [Zeta Flutter](https://pub.dev/packages/zeta_flutter)

### Debounce

Debouncing ensures that the function is only called once after a specified duration has passed since the last time it was invoked. This is useful for scenarios where you want to limit the rate at which a function is executed, such as handling user input events or API calls.

```dart
final debouncer = Debounce(()=> print('Hello, world!'), duration: Duration(seconds: 1));
```

### Nothing

A convenient widget that renders nothing. It is typically used when a widget requires a child, but we don't want to provide one.

```dart
    child: Nothing(),
```

### Extensions

Various extension methods are provided:

#### Iterable<Widget>

- `divide(Widget separator)` - Divides a list of widgets with user defined separators.
- `gap(double gap)` - Spaces out a list of widgets with a gap of fixed width.

#### Widget

- `paddingAll(double space)` - Adds padding to all sides of a widget.
- `paddingStart(double space) / paddingEnd(double space)` - Adds padding to the start / end of a widget depending on if device is configured for LTR or RTL.
- `paddingTop(double space) / paddingBottom(double space)` Adds padding to the top or bottom of a widget.
- `paddingVertical(double space)` - Adds padding to both the top and bottom of a widget.
- `paddingHorizontal(double space)` - Adds padding to both the start and end of a widget.

#### Num

- `formatMaxChars([int maxChars=1])` - returns numbers up to a maximum number of characters. For example, when maxChars = 1, any number over 9 will return '9+'. Typically used for notifications.

#### String

- `initials` - Returns the initials from a name.

- `capitalize` - Capitalizes the first letter of a string.

### Universal Platform Check

A universal platform check that works on web too. Copyright (c) 2021 Mike Rydstrom; see [3rd party licenses.](https://github.com/ZebraDevs/zeta_flutter/tree/develop/packages/zeta_flutter_utils/LICENSE-3RD-PARTY)
