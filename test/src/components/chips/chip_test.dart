import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';

void main() {
  group('ZetaChip', () {
    testWidgets('renders label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(home: ZetaChip(label: 'Test Chip')),
      );

      expect(find.text('Test Chip'), findsOneWidget);
    });

    testWidgets('triggers onTap callback when tapped', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        TestApp(
          home: ZetaChip(
            label: 'Test Chip',
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(ZetaChip));
      expect(tapped, isTrue);
    });

    testWidgets('triggers onToggle callback when selected', (WidgetTester tester) async {
      bool selected = false;

      await tester.pumpWidget(
        TestApp(
          home: ZetaChip(
            label: 'Test Chip',
            selected: selected,
            onToggle: (value) => selected = value,
          ),
        ),
      );

      await tester.tap(find.byType(ZetaChip));
      expect(selected, isTrue);
    });

    testWidgets('renders leading widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaChip(
            label: 'Test Chip',
            leading: Icon(Icons.check),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('renders trailing widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaChip(
            label: 'Test Chip',
            trailing: Icon(Icons.close),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });

  testWidgets('ZetaChip changes selected property correctly', (WidgetTester tester) async {
    bool selected = false;
    StateSetter? setState;

    await tester.pumpWidget(
      TestApp(
        home: StatefulBuilder(
          builder: (context, setState2) {
            setState = setState2;
            return ZetaChip(label: 'Chip', selected: selected);
          },
        ),
      ),
    );

    final Finder iconFinder = find.byIcon(ZetaIcons.check_mark_round);
    expect(iconFinder, findsNothing);

    // Change isOpen property to true
    setState?.call(() => selected = true);
    await tester.pumpAndSettle();

    expect(iconFinder, findsOne);
  });
}
