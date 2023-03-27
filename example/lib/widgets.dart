// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

const Color exampleBlue = Color(0xCCc0dcf9);
const Color exampleBlueDark = Color(0xFF7bb7f5);

class ExampleModel {
  final Widget example;
  final String code;
  final String token;
  final String? description;
  final Widget? wDescription;

  const ExampleModel({
    required this.example,
    required this.token,
    required this.code,
    this.description,
    this.wDescription,
  });
}

class ExampleBuilder extends StatelessWidget {
  final ExampleModel model;
  const ExampleBuilder(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        ).squish(ZetaSpacing.x9).inline(ZetaSpacing.x4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CodeExample(code: model.token),
              if (model.description != null) ZetaText(model.description),
              if (model.wDescription != null) model.wDescription!,
              model.example,
              Container(color: const Color(0xFFF5F5F5)),
              CodeExample(code: model.code, fill: true),
            ],
          ),
        ),
        const SizedBox(height: 7, width: 7).squish(ZetaSpacing.x9).inline(ZetaSpacing.x4),
      ],
    );
  }
}

class ExampleScaffold extends StatelessWidget {
  final String name;
  final Widget child;

  const ExampleScaffold({required this.name, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SelectionArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.x2, vertical: ZetaSpacing.x6),
              child: child,
            ),
          ),
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
                          child: const ZetaText('Flutter'),
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
