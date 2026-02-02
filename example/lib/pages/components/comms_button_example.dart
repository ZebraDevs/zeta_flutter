import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class CommsButtonExample extends StatelessWidget {
  const CommsButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: commsButtonRoute, children: [
      Wrap(
        runSpacing: Zeta.of(context).spacing.xl_3,
        alignment: WrapAlignment.start,
        children: [
          Column(
            children: [
              ZetaCommsButton.reject(
                label: 'Reject',
                size: ZetaWidgetSize.large,
              ),
              ZetaCommsButton.reject(
                label: 'Reject',
                size: ZetaWidgetSize.medium,
              ),
              ZetaCommsButton.reject(
                label: 'Reject',
                size: ZetaWidgetSize.small,
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.answer(
                label: 'Answer',
                size: ZetaWidgetSize.large,
              ),
              ZetaCommsButton.answer(
                label: 'Answer',
                size: ZetaWidgetSize.medium,
              ),
              ZetaCommsButton.answer(
                label: 'Answer',
                size: ZetaWidgetSize.small,
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.mute(
                label: 'Mute',
                size: ZetaWidgetSize.large,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Un-Mute',
              ),
              ZetaCommsButton.mute(
                label: 'Mute',
                size: ZetaWidgetSize.medium,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Un-Mute',
              ),
              ZetaCommsButton.mute(
                label: 'Mute',
                size: ZetaWidgetSize.small,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Un-Mute',
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.video(
                label: 'Hide Video',
                size: ZetaWidgetSize.large,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Show Video',
              ),
              ZetaCommsButton.video(
                label: 'Hide Video',
                size: ZetaWidgetSize.medium,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Show Video',
              ),
              ZetaCommsButton.video(
                label: 'Hide Video',
                size: ZetaWidgetSize.small,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Show Video',
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.transfer(
                label: 'Transfer',
                size: ZetaWidgetSize.large,
              ),
              ZetaCommsButton.transfer(
                label: 'Transfer',
                size: ZetaWidgetSize.medium,
              ),
              ZetaCommsButton.transfer(
                label: 'Transfer',
                size: ZetaWidgetSize.small,
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.hold(
                label: 'Hold Call',
                size: ZetaWidgetSize.large,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'On Hold',
              ),
              ZetaCommsButton.hold(
                label: 'Hold Call',
                size: ZetaWidgetSize.medium,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'On Hold',
              ),
              ZetaCommsButton.hold(
                label: 'Hold Call',
                size: ZetaWidgetSize.small,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'On Hold',
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.speaker(
                label: 'Speaker On',
                size: ZetaWidgetSize.large,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Speaker Off',
              ),
              ZetaCommsButton.speaker(
                label: 'Speaker On',
                size: ZetaWidgetSize.medium,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Speaker Off',
              ),
              ZetaCommsButton.speaker(
                label: 'Speaker On',
                size: ZetaWidgetSize.small,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Speaker Off',
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.record(
                label: 'Record',
                size: ZetaWidgetSize.large,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Stop',
              ),
              ZetaCommsButton.record(
                label: 'Record',
                size: ZetaWidgetSize.medium,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Stop',
              ),
              ZetaCommsButton.record(
                label: 'Record',
                size: ZetaWidgetSize.small,
                onToggle: (isToggled) {
                  print('Toggled');
                  print(isToggled);
                },
                toggledLabel: 'Stop',
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.add(
                label: 'Add',
                size: ZetaWidgetSize.large,
              ),
              ZetaCommsButton.add(
                label: 'Add',
                size: ZetaWidgetSize.medium,
              ),
              ZetaCommsButton.add(
                label: 'Add',
                size: ZetaWidgetSize.small,
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
          Column(
            children: [
              ZetaCommsButton.security(
                label: 'Security',
                size: ZetaWidgetSize.large,
              ),
              ZetaCommsButton.security(
                label: 'Security',
                size: ZetaWidgetSize.medium,
              ),
              ZetaCommsButton.security(
                label: 'Security',
                size: ZetaWidgetSize.small,
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
        ].gap(Zeta.of(context).spacing.large),
      ),
    ]);
  }
}
