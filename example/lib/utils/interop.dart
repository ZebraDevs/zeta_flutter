import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

extension type InitialData._(JSObject _) implements JSObject {
  /// Retrieve `initialData` from `ui_web` for [viewId].
  static InitialData? forView(int viewId) {
    return ui_web.views.getInitialData(viewId) as InitialData?;
  }

  @JS('darkMode')
  external JSBoolean get _darkMode;
  @JS('highContrast')
  external JSBoolean get _highContrast;
  @JS('route')
  external JSString get _route;
}

/// Translate [InitialData]'s getters to Dart types.
extension InitialDataDartGetters on InitialData {
  bool get darkMode => _darkMode.toDart;

  bool get highContrast => _highContrast.toDart;

  String get route => _route.toDart;

  /// Returns a [Map]-like version of this object.
  Object? get toDart => dartify();
}
