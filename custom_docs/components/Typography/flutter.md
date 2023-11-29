## ZetaText Usage

To import ZetaText into a Dart file:

```dart
import 'package:zeta_flutter/zeta_flutter.dart';
```

### Example

```dart
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaTextExample extends StatelessWidget{
  const ZetaTextExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZetaText(...);
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

### ZetaText

Zeta text styles are within ZetaTheme.zeta, and so will be automatically applied to many widgets that use the built in text theme. When building components, text should not have any spacing by default, and so it is recommended to use the individual text styles with Text, rather than using ZetaText as this will by default apply a x2 squish padding (top and bottom).

Zeta Typography styles can be used in multiple ways:

### ZetaText widget with named constructors

```dart
const ZetaText.bodySmall('Example'),
const ZetaText.displayLarge('Example'),
```

This is the preferred way to display text. Having a const, named constructor with helper parameters makes the intuitive and efficient. Constructors exist for all pre-defined text styles and helper functions exist to support all tokens.

### ZetaText widget

```dart
const ZetaText('Example', style: ZetaText.zetaBodySmall)
```

This method is less intuitive than using the named constructor, although it does still provide a const constructor for efficiency. Having a const, named constructor with helper functions makes the intuitive and efficient. Constructors exist for all pre-defined text styles and helper parameters exist to support all tokens.

### ZetaText styles

```dart
Text('Example', style: ZetaText.zetaBodySmall)
Text('Example', style: Theme.of(context).bodySmall)
```

Using the base styles gives the greatest flexibility as styles can be extended or added to where needed, at the expense of following the specifications exactly. As ZetaText.textTheme is within the base app style, we can use context to get the styles. This greatly speed up the process of applying Zeta to a pre-existing application. Using this method means helper parameters (such as caps) can not be used and spacing is not applied. This can be useful in components where spacing should be zero.
