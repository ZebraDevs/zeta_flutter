import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class PaginationExample extends StatefulWidget {
  const PaginationExample({super.key});

  @override
  State<PaginationExample> createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      gap: 80,
      name: paginationRoute,
      children: [
        Center(
          child: Text(
            'Current Page: ${currentPage}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          key: Key('docs-pagination'),
          children: [
            ZetaPagination(
              pages: 10,
              currentPage: currentPage,
              onChange: (val) => setState(() => currentPage = val),
              type: ZetaPaginationType.standard,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          key: Key('docs-pagination-dropdown'),
          children: [
            ZetaPagination(
              pages: 10,
              currentPage: currentPage,
              onChange: (val) => setState(() => currentPage = val),
              type: ZetaPaginationType.dropdown,
            ),
          ],
        ),
      ],
    );
  }
}
