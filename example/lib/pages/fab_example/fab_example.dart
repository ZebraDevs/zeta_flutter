import 'package:flutter/material.dart';
import 'package:zeta_example/pages/fab_example/primary_fab.dart';
import 'package:zeta_example/pages/button_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../home.dart';
import '../../widgets.dart';

class FABExample extends StatelessWidget {
  static const String name = 'FAB';

  const FABExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final colors = BuildExampleButtonColors(theme: theme);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ExampleScaffold(
          name: FABExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.m),
            child: getFABExampleColumn(colors),
          ),
        );
      },
    );
  }
}

Widget getFABExampleColumn(BuildExampleButtonColors colors) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZetaButton.filled(
          label: 'Primary small circle',
          colors: colors.primaryColors,
          onPressed: () => router.pushNamed(FabPrimarySmallCircle.name),
          icon: ZetaIcons.arrow_forward_round,
          iconOnRight: true,
        ),
        ZetaButton.filled(
          label: 'Primary small rounded',
          colors: colors.primaryColors,
          onPressed: () => router.pushNamed(FabPrimarySmallRounded.name),
          icon: ZetaIcons.arrow_forward_round,
          iconOnRight: true,
        ),
        ZetaButton.filled(
          label: 'Primary second small sharp',
          colors: colors.primaryVariantColors,
          onPressed: () => router.pushNamed(FabPrimarySecondSmallSharp.name),
          icon: ZetaIcons.arrow_forward_round,
          iconOnRight: true,
        ),
        ZetaButton.filled(
          label: 'Primary second large circle',
          colors: colors.primaryVariantColors,
          onPressed: () => router.pushNamed(FabPrimarySecondLargeCircle.name),
          icon: ZetaIcons.arrow_forward_round,
          iconOnRight: true,
        ),
        ZetaButton.outlined(
          label: 'Inverse large rounded',
          colors: colors.outlinedSubtle,
          onPressed: () => router.pushNamed(FabInverseLargeRounded.name),
          icon: ZetaIcons.arrow_forward_round,
          iconOnRight: true,
        ),
        ZetaButton.outlined(
          label: 'Inverse large sharp',
          colors: colors.outlinedSubtle,
          onPressed: () => router.pushNamed(FabInverseLargeSharp.name),
          icon: ZetaIcons.arrow_forward_round,
          iconOnRight: true,
        ),
      ],
    );

Widget getFABScaffold(
    ZetaFabShape shape, ZetaFabSize size, ZetaFabType type, ScrollController scrollController, String name) {
  return ExampleScaffold(
    floatingActionButton: ZetaFAB(
      buttonLabel: 'Label',
      scrollController: scrollController,
      onPressed: () {},
      buttonShape: shape,
      buttonSize: size,
      buttonType: type,
    ),
    name: name,
    child: ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (context, index) => ListTile(
        title: Text('Item $index'),
      ),
    ),
  );
}
