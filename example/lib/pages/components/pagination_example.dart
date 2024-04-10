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
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: PaginationExample.name,
      child: ZetaPagination(pages: 10000),
    );
  }
}
