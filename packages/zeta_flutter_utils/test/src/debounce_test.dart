import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  group('Debounce', () {
    late MockCallback mockCallback;

    setUp(() {
      mockCallback = MockCallback();
    });

    test('debounce calls the callback after the specified duration', () async {
      const debounceDuration = Duration(milliseconds: 100);
      Debounce(mockCallback.call, duration: debounceDuration);

      await Future<void>.delayed(debounceDuration + const Duration(milliseconds: 50));

      verify(mockCallback()).called(1);
    });

    test('debounce does not call the callback if cancelled', () async {
      const debounceDuration = Duration(milliseconds: 100);
      Debounce(mockCallback.call, duration: debounceDuration).cancel();

      await Future<void>.delayed(debounceDuration + const Duration(milliseconds: 50));

      verifyNever(mockCallback());
    });

    test('debounce restarts the timer if called again before duration ends', () async {
      const debounceDuration = Duration(milliseconds: 100);
      final debouncer = Debounce(mockCallback.call, duration: debounceDuration);

      await Future<void>.delayed(const Duration(milliseconds: 50));
      debouncer.debounce();

      await Future<void>.delayed(const Duration(milliseconds: 75));
      verifyNever(mockCallback());

      await Future<void>.delayed(const Duration(milliseconds: 50));
      verify(mockCallback()).called(1);
    });

    test('Debounce.stopped does not start the timer automatically', () async {
      const debounceDuration = Duration(milliseconds: 100);
      Debounce.stopped(mockCallback.call, duration: debounceDuration);

      await Future<void>.delayed(debounceDuration + const Duration(milliseconds: 50));

      verifyNever(mockCallback());
    });

    test('debounce can be called with a new callback', () async {
      const debounceDuration = Duration(milliseconds: 100);
      final debouncer = Debounce(mockCallback.call, duration: debounceDuration);

      final newCallback = MockCallback();
      debouncer.debounce(newCallback: newCallback.call);

      await Future<void>.delayed(debounceDuration + const Duration(milliseconds: 50));

      verifyNever(mockCallback());
      verify(newCallback()).called(1);
    });
  });
}
