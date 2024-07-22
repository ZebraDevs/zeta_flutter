import 'package:flutter/widgets.dart';

/// A convenient widget that renders nothing.
/// {@category Utils}
class Nothing extends StatelessWidget {
  /// Constructs a [Nothing] widget.
  const Nothing({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
