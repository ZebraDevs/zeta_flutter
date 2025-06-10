import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ButtonExample extends StatelessWidget {
  static const String name = 'Buttons/Button';
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons(ZetaWidgetBorder? borderType) {
      return List.generate(
        ZetaWidgetSize.values.length + 1,
        (index) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              ZetaButtonType.values.length,
              (index2) => ZetaButton(
                label: 'Button',
                onPressed: index == 0 ? null : () {},
                type: ZetaButtonType.values[index2],
                size: ZetaWidgetSize.values[index == 0 ? 0 : index - 1],
                borderType: borderType,
              ),
            ).divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
          ),
        ),
      ).reversed.divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList();
    }

    return ExampleScaffold(
      name: ButtonExample.name,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buttons(null),
          key: Key('docs-button'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buttons(ZetaWidgetBorder.full),
          key: Key('docs-button-full'),
        ),
      ],
    );
  }
}

class IconButtonExample extends StatelessWidget {
  static const String name = 'Buttons/IconButton';
  const IconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      ZetaIcons.hamburger_menu,
      ZetaIcons.activity,
      ZetaIcons.star,
      ZetaIcons.barcode,
      ZetaIcons.adjustments,
      ZetaIcons.server,
      ZetaIcons.group,
    ];

    List<Widget> iconButtons(ZetaWidgetBorder? borderType) {
      return List.generate(
        ZetaWidgetSize.values.length + 1,
        (index) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              ZetaButtonType.values.length,
              (index2) => ZetaIconButton(
                onPressed: index == 0 ? null : () {},
                type: ZetaButtonType.values[index2],
                size: ZetaWidgetSize.values[index == 0 ? 0 : index - 1],
                borderType: borderType,
                icon: icons[index2],
              ),
            ).divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
          ),
        ),
      ).reversed.divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList();
    }

    return ExampleScaffold(name: name, children: [
      Column(
        children: iconButtons(null),
        crossAxisAlignment: CrossAxisAlignment.start,
        key: Key('docs-icon-button'),
      ),
      Column(
        children: iconButtons(ZetaWidgetBorder.full),
        crossAxisAlignment: CrossAxisAlignment.start,
        key: Key('docs-icon-button-full'),
      ),
    ]);
  }
}

class ButtonGroupExample extends StatelessWidget {
  const ButtonGroupExample({super.key});
  static const String name = 'ButtonGroup';

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: name, children: [
      Column(
        key: Key('docs-button-group'),
        children: [
          ZetaButtonGroup(isLarge: true, buttons: [
            ZetaGroupButton(
              onPressed: () {},
              label: "Label",
            ),
            ZetaGroupButton(
              onPressed: () {},
              label: "Label",
            ),
          ]),
          ZetaButtonGroup(isLarge: true, buttons: [
            ZetaGroupButton(
              onPressed: () {},
              label: "Label",
              icon: ZetaIcons.star,
            ),
            ZetaGroupButton.dropdown(
              onChange: print,
              label: "Label",
              items: [
                ZetaDropdownItem(value: 'Item 1'),
                ZetaDropdownItem(value: 'Item 2'),
              ],
            ),
          ]),
          ZetaButtonGroup(
            isLarge: true,
            isInverse: true,
            buttons: [
              ZetaGroupButton.icon(
                icon: ZetaIcons.star,
                onPressed: () {},
                label: "Label",
              ),
              ZetaGroupButton.dropdown(
                icon: ZetaIcons.star,
                onChange: (_) {},
                label: "Label",
                items: [
                  ZetaDropdownItem(value: 'Item 1', icon: Icon(ZetaIcons.star_half)),
                  ZetaDropdownItem(value: 'Item 2'),
                ],
              ),
              ZetaGroupButton.icon(icon: ZetaIcons.star, label: "Label"),
            ],
          ),
        ].gap(16),
      )
    ]);
  }
}

class FabExample extends StatelessWidget {
  static const String name = 'FAB';
  const FabExample({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building FAB Example');

    return ExampleScaffold(
      name: FabExample.name,
      children: [
        ZetaFAB(
          onPressed: () => {},
          expanded: false,
        )
      ],
    );
  }
}
