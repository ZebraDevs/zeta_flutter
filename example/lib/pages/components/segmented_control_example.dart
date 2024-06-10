import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SegmentedControlExample extends StatefulWidget {
  const SegmentedControlExample({super.key});

  static const String name = 'SegmentedControl';

  @override
  State<SegmentedControlExample> createState() => _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<SegmentedControlExample> {
  final _iconsSegments = [1, 2, 3, 4, 5];
  final _numberSegments = [1, 2, 3, 4, 5];
  late int _selectedIconSegment = _iconsSegments.first;
  late int _selectedNumberSegment = _numberSegments.first;
  late String _selectedTextSegment = _textSegments.first;
  final _textSegments = ["Item 1", "Item 2", "Item 3"];

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: SegmentedControlExample.name,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Text
            Padding(
              padding: const EdgeInsets.all(ZetaSpacing.xl_4),
              child: ZetaSegmentedControl(
                segments: [
                  for (final value in _textSegments)
                    ZetaButtonSegment(
                      value: value,
                      child: Text(value),
                    ),
                ],
                onChanged: (value) => setState(
                  () => _selectedTextSegment = value,
                ),
                selected: _selectedTextSegment,
              ),
            ),

            // Numbers
            Padding(
              padding: const EdgeInsets.all(ZetaSpacing.xl_4),
              child: ZetaSegmentedControl(
                segments: [
                  for (final value in _numberSegments)
                    ZetaButtonSegment(
                      value: value,
                      child: Text(value.toString()),
                    ),
                ],
                onChanged: (value) => setState(
                  () => _selectedNumberSegment = value,
                ),
                selected: _selectedNumberSegment,
              ),
            ),

            // Icons
            Padding(
              padding: const EdgeInsets.all(ZetaSpacing.xl_4),
              child: ZetaSegmentedControl(
                segments: [
                  for (final value in _iconsSegments)
                    ZetaButtonSegment(
                      value: value,
                      child: Icon(ZetaIcons.star_round),
                    ),
                ],
                onChanged: (value) => setState(
                  () => _selectedIconSegment = value,
                ),
                selected: _selectedIconSegment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
