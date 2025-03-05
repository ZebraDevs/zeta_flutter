This guide outlines the process and expectations for contributors looking to enhance the Zeta Libraries open-source project.

These components are open source, and we warmly welcome contributions from the community. All collaborators are expected to adhere to [Zebra's contributing guidelines](https://github.com/ZebraDevs/About/blob/master/CONTRIBUTING.md) and agree to the [Contributor Covenant Code of Conduct](https://github.com/ZebraDevs/About/blob/master/Code_of_Conduct.md).

Contributions to the Zeta libraries are encouraged; however, new components _must_ be defined in the [Figma designs](https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components) before proceeding.

## Component creation and contribution process {#component-creation-flutter}

For both Zeta libraries, the process for component creation follows the same steps:

1. **Internal design completion in Figma (new components only)**: For new designs, the initial design phase is conducted internally by the Zebra Technologies Customer Experience Design team using Figma. This step is exclusive to the internal team to ensure that the new component aligns with our project’s standards and goals. The design undergoes a rigorous internal review process before being approved for further development.
   **Note that this step does not apply to bug fixes or quality of life improvements**.

2. **Ticket creation**: If you’ve noticed a bug or have a suggestion for a new feature, please open an issue in this project and include as much information as possible. Before undertaking substantial work, it’s important to file issues to avoid duplicate efforts and to allow for discussion of any design concerns. Once a design is approved, create a development ticket either on the [Zebra internal Jira - UX board](https://jira.zebra.com/browse/UX) or by raising an issue on the relevant GitHub repository.

3. **Component development**: We’re always open to pull requests; they should be clearly described and adhere to our project’s style guide for consistency. When you’re ready to start coding, fork the necessary repository to your own GitHub account and create your changes in a new branch. If you’re an external collaborator without write access to ZebraDevs, forking the repository is essential to push your changes. Focus on writing clean, maintainable, and efficient code following best practices, including modular, well-documented code. Once satisfied, open a pull request, explaining the changes and their purpose. If your change addresses a bug, try to include a test that aligns with it. All contributions will undergo an internal peer review to ensure quality and consistency.

   We want the designs to be the source of truth for this repository, so new components will only be accepted if they align with the design files. New components should use all tokens matching the design and avoid hardcoded values for color, spacing, or radius, ensuring that changes to these fundamental tokens are reflected consistently throughout the library.

4. **Integration and Testing**: The newly developed component should be integrated into the example app (such as Storybook or Widgetbook). This step involves writing comprehensive tests to assess the component’s functionality and quality. It is crucial to address any lint or static analysis issues, rather than ignoring them, to maintain code quality. Additionally, ensure that code lines do not exceed 120 characters to enhance readability and maintainability throughout the project. This practice helps maintain a consistent coding style that is easy for all team members to follow and review.

5. **Commit Guidelines**: When committing changes, adhere to the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) guidelines to ensure accurate release note generation. For a full list of the commit keywords we support, see the `release-please-config.json` file in the repository. We recommend using Git Rebase (rather than merging BASE) to keep your branch updated, facilitating easier merges without complex branching.

6. **Pull Request submission**: Once the component is ready, submit a PR. This can be done from a fork or a branch within the repository. Ensure your branch is fully up-to-date with the target branch, typically `main`. However, if requested by the authors, you might need to merge into `develop`, especially if the PR includes breaking changes that shouldn’t be released immediately.

   When creating the PR, the title should follow the format keyword(ticket number): description. For example, `feat(UX-101): Create button`. This ensures consistency with our versioning and release processes.

   In the PR description, any changes that should be included in the changelog or release notes should be clearly outlined at the top. Use the same conventional commit formatting for these entries. This section can span multiple lines if needed, providing a detailed overview of significant changes, features, or bug fixes. Additional information or context can be included below this section. Furthermore, supplementary details or clarifications can also be added as comments on the PR itself, ensuring that all relevant information is easily accessible for reviewers.

7. **PR Checks**: Once you submit your PR, it will undergo a series of automated checks to verify code quality and functionality. These checks include running tests, static analysis, and linting to ensure that the code meets our project’s standards. The results of these checks will be automatically commented on the PR, providing clear feedback on any issues that need to be addressed. For your PR to be eligible for merging, all tests must pass, and there should be no outstanding linting or formatting errors. Be sure to review these comments carefully and make the necessary adjustments to resolve any issues.

8. **Code Review**: A member of the `Front-end Devs` GitHub team must review your PR before it can be merged. Our team aims to review pull requests within one week of their opening to ensure timely feedback and progress. If you require more immediate attention or have specific questions, feel free to tag relevant authors or team members directly in the GitHub issue or PR comments to expedite the process. All comments and suggestions provided during the review must be addressed to ensure the highest quality and alignment with project standards.

9. **Merging**: Once the review is complete and all checks have passed, your PR will be merged. We utilize squash merging for all PRs, which means that the title and description of the PR will be used as the commit title and body. This helps maintain a clean and concise commit history. Note that the merged changes will not be immediately distributed until a formal release is conducted.

## Package specific overview {#package-specific-overview-flutter}

When contributing new code to Zeta Flutter, ensure that you carefully select the appropriate package for your additions. The `zeta_flutter` package is intended for component-specific code, while `zeta_flutter_utils` should house utility code, such as helper methods and extensions. Avoid making direct changes to `zeta_flutter_theme` and `zeta_icons`, as these packages are mainly autogenerated, with modifications triggered automatically by updates in the Figma designs to maintain consistency with the design system.

- **File Formatting**: Ensure all files are formatted with a maximum line length of 120 characters for improved readability.
- **Code Analysis**: Run dart analyze to confirm that no issues are present in the codebase.
- **Branch Synchronization**: Ensure your branch is fully synchronized and not behind the HEAD of the target branch.
- **Testing**: New components must include a corresponding test file to verify functionality using Flutter's built-in testing framework. See [testing](https://design.zebra.com/docs/Development/testing/testing-guide?package=flutter)
- **Golden Tests**: New components should also have a golden test to ensure visual consistency and correctness. See [testing](https://design.zebra.com/docs/Development/testing/testing-guide?package=flutter#golden-testing-flutter)
- **Example App Integration**: Integrate new components into the example app to demonstrate their usage.
- **Widgetbook Integration**: Add new components to the widgetbook and ensure they are fully integrated for comprehensive documentation and usage examples.

Some of these rules are enforced automatically by the [flutter-code-quality](https://github.com/ZebraDevs/flutter-code-quality) GitHub Action, which runs when pull requests are opened. This automation helps maintain high standards across the project and streamlines the review process.

### Creating a new component {#creating-a-new-component-flutter}

All components should include inline [dartdoc](https://dart.dev/tools/dart-doc) documentation on public functions and variables, enforced by lint rules. Components should extend either `ZetaStatelessWidget` or `ZetaStatefulWidget`, which incorporate the rounded prop and getters shared by many component variants in the design system. To add this rounded prop in your widget, include super.rounded in your constructor, without providing a default value, as this is supplied by Zeta or ZetaRoundedScope.

To utilize the rounded value, always call `context.rounded`, not `rounded`, allowing for global or scoped values to be inserted. If your component includes child widgets that can inherit a rounded value, use ZetaRoundedScope to provide the correct value.

### Adding examples {#adding-examples-flutter}

To effectively demonstrate a component, create two examples: one in the Zeta Flutter example app (`./example`) and another in the widgetbook instance (`./widgetbook`). The example app should display basic examples to compare against the designs and is typically used by developers during component development. The widgetbook serves as a review tool for the broader team, showcasing the full functionality of a component in a single instance. Utilize helper functions for building knobs for icons and the rounded bool in utils.dart. For more information on widgetbook, read the docs.

## Releasing {#releasing-flutter}

Our repositories utilize [Release-Please](https://github.com/googleapis/release-please) to streamline release management. This tool automates the generation of release notes and version bumping, based on keywords in the pull requests that are merged. These keywords are defined in the repository’s `release-please-config.json` file. When code is merged, Release-Please automatically generates pull requests (PRs) that, once merged, will create a release and distribute the updated code.

We follow a flexible release schedule, deploying updates as necessary rather than adhering to a strict timetable. If a pull request includes a bug marked as “urgent” in its body, it will trigger an immediate release upon merging. Should a specific release be required outside of our usual process, contributors are encouraged to tag the authors in the relevant Release-Please PR to expedite the release.
