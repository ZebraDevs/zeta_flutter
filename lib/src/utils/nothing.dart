import 'package:flutter/widgets.dart';

/// A convenient widget that renders nothing.
///
/// {@category Utils}
class ZetaNothing extends StatelessWidget {
  /// Constructs a [ZetaNothing] widget.
  const ZetaNothing({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
