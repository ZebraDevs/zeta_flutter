// Mocks generated by Mockito 5.4.5 from annotations
// in zeta_flutter/test/components/search_bar/search_bar_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;

import 'search_bar_test.dart' as _i2;

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

/// A class which mocks [ISearchBarEvents].
///
/// See the documentation for Mockito's code generation for more information.
class MockISearchBarEvents extends _i1.Mock implements _i2.ISearchBarEvents {
  @override
  void onChange(String? text) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [text],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onSubmit(String? text) => super.noSuchMethod(
        Invocation.method(
          #onSubmit,
          [text],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<String?> onSpeech() => (super.noSuchMethod(
        Invocation.method(
          #onSpeech,
          [],
        ),
        returnValue: _i3.Future<String?>.value(),
        returnValueForMissingStub: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);
}
