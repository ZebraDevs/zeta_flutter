import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String appBarPath = '$componentsPath/Top App Bar';

@widgetbook.UseCase(
  name: 'Default',
  type: ZetaTopAppBar,
  path: appBarPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-7212&t=eEOivHU9uV4K8qJq-4',
)
Widget defaultTopAppBar(BuildContext context) => ZetaTopAppBar(
      leading: IconButton(
        icon: ZetaIcon(iconKnob(context, name: 'Leading Icon', initial: ZetaIcons.hamburger_menu)),
        onPressed: () {},
      ),
      title: Text(context.knobs.string(label: 'Title', initialValue: 'Title')),
      actions: context.knobs.boolean(label: 'Enabled actions', initialValue: true)
          ? [
              IconButton(onPressed: () {}, icon: const ZetaIcon(Icons.language)),
              IconButton(onPressed: () {}, icon: const ZetaIcon(Icons.favorite)),
              IconButton(onPressed: () {}, icon: const ZetaIcon(ZetaIcons.more_vertical)),
            ]
          : [],
    );

@widgetbook.UseCase(
  name: 'Centered',
  type: ZetaTopAppBar,
  path: appBarPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-7224&t=QGJWipbvqxlvCtMR-4',
)
Widget centered(BuildContext context) => ZetaTopAppBar(
      leading: IconButton(
        onPressed: () {},
        icon: ZetaIcon(iconKnob(context, name: 'Leading Icon', initial: ZetaIcons.hamburger_menu)),
      ),
      type: ZetaTopAppBarType.centered,
      title: Text(context.knobs.string(label: 'Title', initialValue: 'Title')),
      actions: context.knobs.boolean(
        label: 'Enabled actions',
        initialValue: true,
      )
          ? [
              IconButton(
                onPressed: () {},
                icon: const ZetaIcon(Icons.account_circle),
              ),
            ]
          : [],
    );

@widgetbook.UseCase(
  name: 'Contextual',
  type: ZetaTopAppBar,
  path: appBarPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-7224&t=QGJWipbvqxlvCtMR-4',
)
Widget contextual(BuildContext context) => ZetaTopAppBar(
      leading: IconButton(
        onPressed: () {},
        icon: ZetaIcon(iconKnob(context, name: 'Leading Icon', initial: ZetaIcons.close)),
      ),
      title: Text(context.knobs.string(label: 'Title', initialValue: 'Title')),
      actions: context.knobs.boolean(
        label: 'Enabled actions',
        initialValue: true,
      )
          ? [
              IconButton(
                onPressed: () {},
                icon: const ZetaIcon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const ZetaIcon(Icons.share),
              ),
              IconButton(
                onPressed: () {},
                icon: const ZetaIcon(Icons.delete),
              ),
              IconButton(
                onPressed: () {},
                icon: const ZetaIcon(Icons.more_vert),
              ),
            ]
          : [],
    );

final searchController = ZetaSearchController()..startSearch();

@widgetbook.UseCase(
  name: 'Search',
  type: ZetaTopAppBar,
  path: appBarPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-7226&t=QGJWipbvqxlvCtMR-4',
)
Widget search(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaTopAppBar.search(
        leading: IconButton(
          onPressed: () {},
          icon: ZetaIcon(iconKnob(context, name: 'Leading Icon', initial: ZetaIcons.arrow_back)),
        ),
        searchController: searchController,
        onSearchMicrophoneIconPressed: context.knobs.boolean(
          label: 'Enabled speech recognition',
          description:
              'Randomly generated text. There is no real speech recognition. That is just for testing the functionality',
        )
            ? () {
                searchController.startSearch();
                const sampleTexts = ['This is a sample text', 'Another sample', 'Speech recognition text', 'Example'];
                final generatedText = sampleTexts[Random().nextInt(sampleTexts.length)];
                searchController.text = generatedText;
              }
            : null,
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Extended',
  type: ZetaTopAppBar,
  path: appBarPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-7227&t=QGJWipbvqxlvCtMR-4',
)
Widget extendedTopAppBarUseCase(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: CustomScrollView(
              slivers: [
                ZetaTopAppBar.extended(
                  leading: IconButton(
                    icon: ZetaIcon(iconKnob(context, name: 'Leading Icon', initial: ZetaIcons.hamburger_menu)),
                    onPressed: () {},
                  ),
                  title: Text(context.knobs.string(label: 'Title', initialValue: 'Large Title')),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const ZetaIcon(Icons.language),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const ZetaIcon(Icons.favorite),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const ZetaIcon(ZetaIcons.more_vertical),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 4,
                    color: Zeta.of(context).colors.surfaceSecondary,
                    child: CustomPaint(
                      painter: Painter(context: context, constraints: constraints),
                      size: Size(constraints.maxWidth, constraints.maxHeight * 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class Painter extends CustomPainter {
  Painter({super.repaint, required this.context, required this.constraints});
  final BuildContext context;
  final BoxConstraints constraints;

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = -(constraints.maxWidth + 1000); i < constraints.maxWidth; i += 50) {
      final p1 = Offset(i, -10);
      final p2 = Offset(constraints.maxHeight + i, constraints.maxHeight * 4);
      final paint = Paint()
        ..color = Zeta.of(context).colors.mainPrimary
        ..strokeWidth = Zeta.of(context).spacing.minimum;
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => oldDelegate != this;
}
