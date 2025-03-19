import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ButtonExample extends StatefulWidget {
  static const String name = 'Button';

  const ButtonExample({super.key});

  @override
  State<ButtonExample> createState() => _ButtonExampleState();
}

class _ButtonExampleState extends State<ButtonExample> {
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
      name: 'Button',
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
        Text('Regular Buttons', style: ZetaTextStyles.displayMedium).paddingAll(8),
        Column(children: buttons(null), key: Key('docs')),
        Column(
          children: [
            Text('Full Buttons', style: ZetaTextStyles.displayMedium),
            Column(children: buttons(ZetaWidgetBorder.full)),
            Text('Icon Buttons', style: ZetaTextStyles.displayLarge),
            Column(children: iconButtons(null)),
            Text('Full Icon Buttons', style: ZetaTextStyles.displayMedium),
            Column(children: iconButtons(ZetaWidgetBorder.full)),
            Text('Group Buttons', style: ZetaTextStyles.displayLarge),
            Column(children: groupButtons(null)),
            Text('Floating Action Buttons', style: ZetaTextStyles.displayMedium),
            Text('Tap buttons to change current FAB: ', style: ZetaTextStyles.bodyMedium),
            Wrap(children: fabs.divide(SizedBox.square(dimension: 10)).toList()),
          ],
        ).paddingAll(8),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: SingleChildScrollView(
        //     controller: _scrollController,
        //     child: Row(
        //       children: [
        //         Expanded(
        //           flex: 8,
        //           child: Column(
        //             children: [].divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }

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
              icon: ZetaButtonType.values[index2] == ZetaButtonType.negative
                  ? ZetaIcons.delete
                  : ZetaIcons.more_horizontal,
            ),
          ).divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
        ),
      ),
    ).reversed.divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList();
  }

  List<Widget> groupButtons(ZetaWidgetBorder? ZetaWidgetBorder) {
    return [
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
            onChange: (item) {
              print(item);
            },
            label: "Label",
            items: [
              ZetaDropdownItem(
                value: 'Item 1',
                icon: ZetaIcon(ZetaIcons.star_half),
              ),
              ZetaDropdownItem(value: 'Item 2'),
            ],
          ),
          ZetaGroupButton.icon(
            icon: ZetaIcons.star,
            label: "Label",
          ),
        ],
      ),
      ZetaButtonGroup(
        isLarge: true,
        buttons: [
          ZetaGroupButton.icon(
            icon: ZetaIcons.star,
            label: "Label",
            onPressed: () {},
          ),
          ZetaGroupButton.icon(
            icon: ZetaIcons.star,
            label: "Label",
            onPressed: () {},
          ),
          ZetaGroupButton.icon(
            icon: ZetaIcons.star,
            label: "Label",
            onPressed: () {},
          ),
        ],
      ),
    ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList();
  }
}
