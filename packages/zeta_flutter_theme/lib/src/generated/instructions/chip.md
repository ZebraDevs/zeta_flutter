# Chip

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5122-2783&m=dev

## Input Chip

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5125-3467&m=dev

### Overview

Represents a person, entity or value someone has entered or picked, such as a recipient on a message, so it can be reviewed and removed without retyping. It belongs inside input and selection fields. Reach for a filter chip to narrow content, or an assist chip to offer an action.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Label | text | Label | The value the chip stands for, usually a name or a term someone entered. Keep it to the entity itself. A chip that needs explaining is carrying a sentence that belongs in the field's helper text. |
| Show Avatar | true | true | Show a face or initials when the value is a person, which is what makes a row of recipients scannable. Leave it on only when every chip in the field can supply one, because a mix of some with and some without reads as broken alignment. |
| Show Avatar | false | - | For values that are not people, such as a tag or a typed term. The chip closes up around the label and the remove control. |
| State | default | true | The resting chip, and where placed instances should stay. This axis records the interaction treatment rather than driving it. |
| State | hover | - | Pointer over the chip. Setting it by hand pins the chip into a hovered look that never clears. |
| State | focus | - | Keyboard focus. The one state a keyboard user depends on, so check it survives whatever surface the field sits on. |
| disabled | false | true | The usual case. |
| disabled | true | - | The value is fixed. Pair it with an explanation nearby, because the remove control stays visible and a control that looks available but will not respond reads as broken rather than locked. |
| Rounded | true | true | Match the contour of the field the chips sit in rather than deciding per chip. |
| Rounded | false | - | The square-cornered pairing, for forms built from sharp controls. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | — | — | Background interactive/ghost/background/default with a 1px inside border in interactive/neutral/border/default. |
| hover | Pointer over the chip | — | Background moves to interactive/ghost/background/hover. Border, label and both icons are unchanged. |
| focus | Keyboard focus | — | Background moves to interactive/ghost/background/focused and the border is replaced by a 2px focus/outline drawn outside the chip, so nothing reflows. |
| disabled | disabled set to true | — | Background becomes interactive/neutral/background/disabled, the label drops to interactive/neutral/foreground/disabled, and the border is removed entirely. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is authored. Every state change is a flat swap of fill, border or text colour. |
| Removal | The remove control is always present and the set models no removed state. What activating it does, and whether the value can be restored, belongs to the implementation. |
| Coverage | Eight of the twelve possible combinations are built. disabled appears only alongside State=default, so there is no disabled hover or disabled focus to point at. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | Plain text set per instance, defaulting to Label. The only text the chip takes. |
| Avatar | nested instance, toggled by Show Avatar | An Avatar at Size=xxxsmall with its own Status, Ring and Close all switched off, so only the face or initials shows. Its visibility is the one child property the chip surfaces. |
| Remove control | fixed nested Icon | An Icon at Size=small swapped to Close. There is no property to hide it, so every input chip shows a remove affordance whether or not the value can be removed. |

### Anatomy

1. **Chip** — The component frame. A horizontal auto-layout that hugs its content at a fixed height, carrying the fill and the border.
2. **Avatar** — The optional leading identity, present when Show Avatar is on.
3. **Remove control** — The trailing close icon. Always present, with no property to hide it.

### How to use

**Do:**
- Use one chip per value, inside the field the value was entered in. A row of chips is how someone checks what they have picked.
- Turn Show Avatar off for values that are not people. A placeholder face on a tag is worse than no face at all.

**Don't:**
- Don't use an input chip to filter a list. That is a filter chip, and the remove icon here promises deletion rather than toggling.
- Don't leave a chip disabled without saying why nearby. The remove control stays visible, so it reads as broken rather than locked.

### Accessibility & Content Guidelines

