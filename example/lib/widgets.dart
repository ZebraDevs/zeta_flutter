import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

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
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, shape: BoxShape.circle),
        ).squish(Dimensions.x9).inline(Dimensions.x4),
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
        const SizedBox(height: 7, width: 7).squish(Dimensions.x9).inline(Dimensions.x4),
      ],
    );
  }
}

class ExampleScaffold extends StatelessWidget {
  final String name;
  final Widget child;
  final List<Widget> actions;

  const ExampleScaffold({
    required this.name,
    required this.child,
    this.actions = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        actions: [
          ...actions,
        ],
      ),
      body: SelectionArea(
        child: child,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Row(
            children: [
              const Spacer(),
              ZetaText('DarkMode'),
              Switch.adaptive(
                value: Zeta.of(context).themeMode == ThemeMode.dark,
                onChanged: (isDarkMode) {
                  ZetaProvider.of(context).updateThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
                },
              ),
              const SizedBox(width: Dimensions.s),
              ZetaText('AAA '),
              Switch.adaptive(
                value: Zeta.of(context).contrast == ZetaContrast.aaa,
                onChanged: (isAAA) {
                  ZetaProvider.of(context).updateContrast(isAAA ? ZetaContrast.aaa : ZetaContrast.aa);
                },
              ),
            ],
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
    var colors = Zeta.of(context).colors;
    final widget = Container(
      color: colors.surfaceDisabled,
      padding: Dimensions.x4.square,
      child: Text(code, style: GoogleFonts.ibmPlexMono(color: colors.textDefault)),
    );

    return (fill
            ? Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FlutterWordMark(),
                        Row(children: [Expanded(child: widget)]),
                      ],
                    ),
                  )
                ],
              )
            : widget)
        .squish(Dimensions.x4);
  }
}

class FlutterWordMark extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const FlutterWordMark({
    this.text = 'Flutter',
    this.padding = const EdgeInsets.symmetric(horizontal: Dimensions.x5, vertical: Dimensions.x2),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Zeta.of(context).colors.borderSubtle,
      padding: padding,
      child: ZetaText(text),
    );
  }
}
