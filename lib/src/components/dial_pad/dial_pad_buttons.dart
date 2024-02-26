import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';

const Map<String, String> _defaultButtonValues = {
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

const int _defaultButtonsPerRow = 3;

/// Dial pad gives the user the ability to dial a number and start a call. It also has a quick dial security action and a delete entry action.
class ZetaDialPad extends StatelessWidget {
  /// Constructs a [ZetaDialPad].
  const ZetaDialPad({
    super.key,
    this.onInput,
    this.buttonsPerRow = _defaultButtonsPerRow,
    this.buttonValues = _defaultButtonValues,
  });

  /// Callback when number is tapped. Returns the large value from the button, i,e, 1,2,3 etc.
  final ValueChanged<String>? onInput;

  /// Number of buttons to show on each row. Defaults to 3.
  final int? buttonsPerRow;

  /// Map of values to show on the buttons.
  ///
  /// Key is the large character, i.e. 1, 2, 3.
  ///
  /// Value is the smaller character(s): i.e. 'ABC'
  final Map<String, String>? buttonValues;

  int get _buttonsPerRow => buttonsPerRow ?? _defaultButtonsPerRow;
  Map<String, String> get _buttonValues => buttonValues ?? _defaultButtonValues;

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: SizedBox(
        width: (_buttonsPerRow * ZetaSpacing.x16) + ((_buttonsPerRow - 1) * ZetaSpacing.x9),
        child: GridView.count(
          crossAxisCount: _buttonsPerRow,
          shrinkWrap: true,
          semanticChildCount: _buttonValues.length,
          mainAxisSpacing: ZetaSpacing.x9,
          crossAxisSpacing: ZetaSpacing.x8,
          children: _buttonValues.entries
              .map(
                (e) => _DialPadButton(
                  number: e.key,
                  letters: e.value,
                  onTap: onInput,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onInput', onInput))
      ..add(IntProperty('buttonsPerRow', buttonsPerRow))
      ..add(DiagnosticsProperty<Map<String, String>>('buttonValues', buttonValues));
  }
}

class _DialPadButton extends StatefulWidget {
  const _DialPadButton({
    required this.number,
    this.letters = '',
    required this.onTap,
    this.topPadding = 3,
  });

  final String number;
  final String letters;
  final double topPadding;
  final ValueChanged<String>? onTap;

  @override
  State<_DialPadButton> createState() => _DialPadButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<String>>.has('onTap', onTap))
      ..add(StringProperty('letters', letters))
      ..add(StringProperty('number', number))
      ..add(DoubleProperty('topPadding', topPadding));
  }
}

class _DialPadButtonState extends State<_DialPadButton> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Semantics(
      button: true,
      value: widget.number,
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: Durations.short2,
        width: ZetaSpacing.x16,
        height: ZetaSpacing.x16,
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: _focused ? BorderSide(color: colors.blue, width: ZetaSpacing.x0_5) : BorderSide.none,
          ),
          color: colors.warm.shade10,
          shadows: [BoxShadow(color: colors.black.withOpacity(0.15), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => widget.onTap?.call(widget.number),
            borderRadius: ZetaRadius.full,
            overlayColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return colors.surfaceSelectedHovered;
              }
              if (states.contains(MaterialState.hovered)) {
                return colors.surfaceHovered;
              }
              return null;
            }),
            onFocusChange: (value) {
              if (_focused != value) setState(() => _focused = value);
            },
            child: Column(
              children: [
                SizedBox(height: widget.topPadding),
                Text(widget.number, style: ZetaTextStyles.heading1),
                if (widget.topPadding < 10) Text(widget.letters, style: ZetaTextStyles.labelIndicator),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