- The remove control is an icon with no text. It needs an accessible name that includes the value it removes, not just Remove.
- Focus is the only state with a visible outline and it is drawn outside the chip. Check it is not clipped by the field around it.
- Removing a chip changes what the field contains. That change has to be announced, or a keyboard user loses track of what is left.
- Disabled chips drop the border entirely and rely on fill and text colour alone. Check both against the field background.
- The label uses label/medium at 14px and carries the actual value, so it should not be reduced further.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug width, fixed height | 40 tall across all eight variants. Width hugs the avatar, label and remove control. |
| Padding and gap | Fixed | space/xs top and bottom, space/sm left and right, with a space/sm gap between the three parts. |
| Radius | Per Rounded | radius/pill when true and radius/none when false, bound on all four corners. |
| Fill | Theming | interactive/ghost/background at default, hover and focused. disabled uses interactive/neutral/background/disabled. |
| Border | Per state | 1px inside interactive/neutral/border/default at rest and on hover. Focus replaces it with 2px focus/outline drawn outside. Disabled carries no border. |
| Label | Theming | label/medium, IBM Plex Sans Medium 14 over a 20px line, in interactive/neutral/foreground/default and dropping to the disabled token. |
| Child sizes | Fixed | Avatar 24 square, remove icon 16 square. |

### Layer structure

- Input Chip (COMPONENT)
  - Input Chip/Avatar (INSTANCE)
  - Input Chip/Label (TEXT)
  - Input Chip/Remove Icon (INSTANCE, icon: close)

### Resolved tokens (default variant: State=default, disabled=false, Rounded=true, Size=medium)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input Chip | height | 40 | control.target-min |
| Input Chip | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Input Chip | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input Chip | cornerRadius | 9999 | radius.pill |
| Input Chip | strokeWeight | 1 | stroke.thin |
| Input Chip | itemSpacing | 8 | space.sm |
| Input Chip | padding.left | 8 | space.sm |
| Input Chip | padding.right | 8 | space.sm |
| Input Chip | padding.top | 4 | space.xxs |
| Input Chip | padding.bottom | 4 | space.xxs |
| Input Chip/Label | fill[0] | #0c0d0e | interactive.neutral.foreground.default |
| Input Chip/Label | fontSize | 14 | label.medium.font size |
| Input Chip/Label | lineHeight | 20 | label.medium.line height |
| Input Chip/Label | letterSpacing | 0 | label.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Input Chip | fill[0] | interactive.ghost.background.hover |
| State | focus | Input Chip | fill[0] | interactive.ghost.background.focused |
| State | focus | Input Chip | stroke[0] | focus.outline |
| State | focus | Input Chip | strokeWeight | stroke.thick |
| disabled | true | Input Chip | fill[0] | interactive.neutral.background.disabled |
| disabled | true | Input Chip | stroke[0] | — |
| disabled | true | Input Chip | strokeWeight | — |
| disabled | true | Input Chip/Label | fill[0] | interactive.neutral.foreground.disabled |
| Rounded | false | Input Chip | cornerRadius | radius.none |

## Filter Chip

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5126-3677&m=dev

### Overview

