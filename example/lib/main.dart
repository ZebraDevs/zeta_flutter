import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

final List<Component> components = [
  Component('Grid', const GridExample()),
  Component('Spacing', const SpacingExample()),
];

class Component {
  final String name;
  final Widget page;

  Component(this.name, this.page);
}

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
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text(components[index].name)),
                    body: SelectionArea(
                      child: Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.x2, vertical: ZetaSpacing.x6),
                            child: components[index].page,
                          ),
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

class CodeExample extends StatelessWidget {
  final String code;
  final bool fill;
  const CodeExample({required this.code, this.fill = false, super.key});

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      color: const Color(0xFFF5F5F5),
      padding: ZetaSpacing.x4.square,
      child: Text(code, style: GoogleFonts.ibmPlexMono()),
    );
    return (fill
            ? Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: const Color(0xFFE9E9E9),
                          padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.x5, vertical: ZetaSpacing.x2),
                          child: const Text('Flutter'),
                        ),
                        Row(
                          children: [Expanded(child: widget)],
                        ),
                      ],
                    ),
                  )
                ],
              )
            : widget)
        .squish(ZetaSpacing.x4);
  }
}

const Color exampleBlue = Color(0xCCc0dcf9);
const Color exampleBlueDark = Color(0xFF7bb7f5);
