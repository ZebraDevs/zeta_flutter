// Mocks generated by Mockito 5.4.5 from annotations
// in zeta_flutter/test/src/components/tooltip/tooltip_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i8;

import 'package:flutter/foundation.dart' as _i5;
import 'package:flutter/material.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;
import 'package:zeta_flutter_theme/src/contrast.dart' as _i7;
import 'package:zeta_flutter_theme/src/generated/tokens/primitives.g.dart' as _i2;
import 'package:zeta_flutter_theme/src/generated/tokens/semantics.g.dart' as _i3;
import 'package:zeta_flutter_theme/src/zeta.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeZetaPrimitives_0 extends _i1.SmartFake implements _i2.ZetaPrimitives {
  _FakeZetaPrimitives_0(Object parent, Invocation parentInvocation) : super(parent, parentInvocation);
}

class _FakeZetaSemantics_1 extends _i1.SmartFake implements _i3.ZetaSemantics {
  _FakeZetaSemantics_1(Object parent, Invocation parentInvocation) : super(parent, parentInvocation);
}

class _FakeZetaColors_2 extends _i1.SmartFake implements _i3.ZetaColors {
  _FakeZetaColors_2(Object parent, Invocation parentInvocation) : super(parent, parentInvocation);
}

class _FakeZetaRadius_3 extends _i1.SmartFake implements _i3.ZetaRadius {
  _FakeZetaRadius_3(Object parent, Invocation parentInvocation) : super(parent, parentInvocation);
}

class _FakeZetaSpacing_4 extends _i1.SmartFake implements _i3.ZetaSpacing {
  _FakeZetaSpacing_4(Object parent, Invocation parentInvocation) : super(parent, parentInvocation);
}

class _FakeWidget_5 extends _i1.SmartFake implements _i4.Widget {
  _FakeWidget_5(Object parent, Invocation parentInvocation) : super(parent, parentInvocation);

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) => super.toString();
}

class _FakeInheritedElement_6 extends _i1.SmartFake implements _i4.InheritedElement {
  _FakeInheritedElement_6(Object parent, Invocation parentInvocation) : super(parent, parentInvocation);

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) => super.toString();
}

class _FakeDiagnosticsNode_7 extends _i1.SmartFake implements _i5.DiagnosticsNode {
  _FakeDiagnosticsNode_7(Object parent, Invocation parentInvocation) : super(parent, parentInvocation);

  @override
  String toString({
    _i5.TextTreeConfiguration? parentConfiguration,
    _i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info,
  }) =>
      super.toString();
}

