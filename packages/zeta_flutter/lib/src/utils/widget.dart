import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///  Zeta Extension of [StatelessWidget] which adds [rounded] super parameter. Always use `context.rounded` to ensure correct value for [rounded] is used.
abstract class ZetaStatelessWidget extends StatelessWidget {
  /// Constructs a [ZetaStatelessWidget].
  const ZetaStatelessWidget({super.key, this.rounded});

  /// {@macro zeta-component-rounded}
  final bool? rounded;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool?>('rounded', rounded));
  }
}

///  Zeta Extension of [StatefulWidget] which adds [rounded] super parameter. Always use `context.rounded` to ensure correct value for [rounded] is used.
abstract class ZetaStatefulWidget extends StatefulWidget {
  /// Constructs a [ZetaStatefulWidget].
  const ZetaStatefulWidget({super.key, this.rounded});

  /// {@macro zeta-component-rounded}
  final bool? rounded;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool?>('rounded', rounded));
  }
}
