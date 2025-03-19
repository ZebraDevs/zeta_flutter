import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class AccordionExample extends StatelessWidget {
  static const String name = 'Accordion';

  const AccordionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: AccordionExample.name,
      children: [
        Text('Divider'),
        const SizedBox(height: 20),
        ZetaAccordion(
          title: 'title',
          key: Key('docs'),
          child: Column(
            children: [
              ListTile(title: Text('List Item')),
              ListTile(title: Text('List Item')),
              ListTile(title: Text('List Item')),
            ],
          ),
        ),
        ZetaAccordion(title: 'title'),
        const SizedBox(height: 40),
        Text('Contained'),
        const SizedBox(height: 20),
        ZetaAccordion(
          contained: true,
          key: Key('docs-2'),
          title: 'title',
          child: Column(
            children: [
              ListTile(title: Text('List Item')),
              ListTile(title: Text('List Item')),
              ListTile(title: Text('List Item')),
            ],
          ),
        ),
        ZetaAccordion(
          contained: true,
          title: 'title',
        ),
        const SizedBox(height: 40),
      ],
      // child: SingleChildScrollView(
      //   padding: EdgeInsets.all(Zeta.of(context).spacing.medium),
      //   child: Column(
      //     children: [].divide(const SizedBox.square(dimension: 10)).toList(),
      //   ),
      // ),
    );
  }
}
