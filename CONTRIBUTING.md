# Getting Involved

Thank you for your interest in this project. We'd love to see your contributions. There are just few small guidelines you need to follow.
Please note we have a code of conduct, please follow it in all your interactions with the project.

## Opening an issue

If you've noticed a bug or you have a suggestion for a new feature, please go ahead and open an issue in this project. Please do include as much information as possible.

Please file issues before doing substantial work; this will ensure that others don't duplicate the work and that there's a chance to discuss any design issues.

## Making a code change

We're always open to pull requests, but these should be small and clearly described so that we can understand what you're trying to do.

When you're ready to start coding, fork the needed repository to your own GitHub account and make your changes in a new branch. Once you're happy, open a pull request and explain what the change is and why you think we should include it in our project.

If the change is a bug fix, try to create a test that aligns with the bug.

## Creating a new component

We want the designs to be the source of truth for this repository, so new components will only be accepted if they are with the design files.

New components should use all tokens matching the design, and should not use hardcoded values for color, spacing, or radius. This ensures that changes made to these fundamental tokens are reflected throughout the library.

All components should have inline [dartdoc](https://dart.dev/tools/dart-doc) documentation on public functions and variables. This is enforced by the lint rules.

Components should extend from either `ZetaStatelessWidget` or `ZetaStatefulWidget`. These widgets add the rounded prop and getters, shared by many component variants in the design system, and future-proof our components for future use.
To add this rounded prop in your widget, add `super.rounded` to your constructor. This should _not_ provide a default value, as that is provided by either the top-level `Zeta` or `ZetaRoundedScope`.

_To use the rounded value, you should call `context.rounded` at all times, not `rounded`, as this allows for global or scoped values to be inserted._.
If your component has child widgets that can inherit a rounded value, use `ZetaRoundedScope` to provide the correct value for rounded to be consumed.

### Adding to the example app

To demonstrate a component, we need to create 2 examples: firstly in the zeta_flutter example app and secondly in widgetbook.

Example app should show basic examples to compare against the designs and is typically used by developers whilst building out components.

The widgetbook is used by the wider team to review components. We should attempt to show the full functionality of a component in a single Widgetbook instance. We have some helper functions for building knobs for icons and rounded bool in [utils.dart](./example/widgetbook/utils/utils.dart).
For more information on widgetbook, [read the docs](https://docs.widgetbook.io/).

We should also create a test for each widget created.

### Contributing Guide for Writing Tests

#### Folder Structure

To maintain consistency and ease of navigation, follow the same folder structure in the `test` directory as in the `lib` directory. For example, if you have a file located at `lib/src/components/tooltip/tooltip.dart`, your test file should be located at `test/src/components/tooltip/tooltip_test.dart`.

##### Example Folder Structure

```
lib/
└── src/
    └── components/
        └── tooltip/
            └── tooltip.dart

test/
└── src/
    └── components/
        └── tooltip/
            └── tooltip_test.dart
```

#### Writing Tests

1. **Unit Tests**: Test individual functions and classes.
2. **Widget Tests**: Test individual widgets and their interactions.
3. **Integration Tests**: Test the complete app or large parts of it.

##### Guidelines

- Use descriptive test names.
- Test one thing per test.
- Mock dependencies using `mockito`.
- Write tests for edge cases.

#### Measuring Code Coverage

To ensure high code coverage (at least > 96%), use the following steps:

##### With 'lcov'
1. **Run the script coverage.sh from the project root, which make use of `lcov` to generate the coverage report**:
   ```sh
   sh coverage.sh
   ``` 
##### Alternatively, with 'genhtml'   
1. **Install dependencies**:
   ```sh
   flutter pub add --dev test coverage
   ```

2. **Run tests with coverage**:
   ```sh
   flutter test --coverage
   ```

3. **Generate coverage report**:
   ```sh
   genhtml coverage/lcov.info -o coverage/html
   ```

4. **View coverage report**:
   Open `coverage/html/index.html` in a web browser.

  
##### Maximizing Coverage

- Write tests for all public methods and classes.
- Include tests for edge cases and error handling.
- Avoid excluding files from coverage unless necessary.

#### Golden Tests

Golden tests are used to ensure that the visual output of your widgets remains consistent over time. They are particularly useful for complex UI components.

##### Why Golden Tests?

In the `tooltip` example, the direction of the arrows in the tooltip is crucial. Golden tests help to ensure that any changes to the tooltip do not unintentionally alter the direction of the arrows or other visual aspects.

##### Adding Golden Tests

1. **Set up golden tests**:
   ```dart
   import 'package:flutter_test/flutter_test.dart';
   import 'package:zeta_flutter/zeta_flutter.dart';
   
   import '../../../test_utils/test_app.dart';

   void main() {
    testWidgets('renders with arrow correctly in up direction', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              arrowDirection: ZetaTooltipArrowDirection.up,
              child: Text('Tooltip up'),
            ),
          ),
        ),
      );

      expect(find.text('Tooltip up'), findsOneWidget);

      // Verifying the CustomPaint with different arrow directions.
      await expectLater(
        find.byType(ZetaTooltip),
        matchesGoldenFile(p.join('golden', 'arrow_up.png')),
      );
    });
   }
   ```

2. **Run golden tests**:
   ```sh
   flutter test --update-goldens
   ```

3. **Verify golden tests**:
   Ensure that the generated golden files are correct and commit them to the repository.



## Code reviews

All submissions, including submissions by project members, require review. We use GitHub pull requests (PRs) for this purpose. Consult [GitHub Help](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests) for more information on using pull requests.

Before a PR can be reviewed, ensure you have done the following, and fixed any issues that may arise:

- Ensure branch is up to date `git rebase main`
- Check formatting: `flutter format .`
- Run static analyses: `flutter analyze`
- Run unit-tests: `flutter test`

All PRs should be titled according to [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), as the branch will be squashed, so the PR title will become the commit message.
Examples:

- `feat(X):` for new features
- `fix(x):` for bug fixes
- `chore(x):` for admin / chores.
