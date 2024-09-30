import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class CommsButtonExample extends StatelessWidget {
  static const String name = 'CommsButton';

  const CommsButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            runSpacing: Zeta.of(context).spacing.xl_3,
            alignment: WrapAlignment.start,
            children: [
              Column(
                children: [
                  ZetaCommsButton(
                    semanticLabel: "Reject / Answer",
                    label: 'Reject',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.reject,
                    icon: ZetaIcons.end_call,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.phone,
                    toggledType: ZetaCommsButtonType.on,
                    toggledLabel: 'Call Back',
                  ),
                  ZetaCommsButton(
                    label: 'Reject',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.reject,
                    icon: ZetaIcons.end_call,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.phone,
                    toggledType: ZetaCommsButtonType.on,
                    toggledLabel: 'Call Back',
                  ),
                  ZetaCommsButton(
                    label: 'Reject',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.reject,
                    icon: ZetaIcons.end_call,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.phone,
                    toggledType: ZetaCommsButtonType.on,
                    toggledLabel: 'Call Back',
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Answer',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.answer,
                    icon: ZetaIcons.phone,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.end_call,
                    toggledType: ZetaCommsButtonType.reject,
                    toggledLabel: 'End Call',
                  ),
                  ZetaCommsButton(
                    label: 'Answer',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.answer,
                    icon: ZetaIcons.phone,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.end_call,
                    toggledType: ZetaCommsButtonType.reject,
                    toggledLabel: 'End Call',
                  ),
                  ZetaCommsButton(
                    label: 'Answer',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.answer,
                    icon: ZetaIcons.phone,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.end_call,
                    toggledType: ZetaCommsButtonType.reject,
                    toggledLabel: 'End Call',
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Mute',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.microphone,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.microphone_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Un-Mute',
                  ),
                  ZetaCommsButton(
                    label: 'Mute',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.microphone,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.microphone_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Un-Mute',
                  ),
                  ZetaCommsButton(
                    label: 'Mute',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.microphone,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.microphone_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Un-Mute',
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Hide Video',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.video,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.video_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Show Video',
                  ),
                  ZetaCommsButton(
                    label: 'Hide Video',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.video,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.video_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Show Video',
                  ),
                  ZetaCommsButton(
                    label: 'Hide Video',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.video,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.video_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Show Video',
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Transfer',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.forward,
                  ),
                  ZetaCommsButton(
                    label: 'Transfer',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.forward,
                  ),
                  ZetaCommsButton(
                    label: 'Transfer',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.forward,
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Hold Call',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.pause,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.pause,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'On Hold',
                  ),
                  ZetaCommsButton(
                    label: 'Hold Call',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.pause,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.pause,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'On Hold',
                  ),
                  ZetaCommsButton(
                    label: 'Hold Call',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.pause,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.pause,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'On Hold',
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Speaker On',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.volume_up,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.volume_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Speaker Off',
                  ),
                  ZetaCommsButton(
                    label: 'Speaker On',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.volume_up,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.volume_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Speaker Off',
                  ),
                  ZetaCommsButton(
                    label: 'Speaker On',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.volume_up,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.volume_off,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Speaker Off',
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Record',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.recording,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.stop,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Stop',
                  ),
                  ZetaCommsButton(
                    label: 'Record',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.recording,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.stop,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Stop',
                  ),
                  ZetaCommsButton(
                    label: 'Record',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.recording,
                    onToggle: () {
                      print('Toggled');
                    },
                    toggledIcon: ZetaIcons.stop,
                    toggledType: ZetaCommsButtonType.off,
                    toggledLabel: 'Stop',
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Add',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.add_group_sharp,
                  ),
                  ZetaCommsButton(
                    label: 'Add',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.add_group_sharp,
                  ),
                  ZetaCommsButton(
                    label: 'Add',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.on,
                    icon: ZetaIcons.add_group_sharp,
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
              Column(
                children: [
                  ZetaCommsButton(
                    label: 'Security',
                    size: ZetaWidgetSize.large,
                    type: ZetaCommsButtonType.security,
                    icon: ZetaIcons.alert_active,
                    onPressed: () {
                      print('Pressed');
                    },
                  ),
                  ZetaCommsButton(
                    label: 'Security',
                    size: ZetaWidgetSize.medium,
                    type: ZetaCommsButtonType.security,
                    icon: ZetaIcons.alert_active,
                  ),
                  ZetaCommsButton(
                    label: 'Security',
                    size: ZetaWidgetSize.small,
                    type: ZetaCommsButtonType.security,
                    icon: ZetaIcons.alert_active,
                  ),
                ].gap(Zeta.of(context).spacing.large),
              ),
            ].gap(Zeta.of(context).spacing.large),
          ),
        ),
      ),
    );
  }
}
