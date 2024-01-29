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
          buttonLabel: 'Small Circle Primary',
          buttonSize: ZetaFabSize.small,
          buttonShape: ZetaFabShape.circle,
          buttonType: ZetaFabType.primary,
          onPressed: () => setFab(0),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Small Rounded Primary',
          buttonSize: ZetaFabSize.small,
          buttonShape: ZetaFabShape.rounded,
          buttonType: ZetaFabType.primary,
          onPressed: () => setFab(1),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Small Sharp Primary',
          buttonSize: ZetaFabSize.small,
          buttonShape: ZetaFabShape.sharp,
          buttonType: ZetaFabType.primary,
          onPressed: () => setFab(2),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Small Circle Secondary',
          buttonSize: ZetaFabSize.small,
          buttonShape: ZetaFabShape.circle,
          buttonType: ZetaFabType.primarySecond,
          onPressed: () => setFab(3),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Small Circle Secondary',
          buttonSize: ZetaFabSize.small,
          buttonShape: ZetaFabShape.rounded,
          buttonType: ZetaFabType.primarySecond,
          onPressed: () => setFab(4),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Small Sharp Secondary',
          buttonSize: ZetaFabSize.small,
          buttonShape: ZetaFabShape.sharp,
          buttonType: ZetaFabType.primarySecond,
          onPressed: () => setFab(5),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Large Circle Primary',
          buttonSize: ZetaFabSize.large,
          buttonShape: ZetaFabShape.circle,
          buttonType: ZetaFabType.primary,
          onPressed: () => setFab(6),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Large Rounded Primary',
          buttonSize: ZetaFabSize.large,
          buttonShape: ZetaFabShape.rounded,
          buttonType: ZetaFabType.primary,
          onPressed: () => setFab(7),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Large Sharp Primary',
          buttonSize: ZetaFabSize.large,
          buttonShape: ZetaFabShape.sharp,
          buttonType: ZetaFabType.primary,
          onPressed: () => setFab(8),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Large Circle Primary',
          buttonSize: ZetaFabSize.large,
          buttonShape: ZetaFabShape.circle,
          buttonType: ZetaFabType.primarySecond,
          onPressed: () => setFab(9),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Large Rounded Secondary',
          buttonSize: ZetaFabSize.large,
          buttonShape: ZetaFabShape.rounded,
          buttonType: ZetaFabType.primarySecond,
          onPressed: () => setFab(10),
        ),
        ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: 'Large Sharp Secondary',
          buttonSize: ZetaFabSize.large,
          buttonShape: ZetaFabShape.sharp,
          buttonType: ZetaFabType.primarySecond,
          onPressed: () => setFab(11),
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
                  Column(children: buttons(BorderType.rounded)),
                  Text('Sharp Buttons', style: ZetaTextStyles.displayMedium),
                  Column(children: buttons(BorderType.sharp)),
                  Text('Full Buttons', style: ZetaTextStyles.displayMedium),
                  Column(children: buttons(BorderType.full)),
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

  List<Widget> buttons(BorderType borderType) {
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
}
