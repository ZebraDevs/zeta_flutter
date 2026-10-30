# Radio Button

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3843-2543&m=dev

## Radio Button

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4294-3121&m=dev

### Overview

A circular control for choosing exactly one option from a set, with an optional text label beside it. Every option in the set shares a group and exactly one carries Checked at a time. A short, fixed list of mutually exclusive options is what it fits, a long or growing list is better served by a dropdown.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| hasLabel | Boolean | true | Shows a text label beside the control, as a separate element rather than part of the circle itself. The default. |
| hasLabel | Boolean | - | Removes the label, leaving only the circular control at a fixed 40 by 40 size. The option’s meaning then has to be communicated some other way nearby. |
| Checked | Variant | true | The option is not the one currently chosen in its group. The inner fill stays hidden in every interactive state. |
| Checked | Variant | - | The option is the one currently chosen in its group. Only one Radio Button in a group carries this at a time. |
| State | Variant | true | Resting and interactive. Ring colour follows Checked, the inner fill is hidden when unchecked and shown when Checked. The default. |
| State | Variant | - | Pointer over the control. Ring colour steps to its hover tone for both Checked and unchecked, the inner fill’s visibility does not change. |
| State | Variant | - | Keyboard focus. A second ring is drawn around the control at the same colour as the inner ring, the inner fill keeps whatever visibility Checked already gives it. |
| State | Variant | - | Not interactive. Ring and inner fill both move to their disabled tones. Ships only in its unchecked form, a chosen option that becomes disabled has no variant of its own. |
| Size | Variant | true | 24px ring, 12px inner fill when Checked. The default. |
| Size | Variant | - | 16px ring, 8px inner fill when Checked. The surrounding touch target and the label’s type size stay the same, only the circle itself changes. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| enabled | Resting | — | Ring colour follows Checked. Unchecked rings use the default border tone, Checked rings and the inner fill both use a stronger tone. The inner fill is hidden entirely when unchecked rather than drawn in a lighter shade. |
| hover | Pointer over the control | — | Ring colour steps to its hover tone for both Checked and unchecked. The inner fill’s visibility does not change with hover, it stays tied to Checked. |
| focus | Keyboard focus | — | A second ring is drawn around the control, independent of the inner ring, both using the same focus colour. The inner fill keeps whatever visibility Checked already gives it. |
| disabled | Disabled set to true | — | Ring and inner fill both move to their disabled tones. The inner fill is visible here even though the variant is unchecked, unlike every other unchecked state, where it is visible only when Checked. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Every state change is a colour and visibility change, except Focus, which adds a second ring rather than altering the existing one. |
| Resize | Removing the label collapses the control to its 40 by 40 touch target, nothing else in the layout shifts position. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | Plain text | Consumer owned. Positioned directly beside the touch target with no gap token between them, at a fixed type size that does not change with Size. |

### Anatomy

1. **Ring** — A circular frame with a stroke, sized by Size and coloured by Checked and State together.
2. **Inner fill** — A separate circular layer centred inside the ring, hidden when unchecked in every state except disabled.
3. **Label** — Plain text beside the touch target, consumer owned and fixed in type size across both sizes.

### How to use

**Do:**
- Give every option in a set its own Radio Button sharing a group, with exactly one Checked at a time.
- Pair Checked with a label that states the option in full, the control alone does not say what is being chosen.

**Don't:**
- Don’t leave more than one Radio Button in the same group Checked at once, the control is built for a single choice.
- Don’t use Radio Button for a single standalone yes or no choice, Checkbox or Switch fits that better.

### Accessibility & Content Guidelines

- Grouping, the relationship that makes exactly one option in a set selectable, is not something Figma represents, it is carried by whatever groups the instances in code. Focus here is the only visual record of keyboard interaction, pair it with a label so the option reads on its own.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Touch target | 40×40, fixed | Does not change with Size, both ring sizes sit inside the same touch target. |
| Ring | 24px at Large, 16px at Medium | A 2px stroke at both sizes, drawn on a frame with a 9999 corner radius rather than an ellipse shape. |
| Inner fill | 12px at Large, 8px at Medium | A separate circular layer rather than a change to the ring’s own fill. |
| Gap | 0, no token | The label sits directly against the touch target’s edge with no spacing token between them. |
| Type | 16px at both sizes | Does not change between Large and Medium, only the ring and inner fill do. |

### Layer structure

