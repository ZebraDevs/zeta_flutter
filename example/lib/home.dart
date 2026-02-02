import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/widgets.dart' show ExampleScaffold;
import 'package:zeta_flutter/zeta_flutter.dart' show Nothing, SpacingWidget, Zeta, ZetaAccordion, ZetaAccordionItem;

class Home extends StatefulWidget {
  final Map<String, Iterable<GoRoute>> routes;
  const Home({
    super.key,
    required this.routes,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    if (GoRouterState.of(context).extra == 'docs') {
      return Nothing();
    }

    return ExampleScaffold(
      // x-release-please-start-version
      name: 'zeta_flutter v1.0.0',
      // x-release-please-end
      child: SingleChildScrollView(
        child: ZetaAccordion(
                inCard: true,
                children: widget.routes.entries.map((entry) {
                  return ZetaAccordionItem(
                    title: entry.key,
                    child: ZetaAccordion(
                      children: entry.value.map((route) {
                        return ZetaAccordionItem.navigation(
                          title: route.name ?? route.path,
                          onTap: () => context.go('/${route.path}'),
                        );
                      }).toList(),
                    ),
                  );
                }).toList())
            .paddingAll(Zeta.of(context).spacing.medium),
      ),
    );
  }
}
