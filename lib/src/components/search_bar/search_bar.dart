import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';
import '../buttons/input_icon_button.dart';

/// ZetaSearchBar provides input field for searching.
/// {@category Components}
class ZetaSearchBar extends ZetaTextFormField {
  /// Constructor for [ZetaSearchBar].
  ZetaSearchBar({
    super.autovalidateMode,
    super.validator,
    super.onSaved,
    super.onChange,
    @Deprecated('Use onFieldSubmitted instead. ' 'deprecated as of 0.15.0') ValueChanged<String?>? onSubmit,
    super.onFieldSubmitted,
    super.requirementLevel,
    super.controller,
    super.disabled = false,
    super.initialValue,
    this.size = ZetaWidgetSize.medium,
    this.shape = ZetaWidgetBorder.rounded,
    @Deprecated('Use hintText instead. ' 'deprecated as of 0.15.0') String? hint,
    this.hintText,
    this.onSpeechToText,
    this.showSpeechToText = true,
    @Deprecated('Use disabled instead. ' 'enabled is deprecated as of 0.11.0') bool enabled = true,
    this.focusNode,
    this.textInputAction,
    this.microphoneSemanticLabel,
    this.clearSemanticLabel,
    super.key,
    @Deprecated('Show leading icon is deprecated as of 0.14.2') bool showLeadingIcon = true,
    @Deprecated('Use onChange instead') ValueChanged<String?>? onChanged,
  }) : super(
          builder: (field) {
            final zeta = Zeta.of(field.context);

            final _ZetaSearchBarState state = field as _ZetaSearchBarState;

            final BorderRadius borderRadius = switch (shape) {
              ZetaWidgetBorder.rounded => zeta.radii.minimal,
              ZetaWidgetBorder.full => zeta.radii.full,
              _ => zeta.radii.none,
            };

            final defaultInputBorder = OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: zeta.colors.border.defaultColor),
            );

            final focusedBorder = defaultInputBorder.copyWith(
              borderSide: BorderSide(
                color: zeta.colors.border.primary,
                width: zeta.spacing.minimum,
              ),
            );

            final disabledborder = defaultInputBorder.copyWith(
              borderSide: BorderSide(color: zeta.colors.border.disabled),
            );

            late final double iconSize;
            late final double padding;

            switch (size) {
              case ZetaWidgetSize.large:
                iconSize = zeta.spacing.xl_2;
                padding = zeta.spacing.medium;
              case ZetaWidgetSize.medium:
                iconSize = zeta.spacing.xl;
                padding = zeta.spacing.small;
              case ZetaWidgetSize.small:
                iconSize = zeta.spacing.large;
                padding = zeta.spacing.minimum;
            }

            return ZetaRoundedScope(
              rounded: shape != ZetaWidgetBorder.sharp,
              child: Semantics(
                excludeSemantics: disabled,
                label: disabled ? hintText ?? 'Search' : null, // TODO(UX-1003): Localize
                enabled: disabled ? false : null,
                child: TextFormField(
                  focusNode: focusNode,
                  enabled: !disabled,
                  controller: state.effectiveController,
                  keyboardType: TextInputType.text,
                  textInputAction: textInputAction,
                  onFieldSubmitted: onFieldSubmitted,
                  onChanged: state.onChange,
                  style: ZetaTextStyles.bodyMedium,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: padding,
                    ),
                    hintText: hintText ?? 'Search', // TODO(UX-1003): Localize
                    hintStyle: ZetaTextStyles.bodyMedium.copyWith(
                      color: !disabled ? zeta.colors.main.subtle : zeta.colors.main.disabled,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: zeta.spacing.medium, right: zeta.spacing.small),
                      child: ZetaIcon(
                        ZetaIcons.search,
                        color: !disabled ? zeta.colors.main.subtle : zeta.colors.main.disabled,
                        size: iconSize,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minHeight: zeta.spacing.xl_2,
                      minWidth: zeta.spacing.xl_2,
                    ),
                    suffixIcon: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.effectiveController.text.isNotEmpty && !disabled) ...[
                            Semantics(
                              container: true,
                              button: true,
                              excludeSemantics: true,
                              label: clearSemanticLabel,
                              child: InputIconButton(
                                icon: ZetaIcons.cancel,
                                onTap: () => state.onChange(''),
                                disabled: disabled,
                                size: size,
                                color: zeta.colors.main.subtle,
                                key: const ValueKey('search-clear-btn'),
                              ),
                            ),
                            if (showSpeechToText)
                              SizedBox(
                                height: iconSize,
                                child: VerticalDivider(
                                  color: zeta.colors.main.subtle,
                                  width: 5,
                                  thickness: 1,
                                ),
                              ),
                          ],
                          if (showSpeechToText)
                            Semantics(
                              label: microphoneSemanticLabel,
                              container: true,
                              button: true,
                              excludeSemantics: true,
                              child: InputIconButton(
                                icon: ZetaIcons.microphone,
                                onTap: state.onSpeechToText,
                                key: const ValueKey('speech-to-text-btn'),
                                disabled: disabled,
                                size: size,
                                color: zeta.colors.main.defaultColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minHeight: zeta.spacing.xl_2,
                      minWidth: zeta.spacing.xl_2,
                    ),
                    filled: !disabled ? null : true,
                    fillColor: !disabled ? null : zeta.colors.surface.disabled,
                    enabledBorder: defaultInputBorder,
                    focusedBorder: focusedBorder,
                    disabledBorder: disabledborder,
                  ),
                ),
              ),
            );
          },
        );

  /// Determines the size of the input field.
  /// Default is [ZetaWidgetSize.medium]
  final ZetaWidgetSize size;

  /// Determines the shape of the input field.
  /// Default is [ZetaWidgetBorder.rounded]
  final ZetaWidgetBorder shape;

  /// If provided, displays a hint inside the input field.
  /// Default is `Search`.
  final String? hintText;

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
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('initialValue', initialValue))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSpeechToText', onSpeechToText))
      ..add(DiagnosticsProperty<bool>('showSpeechToText', showSpeechToText))
      ..add(DiagnosticsProperty<FocusNode>('focusNode', focusNode))
      ..add(EnumProperty<TextInputAction>('textInputAction', textInputAction))
      ..add(StringProperty('microphoneSemanticLabel', microphoneSemanticLabel))
      ..add(StringProperty('clearSemanticLabel', clearSemanticLabel));
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