- Radio Button (COMPONENT)
  - Radio Button/Radio Button (FRAME)
    - Radio Button/Radio Button/Radio Button (FRAME)
      - Radio Button/Radio Button/Radio Button/Check (ELLIPSE)
    - Radio Button/Radio Button/Focus (FRAME)
      - Radio Button/Radio Button/Focus/Radio Button (FRAME)
        - Radio Button/Radio Button/Focus/Radio Button/Check (ELLIPSE)
  - Radio Button/Label (TEXT)

### Resolved tokens (default variant: Checked=false, State=enabled, Size=large)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Radio Button | cornerRadius | 0 | radius.none |
| Radio Button/Radio Button | width | 40 | control.target-min |
| Radio Button/Radio Button | height | 40 | control.target-min |
| Radio Button/Radio Button/Radio Button | stroke[0] | #7a8190 | interactive.selection.border.default |
| Radio Button/Radio Button/Radio Button | cornerRadius | 9999 | radius.pill |
| Radio Button/Radio Button/Radio Button | strokeWeight | 2 | stroke.thick |
| Radio Button/Radio Button/Radio Button | padding.left | 4 | space.xxs |
| Radio Button/Radio Button/Radio Button | padding.right | 4 | space.xxs |
| Radio Button/Radio Button/Radio Button | padding.top | 4 | space.xxs |
| Radio Button/Radio Button/Radio Button | padding.bottom | 4 | space.xxs |
| Radio Button/Radio Button/Radio Button/Check | fill[0] | #7a8190 | foreground.tertiary |
| Radio Button/Label | fill[0] | #0c0d0e | foreground.primary |
| Radio Button/Label | fontSize | 14 | label.medium.font size |
| Radio Button/Label | lineHeight | 20 | label.medium.line height |
| Radio Button/Label | letterSpacing | 0 | label.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Checked | true | Radio Button/Radio Button/Radio Button | stroke[0] | interactive.selection.border.pressed |
| Checked | true | Radio Button/Radio Button/Radio Button/Check | fill[0] | interactive.selection.background.pressed |
| State | hover | Radio Button/Radio Button/Radio Button | stroke[0] | interactive.selection.border.hover |
| State | hover | Radio Button/Radio Button/Radio Button/Check | fill[0] | foreground.secondary |
| State | disabled | Radio Button/Radio Button/Radio Button | stroke[0] | interactive.selection.border.disabled |
| State | disabled | Radio Button/Radio Button/Radio Button/Check | fill[0] | interactive.selection.background.disabled |
| State | disabled | Radio Button/Label | fill[0] | foreground.disabled |
| State | focus | Radio Button/Radio Button/Radio Button | stroke[0] | — |
| State | focus | Radio Button/Radio Button/Radio Button | cornerRadius | — |
| State | focus | Radio Button/Radio Button/Radio Button | strokeWeight | — |
| State | focus | Radio Button/Radio Button/Radio Button | padding.left | — |
| State | focus | Radio Button/Radio Button/Radio Button | padding.right | — |
| State | focus | Radio Button/Radio Button/Radio Button | padding.top | — |
| State | focus | Radio Button/Radio Button/Radio Button | padding.bottom | — |
| State | focus | Radio Button/Radio Button/Radio Button/Check | fill[0] | — |
| State | focus | Radio Button/Radio Button/Focus | stroke[0] | border.focus |
| State | focus | Radio Button/Radio Button/Focus | cornerRadius | radius.pill |
| State | focus | Radio Button/Radio Button/Focus | strokeWeight | stroke.thick |
| State | focus | Radio Button/Radio Button/Focus/Radio Button | stroke[0] | interactive.selection.border.default |
| State | focus | Radio Button/Radio Button/Focus/Radio Button | cornerRadius | radius.pill |
| State | focus | Radio Button/Radio Button/Focus/Radio Button | strokeWeight | stroke.thick |
| State | focus | Radio Button/Radio Button/Focus/Radio Button | padding.left | space.xxs |
| State | focus | Radio Button/Radio Button/Focus/Radio Button | padding.right | space.xxs |
| State | focus | Radio Button/Radio Button/Focus/Radio Button | padding.top | space.xxs |
| State | focus | Radio Button/Radio Button/Focus/Radio Button | padding.bottom | space.xxs |
| State | focus | Radio Button/Radio Button/Focus/Radio Button/Check | fill[0] | foreground.tertiary |
| Size | medium | Radio Button/Radio Button/Radio Button | padding.left | space.2xs |
| Size | medium | Radio Button/Radio Button/Radio Button | padding.right | space.2xs |
| Size | medium | Radio Button/Radio Button/Radio Button | padding.top | space.2xs |
| Size | medium | Radio Button/Radio Button/Radio Button | padding.bottom | space.2xs |
| Size | medium | Radio Button/Radio Button/Radio Button | height | control.icon-sm |
