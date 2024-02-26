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

  List<Widget> fabs = [];
  @override
  Widget build(BuildContext context) {
    if (fabs.isEmpty) {
      fabs = [
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Small Circle Primary',
          size: ZetaFabSize.small,
          shape: ZetaWidgetBorder.full,
          type: ZetaFabType.primary,
          onPressed: () => setFab(0),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Small Rounded Primary',
          size: ZetaFabSize.small,
          shape: ZetaWidgetBorder.rounded,
          type: ZetaFabType.secondary,
          onPressed: () => setFab(1),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Small Sharp Primary',
          size: ZetaFabSize.small,
          shape: ZetaWidgetBorder.sharp,
          type: ZetaFabType.inverse,
          onPressed: () => setFab(2),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Large Circle Primary',
          size: ZetaFabSize.large,
          shape: ZetaWidgetBorder.full,
          type: ZetaFabType.secondary,
          onPressed: () => setFab(3),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Large Rounded Secondary',
          size: ZetaFabSize.large,
          shape: ZetaWidgetBorder.rounded,
          type: ZetaFabType.inverse,
          onPressed: () => setFab(4),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          label: 'Large Sharp Secondary',
          size: ZetaFabSize.large,
          shape: ZetaWidgetBorder.sharp,
          type: ZetaFabType.primary,
          onPressed: () => setFab(5),
        ),
      ];
    }

    return ExampleScaffold(
      name: 'Button',
      floatingActionButton: fab ?? fabs.first,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Text('Rounded Buttons', style: ZetaTextStyles.displayMedium),
                  Column(children: buttons(ZetaWidgetBorder.rounded)),
                  Text('Sharp Buttons', style: ZetaTextStyles.displayMedium),
                  Column(children: buttons(ZetaWidgetBorder.sharp)),
                  Text('Full Buttons', style: ZetaTextStyles.displayMedium),
                  Column(children: buttons(ZetaWidgetBorder.full)),
                  Text('Icon Buttons', style: ZetaTextStyles.displayLarge),
                  Text('Rounded Buttons', style: ZetaTextStyles.displayMedium),
                  Column(children: inputButtons(ZetaWidgetBorder.rounded)),
                  Text('Sharp Buttons', style: ZetaTextStyles.displayMedium),
                  Column(children: inputButtons(ZetaWidgetBorder.sharp)),
                  Text('Floating Action Buttons', style: ZetaTextStyles.displayMedium),
                  Text('Tap buttons to change current FAB: ', style: ZetaTextStyles.bodyMedium),
                  Wrap(children: fabs.divide(SizedBox.square(dimension: 10)).toList()),
                ].divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
              ),
            ),
            Expanded(child: const SizedBox()),
          ],
        ),
      ),
    );
  }

  List<Widget> buttons(ZetaWidgetBorder borderType) {
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
          ).divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
        ),
      ),
    ).reversed.divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList();
  }

  List<Widget> inputButtons(ZetaWidgetBorder borderType) {
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
                  ? ZetaIcons.delete_round
                  : ZetaIcons.more_horizontal_round,
            ),
          ).divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
        ),
      ),
    ).reversed.divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList();
  }
}
