// Mocks generated by Mockito 5.4.4 from annotations
// in zeta_flutter/test/src/components/tooltip/tooltip_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i5;

import 'package:flutter/foundation.dart' as _i4;
import 'package:flutter/material.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:zeta_flutter/zeta_flutter.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeZetaThemeData_0 extends _i1.SmartFake implements _i2.ZetaThemeData {
  _FakeZetaThemeData_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeZetaColors_1 extends _i1.SmartFake implements _i2.ZetaColors {
  _FakeZetaColors_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeZetaRadiiSemantics_2 extends _i1.SmartFake
    implements _i2.ZetaRadiiSemantics {
  _FakeZetaRadiiSemantics_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeZetaSpacingSemantics_3 extends _i1.SmartFake
    implements _i2.ZetaSpacingSemantics {
  _FakeZetaSpacingSemantics_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWidget_4 extends _i1.SmartFake implements _i3.Widget {
  _FakeWidget_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedElement_5 extends _i1.SmartFake
    implements _i3.InheritedElement {
  _FakeInheritedElement_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_6 extends _i1.SmartFake
    implements _i4.DiagnosticsNode {
  _FakeDiagnosticsNode_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({
    _i4.TextTreeConfiguration? parentConfiguration,
    _i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info,
  }) =>
      super.toString();
}

/// A class which mocks [Zeta].
///
/// See the documentation for Mockito's code generation for more information.
class MockZeta extends _i1.Mock implements _i2.Zeta {
  @override
  _i2.ZetaContrast get contrast => (super.noSuchMethod(
        Invocation.getter(#contrast),
        returnValue: _i2.ZetaContrast.aa,
        returnValueForMissingStub: _i2.ZetaContrast.aa,
      ) as _i2.ZetaContrast);

  @override
  _i3.ThemeMode get themeMode => (super.noSuchMethod(
        Invocation.getter(#themeMode),
        returnValue: _i3.ThemeMode.system,
        returnValueForMissingStub: _i3.ThemeMode.system,
      ) as _i3.ThemeMode);

  @override
  _i2.ZetaThemeData get themeData => (super.noSuchMethod(
        Invocation.getter(#themeData),
        returnValue: _FakeZetaThemeData_0(
          this,
          Invocation.getter(#themeData),
        ),
        returnValueForMissingStub: _FakeZetaThemeData_0(
          this,
          Invocation.getter(#themeData),
        ),
      ) as _i2.ZetaThemeData);

  @override
  bool get rounded => (super.noSuchMethod(
        Invocation.getter(#rounded),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i2.ZetaColors get colors => (super.noSuchMethod(
        Invocation.getter(#colors),
        returnValue: _FakeZetaColors_1(
          this,
          Invocation.getter(#colors),
        ),
        returnValueForMissingStub: _FakeZetaColors_1(
          this,
          Invocation.getter(#colors),
        ),
      ) as _i2.ZetaColors);

  @override
  _i5.Brightness get brightness => (super.noSuchMethod(
        Invocation.getter(#brightness),
        returnValue: _i5.Brightness.dark,
        returnValueForMissingStub: _i5.Brightness.dark,
      ) as _i5.Brightness);

  @override
  _i2.ZetaRadiiSemantics get radius => (super.noSuchMethod(
        Invocation.getter(#radius),
        returnValue: _FakeZetaRadiiSemantics_2(
          this,
          Invocation.getter(#radius),
        ),
        returnValueForMissingStub: _FakeZetaRadiiSemantics_2(
          this,
          Invocation.getter(#radius),
        ),
      ) as _i2.ZetaRadiiSemantics);

  @override
  _i2.ZetaSpacingSemantics get spacing => (super.noSuchMethod(
        Invocation.getter(#spacing),
        returnValue: _FakeZetaSpacingSemantics_3(
          this,
          Invocation.getter(#spacing),
        ),
        returnValueForMissingStub: _FakeZetaSpacingSemantics_3(
          this,
          Invocation.getter(#spacing),
        ),
      ) as _i2.ZetaSpacingSemantics);

  @override
  _i3.Widget get child => (super.noSuchMethod(
        Invocation.getter(#child),
        returnValue: _FakeWidget_4(
          this,
          Invocation.getter(#child),
        ),
        returnValueForMissingStub: _FakeWidget_4(
          this,
          Invocation.getter(#child),
        ),
      ) as _i3.Widget);

  @override
  bool updateShouldNotify(_i3.InheritedWidget? oldWidget) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [oldWidget],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void debugFillProperties(_i4.DiagnosticPropertiesBuilder? properties) =>
      super.noSuchMethod(
        Invocation.method(
          #debugFillProperties,
          [properties],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.InheritedElement createElement() => (super.noSuchMethod(
        Invocation.method(
          #createElement,
          [],
        ),
        returnValue: _FakeInheritedElement_5(
          this,
          Invocation.method(
            #createElement,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeInheritedElement_5(
          this,
          Invocation.method(
            #createElement,
            [],
          ),
        ),
      ) as _i3.InheritedElement);

  @override
  String toStringShort() => (super.noSuchMethod(
        Invocation.method(
          #toStringShort,
          [],
        ),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toStringShort,
            [],
          ),
        ),
        returnValueForMissingStub: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toStringShort,
            [],
          ),
        ),
      ) as String);

  @override
  String toStringShallow({
    String? joiner = r', ',
    _i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.debug,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toStringShallow,
          [],
          {
            #joiner: joiner,
            #minLevel: minLevel,
          },
        ),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toStringShallow,
            [],
            {
              #joiner: joiner,
              #minLevel: minLevel,
            },
          ),
        ),
        returnValueForMissingStub: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toStringShallow,
            [],
            {
              #joiner: joiner,
              #minLevel: minLevel,
            },
          ),
        ),
      ) as String);

  @override
  String toStringDeep({
    String? prefixLineOne = r'',
    String? prefixOtherLines,
    _i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.debug,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toStringDeep,
          [],
          {
            #prefixLineOne: prefixLineOne,
            #prefixOtherLines: prefixOtherLines,
            #minLevel: minLevel,
          },
        ),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toStringDeep,
            [],
            {
              #prefixLineOne: prefixLineOne,
              #prefixOtherLines: prefixOtherLines,
              #minLevel: minLevel,
            },
          ),
        ),
        returnValueForMissingStub: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toStringDeep,
            [],
            {
              #prefixLineOne: prefixLineOne,
              #prefixOtherLines: prefixOtherLines,
              #minLevel: minLevel,
            },
          ),
        ),
      ) as String);

  @override
  _i4.DiagnosticsNode toDiagnosticsNode({
    String? name,
    _i4.DiagnosticsTreeStyle? style,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toDiagnosticsNode,
          [],
          {
            #name: name,
            #style: style,
          },
        ),
        returnValue: _FakeDiagnosticsNode_6(
          this,
          Invocation.method(
            #toDiagnosticsNode,
            [],
            {
              #name: name,
              #style: style,
            },
          ),
        ),
        returnValueForMissingStub: _FakeDiagnosticsNode_6(
          this,
          Invocation.method(
            #toDiagnosticsNode,
            [],
            {
              #name: name,
              #style: style,
            },
          ),
        ),
      ) as _i4.DiagnosticsNode);

  @override
  List<_i4.DiagnosticsNode> debugDescribeChildren() => (super.noSuchMethod(
        Invocation.method(
          #debugDescribeChildren,
          [],
        ),
        returnValue: <_i4.DiagnosticsNode>[],
        returnValueForMissingStub: <_i4.DiagnosticsNode>[],
      ) as List<_i4.DiagnosticsNode>);

  @override
  String toString({_i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info}) =>
      super.toString();
}
