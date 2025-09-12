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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Zeta.of(context).spacing.large,
            children: [
              SizedBox(
                width: 328,
                child: ZetaThemeOverride(
                  contrast: ZetaContrast.aaa,
                  themeMode: ThemeMode.dark,
                  child: Column(
                    children: [
                      Builder(
                        builder: (context) {
                          final zeta = Zeta.of(context);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Override: themeMode=${zeta.themeMode}, contrast=${zeta.contrast}',
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          );
                        },
                      ),
                      ZetaAccordion(
                        inCard: true,
                        children: [
                          ZetaAccordionItem(
                            onTap: () {},
                            child: Placeholder(),
                            title: 'Scanner Configuration',
                            header: Row(
                              spacing: Zeta.of(context).spacing.small,
                              children: [
                                ZetaButton.outlineSubtle(label: 'Action 1', onPressed: () {}),
                                ZetaButton.outlineSubtle(label: 'Action 2', onPressed: () {}),
                                ZetaButton.outlineSubtle(label: 'Action 3', onPressed: () {}),
                              ],
                            ),
                          ),
                          ZetaAccordionItem(title: 'Title', onTap: () {}, child: Placeholder()),
                          ZetaAccordionItem(title: 'Title', onTap: () {}, child: Placeholder()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 328,
                child: ZetaAccordion(
                  inCard: true,
                  children: [
                    ZetaAccordionItem(title: 'Title', onTap: () {}, child: Placeholder(), isSelectable: true),
                    ZetaAccordionItem(title: 'Title', onTap: () {}, child: Placeholder(), isSelectable: true),
                    ZetaAccordionItem(title: 'Title', onTap: () {}, child: Placeholder()),
                  ],
                ),
              ),
              SizedBox(
                width: 328,
                child: ZetaAccordion(
                  inCard: true,
                  children: [
                    ZetaAccordionItem(
                      title: 'Title',
                      onTap: () {},
                      isNavigation: true,
                    ),
                    ZetaAccordionItem(title: 'Title', onTap: () {}, isNavigation: true),
                    ZetaAccordionItem(title: 'Title', onTap: () {}, isNavigation: true),
                  ],
                ),
              ),
            ],
          ).paddingAll(Zeta.of(context).spacing.medium),
        )
      ],
    );
  }
}
