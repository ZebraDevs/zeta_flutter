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

class FabExample extends StatefulWidget {
  static const String name = 'FAB';
  const FabExample({super.key});

  @override
  State<FabExample> createState() => _FabExampleState();
}

class _FabExampleState extends State<FabExample> {
  Widget? fab;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void setFab(int index) => setState(() => fab = fabs[index]);

  List<ZetaFAB> fabs = [];

  @override
  Widget build(BuildContext context) {
    if (fabs.isEmpty) {
      fabs = [
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Small Circle Disabled',
          size: ZetaFabSize.small,
          expanded: false,
          shape: ZetaWidgetBorder.full,
          type: ZetaFabType.primary,
        ),
        ZetaFAB(
          scrollController: _scrollController,
          expanded: false,
          label: 'Small Rounded Secondary',
          size: ZetaFabSize.small,
          shape: ZetaWidgetBorder.rounded,
          type: ZetaFabType.secondary,
          onPressed: () => setFab(1),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Small Sharp Inverse',
          size: ZetaFabSize.small,
          shape: ZetaWidgetBorder.sharp,
          expanded: false,
          type: ZetaFabType.inverse,
          onPressed: () => setFab(2),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Large Circle Secondary',
          size: ZetaFabSize.large,
          shape: ZetaWidgetBorder.full,
          type: ZetaFabType.secondary,
          expanded: false,
          onPressed: () => setFab(3),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Large Rounded Inverse',
          size: ZetaFabSize.large,
          shape: ZetaWidgetBorder.rounded,
          expanded: false,
          type: ZetaFabType.inverse,
          onPressed: () => setFab(4),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Large Sharp Primary',
          size: ZetaFabSize.large,
          shape: ZetaWidgetBorder.sharp,
          type: ZetaFabType.primary,
          expanded: false,
          onPressed: () => setFab(5),
        ),
      ];
    }
    final ZetaFAB theFab = (fab as ZetaFAB?) ?? (fabs.first);
    return ExampleScaffold(
      name: FabExample.name,
      floatingActionButton: ZetaFAB(
        expanded: true,
        icon: theFab.icon,
        label: theFab.label,
        scrollController: _scrollController,
        size: theFab.size,
        type: theFab.type,
        shape: theFab.shape,
        onPressed: theFab.onPressed,
      ),
      children: [
        Text('Floating Action Buttons', style: ZetaTextStyles.displayMedium),
        Text('Tap buttons to change current FAB: ', style: ZetaTextStyles.bodyMedium),
        Wrap(children: fabs.divide(SizedBox.square(dimension: 10)).toList()),
        SizedBox(height: 200),
        Column(
          key: Key('docs-fab'),
          spacing: 8,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ZetaFAB(
                    onPressed: () => {},
                    expanded: false,
                  ),
                ),
                Expanded(
                  child: ZetaFAB(
                    onPressed: () => {},
                    label: 'Add',
                  ).paddingTop(2),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ZetaFAB(
                    onPressed: () => {},
                    label: 'Edit',
                    expanded: false,
                    shape: ZetaWidgetBorder.rounded,
                    type: ZetaFabType.secondary,
                    icon: ZetaIcons.edit,
                  ),
                ),
                Expanded(
                  child: ZetaFAB(
                    onPressed: () => {},
                    shape: ZetaWidgetBorder.rounded,
                    label: 'Edit',
                    icon: ZetaIcons.edit,
                    type: ZetaFabType.secondary,
                  ).paddingTop(2),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ZetaFAB(
                    onPressed: () => {},
                    label: 'Share',
                    icon: ZetaIcons.share,
                    expanded: false,
                    shape: ZetaWidgetBorder.sharp,
                    type: ZetaFabType.inverse,
                    size: ZetaFabSize.large,
                  ),
                ),
                Expanded(
                  child: ZetaFAB(
                    onPressed: () => {},
                    shape: ZetaWidgetBorder.sharp,
                    label: 'Share',
                    icon: ZetaIcons.share,
                    type: ZetaFabType.inverse,
                    size: ZetaFabSize.large,
                  ).paddingTop(2),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
