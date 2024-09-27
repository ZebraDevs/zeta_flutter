// Mocks generated by Mockito 5.4.4 from annotations
// in zeta_flutter/test/src/utils/zeta_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:zeta_flutter/src/theme/theme_service.dart' as _i2;

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

class _FakeZetaThemeServiceData_0 extends _i1.SmartFake implements _i2.ZetaThemeServiceData {
  _FakeZetaThemeServiceData_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ZetaThemeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockZetaThemeService extends _i1.Mock implements _i2.ZetaThemeService {
  @override
  _i3.Future<_i2.ZetaThemeServiceData> loadTheme() => (super.noSuchMethod(
        Invocation.method(
          #loadTheme,
          [],
        ),
        returnValue: _i3.Future<_i2.ZetaThemeServiceData>.value(_FakeZetaThemeServiceData_0(
          this,
          Invocation.method(
            #loadTheme,
            [],
          ),
        )),
        returnValueForMissingStub: _i3.Future<_i2.ZetaThemeServiceData>.value(_FakeZetaThemeServiceData_0(
          this,
          Invocation.method(
            #loadTheme,
            [],
          ),
        )),
      ) as _i3.Future<_i2.ZetaThemeServiceData>);

  @override
  _i3.Future<void> saveTheme({required _i2.ZetaThemeServiceData? themeData}) => (super.noSuchMethod(
        Invocation.method(
          #saveTheme,
          [],
          {#themeData: themeData},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
