import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class AccordionExample extends StatelessWidget {
  static const String name = 'Accordion';

  const AccordionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ExampleScaffold(
          name: AccordionExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.s),
            child: Column(
              children: [
                Text('Default'),
                const SizedBox(height: 20),
                accordionDefaultExample,
                const SizedBox(height: 40),
                Text('Contained'),
                const SizedBox(height: 20),
                accordionContainedExample,
                const SizedBox(height: 40),
                Text('Sharp'),
                const SizedBox(height: 20),
                accordionSharpExample,
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget get accordionDefaultExample => ZetaAccordion(
        spaceBetween: 0,
        children: [
          ZetaAccordionSection(
            title: Text('Title Default Enabled'),
            body: Column(
              children: [
                ListTile(title: Text('List Item')),
                ListTile(title: Text('List Item')),
                ListTile(title: Text('List Item')),
              ],
            ),
          ),
          ZetaAccordionSection(
            disabled: true,
            title: Text('Title Default Disabled'),
            body: Text('...'),
          ),
        ],
      );

  static Widget get accordionContainedExample => ZetaAccordion(
        contained: true,
        children: [
          ZetaAccordionSection(
            title: Text('Title Contained Enabled'),
            body: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
          ),
          ZetaAccordionSection(
            disabled: true,
            title: Text('Title Contained Disabled'),
            body: Text('...'),
          ),
        ],
      );

  static Widget get accordionSharpExample => ZetaAccordion(
        contained: true,
        rounded: false,
        children: [
          ZetaAccordionSection(
            title: Text('Title Contained Sharp Enabled'),
            body: Center(
              child: Icon(Icons.image_outlined, size: 300),
            ),
          ),
          ZetaAccordionSection(
            disabled: true,
            title: Text('Title Contained Sharp Disabled'),
            body: Text('...'),
          ),
        ],
      );
}
