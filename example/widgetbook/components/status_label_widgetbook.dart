import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/status_label_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent statusLabelWidgetBook() {
  return WidgetbookComponent(
    name: 'StatusLabel',
    useCases: [
      WidgetbookUseCase(
        name: 'Status Label',
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              statusLabelExampleRow(ZetaStatusLabelType.neutral),
              statusLabelExampleRow(ZetaStatusLabelType.info),
              statusLabelExampleRow(ZetaStatusLabelType.positive),
              statusLabelExampleRow(ZetaStatusLabelType.warning),
              statusLabelExampleRow(ZetaStatusLabelType.negative),
              statusLabelExampleRow(
                ZetaStatusLabelType.custom,
                colors: ZetaStatusLabelColors(accentColor: Colors.blue, backgroundColor: Colors.blue.shade50),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
