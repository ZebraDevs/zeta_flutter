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

### Creating a new component

We want the designs to be the source of truth for this repository, so new components will only be accepted if they are with the design files.

New components should use all tokens matching the design, and should not use hardcoded values for color, spacing, or radius. This ensures that changes made to these fundamental tokens are reflected throughout the library.

All components should have inline [dartdoc](https://dart.dev/tools/dart-doc) documentation on public functions and variables. This is enforced by the lint rules.

To demonstrate a component, we need to create 2 examples: firstly in the zeta_flutter example app and secondly in widgetbook.

Example app should show basic examples to compare against the designs and is typically used by developers whilst building out components.

The widgetbook is used by the wider team to review components. We should attempt to show the full functionality of a component in a single Widgetbook instance. We have some helper functions for building knobs for icons and rounded bool in [utils.dart](./example/widgetbook/utils/utils.dart).
For more information on widgetbook, [read the docs](https://docs.widgetbook.io/).

We should also create a test for each widget created.

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
