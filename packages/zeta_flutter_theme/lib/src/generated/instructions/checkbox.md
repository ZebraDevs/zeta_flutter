# Checkbox

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6382-52&m=dev

## Checkbox

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6384-207&m=dev

### Overview

A square control for turning a single option on or off, with an optional label beside it. Checked carries three values rather than two, so a checkbox that summarises a set of others can say indeterminate instead of guessing between on and off. Reach for it wherever options are independent of each other, and reach for Radio Button where exactly one of a set has to win.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| hasLabel | true | true | Shows the label beside the control. Keep it on, because the box carries no name and the target beside it is the part most people aim at. |
| hasLabel | false | - | Leaves the control as the target alone. Only safe where something else already names the option, such as a column header in a table of rows. |
| Checked | false | true | The option is off. The box carries a border and no fill, which is the only state with nothing inside it. |
| Checked | true | - | The option is on, shown by a check mark on a filled box. |
| Checked | indeterminate | - | Some of what this control stands for is on and some is off. Reach for it on a parent that summarises other checkboxes, never as a third value a person can choose, because nothing cycles into it. |
| State | enabled | true | Resting and interactive. |
| State | hover | - | Pointer over the control. The border answers, and the fill answers too once checked. |
| State | focus | - | Keyboard focus. A second ring is drawn at the box's own size, so the control stays exactly where it was. |
| State | disabled | - | Not interactive. The mark stays visible, so a disabled checkbox still reports its value rather than hiding it. |
| Size | large | true | The default, and the right choice wherever the checkbox stands on its own. |
| Size | medium | - | For dense lists and table rows. The target does not shrink with it, so the control is no harder to hit. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| enabled | Resting | — | The border follows Checked. Unchecked draws interactive/selection/border/default over no fill. Checked and indeterminate fill with interactive/selection/background/pressed and border with interactive/selection/border/pressed. |
| hover | Pointer over the control | — | The border steps to interactive/selection/border/hover, and once checked the fill steps to interactive/selection/background/hover. The label holds. |
| focus | Keyboard focus | — | A ring bound to border/focus is drawn at the box's own size, sitting over the state border rather than replacing it. Nothing else changes. |
| disabled | — | — | The border moves to interactive/selection/border/disabled, any fill to interactive/selection/background/disabled, and the label to foreground/disabled. The mark stays where it is. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Every state is a swap of border, fill and, where it applies, the glyph inside the box. |
| Selection model | Checked carries all three values on one axis rather than pairing a two-value checked with a separate indeterminate flag. A control can therefore be off, on or mixed and never two of those at once, which a separate flag allows by accident. |
| Resize | Turning the label off collapses the control to the 40 target alone. With the label on the width hugs it, so a long option name widens the control rather than wrapping inside a fixed box. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | Plain text, toggled by hasLabel | Consumer owned, set through the Label property and sitting directly beside the target. Turning hasLabel off leaves the control with no visible name, so one has to come from the surrounding structure. |
| Mark | nested Icon, not exposed | A check mark when Checked is true and a dash when it is indeterminate. The Checkbox decides both the glyph and its size and surfaces none of the Icon's own properties, so the mark is not a slot a consumer fills. |

### Anatomy

1. **Touch target** — A fixed 40 square holding the box. It is the pressable area, and it supplies the space between the box and the label on its own.
2. **Box** — The square itself, carrying the border at every state and the fill once checked. The mark sits inside it rather than replacing it.
3. **Label** — The option's name, turned on by hasLabel and set through Label. It extends the area a person can aim at.

### How to use

**Do:**
- Use indeterminate on a parent that summarises a mixed set of children. It is the one value that says some without claiming all or none.
- Keep the label on. The 40 target already reaches past the box, and the label extends the thing a person aims at, which is most of what makes a small control easy to hit.

**Don't:**
- Don't reach for Checkbox where only one option may win. That is Radio Button, and a row of checkboxes gives a person no way to see the constraint before breaking it.
- Don't offer indeterminate as a third value someone can select. Nothing cycles into it. It is set from the state of the things underneath it and read back, never chosen.

### Accessibility & Content Guidelines

