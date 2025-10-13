import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/config/components_config.dart' show ExampleWrap;
import 'package:zeta_example/pages/assets/illustrations_example.dart' deferred as illustrations_example;
import 'package:zeta_example/pages/assets/icons_example.dart' deferred as icons_example;

const String iconsRoute = 'Icons';
const String illustrationsRoute = 'Illustrations';

final Map<String, ExampleWrap> assetExampleNames = {
  iconsRoute: ExampleWrap(
    pageBuilder: (context) => icons_example.IconsExample(),
    loader: icons_example.loadLibrary,
  ),
  illustrationsRoute: ExampleWrap(
    pageBuilder: (context) => illustrations_example.IllustrationsExample(),
    loader: illustrations_example.loadLibrary,
  ),
};

final assetRoutes = assetExampleNames.entries.map(
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