Lets someone narrow a set of content by switching criteria on and off, such as categories in a list of results. Use them in groups where more than one can be on at once. Reach for an assist chip when the control triggers an action rather than a filter.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Label | text | Label | The criterion the chip switches. Name the filter, not the result. A chip reading Show only items in stock is doing a sentence's work. |
| State | default | true | The resting chip, and where placed instances should stay. |
| State | hover | - | Pointer over the chip. |
| State | focus | - | Keyboard focus, and the only state carrying a visible outline. |
| State | selected | - | A second way to show a chosen chip, separate from active. It darkens the background without adding the check mark, so a row mixing selected and active will not read consistently. Prefer active until that overlap is resolved. |
| State | dragged | - | The chip while it is being moved, for filter rows that can be reordered. It reuses the pressed background rather than carrying a token of its own. |
| disabled | false | true | The usual case. |
| disabled | true | - | The criterion cannot be switched right now. Say why nearby, because the chip itself gives no other clue. |
| Rounded | true | true | Match the contour of the controls around the filter row rather than deciding per chip. |
| Rounded | false | - | The square-cornered pairing, for surfaces built from sharp controls. |
| active | false | true | The filter is off and the chip shows its label alone. |
| active | true | - | The filter is on. This is the real switch for a filter chip, and the only value that both adds the check mark and flips to the inverse palette. Built only alongside State=default and State=focus, so an active chip has no hover or dragged appearance. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | — | — | interactive/neutral/background/default behind a 1px inside border in interactive/neutral/border/default. |
| hover | Pointer over the chip | — | Background moves to interactive/neutral/background/hover. Nothing else changes. |
| focus | Keyboard focus | — | Background moves to interactive/neutral/background/focused and the border becomes 2px focus/outline drawn outside the chip. |
| selected | State set to selected | — | Background moves to interactive/neutral/background/selected. Border and label are unchanged and no check mark appears. |
| dragged | Chip being reordered | — | Background moves to interactive/neutral/background/pressed, the same token a pressed state would use. |
| disabled | disabled set to true | — | Background becomes interactive/neutral/background/disabled, the label drops to the disabled foreground, and the border is removed. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is authored. Turning a filter on is a flat swap of fill, text colour and the presence of the check mark. |
| Turning on | active is what switches the filter. It replaces the neutral palette with interactive/inverse and inserts a leading check mark, which also changes the chip's vertical padding and its gap. |
| Coverage | Sixteen of the forty possible combinations are built. active=true exists only with State=default and State=focus, so hovering or dragging an active chip is not drawn. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | Plain text set per instance, defaulting to Label. The only text the chip takes. |
| Selected Icon | nested Icon, present when active is true | An Icon at Size=small swapped to Check Mark, inserted before the label. It is not a slot and carries no property of its own on the chip. |
| Trailing content | not provided | There is no trailing slot. A filter chip cannot carry a count or a remove control without detaching. |

### Anatomy

1. **Chip** — The component frame. A horizontal auto-layout hugging its content at a fixed height.
2. **Check mark** — The leading icon, present only when active is true. It is what makes the on state readable without colour.
3. **Label** — The criterion itself, and the only content the chip takes.

### How to use

**Do:**
- Use active to turn a filter on. It is the only value that both recolours the chip and shows the check mark.
- Keep filter chips in a group where more than one can be on. A single chip that toggles is usually a switch or a checkbox.

**Don't:**
- Don't mix State=selected with active in one row. They are two different ways to look chosen and they do not match.
- Don't rely on the colour flip alone for the on state. The check mark is what carries it.

### Accessibility & Content Guidelines

- An active chip carries a check mark as well as the inverse palette, which is what keeps the on state readable without colour. Do not remove it.
- State=selected shows a chosen chip through colour alone with no check mark, so it fails that test. Prefer active.
- Focus is the only state with a visible outline and it is drawn outside the chip, so check it is not clipped by a scrolling filter row.
- Each chip is an on and off control. Expose a pressed or checked state, not just a label.
- The label uses indicator/medium at 12px over a 14px line. Check it against the inverse palette as well as the neutral one.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug width, fixed height | 32 tall across all sixteen variants. Width hugs the label, plus the check mark when active. |
| Padding | Per active | space/md left and right throughout. Vertically space/sm when active is false and space/xs when it is true, because the 16px check is taller than the label. |
| Gap | Per active | space/xs when active is false, space/sm when true. |
| Radius | Per Rounded | radius/pill when true and radius/none when false. |
| Fill | Per state | interactive/neutral/background at default, hover, focused, selected and disabled, with pressed reused for dragged. active=true overrides all of it with interactive/inverse/background/selected. |
| Border | Per state | 1px inside interactive/neutral/border/default at rest. Focus swaps to 2px focus/outline drawn outside. active=true uses interactive/inverse/border/pressed. Disabled carries none. |
| Label | Theming | indicator/medium, IBM Plex Sans Medium 12 over a 14px line, in interactive/neutral/foreground/default, dropping to the disabled token and flipping to interactive/inverse/foreground/default when active. |

### Layer structure

- Filter Chip (COMPONENT)
  - Filter Chip/Label (TEXT)
  - Filter Chip/Selected Icon (INSTANCE, icon: check_mark)

