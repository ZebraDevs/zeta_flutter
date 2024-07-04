import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class WidgetBookScaffold extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints) builder;
  final bool removeBody;
  final Color? backgroundColor;

  const WidgetBookScaffold({
    required this.builder,
    super.key,
    this.removeBody = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Zeta.of(context).colors.surfaceDefault,
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: ListView(
            shrinkWrap: true,
            children: [Center(child: builder(context, constraints))],
          ),
        );
      }),
    );
  }
}
