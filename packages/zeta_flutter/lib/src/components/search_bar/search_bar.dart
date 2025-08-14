import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

import '../buttons/input_icon_button.dart';
import '../text_input/internal_text_input.dart';

/// A text input field for entering search queries.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=875-17463&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/search-bar/zetasearchbar/search-bar
class ZetaSearchBar extends ZetaTextFormField {
  /// Constructor for [ZetaSearchBar].
  ZetaSearchBar({
    super.autovalidateMode,
    super.validator,
    super.onSaved,
    super.onChange,
    super.onFieldSubmitted,
    super.requirementLevel,
    super.controller,
    super.disabled = false,
    super.initialValue,
    this.size = ZetaWidgetSize.medium,
    this.shape = ZetaWidgetBorder.rounded,
    this.placeholder,
    this.onSpeechToText,
    this.showSpeechToText = true,
    this.focusNode,
    this.textInputAction,
    this.microphoneSemanticLabel,
    this.clearSemanticLabel,
    super.key,
  }) : super(
          builder: (field) {
            final zeta = Zeta.of(field.context);

            final _ZetaSearchBarState state = field as _ZetaSearchBarState;

            final Radius borderRadius = switch (shape) {
              ZetaWidgetBorder.rounded => zeta.radius.minimal,
              ZetaWidgetBorder.full => zeta.radius.full,
              _ => zeta.radius.none,
            };

            late final double iconSize;

            switch (size) {
              case ZetaWidgetSize.large:
                iconSize = zeta.spacing.xl_2;
              case ZetaWidgetSize.medium:
                iconSize = zeta.spacing.xl;
              case ZetaWidgetSize.small:
                iconSize = zeta.spacing.large;
            }

            return ZetaRoundedScope(
              rounded: shape != ZetaWidgetBorder.sharp,
              child: Semantics(
                excludeSemantics: disabled,
                label: disabled ? placeholder ?? 'Search' : null, // TODO(UX-1003): Localize
                enabled: disabled ? false : null,
                child: Builder(
                  builder: (context) {
                    return InternalTextInput(
                      focusNode: focusNode,
                      size: size,
                      disabled: disabled,
                      constrained: true,
                      borderRadius: BorderRadius.all(borderRadius),
                      controller: state.effectiveController,
                      keyboardType: TextInputType.text,
                      textInputAction: textInputAction,
                      placeholder: placeholder ?? 'Search', // TODO(UX-1003): Localize
                      onSubmit: onFieldSubmitted,
                      onChange: state.onChange,
                      prefix: Icon(
                        context.rounded ? ZetaIcons.search_round : ZetaIcons.search_sharp,
                        color: !disabled ? zeta.colors.mainSubtle : zeta.colors.mainDisabled,
                        size: iconSize,
                      ),
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.effectiveController.text.isNotEmpty && !disabled) ...[
                            InputIconButton(
                              icon: ZetaIcons.cancel,
                              onTap: () => state.onChange(''),
                              disabled: disabled,
                              size: size,
                              semanticLabel: clearSemanticLabel,
                              color: zeta.colors.mainSubtle,
                              key: const ValueKey('search-clear-btn'),
                            ),
                            if (showSpeechToText)
                              SizedBox(
                                height: iconSize,
                                child: VerticalDivider(
                                  color: zeta.colors.mainSubtle,
                                  width: 5,
                                  thickness: 1,
                                ),
                              ),
                          ],
                          if (showSpeechToText)
                            InputIconButton(
                              icon: ZetaIcons.microphone,
                              onTap: state.onSpeechToText,
                              key: const ValueKey('speech-to-text-btn'),
                              disabled: disabled,
                              semanticLabel: microphoneSemanticLabel,
                              size: size,
                              color: zeta.colors.mainDefault,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );

  /// Determines the size of the input field.
  /// Default is [ZetaWidgetSize.medium]
  final ZetaWidgetSize size;

  /// Placeholder text for the search field.
  final String? placeholder;

  /// Determines the shape of the input field.
  /// Default is [ZetaWidgetBorder.rounded]
  final ZetaWidgetBorder shape;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// A callback, which is invoked when the microphone button is pressed.
  final Future<String?> Function()? onSpeechToText;

  /// Determines if there should be a Speech-To-Text button.
  /// Default is `true`.
  final bool showSpeechToText;

  /// A [FocusNode] for the underlying [TextFormField]
  final FocusNode? focusNode;

  /// Label passed to the microphone button for semantic purposes.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? microphoneSemanticLabel;

  /// Label passed to the clear button for semantic purposes.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? clearSemanticLabel;

  @override
  FormFieldState<String> createState() => _ZetaSearchBarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(EnumProperty<ZetaWidgetBorder>('shape', shape))
      ..add(StringProperty('initialValue', initialValue))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSpeechToText', onSpeechToText))
      ..add(DiagnosticsProperty<bool>('showSpeechToText', showSpeechToText))
      ..add(DiagnosticsProperty<FocusNode>('focusNode', focusNode))
      ..add(EnumProperty<TextInputAction>('textInputAction', textInputAction))
      ..add(StringProperty('microphoneSemanticLabel', microphoneSemanticLabel))
      ..add(StringProperty('clearSemanticLabel', clearSemanticLabel))
      ..add(StringProperty('placeholder', placeholder));
  }
}

class _ZetaSearchBarState extends ZetaTextFormFieldState {
  @override
  ZetaSearchBar get widget => super.widget as ZetaSearchBar;

  Future<void> onSpeechToText() async {
    if (widget.onSpeechToText != null) {
      final text = await widget.onSpeechToText!();
      if (text != null) {
        effectiveController.text = text;
        super.onChange(value);
      }
    }
  }
}