### Resolved tokens (default variant: State=default, disabled=false, Rounded=true, active=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Filter Chip | fill[0] | #ffffff | interactive.neutral.background.default |
| Filter Chip | stroke[0] | #ced2db | interactive.neutral.border.default |
| Filter Chip | cornerRadius | 9999 | radius.pill |
| Filter Chip | strokeWeight | 1 | stroke.thin |
| Filter Chip | itemSpacing | 4 | space.xxs |
| Filter Chip | padding.left | 12 | space.md |
| Filter Chip | padding.right | 12 | space.md |
| Filter Chip | padding.top | 8 | space.sm |
| Filter Chip | padding.bottom | 8 | space.sm |
| Filter Chip/Label | fill[0] | #0c0d0e | interactive.neutral.foreground.default |
| Filter Chip/Label | fontSize | 12 | indicator.medium.font size |
| Filter Chip/Label | lineHeight | 14 | indicator.medium.line height |
| Filter Chip/Label | letterSpacing | 0 | indicator.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Filter Chip | fill[0] | interactive.neutral.background.hover |
| State | focus | Filter Chip | fill[0] | interactive.neutral.background.focused |
| State | focus | Filter Chip | stroke[0] | focus.outline |
| State | focus | Filter Chip | strokeWeight | stroke.thick |
| State | selected | Filter Chip | fill[0] | interactive.neutral.background.selected |
| State | dragged | Filter Chip | fill[0] | interactive.neutral.background.pressed |
| disabled | true | Filter Chip | fill[0] | interactive.neutral.background.disabled |
| disabled | true | Filter Chip | stroke[0] | — |
| disabled | true | Filter Chip | strokeWeight | — |
| disabled | true | Filter Chip/Label | fill[0] | interactive.neutral.foreground.disabled |
| Rounded | false | Filter Chip | cornerRadius | radius.none |
| active | true | Filter Chip | fill[0] | interactive.inverse.background.selected |
| active | true | Filter Chip | stroke[0] | interactive.inverse.border.pressed |
| active | true | Filter Chip | itemSpacing | space.sm |
| active | true | Filter Chip | padding.top | space.xxs |
| active | true | Filter Chip | padding.bottom | space.xxs |
| active | true | Filter Chip/Label | fill[0] | interactive.inverse.foreground.default |

## Assist Chip

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5161-4423&m=dev

### Overview

