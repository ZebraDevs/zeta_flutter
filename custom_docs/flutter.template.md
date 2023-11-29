## ZetaX Usage

To import ZetaX into a Dart file:

```dart
import 'package:zeta_flutter/zeta_flutter.dart';
```

### Example

```dart
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaXExample extends StatelessWidget{
  const ZetaXExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZetaY(...);
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
