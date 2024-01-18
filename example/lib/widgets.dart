import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:zeta_example/pages/theme_color_switch.dart';
import 'package:zeta_example/pages/theme_constrast_switch.dart';
import 'package:zeta_example/pages/theme_mode_switch.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ExampleModel {
  final Widget example;
  final String code;
  final String? token;
  final String? description;
  final Widget? wDescription;
  final String? title;

  const ExampleModel({
    required this.example,
    required this.code,
    this.token,
    this.description,
    this.wDescription,
    this.title,
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
        if (model.token != null)
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, shape: BoxShape.circle),
          ).paddingVertical(Dimensions.x9).paddingHorizontal(Dimensions.x4),
        if (model.title != null && MediaQuery.of(context).size.width > 767) Expanded(child: Text(model.title!)),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.title != null && MediaQuery.of(context).size.width <= 767) Text(model.title!),
              if (model.token != null) CodeExample(code: model.token!),
              if (model.description != null) Text(model.description!),
              if (model.wDescription != null) model.wDescription!,
              model.example,
              Container(color: const Color(0xFFF5F5F5)),
              CodeExample(code: model.code, fill: true),
            ],
          ),
        ),
        const SizedBox(height: 7, width: 7).paddingVertical(Dimensions.x9).paddingHorizontal(Dimensions.x4),
      ],
    );
  }
}

class ExampleScaffold extends StatelessWidget {
  final String name;
  final Widget child;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  const ExampleScaffold({
    required this.name,
    required this.child,
    this.actions = const [],
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          name,
          style: ZetaTextStyles.titleMedium,
        ),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        actions: [
          ...actions,
          ZetaThemeModeSwitch(),
          ZetaThemeContrastSwitch(),
          ZetaThemeColorSwitch(),
        ],
      ),
      body: SelectionArea(
        child: child,
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
    final colors = Zeta.of(context).colors;
    final widget = Container(
      color: colors.surfaceDisabled,
      padding: EdgeInsets.all(Dimensions.x4),
      child: Text(code, style: GoogleFonts.ibmPlexMono(color: colors.textDefault)),
    );

    return (fill
            ? Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [Expanded(child: widget)]),
                      ],
                    ),
                  )
                ],
              )
            : widget)
        .paddingVertical(Dimensions.x4);
  }
}
