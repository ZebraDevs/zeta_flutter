# Switch

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5655-893&m=dev

## Switch

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5804-156&m=dev

### Overview

A single on or off toggle, a track with a thumb slider that switches between its two ends. Two independent icon slots sit at either end of the track, which can be removed as a pair. Focus adds a border rather than changing the track or thumb colour.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | enabled | true | The resting state. Track and thumb take their default or pressed token depending on Switch. |
| State | focus | - | Adds a 2px border bound to border/focus, replacing the 0 weight border/default border at rest. Track and thumb colour do not change. |
| State | disabled | - | Track and thumb switch to their disabled tokens regardless of Switch. The control does not accept input. |
| Switch | off | true | The track sits on interactive/selection/background/default and the thumb sits at the left. The icon slot nearest the thumb is covered. |
| Switch | on | - | The track switches to interactive/selection/background/pressed and the thumb slides 32px to the right. The thumb colour itself does not change between on and off. |
| hasIcons | true | true | Shows both icon slots at the ends of the track. |
| hasIcons | false | - | Removes both icon slots, leaving a plain track and thumb. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| enabled | Resting | — | Track and thumb sit on their default or pressed token depending on Switch. No border. |
| focus | Keyboard focus | — | A 2px border appears, bound to border/focus, drawn inside the control's own bounds. Track and thumb colour do not change from enabled. |
| disabled | Disabled state set | — | Track and thumb switch to their disabled tokens. The control does not accept input. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | When the switch is toggled, the thumb slides to the opposite end of the track and the track colour changes from off to on at the same time.
The movement uses ease-spring: cubic-bezier(0.34, 1.36, 0.64, 1), with a duration of 250ms. 
The track colour changes in step with the thumb, so it reaches its final colour exactly when the thumb arrives.
If the switch is toggled again during the animation, the thumb reverses from where it is, without jumping or restarting.
The thumb increases it’s width to 1.3 before settling back to it’s original width |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Left icon slot | Instance swap on a nested Icon | Independent of the right slot. This file's sample shows Microphone Off at rest and Microphone when the switch is on, to demonstrate a state communicating pair. Any glyph can replace either one. |
| Right icon slot | Instance swap on a nested Icon | Independent of the left slot. Always shows Microphone Off in this sample, covered by the thumb when the switch is on. |

### Anatomy

1. **Track** — A rectangle sitting behind everything else. Its own colour depends on both State and Switch.
2. **Left icon slot** — An instance swap slot, covered by the thumb when Switch is on.
3. **Right icon slot** — An instance swap slot, covered by the thumb when Switch is off.
4. **Thumb** — A circle that slides 32px between the two ends. Its own colour does not change between on and off, only between enabled and disabled.

### How to use

**Do:**
- Keep the two icon slots paired to communicate the current state, the way this file's Microphone example does, rather than using unrelated glyphs on each side.
- Turn hasIcons off for a plain track and thumb switch with no icon content at either end.

**Don't:**
- Don't expect the thumb to change colour between on and off, only the track does. Rely on the track colour and the thumb's position together to show state.
- Don't expect this component's own focus border to extend past its bounds, it is drawn inside the 64x32 footprint rather than around it.

### Accessibility & Content Guidelines

- The switch has the role of switch and tells assistive technology whether it is on or off. Screen readers announce it as “[label], switch, on” or “off”.
- Space toggles the switch. Enter may also toggle it. Tab moves focus to and from the switch.
- The focus ring is clearly visible on keyboard focus against both the on and off track colours.
- The switch’s state is shown by the thumb’s position as well as by colour, so it does not depend on colour alone.
- A disabled switch can’t be toggled, but it stays readable, and the reason it’s disabled is explained nearby when it isn’t obvious.
- With reduced motion turned on, the state changes instantly. The colour change remains, because it shows the switch’s state.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed | 64px, held fixed rather than hugging its content. |
| Height | Fixed | 32px, held fixed. |
| Padding | Fixed | 4px on every side of the track. |
| Thumb | Fixed size, fixed travel | 24px across. Slides between x=4 at off and x=36 at on, 32px of travel. |
| Icon size | Fixed | 20px square at each end, inside the same 4px padding as the thumb. |
| Border | Fixed per State | 0 weight bound to border/default at rest, 2px bound to border/focus when focused, drawn inside the control’s own bounds so the overall size does not change. |

### Layer structure

- Switch (COMPONENT)
  - Switch/Track (RECTANGLE)
  - Switch/Icons (FRAME)
    - Switch/Icons/On Icon (INSTANCE, icon: microphone_off)
    - Switch/Icons/Off Icon (INSTANCE, icon: microphone_off)
  - Switch/Thumb (RECTANGLE)

### Resolved tokens (default variant: State=enabled, Switch=off)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Switch | stroke[0] | #ced2db | border.default |
| Switch | cornerRadius | 9999 | radius.pill |
| Switch | strokeWeight | 0 | stroke.base |
| Switch | itemSpacing | 8 | space.sm |
| Switch | padding.left | 4 | space.xxs |
| Switch | padding.right | 4 | space.xxs |
| Switch | padding.top | 4 | space.xxs |
| Switch | padding.bottom | 4 | space.xxs |
| Switch/Track | fill[0] | #7a8190 | interactive.selection.background.default |
| Switch/Track | cornerRadius | 9999 | radius.pill |
| Switch/Icons | itemSpacing | 8 | — |
| Switch/Icons | padding.left | 4 | space.xxs |
| Switch/Icons | padding.right | 4 | space.xxs |
| Switch/Icons | padding.top | 4 | space.xxs |
| Switch/Icons | padding.bottom | 4 | space.xxs |
| Switch/Thumb | height | 24 | control.xs |
| Switch/Thumb | fill[0] | #ffffff | interactive.primary.foreground.default |
| Switch/Thumb | cornerRadius | 9999 | radius.pill |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | disabled | Switch/Track | fill[0] | interactive.selection.background.disabled |
| State | disabled | Switch/Thumb | fill[0] | interactive.primary.foreground.disabled |
| State | focus | Switch | stroke[0] | border.focus |
| State | focus | Switch | strokeWeight | stroke.thick |
| Switch | on | Switch/Track | fill[0] | interactive.selection.background.pressed |
