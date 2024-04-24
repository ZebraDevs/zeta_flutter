import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class GroupHeaderExample extends StatefulWidget {
  static final name = "GroupHeader";
  const GroupHeaderExample({super.key});

  @override
  State<GroupHeaderExample> createState() => _GroupHeaderExampleState();
}

class _GroupHeaderExampleState extends State<GroupHeaderExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: "GroupHeader",
      child: Center(
        child: SingleChildScrollView(
          child: ZetaGlobalHeader(
            title: "Title",
          ),
        ),
      ),
    );
  }
}
