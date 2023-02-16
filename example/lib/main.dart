import 'package:flutter/material.dart';
import 'package:zeta_example/pages/grid_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final List components = [
  GridExample(),
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
              title: Text(components[index].name),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => components[index])),
            );
          }),
        ),
      ),
    );
  }
}
