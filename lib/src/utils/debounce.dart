import 'dart:async';

export './extensions.dart';

const Duration _debounceDuration = Duration(milliseconds: 500);

/// Debounce utility
/// {@category Utils}
class ZetaDebounce {
  /// Constructs and starts the debouncer.
  factory ZetaDebounce(void Function() callback, {Duration duration = _debounceDuration}) {
    return ZetaDebounce._(callback, duration)..debounce();
  }

  /// Constructs debouncer but does not initialize the timer.
  ZetaDebounce.stopped(this.callback, {this.duration = _debounceDuration});

  ZetaDebounce._(this.callback, this.duration);

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
