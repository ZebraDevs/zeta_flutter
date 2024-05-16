import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';

/// Dial pad gives the user the ability to dial a number and start a call. It also has a quick dial security action and a delete entry action.
class ZetaDialPad extends StatefulWidget {
  /// Constructs a [ZetaDialPad].
  const ZetaDialPad({
    super.key,
    this.buttonsPerRow = ZetaDialPad.defaultButtonsPerRow,
    this.buttonValues = ZetaDialPad.defaultButtonValues,
    this.onNumber,
    this.onText,
  });

  /// Callback when number is tapped. Returns the large value from the button, i,e, 1,2,3 etc.
  final ValueChanged<String>? onNumber;

  /// Callback when number is tapped. Returns the small value from the button after a small delay, i,e, a,b,c etc.
  final ValueChanged<String>? onText;

  /// Number of buttons to show on each row. Defaults to 3 [defaultButtonsPerRow].
  final int? buttonsPerRow;

  /// Map of values to show on the buttons.
  ///
  /// * Key is large value, typically a single digit or special character.
  /// * Value is the smaller value, typically 3/4 alphabetical characters.
  ///
  /// Defaults ot [defaultButtonValues].
  final Map<String, String>? buttonValues;

  /// Default button values (english) for [ZetaDialPad].
  ///
  /// * Key is large value, typically a single digit or special character.
  /// * Value is the smaller value, typically 3/4 alphabetical characters.
  static const Map<String, String> defaultButtonValues = {
    '1': '',
    '2': 'ABC',
    '3': 'DEF',
    '4': 'GHI',
    '5': 'JKL',
    '6': 'MNO',
    '7': 'PQRS',
    '8': 'TUV',
    '9': 'WXYZ',
    '*': '',
    '0': '+',
    '#': '',
  };

  /// Default number of buttons per row for [ZetaDialPad].
  static const int defaultButtonsPerRow = 3;

  @override
  State<ZetaDialPad> createState() => _ZetaDialPadState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onInput', onNumber))
      ..add(IntProperty('buttonsPerRow', buttonsPerRow))
      ..add(DiagnosticsProperty<Map<String, String>>('buttonValues', buttonValues))
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onText', onText));
  }
}

class _ZetaDialPadState extends State<ZetaDialPad> {
  int get _buttonsPerRow => widget.buttonsPerRow ?? ZetaDialPad.defaultButtonsPerRow;

  Map<String, String> get _buttonValues => widget.buttonValues ?? ZetaDialPad.defaultButtonValues;

  String? _lastTapped;
  int _tapCounter = 0;

  ZetaDebounce? _debounce;

  void onTap(String tapped) {
    widget.onNumber?.call(tapped);

    if (tapped != _lastTapped) {
      if (_lastTapped == null) {
        _debounce = ZetaDebounce(() => _fireChar(tapped, _tapCounter));
      } else {
        _debounce?.debounce(newCallback: () => _fireChar(tapped, 1));
        _fireChar(_lastTapped!, _tapCounter);
      }
      _tapCounter = 1;
      _lastTapped = tapped;
    } else if (_lastTapped != null && _lastTapped == tapped) {
      _tapCounter += 1;
      _debounce?.debounce(newCallback: () => _fireChar(tapped, _tapCounter));
    }
  }

  void _fireChar(String lastTapped, int tapCounter) {
    final letters = _buttonValues[lastTapped];
    if (letters != null && letters.isNotEmpty) {
      _tapCounter = 0;
      _lastTapped = null;

      final List<String> options = letters.split('');
      final int index = (tapCounter - 1) % options.length;

      widget.onText?.call(options[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: SizedBox(
        width: (_buttonsPerRow * ZetaSpacing.x16) + ((_buttonsPerRow - 1) * ZetaSpacing.x9),
        child: GridView.count(
          crossAxisCount: _buttonsPerRow,
          shrinkWrap: true,
          semanticChildCount: _buttonValues.length,
          mainAxisSpacing: ZetaSpacing.x6,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: ZetaSpacing.x9,
          children: _buttonValues.entries
              .map(
                (e) => ZetaDialPadButton(
                  primary: e.key,
                  secondary: e.value,
                  onTap: onTap,
                  topPadding: e.key == '*'
                      ? 11
                      : e.value.isEmpty && e.key != '1'
                          ? 14
                          : 3,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

/// Individual button for [ZetaDialPad].
class ZetaDialPadButton extends StatelessWidget {
  /// Constructs a [ZetaDialPadButton]
  const ZetaDialPadButton({
    super.key,
    required this.primary,
    this.secondary = '',
    required this.onTap,
    this.topPadding = 3,
  });

  /// Primary value displayed on button.
  ///
  /// Typically a single-digit number, but can be any string.
  ///
  /// You should avoid using more than a single character, as this will not render correctly.
  final String primary;

  /// Secondary value displayed on button, below [primary].
  ///
  /// Typically letters, but can be any string.
  final String secondary;

  /// Padding for top of button. Defaults to 3.
  final double topPadding;

  /// Returns the number tapped when tapped.
  final ValueChanged<String>? onTap;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<String>>.has('onTap', onTap))
      ..add(StringProperty('letters', secondary))
      ..add(StringProperty('number', primary))
      ..add(DoubleProperty('topPadding', topPadding));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Semantics(
      button: true,
      value: primary,
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: Durations.short2,
        width: ZetaSpacing.x16,
        height: ZetaSpacing.x16,
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: colors.warm.shade10,
          shadows: [BoxShadow(color: colors.black.withOpacity(0.15), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTap?.call(primary),
            borderRadius: ZetaRadius.full,
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return colors.surfaceSelectedHovered;
              }
              if (states.contains(WidgetState.hovered)) {
                return colors.surfaceHovered;
              }
              return null;
            }),
            child: Column(
              children: [
                SizedBox(height: topPadding),
                Text(primary, style: ZetaTextStyles.heading1),
                if (topPadding < 10) Text(secondary, style: ZetaTextStyles.labelIndicator),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