Offers a contextual action, or stands for an item someone can discard, such as an attached file. Five colours borrow the status tokens to mark a state or a kind of item, with PDFs in red, spreadsheets in green and documents in blue, and in code foreground, background and border each take an override beyond those five. The label is the only content a consumer writes, and one colour should hold for every chip of the same kind. Reach for a button when the action is the primary next step, and a filter chip when it narrows content.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Label | text | Label | The action, phrased as a verb. An assist chip whose label names a noun reads as a filter or a tag instead. |
| Show Leading Icon | true | true | Show the glyph naming the action's domain, which is what separates an assist chip from a filter chip at a glance. Keep it consistent across a row, because one chip without an icon among several with them looks misaligned rather than different. |
| Show Leading Icon | false | - | Text only, for an action with no settled icon. Prefer this to inventing one. |
| State | default | true | The resting chip, and where placed instances should stay. |
| State | hover | - | Pointer over the chip. |
| State | focus | - | Keyboard focus, and the only state carrying a visible outline. |
| State | selected | - | A chosen or sticky appearance. Worth questioning on a chip that performs an action, because an action does not usually stay selected afterwards. |
| State | dragged | - | The chip while it is being moved. It reuses the pressed background rather than carrying a token of its own. |
| disabled | false | true | The usual case. |
| disabled | true | - | The action is unavailable. Say why nearby, because the chip itself gives no other clue. |
| Rounded | true | true | Match the contour of the controls around the chip rather than deciding per chip. |
| Rounded | false | - | The square-cornered pairing, for surfaces built from sharp controls. |
| active | false | true | The only value built. The axis exists on the set but offers no second option, so it cannot be switched. Filter Chip carries the same axis with both values, which suggests this one was copied across and left unfinished. |
| Discardable | true | true | Adds a remove control after the label, for an item someone can discard, such as an attached file. |
| Discardable | false | - | No remove control. The chip only triggers its action. |
| Color | neutral | true | The default. Use it when there is no state or kind of item to mark. |
| Color | green | - | Success colours. Use it for a positive state or one kind of item, such as spreadsheets. |
| Color | orange | - | Warning colours. Use it for a state that needs attention or one kind of item. |
| Color | blue | - | Info colours. Use it for an informative state or one kind of item, such as documents. |
| Color | red | - | Error colours. Use it for a failed state or one kind of item, such as PDFs. |
| Foreground | colour token (code) | per Color | Overrides the label, icon and remove colour. Keep it in the same family as the border. |
| Background | colour token (code) | per State | Overrides the fill, which Color leaves neutral. Use a subtle status token or a colour for one kind of item. |
| Border | colour token (code) | per Color | Overrides the border colour, in the same family as the foreground. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | — | — | interactive/neutral/background/default behind a 1px inside border in interactive/neutral/border/default. |
| hover | Pointer over the chip | — | Background moves to interactive/neutral/background/hover. Nothing else changes. |
| focus | Keyboard focus | — | Background moves to interactive/neutral/background/focused and the border becomes 2px focus/outline drawn outside. The chip is also 2px shorter than at rest, which looks like a drafting slip rather than an intended change. |
| selected | State set to selected | — | Background moves to interactive/neutral/background/selected. Border, icon and label are unchanged. |
| dragged | Chip being reordered | — | Background moves to interactive/neutral/background/pressed. |
| disabled | disabled set to true | — | Background becomes interactive/neutral/background/disabled, the label drops to the disabled foreground, the border is removed, and the chip is 2px shorter than at rest. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is authored. Every state change is a flat swap of fill, border or text colour. |
| Action | Nothing in the set records what the chip does or what happens afterwards. An assist chip is a trigger, and the result belongs entirely to the implementation. |
| Coverage | 52 variants are built. disabled appears only with State=default and Color=neutral, and active offers a single value. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | Plain text set per instance, defaulting to Label. Phrase it as the action itself. |
| Leading Icon | nested Icon, toggled by Show Leading Icon | An Icon at Size=small, shipped swapped to Star. The swap runs through the Icon's own Name property, so the glyph can be changed per instance, while visibility is the one thing the chip itself surfaces. |
| Remove control | nested Icon, toggled by Discardable | A Close icon after the label, shown when Discardable is on. It takes the label colour. |

### Anatomy

1. **Chip** — The component frame. A horizontal auto-layout hugging its content, carrying the fill and the border.
2. **Leading Icon** — The optional glyph naming the action's domain, present when Show Leading Icon is on.
3. **Label** — The action itself, and the only text the chip takes.

### How to use

**Do:**
- Phrase the label as a verb. The chip is a thing to do, not a thing to pick.
- Keep Show Leading Icon consistent across a row. One chip without an icon among several with them looks misaligned.

**Don't:**
- Don't reach for an assist chip when the action is the main one on the screen. That is a button.
- Don't use State=selected to mean an action has stuck. A chip that stays selected is usually a filter chip in disguise.

### Accessibility & Content Guidelines

