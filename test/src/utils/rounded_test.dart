import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../../test_utils/test_app.dart';
import 'rounded_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Zeta>(),
])
void main() {
  final mockZeta = MockZeta();

  testWidgets('Global round inherited', (WidgetTester tester) async {
    final GlobalKey key = GlobalKey();

    when(mockZeta.radius).thenReturn(const ZetaRadiusAA(primitives: ZetaPrimitivesLight()));
    await tester.pumpWidget(
      TestApp(
        rounded: true,
        home: ZetaAccordion(
          key: key,
          title: 'Test Accordion',
          child: const ZetaStatusLabel(label: 'Label'),
        ),
      ),
    );

    final zetaLabelFinder = find.byType(ZetaStatusLabel);

    expect(zetaLabelFinder, findsOneWidget);

    final childFinder = find.descendant(of: zetaLabelFinder, matching: find.byType(DecoratedBox));
    expect(childFinder, findsOneWidget);

    final DecoratedBox box = tester.firstWidget(childFinder);

    expect(box.decoration.runtimeType, BoxDecoration);
    expect((box.decoration as BoxDecoration).borderRadius, BorderRadius.all(mockZeta.radius.full));
    expect(Zeta.of(key.currentContext!).rounded, true);
  });

  testWidgets('Global sharp inherited', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        rounded: false,
        home: ZetaAccordion(
          title: 'Test Accordion',
          child: ZetaStatusLabel(label: 'Label'),
        ),
      ),
    );

    final zetaLabelFinder = find.byType(ZetaStatusLabel);
    expect(zetaLabelFinder, findsOneWidget);

    final childFinder = find.descendant(of: zetaLabelFinder, matching: find.byType(DecoratedBox));
    expect(childFinder, findsOneWidget);

    final DecoratedBox box = tester.firstWidget(childFinder);

    expect(box.decoration.runtimeType, BoxDecoration);
    expect((box.decoration as BoxDecoration).borderRadius, BorderRadius.all(mockZeta.radius.none));
  });

  testWidgets('Global sharp, local round, not inherited', (WidgetTester tester) async {
    final GlobalKey key = GlobalKey();
    await tester.pumpWidget(
      TestApp(
        rounded: false,
        home: ZetaAccordion(
          key: key,
          title: 'Test Accordion',
          child: const ZetaStatusLabel(label: 'Label', rounded: true),
        ),
      ),
    );

    final zetaLabelFinder = find.byType(ZetaStatusLabel);

    expect(zetaLabelFinder, findsOneWidget);

    final childFinder = find.descendant(of: zetaLabelFinder, matching: find.byType(DecoratedBox));
    expect(childFinder, findsOneWidget);

    final DecoratedBox box = tester.firstWidget(childFinder);

    expect(box.decoration.runtimeType, BoxDecoration);
    expect((box.decoration as BoxDecoration).borderRadius, BorderRadius.all(mockZeta.radius.full));
  });

  testWidgets('Global sharp, scoped round inherited', (WidgetTester tester) async {
    const Key sharpKey = Key('sharp');
    const Key roundKey = Key('round');

    await tester.pumpWidget(
      const TestApp(
        rounded: false,
        home: Column(
          children: [
            ZetaStatusLabel(label: 'Label', key: sharpKey),
            ZetaRoundedScope(
              rounded: true,
              child: ZetaAccordion(
                title: 'Test Accordion',
                child: ZetaStatusLabel(label: 'Label', key: roundKey),
              ),
            ),
          ],
        ),
      ),
    );

    final sharpLabelFinder = find.byKey(sharpKey);
    expect(sharpLabelFinder, findsOneWidget);

    final roundLabelFinder = find.byKey(roundKey);
    expect(roundLabelFinder, findsOneWidget);

    final sharpChildFinder = find.descendant(of: sharpLabelFinder, matching: find.byType(DecoratedBox));
    expect(sharpChildFinder, findsOneWidget);

    final roundChildFinder = find.descendant(of: roundLabelFinder, matching: find.byType(DecoratedBox));
    expect(roundChildFinder, findsOneWidget);

    final DecoratedBox sharpBox = tester.firstWidget(sharpChildFinder);
    final DecoratedBox roundBox = tester.firstWidget(roundChildFinder);

    expect(sharpBox.decoration.runtimeType, BoxDecoration);
    expect((sharpBox.decoration as BoxDecoration).borderRadius, BorderRadius.all(mockZeta.radius.none));

    expect(roundBox.decoration.runtimeType, BoxDecoration);
    expect((roundBox.decoration as BoxDecoration).borderRadius, BorderRadius.all(mockZeta.radius.full));
  });

  testWidgets('Global sharp, scoped round, scoped sharp inherited', (WidgetTester tester) async {
    const Key sharpKey = Key('sharp');
    const Key sharpKey2 = Key('round');

    await tester.pumpWidget(
      const TestApp(
        rounded: false,
        home: Column(
          children: [
            ZetaStatusLabel(label: 'Label', key: sharpKey),
            ZetaRoundedScope(
              rounded: true,
              child: ZetaAccordion(
                title: 'Test Accordion',
                child: ZetaRoundedScope(rounded: false, child: ZetaStatusLabel(label: 'Label', key: sharpKey2)),
              ),
            ),
          ],
        ),
      ),
    );

    final sharpLabelFinder = find.byKey(sharpKey);
    expect(sharpLabelFinder, findsOneWidget);

    final roundLabelFinder = find.byKey(sharpKey2);
    expect(roundLabelFinder, findsOneWidget);

    final sharpChildFinder = find.descendant(of: sharpLabelFinder, matching: find.byType(DecoratedBox));
    expect(sharpChildFinder, findsOneWidget);

    final roundChildFinder = find.descendant(of: roundLabelFinder, matching: find.byType(DecoratedBox));
    expect(roundChildFinder, findsOneWidget);

    final DecoratedBox sharpBox = tester.firstWidget(sharpChildFinder);
    final DecoratedBox roundBox = tester.firstWidget(roundChildFinder);

    expect(sharpBox.decoration.runtimeType, BoxDecoration);
    expect((sharpBox.decoration as BoxDecoration).borderRadius, BorderRadius.all(mockZeta.radius.none));

    expect(roundBox.decoration.runtimeType, BoxDecoration);
    expect((roundBox.decoration as BoxDecoration).borderRadius, BorderRadius.all(mockZeta.radius.none));
  });

  testWidgets('ZetaRoundedScope debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();

    const ZetaRoundedScope(rounded: true, child: Nothing()).debugFillProperties(diagnostics);

    final rounded = diagnostics.properties.where((p) => p.name == 'rounded').map((p) => p.toDescription()).first;
    expect(rounded, 'true');
  });

  testWidgets('ZetaStatefulWidget debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const _RoundedStateTestWidget(rounded: true).debugFillProperties(diagnostics);

    final rounded = diagnostics.properties.where((p) => p.name == 'rounded').map((p) => p.toDescription()).first;
    expect(rounded, 'true');
  });
}

class _RoundedStateTestWidget extends ZetaStatefulWidget {
  const _RoundedStateTestWidget({super.rounded});

  @override
  State<_RoundedStateTestWidget> createState() => _RoundedStateTestWidgetState();
}

class _RoundedStateTestWidgetState extends State<_RoundedStateTestWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
