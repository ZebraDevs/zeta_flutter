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
  final _searchController = ZetaSearchController()..startSearch();

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: "https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg",
      placeholder: (context, url) => Icon(ZetaIcons.user),
      errorWidget: (context, url, error) => Icon(ZetaIcons.error),
      fit: BoxFit.cover,
    );

    return ExampleScaffold(
      name: TopAppBarExample.name,
      paddingAll: 0,
      gap: 4,
      children: [
        Text('Default', style: Zeta.of(context).textStyles.titleLarge),
        ZetaTopAppBar(
          key: Key('docs-top-app-bar-default'),
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          title: Row(
            children: [
              ZetaAvatar(size: ZetaAvatarSize.xs, image: image),
              Padding(
                padding: EdgeInsets.only(left: Zeta.of(context).spacing.medium),
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
              icon: Icon(ZetaIcons.more_vertical),
            )
          ],
        ),
        Text('Centered', style: Zeta.of(context).textStyles.titleLarge),
        ZetaTopAppBar.centered(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          title: Text("Title"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
        Text('Contextual', style: Zeta.of(context).textStyles.titleLarge),
        ZetaTopAppBar(
          key: Key('docs-top-app-bar-contextual'),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(ZetaIcons.close),
          ),
          title: Text("2 items"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(ZetaIcons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(ZetaIcons.share),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(ZetaIcons.delete),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(ZetaIcons.more_vertical),
            ),
          ],
        ),
        Text('Search', style: Zeta.of(context).textStyles.titleLarge),
        ZetaTopAppBar.search(
          key: Key('docs-top-app-bar-search'),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          title: Text("Title"),
          searchController: _searchController,
          onSearch: (text) => debugPrint('search text: $text'),
          onSearchMicrophoneIconPressed: () async {
            var sampleTexts = ['This is a sample text', 'Another sample', 'Speech recognition text', 'Example'];

            var generatedText = sampleTexts[Random().nextInt(sampleTexts.length)];

            _searchController.text = generatedText;
          },
        ),
        Text('Extended', style: Zeta.of(context).textStyles.titleLarge),
        SizedBox(
          key: Key('docs-top-app-bar-extended'),
          height: 200,
          child: CustomScrollView(
            slivers: [
              ZetaTopAppBar.extended(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                ),
                title: Row(
                  children: [
                    ZetaAvatar(size: ZetaAvatarSize.xxxs, image: image),
                    Padding(
                      padding: EdgeInsets.only(left: Zeta.of(context).spacing.medium),
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
                    icon: Icon(ZetaIcons.more_vertical),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: 800,
                  height: 800,
                  color: Zeta.of(context).colors.surfaceSelectedHover,
                  child: CustomPaint(
                    painter: Painter(context: context),
                    size: Size(800, 800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ].gap(20),
    );
  }
}

class Painter extends CustomPainter {
  final BuildContext context;

  Painter({super.repaint, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -760; i < 760; i += 50) {
      var p1 = Offset(i, -10);
      var p2 = Offset(800 + i, 810);
      var paint = Paint()
        ..color = Zeta.of(context).colors.surfaceDefault
        ..strokeWidth = Zeta.of(context).spacing.minimum;
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => oldDelegate != this;
}
