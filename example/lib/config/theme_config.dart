import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/config/components_config.dart' show ExampleWrap;
import 'package:zeta_example/pages/theme/color_example.dart' deferred as color_example;
import 'package:zeta_example/pages/theme/radius_example.dart' deferred as radius_example;
import 'package:zeta_example/pages/theme/spacing_example.dart' deferred as spacing_example;
import 'package:zeta_example/pages/theme/typography_example.dart' deferred as typography_example;

const String colorsRoute = 'Colors';
const String typographyRoute = 'Typography';
const String spacingRoute = 'Spacing';
const String radiusRoute = 'Radius';

final Map<String, ExampleWrap> themeExampleNames = {
  colorsRoute: ExampleWrap(
    pageBuilder: (context) => color_example.ColorExample(),
    loader: color_example.loadLibrary,
  ),
  typographyRoute: ExampleWrap(
    pageBuilder: (context) => typography_example.TypographyExample(),
    loader: typography_example.loadLibrary,
  ),
  spacingRoute: ExampleWrap(
    pageBuilder: (context) => spacing_example.SpacingExample(),
    loader: spacing_example.loadLibrary,
  ),
  radiusRoute: ExampleWrap(
    pageBuilder: (context) => radius_example.RadiusExample(),
    loader: radius_example.loadLibrary,
  ),
};
final themeRoutes = themeExampleNames.entries.map(
  (e) => GoRoute(
    path: e.key,
    builder: (_, __) => FutureBuilder(
        future: e.value.loader(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (asyncSnapshot.hasError) {
            print('Error loading ${e.key}: ${asyncSnapshot.error}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Failed to load ${e.value}'),
                  SizedBox(height: 8),
                  Text('${asyncSnapshot.error}',
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            );
          }

          if (asyncSnapshot.connectionState == ConnectionState.done) {
            return e.value.pageBuilder.call(_);
          }

          return Center(child: CircularProgressIndicator());
        }),
  ),
);
