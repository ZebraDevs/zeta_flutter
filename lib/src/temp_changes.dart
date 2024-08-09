import 'package:flutter/material.dart';

import '../zeta_flutter.dart';

// TODO(LUKE): remove in 1.0.0

/// Colors used pre 1.0.0
extension OldColors on ZetaColorSemantics {
  /// Default text color
  @Deprecated('Use mainDefault instead. ' 'Will be removed in v1.0.0')
  Color get textDefault => mainDefault;

  /// Default icon color
  @Deprecated('Use mainDefault instead. ' 'Will be removed in v1.0.0')
  Color get iconDefault => mainDefault;

  /// Disabled text color
  @Deprecated('Use disabled instead. ' 'Will be removed in v1.0.0')
  Color get textDisabled => disabled;

  /// Disabled icon color
  @Deprecated('Use disabled instead. ' 'Will be removed in v1.0.0')
  Color get iconDisabled => disabled;

  /// Inverted text color
  @Deprecated('Use inverse instead. ' 'Will be removed in v1.0.0')
  Color get textInverse => inverse;

  /// Inverted icon color
  @Deprecated('Use inverse instead. ' 'Will be removed in v1.0.0')
  Color get iconInverse => inverse;

  /// Subtle text color
  @Deprecated('Use subtle instead. ' 'Will be removed in v1.0.0')
  Color get textSubtle => subtle;

  /// Subtle icon color
  @Deprecated('Use subtle instead. ' 'Will be removed in v1.0.0')
  Color get iconSubtle => subtle;

  /// Warm color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get warm => primitives.warm;

  /// Cool color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get cool => primitives.cool;

  /// Blue color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get blue => primitives.blue;

  /// Primary color swatch - hardcoded to blue
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get primary => primitives.blue;

  /// Green color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get green => primitives.green;

  /// Red color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get red => primitives.red;

  /// Yellow color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get yellow => primitives.yellow;

  /// Purple color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get purple => primitives.purple;

  /// Orange color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get orange => primitives.orange;

  /// Teal color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get teal => primitives.teal;

  /// Pink color swatch
  @Deprecated('Will be removed in v1.0.0')
  ZetaColorSwatch get pink => primitives.pink;

  /// List of colorful colors.
  @Deprecated('Will be removed in v1.0.0')
  List<ZetaColorSwatch> get rainbow => [red, orange, yellow, green, blue, teal, pink];

  /// Map of colorful colors.
  @Deprecated('Will be removed in v1.0.0')
  Map<String, ZetaColorSwatch> get rainbowMap => {
        'red': red,
        'orange': orange,
        'yellow': yellow,
        'green': green,
        'blue': blue,
        'teal': teal,
        'pink': pink,
      };

  /// Pure black color
  @Deprecated('Will be removed in v1.0.0')
  Color get black => primitives.pure.shade1000;

  /// Pure white color
  @Deprecated('Will be removed in v1.0.0')
  Color get white => primitives.pure.shade0;

  /// Error color
  @Deprecated('Use negative instead. ' 'Will be removed in v1.0.0')
  Color get error => negative;
}
