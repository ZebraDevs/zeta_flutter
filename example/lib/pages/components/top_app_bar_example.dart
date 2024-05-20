import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TopAppBarExample extends StatefulWidget {
  const TopAppBarExample({super.key});

  static const String name = 'TopAppBar';

  @override
  State<TopAppBarExample> createState() => _TopAppBarExampleState();
}

class _TopAppBarExampleState extends State<TopAppBarExample> {
  final _searchControllerExtended = AppBarSearchController();
  final _searchControllerRegular = AppBarSearchController();

  void _showHideSearchExtended() {
    _searchControllerExtended.isEnabled
        ? _searchControllerExtended.closeSearch()
        : _searchControllerExtended.startSearch();
  }

  void _showHideSearchRegular() {
    _searchControllerRegular.isEnabled
        ? _searchControllerRegular.closeSearch()
        : _searchControllerRegular.startSearch();
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: "https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg",
      placeholder: (context, url) => Icon(ZetaIcons.user_round),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    );
    final colors = Zeta.of(context).colors;

    return ExampleScaffold(
      name: TopAppBarExample.name,
      child: ColoredBox(
        color: colors.surfaceSecondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Default', style: ZetaTextStyles.titleLarge),
              ZetaTopAppBar(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu_rounded),
                ),
                title: Row(
                  children: [
                    ZetaAvatar(size: ZetaAvatarSize.xs, image: image),
                    Padding(
                      padding: const EdgeInsets.only(left: ZetaSpacing.s),
                      child: Text("Title"),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.language),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.more_vertical_round),
                  )
                ],
              ),
              Text('Centered', style: ZetaTextStyles.titleLarge),
              ZetaTopAppBar(
                type: ZetaTopAppBarType.centeredTitle,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu_rounded),
                ),
                title: Text("Title"),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.account_circle),
                  ),
                ],
              ),
              Text('Contextual', style: ZetaTextStyles.titleLarge),
              ZetaTopAppBar(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(ZetaIcons.close_round),
                ),
                title: Text("2 items"),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.edit_round),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.share_round),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.delete_round),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.more_vertical_round),
                  ),
                ],
              ),
              Text('Search', style: ZetaTextStyles.titleLarge),
              ZetaTopAppBar(
                type: ZetaTopAppBarType.centeredTitle,
                leading: BackButton(),
                title: Text("Title"),
                actions: [
                  IconButton(
                    onPressed: _showHideSearchRegular,
                    icon: Icon(ZetaIcons.search_round),
                  )
                ],
                searchController: _searchControllerRegular,
                onSearch: (text) => debugPrint('search text: $text'),
                onSearchMicrophoneIconPressed: () async {
                  var sampleTexts = ['This is a sample text', 'Another sample', 'Speech recognition text', 'Example'];

                  var generatedText = sampleTexts[Random().nextInt(sampleTexts.length)];

                  _searchControllerRegular.text = generatedText;
                },
              ),
              Text('Extended', style: ZetaTextStyles.titleLarge),
              SizedBox(
                width: 800,
                height: 200,
                child: CustomScrollView(
                  slivers: [
                    ZetaTopAppBar.extended(
                      leading: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu_rounded),
                      ),
                      title: Row(
                        children: [
                          ZetaAvatar(size: ZetaAvatarSize.xs, image: image),
                          Padding(
                            padding: const EdgeInsets.only(left: ZetaSpacing.s),
                            child: Text("Title"),
                          ),
                        ],
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.language),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(ZetaIcons.more_vertical_round),
                        )
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 800,
                        height: 800,
                        color: Zeta.of(context).colors.surfaceSecondary,
                        child: CustomPaint(
                          painter: Painter(colors: colors),
                          size: Size(800, 800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text('Extended Search', style: ZetaTextStyles.titleLarge),
              SizedBox(
                width: 800,
                height: 200,
                child: CustomScrollView(
                  slivers: [
                    ZetaTopAppBar.extended(
                      leading: BackButton(),
                      title: Text("Title"),
                      actions: [
                        IconButton(
                          onPressed: _showHideSearchExtended,
                          icon: Icon(ZetaIcons.search_round),
                        )
                      ],
                      searchController: _searchControllerExtended,
                      onSearch: (text) => debugPrint('search text: $text'),
                      onSearchMicrophoneIconPressed: () async {
                        var sampleTexts = [
                          'This is a sample text',
                          'Another sample',
                          'Speech recognition text',
                          'Example'
                        ];
                        var generatedText = sampleTexts[Random().nextInt(sampleTexts.length)];
                        _searchControllerExtended.text = generatedText;
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 800,
                        height: 800,
                        color: Zeta.of(context).colors.surfaceSecondary,
                        child: CustomPaint(
                          painter: Painter(colors: colors),
                          size: Size(800, 800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ].gap(20),
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final ZetaColors colors;

  Painter({super.repaint, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -760; i < 760; i += 50) {
      var p1 = Offset(i, -10);
      var p2 = Offset(800 + i, 810);
      var paint = Paint()
        ..color = colors.primary
        ..strokeWidth = ZetaSpacing.x1;
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => oldDelegate != this;
}
