import 'package:flutter/material.dart';

abstract class ExampleWidget {
  abstract final String name;
}

class ExampleScaffold extends StatelessWidget {
  final String name;
  final List<Widget> children;
  const ExampleScaffold({required this.name, required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
