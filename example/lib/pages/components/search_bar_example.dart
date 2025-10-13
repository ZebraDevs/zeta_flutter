import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SearchBarExample extends StatefulWidget {
  const SearchBarExample({Key? key}) : super(key: key);

  @override
  State<SearchBarExample> createState() => _SearchBarExampleState();
}

class _SearchBarExampleState extends State<SearchBarExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: searchBarRoute,
      children: [
        Column(
          spacing: 20,
          children: [
            ZetaSearchBar(
              shape: ZetaWidgetBorder.sharp,
              size: ZetaWidgetSize.small,
              placeholder: 'Small / Sharp',
            ),
            ZetaSearchBar(
              shape: ZetaWidgetBorder.rounded,
              size: ZetaWidgetSize.medium,
              placeholder: 'Medium / Rounded',
            ),
            ZetaSearchBar(
              shape: ZetaWidgetBorder.full,
              size: ZetaWidgetSize.large,
              placeholder: 'Large / Full',
            ),
            ZetaSearchBar(
              placeholder: 'Disabled',
              disabled: true,
            ),
          ],
        ),
      ],
    );
  }
}
