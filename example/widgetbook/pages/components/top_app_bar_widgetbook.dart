import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget defaultTopAppBarUseCase(BuildContext context) {
  final title = context.knobs.string(label: "Title", initialValue: "Title");
  final type = context.knobs.list(
    label: "Title Alignment",
    options: [
      ZetaTopAppBarType.defaultAppBar,
      ZetaTopAppBarType.centeredTitle,
    ],
    initialOption: ZetaTopAppBarType.defaultAppBar,
    labelBuilder: (option) {
      return option == ZetaTopAppBarType.defaultAppBar ? 'Left' : 'Center';
    },
  );
  final enabledActions = context.knobs.boolean(
    label: "Enabled actions",
    initialValue: true,
  );
  final leadingIcon = iconKnob(context, name: 'Leading Icon', initial: ZetaIcons.hamburger_menu);

  return WidgetbookScaffold(
      backgroundColor: Colors.green,
      removeBody: true,
      builder: (context, _) => Column(
            children: [
              ZetaTopAppBar(
                leading: IconButton(
                  onPressed: () {},
                  icon: ZetaIcon(leadingIcon),
                ),
                type: type,
                title: Text(title),
                actions: enabledActions
                    ? [
                        IconButton(
                          onPressed: () {},
                          icon: ZetaIcon(Icons.language),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: ZetaIcon(Icons.favorite),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: ZetaIcon(ZetaIcons.more_vertical),
                        )
                      ]
                    : null,
              ),
            ],
          ));
}

Widget searchTopAppBarUseCase(BuildContext context) {
  return WidgetbookScaffold(
    backgroundColor: Colors.green,
    removeBody: true,
    builder: (context, _) => Column(children: [_SearchUseCase()]),
  );
}

class _SearchUseCase extends StatefulWidget {
  const _SearchUseCase();

  @override
  State<_SearchUseCase> createState() => _SearchUseCaseState();
}

class _SearchUseCaseState extends State<_SearchUseCase> {
  late final searchController = ZetaSearchController();

  @override
  Widget build(BuildContext context) {
    final title = context.knobs.string(label: "Title", initialValue: "Title");
    final type = context.knobs.list(
      label: "Title Alignment",
      options: [
        ZetaTopAppBarType.defaultAppBar,
        ZetaTopAppBarType.centeredTitle,
      ],
      initialOption: ZetaTopAppBarType.defaultAppBar,
      labelBuilder: (option) {
        return option == ZetaTopAppBarType.defaultAppBar ? 'Left' : 'Center';
      },
    );

    final leadingIcon = iconKnob(context, name: 'Leading Icon', initial: ZetaIcons.hamburger_menu);

    final enabledSpeechRecognition = context.knobs.boolean(
      label: "Enabled speech recognition",
      description:
          "Randomly generated text. There is no real speech recognition. That is just for testing the functionality",
      initialValue: false,
    );

    return ZetaTopAppBar(
      leading: IconButton(
        onPressed: () {},
        icon: ZetaIcon(leadingIcon),
      ),
      type: type,
      title: Text(title),
      searchController: searchController,
      onSearchMicrophoneIconPressed: enabledSpeechRecognition
          ? () {
              var sampleTexts = ['This is a sample text', 'Another sample', 'Speech recognition text', 'Example'];

              var generatedText = sampleTexts[Random().nextInt(sampleTexts.length)];

              searchController.text = generatedText;
            }
          : null,
      actions: [
        IconButton(
            onPressed: () {
              searchController.isEnabled ? searchController.closeSearch() : searchController.startSearch();
            },
            icon: ZetaIcon(ZetaIcons.search)),
      ],
    );
  }
}

Widget extendedTopAppBarUseCase(BuildContext context) => ExtendedSearch();

class ExtendedSearch extends StatefulWidget {
  const ExtendedSearch({super.key});

  @override
  State<ExtendedSearch> createState() => _ExtendedSearchState();
}

class _ExtendedSearchState extends State<ExtendedSearch> {
  final _searchControllerExtended = ZetaSearchController();

  void _showHideSearchExtended() {
    _searchControllerExtended.isEnabled
        ? _searchControllerExtended.closeSearch()
        : _searchControllerExtended.startSearch();
  }

  @override
  Widget build(BuildContext context) {
    final title = context.knobs.string(label: "Title", initialValue: "Title");

    final leadingIcon = iconKnob(context, name: 'Leading Icon', initial: ZetaIcons.hamburger_menu);

    final showSearch = context.knobs.boolean(label: 'Search variant', initialValue: false);

    return WidgetbookScaffold(
      removeBody: true,
      builder: (context, constraints) => SafeArea(
        child: SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: CustomScrollView(
            slivers: [
              ZetaTopAppBar.extended(
                leading: IconButton(icon: ZetaIcon(leadingIcon), onPressed: () {}),
                title: Text(title),
                actions: showSearch
                    ? [
                        IconButton(
                          onPressed: _showHideSearchExtended,
                          icon: ZetaIcon(ZetaIcons.search),
                        )
                      ]
                    : [
                        IconButton(
                          onPressed: () {},
                          icon: ZetaIcon(Icons.language),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: ZetaIcon(Icons.favorite),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: ZetaIcon(ZetaIcons.more_vertical),
                        )
                      ],
                searchController: showSearch ? _searchControllerExtended : null,
                onSearch: showSearch ? (text) => debugPrint('search text: $text') : null,
                onSearchMicrophoneIconPressed: showSearch
                    ? () async {
                        var sampleTexts = [
                          'This is a sample text',
                          'Another sample',
                          'Speech recognition text',
                          'Example'
                        ];
                        var generatedText = sampleTexts[Random().nextInt(sampleTexts.length)];
                        _searchControllerExtended.text = generatedText;
                      }
                    : null,
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
  }
}

class Painter extends CustomPainter {
  final BuildContext context;
  final BoxConstraints constraints;
  Painter({super.repaint, required this.context, required this.constraints});

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -(constraints.maxWidth + 1000); i < constraints.maxWidth; i += 50) {
      var p1 = Offset(i, -10);
      var p2 = Offset(constraints.maxHeight + i, constraints.maxHeight * 4);
      var paint = Paint()
        ..color = Zeta.of(context).colors.mainPrimary
        ..strokeWidth = Zeta.of(context).spacing.minimum;
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => oldDelegate != this;
}