- The chip is a control. It needs a button role and a name stating the action, not just the label text.
- Focus is the only state with a visible outline and it is drawn outside the chip, so check it is not clipped by a scrolling row.
- The leading icon sits next to the label and is decorative. If it ever carries meaning the label does not, that meaning has to be in text.
- Disabled chips lose the border and rely on fill and text colour alone. Check both against the surface behind them.
- The label uses indicator/medium at 12px over a 14px line. It is the action's only name, so it should not be shortened to an abbreviation.
- Colour marks the kind of item but never replaces the label. Check each override pair for contrast against the surface behind it.
- The remove control is a real target. Name it after what it removes, such as Remove Document.pdf.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug width, fixed height | 34 tall at default, hover, selected and dragged, but 32 at focus and disabled. That 2px difference is unintended and makes a mixed row sit unevenly. |
| Padding and gap | Fixed | space/xs on all sides and no gap. The label sits in its own frame padded space/xxs left and right, which spaces it from the icon and the remove control. |
| Radius | Per Rounded | radius/pill when true and radius/none when false. |
| Fill | Per state | interactive/neutral/background at default, hover, focused, selected and disabled, with pressed reused for dragged. |
| Border | Per state | 1px inside at rest, interactive/neutral/border/default on neutral and border/success, warning, info or error per Color. Focus swaps to 2px focus/outline drawn outside. Disabled carries none. |
| Label | Theming | indicator/medium, IBM Plex Sans Medium 12 over a 14px line. interactive/neutral/foreground/default on neutral, feedback/success, warning, info or error foreground per Color, and the disabled token when disabled. |
| Leading icon | Fixed | Icon at Size=small, 16 square. |
| Colour overrides | Per Color, or per instance in code | Color sets the border and the label. In code, foreground, background and border each accept a colour token on top, so one kind of item can hold one colour across a view. |

### Layer structure

- Assist Chip (COMPONENT)
  - Assist Chip/Leading Icon (INSTANCE, icon: user_circle)
  - Assist Chip/Label (FRAME)
    - Assist Chip/Label/Label (TEXT)
  - Assist Chip/Discardable (INSTANCE, icon: close)

### Resolved tokens (default variant: State=default, disabled=false, Rounded=true, active=false, Color=neutral)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Assist Chip | fill[0] | #ffffff | interactive.neutral.background.default |
| Assist Chip | stroke[0] | #ced2db | interactive.neutral.border.default |
| Assist Chip | cornerRadius | 9999 | radius.pill |
| Assist Chip | strokeWeight | 1 | stroke.thin |
| Assist Chip | itemSpacing | 2 | space.2xs |
| Assist Chip | padding.left | 8 | space.sm |
| Assist Chip | padding.right | 8 | space.sm |
| Assist Chip | padding.top | 6 | space.xs |
| Assist Chip | padding.bottom | 6 | space.xs |
| Assist Chip/Leading Icon | width | 12 | control.icon-xs |
| Assist Chip/Leading Icon | height | 12 | control.icon-xs |
| Assist Chip/Label | padding.left | 4 | space.xxs |
| Assist Chip/Label | padding.right | 4 | space.xxs |
| Assist Chip/Label/Label | fill[0] | #0c0d0e | interactive.neutral.foreground.default |
| Assist Chip/Label/Label | fontSize | 12 | indicator.medium.font size |
| Assist Chip/Label/Label | lineHeight | 14 | indicator.medium.line height |
| Assist Chip/Label/Label | letterSpacing | 0 | indicator.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Assist Chip | fill[0] | interactive.neutral.background.hover |
| State | focus | Assist Chip | fill[0] | interactive.neutral.background.focused |
| State | focus | Assist Chip | stroke[0] | focus.outline |
| State | focus | Assist Chip | strokeWeight | stroke.thick |
| State | selected | Assist Chip | fill[0] | interactive.neutral.background.selected |
| State | dragged | Assist Chip | fill[0] | interactive.neutral.background.pressed |
| disabled | true | Assist Chip | fill[0] | interactive.neutral.background.disabled |
| disabled | true | Assist Chip | stroke[0] | — |
| disabled | true | Assist Chip | strokeWeight | — |
| disabled | true | Assist Chip/Label/Label | fill[0] | interactive.neutral.foreground.disabled |
| Rounded | false | Assist Chip | cornerRadius | radius.none |
| Color | green | Assist Chip | stroke[0] | border.success |
| Color | green | Assist Chip/Label/Label | fill[0] | feedback.success.foreground |
| Color | orange | Assist Chip | stroke[0] | border.warning |
| Color | orange | Assist Chip/Label/Label | fill[0] | feedback.warning.foreground |
| Color | blue | Assist Chip | stroke[0] | border.info |
| Color | blue | Assist Chip/Label/Label | fill[0] | feedback.info.foreground |
| Color | red | Assist Chip | stroke[0] | border.error |
| Color | red | Assist Chip/Label/Label | fill[0] | feedback.error.foreground |
