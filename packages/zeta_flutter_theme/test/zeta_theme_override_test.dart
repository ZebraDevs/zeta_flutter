// TODO(thelukewalton): Fix these tests
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:zeta_flutter_theme/zeta_flutter_theme.dart';
// void main() {
//   testWidgets('ZetaThemeOverride overrides themeMode and contrast only', (WidgetTester tester) async {
//     // Build a widget tree with ZetaProvider and ZetaThemeOverride
//     await tester.pumpWidget(
//       ZetaProvider(
//         builder: (context, light, dark, mode) {
//           return ZetaThemeOverride(
//             themeMode: ThemeMode.dark,
//             contrast: ZetaContrast.aaa,
//             child: Builder(
//               builder: (context) {
//                 final zeta = Zeta.of(context);
//                 return Column(
//                   children: [
//                     Text('ThemeMode: \\${zeta.themeMode}'),
//                     Text('Contrast: \\${zeta.contrast}'),
//                   ],
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );

//     // Find the Text widgets and verify their values
//     expect(find.text('ThemeMode: ThemeMode.dark'), findsOneWidget);
//     expect(find.text('Contrast: ZetaContrast.aaa'), findsOneWidget);
//   });

//   testWidgets('ZetaThemeOverride inherits other Zeta settings', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       ZetaProvider(
//         fontFamily: 'CustomFont',
//         builder: (context, light, dark, mode) {
//           return ZetaThemeOverride(
//             themeMode: ThemeMode.light,
//             child: Builder(
//               builder: (context) {
//                 final zeta = Zeta.of(context);
//                 return Text('Font: \\${zeta.textStyles.fontFamily}');
//               },
//             ),
//           );
//         },
//       ),
//     );
//     expect(find.text('Font: CustomFont'), findsOneWidget);
//   });
// }