/// A class which mocks [Zeta].
///
/// See the documentation for Mockito's code generation for more information.
class MockZeta extends _i1.Mock implements _i6.Zeta {
  @override
  bool get rounded => (super.noSuchMethod(
        Invocation.getter(#rounded),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i7.ZetaContrast get contrast => (super.noSuchMethod(
        Invocation.getter(#contrast),
        returnValue: _i7.ZetaContrast.aa,
        returnValueForMissingStub: _i7.ZetaContrast.aa,
      ) as _i7.ZetaContrast);

  @override
  _i4.ThemeMode get themeMode => (super.noSuchMethod(
        Invocation.getter(#themeMode),
        returnValue: _i4.ThemeMode.system,
        returnValueForMissingStub: _i4.ThemeMode.system,
      ) as _i4.ThemeMode);

  @override
  _i2.ZetaPrimitives get primitives => (super.noSuchMethod(
        Invocation.getter(#primitives),
        returnValue: _FakeZetaPrimitives_0(
          this,
          Invocation.getter(#primitives),
        ),
        returnValueForMissingStub: _FakeZetaPrimitives_0(
          this,
          Invocation.getter(#primitives),
        ),
      ) as _i2.ZetaPrimitives);

  @override
  _i3.ZetaSemantics get semantics => (super.noSuchMethod(
        Invocation.getter(#semantics),
        returnValue: _FakeZetaSemantics_1(
          this,
          Invocation.getter(#semantics),
        ),
        returnValueForMissingStub: _FakeZetaSemantics_1(
          this,
          Invocation.getter(#semantics),
        ),
      ) as _i3.ZetaSemantics);

  @override
  _i3.ZetaColors get colors => (super.noSuchMethod(
        Invocation.getter(#colors),
        returnValue: _FakeZetaColors_2(this, Invocation.getter(#colors)),
        returnValueForMissingStub: _FakeZetaColors_2(
          this,
          Invocation.getter(#colors),
        ),
      ) as _i3.ZetaColors);

  @override
  _i8.Brightness get brightness => (super.noSuchMethod(
        Invocation.getter(#brightness),
        returnValue: _i8.Brightness.dark,
        returnValueForMissingStub: _i8.Brightness.dark,
      ) as _i8.Brightness);

  @override
  _i3.ZetaRadius get radius => (super.noSuchMethod(
        Invocation.getter(#radius),
        returnValue: _FakeZetaRadius_3(this, Invocation.getter(#radius)),
        returnValueForMissingStub: _FakeZetaRadius_3(
          this,
          Invocation.getter(#radius),
        ),
      ) as _i3.ZetaRadius);

  @override
  _i3.ZetaSpacing get spacing => (super.noSuchMethod(
        Invocation.getter(#spacing),
        returnValue: _FakeZetaSpacing_4(this, Invocation.getter(#spacing)),
        returnValueForMissingStub: _FakeZetaSpacing_4(
          this,
          Invocation.getter(#spacing),
        ),
      ) as _i3.ZetaSpacing);

  @override
  _i4.Widget get child => (super.noSuchMethod(
        Invocation.getter(#child),
        returnValue: _FakeWidget_5(this, Invocation.getter(#child)),
        returnValueForMissingStub: _FakeWidget_5(
          this,
          Invocation.getter(#child),
        ),
      ) as _i4.Widget);

  @override
  bool updateShouldNotify(_i4.InheritedWidget? oldWidget) => (super.noSuchMethod(
        Invocation.method(#updateShouldNotify, [oldWidget]),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void debugFillProperties(_i5.DiagnosticPropertiesBuilder? properties) => super.noSuchMethod(
        Invocation.method(#debugFillProperties, [properties]),
        returnValueForMissingStub: null,
      );

  @override
  _i4.InheritedElement createElement() => (super.noSuchMethod(
        Invocation.method(#createElement, []),
        returnValue: _FakeInheritedElement_6(
          this,
          Invocation.method(#createElement, []),
        ),
        returnValueForMissingStub: _FakeInheritedElement_6(
          this,
          Invocation.method(#createElement, []),
        ),
      ) as _i4.InheritedElement);

  @override
  String toStringShort() => (super.noSuchMethod(
        Invocation.method(#toStringShort, []),
        returnValue: _i9.dummyValue<String>(
          this,
          Invocation.method(#toStringShort, []),
        ),
        returnValueForMissingStub: _i9.dummyValue<String>(
          this,
          Invocation.method(#toStringShort, []),
        ),
      ) as String);

  @override
  String toStringShallow({
    String? joiner = ', ',
    _i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.debug,
  }) =>
      (super.noSuchMethod(
        Invocation.method(#toStringShallow, [], {
          #joiner: joiner,
          #minLevel: minLevel,
        }),
        returnValue: _i9.dummyValue<String>(
          this,
          Invocation.method(#toStringShallow, [], {
            #joiner: joiner,
            #minLevel: minLevel,
          }),
        ),
        returnValueForMissingStub: _i9.dummyValue<String>(
          this,
          Invocation.method(#toStringShallow, [], {
            #joiner: joiner,
            #minLevel: minLevel,
          }),
        ),
      ) as String);

  @override
  String toStringDeep({
    String? prefixLineOne = '',
    String? prefixOtherLines,
    _i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.debug,
    int? wrapWidth = 65,
  }) =>
      (super.noSuchMethod(
        Invocation.method(#toStringDeep, [], {
          #prefixLineOne: prefixLineOne,
          #prefixOtherLines: prefixOtherLines,
          #minLevel: minLevel,
          #wrapWidth: wrapWidth,
        }),
        returnValue: _i9.dummyValue<String>(
          this,
          Invocation.method(#toStringDeep, [], {
            #prefixLineOne: prefixLineOne,
            #prefixOtherLines: prefixOtherLines,
            #minLevel: minLevel,
            #wrapWidth: wrapWidth,
          }),
        ),
        returnValueForMissingStub: _i9.dummyValue<String>(
          this,
          Invocation.method(#toStringDeep, [], {
            #prefixLineOne: prefixLineOne,
            #prefixOtherLines: prefixOtherLines,
            #minLevel: minLevel,
            #wrapWidth: wrapWidth,
          }),
        ),
      ) as String);

  @override
  _i5.DiagnosticsNode toDiagnosticsNode({
    String? name,
    _i5.DiagnosticsTreeStyle? style,
  }) =>
      (super.noSuchMethod(
        Invocation.method(#toDiagnosticsNode, [], {
          #name: name,
          #style: style,
        }),
        returnValue: _FakeDiagnosticsNode_7(
          this,
          Invocation.method(#toDiagnosticsNode, [], {
            #name: name,
            #style: style,
          }),
        ),
        returnValueForMissingStub: _FakeDiagnosticsNode_7(
          this,
          Invocation.method(#toDiagnosticsNode, [], {
            #name: name,
            #style: style,
          }),
        ),
      ) as _i5.DiagnosticsNode);

  @override
  List<_i5.DiagnosticsNode> debugDescribeChildren() => (super.noSuchMethod(
        Invocation.method(#debugDescribeChildren, []),
        returnValue: <_i5.DiagnosticsNode>[],
        returnValueForMissingStub: <_i5.DiagnosticsNode>[],
      ) as List<_i5.DiagnosticsNode>);

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) => super.toString();
}
