### Create component file {#create-component-file-flutter}

This file contains the implementation of the component and should follow the structure below:

`packages/zeta_flutter/lib/src/components/x/x.dart`

```dart
/// Description from figma
///
/// Flutter specific description (optional)
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=X
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/x/zetax/x
class ZetaX extends ZetaStatelessWidget {
  /// The constructor of the component [ZetaX].
  const ZetaX({
    super.key,
    super.rounded,
    this.y,
  });

  /// Description of property y.
  final y;

  @override
  Widget build(BuildContext context) {
    ...
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(...);
  }
}
```

The `ZetaStatelessWidget` and `ZetaStatefulWidget` classes are lightweight wrappers for `StatelessWidget` and `StatefulWidget`, adding the `rounded` property and default behaviors.

### Export the component {#export-the-component-flutter}

`packages/zeta_flutter/lib/src/zeta_components.dart`

```dart
...
export 'src/components/x/x.dart';
...
```

Only export the main component from the component file (for example, `ZetaX`). Avoid exporting internal helper classes, private widgets, or subcomponents that are not intended for public use. Exporting only the main component keeps the public API clean and prevents users from relying on internal implementation details, which may change without notice. This approach also reduces confusion and makes it easier for users to discover and use the intended component.

### Create the \*book file {#create-the-book-file-flutter}

This file should use Widgetbook annotations and typically include a single story. The story should demonstrate every variant of the component. If this is not feasible, you may create multiple stories.

`widgetbook/lib/src/components/x.widgetbook.dart`

```dart
@widgetbook.UseCase(
  name: 'X',
  type: ZetaX,
  path: 'componentsPath/X',
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=x',
)
Widget x(BuildContext context) {
  return ZetaX(
    y: context.knobs.text(label: 'y', initialValue: 'Default value'),
    rounded: context.knobs.boolean(label: 'Rounded', initialValue: true),
    ...
  );
}
```

Before viewing the Widgetbook, you must rebuild it:

```sh
cd widgetbook && dart run build_runner build -d
```

For more information, see the [Widgetbook documentation](https://docs.widgetbook.io/).

### Create the example file {#create-the-example-file-flutter}

This file should provide a straightforward example demonstrating how to use the component. If possible, replicate the default version of the component as shown in Figma. The example app is valuable for debugging during development and for testing the component in a real application context. This example will also be used to showcase the component on design.zebra.com/docs/components/x. Ensure the file follows the structure shown below:

`packages/zeta_flutter/lib/src/examples/components/x_example.dart`

```dart
class XExample extends StatelessWidget {
  static const String name = 'X';

  const XExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: XExample.name,
      children: [
        // Add your example usage here
      ],
    );
  }
}
```

By default, only the first child in `children` is rendered in the documentation. If you need to display more than the first widget, add a key containing the word `docs`.

Note: On the documentation website, content is displayed in a container with a height of 360px (width depends on the client viewport). If your component overflows this container, consider adding a scroll view or reducing the amount of content displayed.

### Link example page {#link-example-page-flutter}

To add the example page to the example app, add it to the list of components:

`example/lib/home.dart`

```dart
...
final List<Component> components = [
  Component(XExample.name, (context) => const XExample()),
  ...
]
...

```

Once added to this file, the example app can be used for debugging and demoing.
