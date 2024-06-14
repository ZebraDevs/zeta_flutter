import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/theme/breakpoints.dart';

import '../../test_utils/test_app.dart';

void main() {
  group('BreakpointLocal extension', () {
    test('returns DeviceType.mobilePortrait for widths <= 479', () {
      const constraints = BoxConstraints(maxWidth: 479);
      expect(constraints.deviceType, DeviceType.mobilePortrait);
    });

    test('returns DeviceType.mobileLandscape for widths <= 767', () {
      const constraints = BoxConstraints(maxWidth: 767);
      expect(constraints.deviceType, DeviceType.mobileLandscape);
    });

    test('returns DeviceType.tablet for widths <= 991', () {
      const constraints = BoxConstraints(maxWidth: 991);
      expect(constraints.deviceType, DeviceType.tablet);
    });

    test('returns DeviceType.desktop for widths <= 1279', () {
      const constraints = BoxConstraints(maxWidth: 1279);
      expect(constraints.deviceType, DeviceType.desktop);
    });

    test('returns DeviceType.desktopL for widths <= 1439', () {
      const constraints = BoxConstraints(maxWidth: 1439);
      expect(constraints.deviceType, DeviceType.desktopL);
    });

    test('returns DeviceType.desktopXL for widths > 1439', () {
      const constraints = BoxConstraints(maxWidth: 1920);
      expect(constraints.deviceType, DeviceType.desktopXL);
    });
  });

  group('BreakpointFull extension', () {
    testWidgets('returns DeviceType.mobilePortrait for widths <= 479', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(479, 800)),
            child: Builder(
              builder: (context) {
                expect(context.deviceType, DeviceType.mobilePortrait);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns DeviceType.mobileLandscape for widths <= 767', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(767, 800)),
            child: Builder(
              builder: (context) {
                expect(context.deviceType, DeviceType.mobileLandscape);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns DeviceType.tablet for widths <= 991', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(991, 800)),
            child: Builder(
              builder: (context) {
                expect(context.deviceType, DeviceType.tablet);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns DeviceType.desktop for widths <= 1279', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1279, 800)),
            child: Builder(
              builder: (context) {
                expect(context.deviceType, DeviceType.desktop);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns DeviceType.desktopL for widths <= 1439', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1439, 800)),
            child: Builder(
              builder: (context) {
                expect(context.deviceType, DeviceType.desktopL);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns DeviceType.desktopXL for widths > 1439', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1920, 800)),
            child: Builder(
              builder: (context) {
                expect(context.deviceType, DeviceType.desktopXL);
                return Container();
              },
            ),
          ),
        ),
      );
    });
  });
}
