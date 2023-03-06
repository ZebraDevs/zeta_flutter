import 'package:flutter/material.dart';
import 'package:zeta_example/pages/grid_example.dart';
import 'package:zeta_example/pages/spacing_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final List<Map<String, Widget>> components = [
  {'Grid': const GridExample()},
  {'Spacing': const SpacingExample()},
];

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Zeta')),
        body: ListView.builder(
          itemCount: components.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(components[index].keys.first),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text(components[index].keys.first)),
                    body: SelectionArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: x10, horizontal: x4),
                          child: components[index].values.first,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
