import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class PaginationExample extends StatefulWidget {
  static const name = 'Pagination';

  const PaginationExample({super.key});

  @override
  State<PaginationExample> createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: PaginationExample.name,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(ZetaSpacing.xl_9),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Current Page: ${currentPage}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              ZetaPagination(
                pages: 10,
                currentPage: currentPage,
                onChange: (val) => setState(() {
                  currentPage = val;
                }),
              ),
              const SizedBox(height: 8),
              ZetaPagination(
                pages: 10,
                currentPage: currentPage,
                onChange: (val) => setState(() {
                  currentPage = val;
                }),
                type: ZetaPaginationType.dropdown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
