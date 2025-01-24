import 'package:flutter/widgets.dart';

/// A convenient widget that renders nothing.
///
/// This is typically used when a widget needs a child but we don't want to provide one.
class Nothing extends StatelessWidget {
  /// Constructs a [Nothing] widget.
  const Nothing({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
