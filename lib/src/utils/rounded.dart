import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// Sets a default rounded value for all of its Zeta children.
/// {@category Utils}
class ZetaRoundedScope extends InheritedWidget {
  /// Constructs a [ZetaRoundedScope].
  const ZetaRoundedScope({
    required bool rounded,
    required super.child,
    super.key,
  }) : _rounded = rounded;

  ///{@macro zeta-component-rounded }
  final bool _rounded;

  /// Finds and returns closest instance of [ZetaRoundedScope].
  static ZetaRoundedScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ZetaRoundedScope>();
  }

  @override
  bool updateShouldNotify(covariant ZetaRoundedScope oldWidget) => oldWidget._rounded != _rounded;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('rounded', _rounded));
  }
}

///  Zeta Extension of [StatelessWidget] which adds [rounded] super parameter. Always use `context.rounded` to ensure correct value for [rounded] is used.
/// {@category Utils}
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
/// {@category Utils}
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

/// Extension used on [BuildContext] to get rounded.
extension Rounded on BuildContext {
  /// {@macro zeta-component-rounded}
  bool get rounded {
    try {
      if ((widget as dynamic).rounded != null && (widget as dynamic).rounded is bool) {
        return (widget as dynamic).rounded as bool;
      }
    } catch (e) {
      /// Ignore error
    }

    return ZetaRoundedScope.of(this)?._rounded ?? Zeta.of(this).rounded;
  }
}
