import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

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
                Text('Rounded Divider'),
                const SizedBox(height: 20),
                ZetaAccordion(
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
                    ZetaAccordionSection(disabled: true, title: Text('Title Default Disabled'), body: Text('...')),
                  ],
                ),
                const SizedBox(height: 40),
                Text('Rounded Contained'),
                const SizedBox(height: 20),
                ZetaAccordion(
                  contained: true,
                  children: [
                    ZetaAccordionSection(
                      title: Text('Title Contained Enabled'),
                      body: Column(
                        children: [
                          ListTile(title: Text('List Item')),
                          ListTile(title: Text('List Item')),
                          ListTile(title: Text('List Item')),
                        ],
                      ),
                    ),
                    ZetaAccordionSection(disabled: true, title: Text('Title Contained Disabled'), body: Text('...')),
                  ],
                ),
                const SizedBox(height: 40),
                Text('Sharp Divider'),
                const SizedBox(height: 20),
                ZetaAccordion(
                  contained: false,
                  rounded: false,
                  children: [
                    ZetaAccordionSection(
                      title: Text('Title Contained Sharp Enabled'),
                      body: Center(child: Icon(Icons.image_outlined, size: 300)),
                    ),
                    ZetaAccordionSection(
                      disabled: true,
                      title: Text('Title Contained Sharp Disabled'),
                      body: Text('...'),
                    ),
                  ],
                ),
                Text('Sharp Contained'),
                const SizedBox(height: 20),
                ZetaAccordion(
                  contained: true,
                  rounded: false,
                  children: [
                    ZetaAccordionSection(
                      title: Text('Title'),
                      body: Center(child: Icon(Icons.image_outlined, size: 300)),
                    ),
                    ZetaAccordionSection(disabled: true, title: Text('Title'), body: Text('...')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
