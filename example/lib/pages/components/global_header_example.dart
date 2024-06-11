import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class GroupHeaderExample extends StatefulWidget {
  static final name = "GlobalHeader";
  const GroupHeaderExample({super.key});

  @override
  State<GroupHeaderExample> createState() => _GroupHeaderExampleState();
}

class _GroupHeaderExampleState extends State<GroupHeaderExample> {
  final childrenOne = List.filled(5, ZetaGlobalHeaderItem(label: 'Button'));
  final childrenTwo = List.filled(10, ZetaGlobalHeaderItem(label: 'Button'));

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: "Global Header",
      child: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: SingleChildScrollView(
            child: Column(children: [
              Text(constraints.maxWidth.toString()),
              ZetaGlobalHeader(
                title: "Title",
                tabItems: childrenOne,
                searchBar: ZetaSearchBar(shape: ZetaWidgetBorder.full, size: ZetaWidgetSize.large),
                onAppsButton: () {},
                actionButtons: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      ZetaIcons.alert_round,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      ZetaIcons.help_round,
                    ),
                  ),
                ],
                avatar: const ZetaAvatar(initials: 'PS'),
              ),
              const SizedBox(height: ZetaSpacing.xl_1),
              ZetaGlobalHeader(title: "Title", tabItems: childrenTwo),
            ]),
          ),
        );
      }),
    );
  }
}