- The label is the control's name. Turning hasLabel off removes it from view, so the name has to come from the surrounding structure before the control is usable without sight.
- indeterminate is a third value, not a styling of checked. It has to be exposed as one, or a mixed parent is announced as simply on or off.
- The 40 square target is larger than the box at both sizes. Keep the whole square pressable rather than only the box, and let the label extend it further.
- disabled keeps the mark visible so the value stays readable. Both the border and the fill move to their disabled tokens while the glyph does not, so check the mark still holds contrast against the dimmed fill.
- Focus is a ring at the box's own size rather than an outset halo. Check it reads against the state border directly beneath it, particularly on a busy surface.
- A checkbox rarely stands alone. Where several belong together, the grouping and its name have to be expressed in the structure around them, because nothing in the control carries it.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Touch target | 40×40, fixed | Does not change with Size. Both sizes centre their box inside the same 40 square, so a column of mixed sizes still aligns and every control keeps the same target regardless of how small its box is. |
| Box | 24 at large, 16 at medium | control/xs at large and control/icon-sm at medium, with a 2px stroke at both. Radius is radius/element-sm at large and radius/xs at medium, so the corner softens in proportion rather than holding one value. |
| Mark | 20 at large, 12 at medium | An Icon at Size=medium for the large box and Size=small for the medium one. It sits inside the box rather than replacing its fill, and is present only when Checked is true or indeterminate. |
| Focus ring | Matches the box | A second stroke bound to border/focus, carried on a frame the same size as the box rather than outside it, so gaining focus does not change the control's footprint or shift anything beside it. |
| Gap | 0, space/none | The label sits directly against the target with nothing between them. The 40 square supplies the visual gap on its own, because the box is only 24 or 16 and sits centred inside it. |
| Label | 14px at both sizes | label/medium at large and medium alike. Size moves the box and the mark and never the text, so the label stays at full legibility in the denser option. |

### Layer structure

- Checkbox (COMPONENT)
  - Checkbox/Target (FRAME)
    - Checkbox/Target/Box (FRAME)
      - Checkbox/Target/Box/Mark (INSTANCE, icon: check_mark)
    - Checkbox/Target/Focus (FRAME)
      - Checkbox/Target/Focus/Box (FRAME)
        - Checkbox/Target/Focus/Box/Mark (INSTANCE, icon: check_mark)
  - Checkbox/Label (TEXT)

### Resolved tokens (default variant: Checked=false, State=enabled, Size=large)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Checkbox/Target | width | 40 | control.target-min |
| Checkbox/Target | height | 40 | control.target-min |
| Checkbox/Target/Box | width | 24 | control.xs |
| Checkbox/Target/Box | height | 24 | control.xs |
| Checkbox/Target/Box | stroke[0] | #7a8190 | interactive.selection.border.default |
| Checkbox/Target/Box | cornerRadius | 4 | radius.element-sm |
| Checkbox/Target/Box | strokeWeight | 2 | stroke.thick |
| Checkbox/Label | fill[0] | #0c0d0e | foreground.primary |
| Checkbox/Label | fontSize | 14 | label.medium.font size |
| Checkbox/Label | lineHeight | 20 | label.medium.line height |
| Checkbox/Label | letterSpacing | 0 | label.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Checked | true | Checkbox/Target/Box | stroke[0] | interactive.selection.border.pressed |
| Checked | true | Checkbox/Target/Box | fill[0] | interactive.selection.background.pressed |
| Checked | indeterminate | Checkbox/Target/Box | stroke[0] | interactive.selection.border.pressed |
| Checked | indeterminate | Checkbox/Target/Box | fill[0] | interactive.selection.background.pressed |
| State | hover | Checkbox/Target/Box | stroke[0] | interactive.selection.border.hover |
| State | focus | Checkbox/Target/Box | width | — |
| State | focus | Checkbox/Target/Box | height | — |
| State | focus | Checkbox/Target/Box | stroke[0] | — |
| State | focus | Checkbox/Target/Box | cornerRadius | — |
| State | focus | Checkbox/Target/Box | strokeWeight | — |
| State | focus | Checkbox/Target/Focus | stroke[0] | border.focus |
| State | focus | Checkbox/Target/Focus | cornerRadius | radius.element-sm |
| State | focus | Checkbox/Target/Focus | strokeWeight | stroke.thick |
| State | focus | Checkbox/Target/Focus/Box | width | control.xs |
| State | focus | Checkbox/Target/Focus/Box | height | control.xs |
| State | focus | Checkbox/Target/Focus/Box | stroke[0] | interactive.selection.border.default |
| State | focus | Checkbox/Target/Focus/Box | cornerRadius | radius.element-sm |
| State | focus | Checkbox/Target/Focus/Box | strokeWeight | stroke.thick |
| State | disabled | Checkbox/Target/Box | stroke[0] | interactive.selection.border.disabled |
| State | disabled | Checkbox/Label | fill[0] | foreground.disabled |
| Size | medium | Checkbox/Target/Box | width | control.icon-sm |
| Size | medium | Checkbox/Target/Box | height | control.icon-sm |
| Size | medium | Checkbox/Target/Box | cornerRadius | radius.xs |
