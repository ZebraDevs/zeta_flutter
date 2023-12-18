import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/tag_example.dart';

WidgetbookComponent tagWidgetBook() {
  return WidgetbookComponent(
    name: 'Tag',
    useCases: [
      WidgetbookUseCase(
        name: 'Tag',
        builder: (context) => Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [TagExample.tagsRowLeft, TagExample.tagsRowRight],
        )),
      ),
    ],
  );
}
