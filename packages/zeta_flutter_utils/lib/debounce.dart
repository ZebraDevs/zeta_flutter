import 'dart:async';

export 'extensions.dart';

const Duration _debounceDuration = Duration(milliseconds: 500);

/// A utility function to debounce a given function.
///
/// Debouncing ensures that the function is only called once after a specified
/// duration has passed since the last time it was invoked. This is useful for
/// scenarios where you want to limit the rate at which a function is executed,
/// such as handling user input events or API calls.
///
/// Example:
///
/// ```dart
/// final debouncer = Debounce(() => print('Hello, world!'));
/// ```
///
/// By default, this will print 'Hello, world!' after 500 milliseconds. You can
/// also specify a custom duration:
///
/// ```dart
/// final debouncer = Debounce(() => print('Hello, world!'), duration: Duration(seconds: 1)});
/// ```
///
/// To reset the debounce, and start the timer again, call the `debounce` method with an optional new callback:
///
/// ```dart
/// debouncer.debounce(newCallback: () => print('Later, world!'));
/// ```
///
/// If this debounce is no longer needed, you can cancel it:
///
/// ```dart
/// debouncer.cancel();
/// ```
class Debounce {
  /// Constructs and starts the debouncer.
  factory Debounce(void Function() callback, {Duration duration = _debounceDuration}) {
    return Debounce._(callback, duration)..debounce();
  }

  /// Constructs debouncer but does not initialize the timer.
  Debounce.stopped(this.callback, {this.duration = _debounceDuration});

  Debounce._(this.callback, this.duration);

  /// Function called after [Duration] has elapsed.
  final void Function() callback;

  /// Duration to wait for function to be ready to send.
  ///
  /// Defaults to 500 milliseconds.
  final Duration duration;

  Timer? _timer;

  /// Starts the debouncer.
  ///
  /// This function is called automatically when default factory constructor is used.
  void debounce({void Function()? newCallback}) {
    _timer?.cancel();
    _timer = Timer(duration, newCallback ?? callback);
  }

  /// Cancels the debouncer.
  void cancel() => _timer?.cancel();
}
