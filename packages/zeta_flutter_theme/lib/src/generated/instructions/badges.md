# Badges

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3717-5570&m=dev

## Notification Indicator

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3719-6256&m=dev

### Overview

Marks that something is waiting on whatever it is pinned to, optionally with a count. Size decides whether that count is shown at all, with small reducing to a plain dot that says only that something is new. It carries one fixed colour, so it reports how many and never what kind.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Value | text | 2 | The count shown inside the indicator. Carried at large and medium, and dropped entirely at small. |
| Size | large | true | The widest form, for a count that may run to more than one digit. |
| Size | medium | - | A fixed square holding a single digit. Use it where space is tight but the number still matters. |
| Size | small | - | A plain dot with no count. It says something is new without saying how much, so using it where the number matters loses the number silently. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The component has no interaction states. It reports that something is waiting rather than offering a way to deal with it. |
| Size | The Size value | — | The only thing that changes is whether the count is shown. The colour holds across all three. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. A change in the count is a text swap. |
| Count and size | small carries no count at all. Moving between small and the other two changes what is being said rather than only the scale, so the choice follows whether the number is worth reading. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Value | text property | Consumer owned, set through Value and shown at large and medium. Keep it short, because only large grows with its text. |

### Anatomy

1. **Surround** — A fully round fill in one fixed colour, sized by Size.
2. **Value** — The count, set through Value. Carried at large and medium and absent at small.
3. **Border** — A zero weight stroke bound to border/inverse, held as a theming hook so a high contrast set can outline the indicator against what sits behind it.

### How to use

**Do:**
- Use small where the fact that something is new is the whole message. It is the only form that makes no claim about quantity.
- Keep the count short. Only large grows with its text, so a long number is clipped at the other two sizes rather than accommodated.

**Don't:**
- Don't use it to mean anything other than items waiting. It has one fixed colour, so it cannot carry a second meaning alongside the first.
- Don't put a count on small. It carries no text, so the number disappears with nothing to show it went.

### Accessibility & Content Guidelines

- The indicator is colour and shape only. The count is its sole text and at small there is none, so what it refers to has to be named by whatever it is pinned to.
- A count of zero belongs with the indicator removed rather than shown as a zero. There is no empty form, so a visible zero reads as a notification about nothing.
- The zero weight border is a theming hook. A high contrast set raises it and separates the indicator from a busy background, which matters because it usually overlaps something.
- Nothing here is focusable and a change in the count does not announce itself. The structure around it has to report that the number moved.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed per Size | 28 by 20 at large, a 16 square at medium and an 8 dot at small. |
| Padding | Per Size | space/xs left and right at large with 3 above and below. medium and small carry none, because their content is centred inside a fixed square. |
| Radius | Fixed | radius/pill at all three sizes, so every form is fully round whether or not it holds a number. |
| Fill | Fixed | interactive/destructive/background/default at every size. One colour throughout, which does not vary with the count. |
| Border | Theming | A stroke bound to border/inverse sits on all three sizes at zero weight. The weight is a theming hook rather than an omission, so a high contrast set can give the indicator a hard outline where it overlaps whatever it is pinned to. |
| Value | Theming | indicator/medium at 12px in interactive/destructive/foreground/default. Present at large and medium, absent at small. |

### Layer structure

- Notification Indicator (COMPONENT)
  - Notification Indicator/2 (TEXT)

### Resolved tokens (default variant: Size=medium)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Notification Indicator | fill[0] | #d70015 | interactive.destructive.background.default |
| Notification Indicator | stroke[0] | #ffffff | border.inverse |
| Notification Indicator | cornerRadius | 9999 | radius.pill |
| Notification Indicator | strokeWeight | 0 | stroke.base |
| Notification Indicator/2 | fill[0] | #ffffff | foreground.on-strong |
| Notification Indicator/2 | fontSize | 12 | indicator.medium.font size |
| Notification Indicator/2 | lineHeight | 14 | indicator.medium.line height |
| Notification Indicator/2 | letterSpacing | 0 | indicator.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | small | Notification Indicator/2 | fill[0] | — |
| Size | small | Notification Indicator/2 | fontSize | — |
| Size | small | Notification Indicator/2 | lineHeight | — |
| Size | small | Notification Indicator/2 | letterSpacing | — |
| Size | large | Notification Indicator | padding.left | space.xxs |
| Size | large | Notification Indicator | padding.right | space.xxs |

## Status Label

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6403-297&m=dev

### Overview

Reports a read-only state on an item, such as Active or Overdue. Status sets the fill, the border and the leading element together while the label text holds one colour throughout, and Leading decides whether the status also shows as a dot, an icon or nothing. Discardable adds the one control anywhere in the badge family, a dismiss that removes the label rather than selecting it.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Label | text | Label | The state being reported. Keep it to the state itself and two words at most, because the component hugs its text and a sentence becomes a wide block inside a narrow column. |
| Status | neutral | true | No particular standing. Use it where a row needs a state shown but none of the four meanings apply, not as a resting value for a status that simply has not changed yet. |
| Status | info | - | Supporting information carrying no judgement. Nothing is wrong and nothing has succeeded e.g ongoing. |
| Status | positive | - | A finished or healthy state. Use it on completion rather than on progress, or there is nothing left to mark the end with. |
| Status | warning | - | Something needs attention but nothing has failed. Using it for a failure understates the problem to anyone scanning a column of these. |
| Status | negative | - | A failed or blocking state. The strongest of the five, so spending it on a recoverable problem leaves nothing in reserve for a real one. |
| Leading | indicator | true | A dot in the status colour. The quietest of the three and the right choice where the label already names the state. |
| Leading | icon | - | A glyph fixed per status, Info for neutral and info, then Check Circle, Warning and Error. Use it where the status has to read without the label being read. |
| Leading | none | - | Text only. The fill and the border still carry the status, so this is the form that leans hardest on colour alone. |
| Shape | rounded | true | Match the contour of the surface the label sits on. |
| Shape | sharp | - | The square-cornered pair, for dense surfaces built from square corners such as a table cell. |
| Discardable | false | true | No discard control, which is where the label starts. It reports a state and offers nothing to act on. |
| Discardable | true | - | Adds a single control that removes the label. It dismisses rather than selects, so it does not turn the label into a Chip, and it is the only thing in the badge family a person can press. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The label has no interaction states. Nothing answers hover, focus or press. Where Discardable turns the dismiss on, that control carries its own states rather than the label gaining any. |
| Status | The Status value | — | Fill, border and the leading element all move together. The label colour does not, so a status change is carried entirely by the surround. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. A status change is a swap of fill, border and the leading element. |
| Read only, with one exception | A badge reports and never responds, which is the line between this family and Chip. Status Label is the one member that can carry a control, and only to dismiss itself. Nothing here selects, filters or toggles. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | Consumer owned, set through the Label property. It hugs, so the length of the text decides the width of the whole component. |
| Leading indicator | drawn, per Status | An 8 dot in the status colour inside a 16 box. The component draws it from Status, so there is nothing to pass in. |
| Leading icon | nested Icon, per Status | An Icon at Size=small whose glyph is fixed per status. The component chooses it and surfaces none of the Icon's own properties, so it is not a slot a consumer fills. |
| Discard control | nested Icon, toggled by Discardable | A Close glyph at Size=small, 16 square, sitting after the label. The component draws it from Discardable rather than taking one in, so the glyph is not a slot a consumer fills. |

### Anatomy

1. **Leading** — A dot or an icon in the status colour, chosen by Leading and absent when it is none. The component draws it from Status rather than taking one in.
2. **Label** — The state being reported, set through Label. It decides the width of the whole component.
3. **Surround** — The fill and the border, both following Status. Together they carry the status even when the leading element is off.

### How to use

**Do:**
- Keep the label to the state itself, such as Active or Overdue. The component hugs its text, so a sentence turns into a wide block in a narrow column.
- Use Leading=icon where the status has to survive greyscale. The dot and the fill are colour alone, the glyph differs in shape as well.

**Don't:**
- Don't use a status label where a person chooses or filters by the value. That is Chip. The only thing this offers is a dismiss, and only when Discardable is on.
- Don't use neutral to mean normal. It is the absence of a status, and spending it that way leaves no way to say that nothing is known.

### Accessibility & Content Guidelines

- Status is carried by the fill, the border and the leading element. The label holds foreground/primary at every status, so colour alone separates one status from another unless the label names it.
- Set Leading to icon where the status has to survive greyscale or low vision. The glyph differs per status in shape, not only in colour.
- The label text is the accessible name. Where it carries only a colour word or an internal code, the status is unreadable to anyone not already fluent in the convention.
- neutral and info both carry the Info glyph. Where the two appear in one view, the label is the only thing separating them.
- The discard control is a real target with no text of its own. It needs a name that says what it removes, and it has to be reachable by keyboard, because it is the only thing here a person can act on.
- Nothing else here is focusable and nothing announces itself. Where a status changes while a person is on the page, the surrounding structure has to announce it.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug width, fixed height | 28 tall at every status. The width hugs the label, running 69 with a leading element and 53 without, so the component is as wide as its text needs. |
| Padding and gap | Fixed | space/xs on all four sides, with no gap between the leading element and the label. The leading element is a 16 square box carrying an 8 dot or a 16 icon, and that box supplies the separation on its own. |
| Radius | Per Shape | radius/pill when rounded and radius/none when sharp. Nothing else moves between the two. |
| Fill | Per Status | neutral draws interactive/neutral/background/default. The other four draw feedback/info, success, warning and error at background/subtle, so all four sit at one tint strength rather than escalating with severity. |
| Border | Per Status | A 1px stroke tracking the fill, border/default for neutral and border/info, success, warning or error for the rest. It is what keeps four subtle tints apart from each other at a glance. |
| Label | Theming | body/small at 14px, held at foreground/primary for every status. Only the fill, the border and the leading element move. |
| Discard control | Fixed | A 16 square after the label when Discardable is on, adding 16 to the width. It takes no gap of its own, because the component runs at space/none and the padding does the separating. |

### Layer structure

- Status Label (COMPONENT)
  - Status Label/Leading (FRAME, icon: info)
    - Status Label/Leading/Status indicator (ELLIPSE)
  - Status Label/Label container (FRAME)
    - Status Label/Label container/Label (TEXT)

### Resolved tokens (default variant: Status=neutral, Leading=indicator, Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Status Label | fill[0] | #f8fbff | feedback.neutral.background.subtle |
| Status Label | stroke[0] | #ced2db | border.default |
| Status Label | cornerRadius | 9999 | radius.pill |
| Status Label | strokeWeight | 1 | stroke.thin |
| Status Label | padding.left | 4 | space.xxs |
| Status Label | padding.right | 4 | space.xxs |
| Status Label | padding.top | 2 | space.2xs |
| Status Label | padding.bottom | 2 | space.2xs |
| Status Label/Leading | width | 16 | control.icon-sm |
| Status Label/Leading | height | 16 | control.icon-sm |
| Status Label/Leading/Status indicator | width | 8 | control.icon-xxs |
| Status Label/Leading/Status indicator | height | 8 | control.icon-xxs |
| Status Label/Leading/Status indicator | fill[0] | #0c0d0e | foreground.primary |
| Status Label/Label container | padding.left | 4 | space.xxs |
| Status Label/Label container | padding.right | 4 | space.xxs |
| Status Label/Label container/Label | fill[0] | #0c0d0e | foreground.primary |
| Status Label/Label container/Label | fontSize | 14 | body.small.font size |
| Status Label/Label container/Label | lineHeight | 18 | body.small.line height |
| Status Label/Label container/Label | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | info | Status Label | fill[0] | feedback.info.background.subtle |
| Status | info | Status Label | stroke[0] | border.info |
| Status | info | Status Label/Leading/Status indicator | fill[0] | foreground.info |
| Status | positive | Status Label | fill[0] | feedback.success.background.subtle |
| Status | positive | Status Label | stroke[0] | border.success |
| Status | positive | Status Label/Leading/Status indicator | fill[0] | foreground.success |
| Status | warning | Status Label | fill[0] | feedback.warning.background.subtle |
| Status | warning | Status Label | stroke[0] | border.warning |
| Status | warning | Status Label/Leading/Status indicator | fill[0] | foreground.warning |
| Status | negative | Status Label | fill[0] | feedback.error.background.subtle |
| Status | negative | Status Label | stroke[0] | border.error |
| Status | negative | Status Label/Leading/Status indicator | fill[0] | foreground.error |
| Leading | icon | Status Label/Leading | width | — |
| Leading | icon | Status Label/Leading | height | — |
| Leading | icon | Status Label/Leading/Status indicator | width | — |
| Leading | icon | Status Label/Leading/Status indicator | height | — |
| Leading | icon | Status Label/Leading/Status indicator | fill[0] | — |
| Leading | none | Status Label/Leading | width | — |
| Leading | none | Status Label/Leading | height | — |
| Leading | none | Status Label/Leading/Status indicator | width | — |
| Leading | none | Status Label/Leading/Status indicator | height | — |
| Leading | none | Status Label/Leading/Status indicator | fill[0] | — |
| Shape | sharp | Status Label | cornerRadius | radius.none |

## Label

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6404-328&m=dev

### Overview

Names a category on an item in a word or two. Variant carries the standing of that category, and Bold and Outlined decide how hard it pushes, from a solid fill down to a tint with no visible edge. It reports and never responds, which is the line between it and Chip.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Label | text | Label | The category name, in one or two words. |
| Variant | neutral | true | Use for a category with no standing, such as a type or a topic. |
| Variant | info | - | Use for a category that informs and asks for no action. |
| Variant | positive | - | Use for a category that marks a finished or successful outcome. |
| Variant | warning | - | Use for a category that needs attention but has not failed. |
| Variant | negative | - | Use for a category that has failed or is blocking. |
| Shape | rounded | true | Use by default, and wherever the surrounding components have rounded corners. |
| Shape | sharp | - | Use on square-cornered surfaces such as table cells. Never mix both shapes in one view. |
| Bold | true | true | Solid fill with light text, the strongest form, for a label that must be spotted at a glance. Keep Outlined false, because Bold and Outlined together is not built. |
| Bold | false | - | Tinted fill with dark text, for a label that supports the item rather than leads it. Pair with Outlined to choose between the edged and the plain form. |
| Outlined | false | true | No visible border. With Bold false this is the quietest form, for surfaces that already set the label apart. |
| Outlined | true | - | Adds a 1px border to the tinted fill, for a label that must stay findable without dominating. Use only with Bold false. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The component has no interaction states. Nothing answers hover, focus or press, because it names a category rather than offering one. |
| Variant and emphasis | Variant, Bold or Outlined | — | Fill, border and text colour move together. Variant chooses the colour family and the two emphasis properties decide how much of it shows. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. A variant change is a swap of fill, border and text colour. |
| Read only | A badge reports and never responds. There is nothing to press, no selected form and no interaction states, which is the line between this and Chip. Where a category can be chosen, removed or filtered by, that is Chip's job rather than this one's. |
| Emphasis model | Bold and Outlined give three forms rather than four. Bold alone is the solid one, Outlined alone is the edged one, neither gives the quiet tint, and the two together are not built. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | Consumer owned, set through Label. It hugs, so the text decides the width of the whole component. |

### Anatomy

1. **Label** — The category name, set through Label. It decides the width of the whole component.
2. **Fill** — A background per Variant, solid on the bold form and a tint on the other two.
3. **Border** — Visible only on the outlined form. The same bound stroke sits on the plain form at zero weight, held as a theming hook.

### How to use

**Do:**
- Keep it to one or two words. The component hugs its text at 12px, so a phrase becomes a wide bar in a narrow column.
- Pick one emphasis and hold it down a column. Mixing solid and tinted labels in one list reads as two kinds of thing rather than one scale.

**Don't:**
- Don't use a label where a person can act on the category. Choosing, removing and filtering belong to Chip, and a label that looks pressable but is not is worse than either.
- Don't lean on the colour to carry the category. At 12px the word is doing the work and the colour is reinforcement.

### Accessibility & Content Guidelines

- The label text is the accessible name and the only thing that names the category. The fill reinforces it and never replaces it.
- It is not focusable and not a control. Nothing about it should suggest otherwise, because a person who tries to press it gets no answer.
- The bold form knocks 12px text out of a strong fill. Check contrast per variant, because the pairing differs between them rather than following one rule.
- The plain form carries no visible edge, so on a tinted surface it can lose its boundary. The zero weight border is the hook that gives it one in a high contrast set.
- neutral and the four feedback variants are separated by colour alone. A reader who cannot tell them apart relies entirely on the word inside.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug width, fixed height | 24 tall on the outlined and plain forms and 26 on bold, the difference being a 1px stroke drawn inside the box rather than centred on its edge. The width hugs the text in every form. |
| Padding and gap | Fixed | space/xs on all four sides, with a space/2xs gap held for anything placed beside the text. |
| Radius | Per Shape | radius/element-sm when rounded and radius/none when sharp. Softer than a pill, so it reads as a block of text rather than as a token. |
| Fill | Per Variant and emphasis | bold takes feedback/info, success, warning or error at background/strong, with neutral on foreground/secondary. The other two forms take the matching background/subtle, with neutral on surface/subtle. |
| Border | Per emphasis | outlined draws a 1px stroke centred on the edge, border/strong for neutral and the matching border token otherwise. The plain form carries that same bound stroke at zero weight, which is a theming hook rather than an absent border, so a high contrast set can give every label an edge. bold's stroke matches its own fill. |
| Label | Theming | body/xsmall at 12px in every form. bold knocks the text out of its fill, foreground/inverse on neutral and the matching foreground token elsewhere, while the other two hold foreground/primary. |

### Layer structure

- Label (COMPONENT)
  - Label/Label (TEXT)

### Resolved tokens (default variant: Variant=neutral, Shape=rounded, Bold=true, Outlined=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Label | fill[0] | #545963 | foreground.secondary |
| Label | stroke[0] | #545963 | foreground.secondary |
| Label | cornerRadius | 4 | radius.element-sm |
| Label | strokeWeight | 1 | stroke.thin |
| Label | itemSpacing | 2 | space.2xs |
| Label | padding.left | 4 | space.xxs |
| Label | padding.right | 4 | space.xxs |
| Label | padding.top | 4 | space.xxs |
| Label | padding.bottom | 4 | space.xxs |
| Label/Label | fill[0] | #ffffff | foreground.inverse |
| Label/Label | fontSize | 12 | body.xsmall.font size |
| Label/Label | lineHeight | 16 | body.xsmall.line height |
| Label/Label | letterSpacing | 0 | body.xsmall.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Variant | info | Label | fill[0] | feedback.info.background.strong |
| Variant | info | Label | stroke[0] | feedback.info.background.strong |
| Variant | info | Label/Label | fill[0] | interactive.primary.foreground.default |
| Variant | positive | Label | fill[0] | feedback.success.background.strong |
| Variant | positive | Label | stroke[0] | feedback.success.background.strong |
| Variant | positive | Label/Label | fill[0] | interactive.primary.foreground.default |
| Variant | warning | Label | fill[0] | feedback.warning.background.strong |
| Variant | warning | Label | stroke[0] | feedback.warning.background.strong |
| Variant | negative | Label | fill[0] | feedback.error.background.strong |
| Variant | negative | Label | stroke[0] | feedback.error.background.strong |
| Variant | negative | Label/Label | fill[0] | interactive.destructive.foreground.default |
| Shape | sharp | Label | cornerRadius | radius.none |
| Bold | false | Label | fill[0] | surface.subtle |
| Bold | false | Label | stroke[0] | border.strong |
| Bold | false | Label | strokeWeight | stroke.base |
| Bold | false | Label/Label | fill[0] | foreground.primary |

## Priority Pill

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6406-410&m=dev

### Overview

Shows where an item sits on a four step scale, from low to urgent. Level sets the fill, the circle and the glyph together, Variant decides whether the name appears beside the circle or the circle stands alone, and Leading swaps the glyph for a rank number. Use it where items compete for attention and the order between them is the point.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Label | text | Label | The priority name, such as Low or Urgent. Carried on lozenge only, so switching to badge removes it rather than shortening it. |
| Priority Number | text | 4 | The rank shown inside the circle when Leading is number. One or two characters, because the circle is a fixed square and does not grow with the value. |
| Level | low | true | The bottom of the scale, drawn in a neutral rather than a feedback colour so it reads as ordinary rather than as something going well. |
| Level | medium | - | The middle of the scale. It takes the info colour, the one level that does not escalate the surface it sits on. |
| Level | high | - | Ahead of the rest but not at the top. Using it on a true emergency leaves nothing above it. |
| Level | urgent | - | The top of the scale. The strongest colour in the set, so spending it broadly flattens the very scale it exists to express. |
| Variant | lozenge | true | Circle and label together. Use it wherever a reader may not already know the scale, because the label is the only part that names the level outright. |
| Variant | badge | - | The circle alone. Use it in a dense list or pinned to another object, and only where the colour and the glyph are already understood. |
| Size | large | true | The default, for a row with room for the name. |
| Size | small | - | For dense lists. It reduces the text as well as the box, so a long name gets harder to read rather than merely tighter. |
| Leading | icon | true | A direction glyph in the circle, down for low, a dash for medium, up for high and the priority mark for urgent. It says which way the level points without the label being read. |
| Leading | number | - | A rank number in the circle in place of the glyph. Use it where the exact position in a queue matters, and note that it removes the only cue to direction that is not colour. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The component has no interaction states. Nothing answers hover, focus or press, because it reports a rank rather than offering an action. Like the rest of the badge family it is read only, which is the line between it and Chip. |
| Level | The Level value | — | The pill fill, the circle fill and the label colour move together, and the glyph changes shape with them. Nothing else varies. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. A level change is a swap of fill, circle, label colour and glyph. |
| Variant and label | badge removes the label rather than hiding it, so the component becomes a fixed square instead of a pill that hugs its text. Whatever the label was carrying has to be available elsewhere on the row. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | Consumer owned, set through Label. Present on lozenge only. |
| Priority Number | text property | Consumer owned, set through Priority Number and shown in the circle when Leading is number. |
| Leading glyph | nested Icon, per Level | An Icon at Size=small whose glyph is fixed per level. The component chooses it from Level and surfaces none of the Icon's own properties, so it is not a slot a consumer fills. |
| Circle | drawn | Drawn by the component rather than passed in. It holds either the glyph or the number and never both. |

### Anatomy

1. **Circle** — A knockout disc carrying either a direction glyph or a rank number. It takes the label's colour while its contents take the pill's.
2. **Label** — The priority name, set through Label and present on lozenge only.
3. **Pill** — The surround, filled per Level. On badge this is the whole component.

### How to use

**Do:**
- Use lozenge wherever a reader may not already know the scale. The label is the only part that names the level without prior knowledge of the colours.
- Keep Leading=icon where direction matters more than exact position. The glyph changes shape per level, so it survives greyscale in a way the fill does not.

**Don't:**
- Don't mix badge and lozenge down one column. The two read as different scales rather than as one scale abbreviated.
- Don't treat the rank number as a count. It is a position in a queue, so a larger number does not mean more of anything.

### Accessibility & Content Guidelines

- Level is carried by fill and by glyph shape. With Leading=number the glyph is gone, leaving colour as the only cue that is not text, so the label has to be present or the level named nearby.
- badge drops the label entirely. It needs an accessible name from the surrounding structure, or the level reaches only a reader who already knows the colour code.
- The circle is a knockout, so its contents sit in the pill's background colour on the label's colour. Check that pairing holds contrast at small, where the glyph is 16 and the number is 10px.
- At small the label drops to 10px, which is below comfortable reading size for a long name. Keep names to one short word at that size.
- Nothing here is focusable and nothing announces itself. A level changing while a person is on the page has to be announced by the structure around it.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug on lozenge, fixed on badge | Lozenge is 28 tall at large and 20 at small, hugging its label. Badge is a fixed square at the same two heights, 28 and 20, because it carries no label to hug. |
| Padding and gap | Fixed | space/xs around the lozenge at large and space/2xs at small, with a wider trailing edge at both so the label clears the end of the pill. The circle and the label are separated by space/xs at both sizes. |
| Radius | Fixed | radius/pill on every level, variant and size. There is no square cornered form. |
| Fill | Per Level | low draws foreground/secondary. medium, high and urgent draw feedback/info, warning and error at background/strong. low is the only level not taking a feedback colour, which is what keeps it reading as ordinary rather than good. |
| Circle | Knockout | 20 at large and 16 at small, filled with the same token as the label. Whatever sits inside it, glyph or number, is drawn in the pill's own background colour, so the circle reads as a hole punched through the pill. |
| Label | Theming | body/small at 14px on large and indicator/small at 10px on small. The colour pairs with the level, foreground/inverse on low and high and the matching foreground token on medium and urgent. |

### Layer structure

- Priority Pill (COMPONENT)
  - Priority Pill/Circle (FRAME)
    - Priority Pill/Circle/Glyph (INSTANCE, icon: arrow_down)
    - Priority Pill/Circle/Rank (TEXT)
  - Priority Pill/Label container (FRAME)
    - Priority Pill/Label container/Label (TEXT)

### Resolved tokens (default variant: Level=low, Variant=lozenge, Size=large, Leading=icon)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Priority Pill | fill[0] | #545963 | foreground.secondary |
| Priority Pill | cornerRadius | 9999 | radius.pill |
| Priority Pill | itemSpacing | 4 | space.xxs |
| Priority Pill | padding.left | 4 | space.xxs |
| Priority Pill | padding.right | 8 | space.sm |
| Priority Pill | padding.top | 4 | space.xxs |
| Priority Pill | padding.bottom | 4 | space.xxs |
| Priority Pill/Circle | width | 20 | control.icon-md |
| Priority Pill/Circle | height | 20 | control.icon-md |
| Priority Pill/Circle | fill[0] | #ffffff | foreground.inverse |
| Priority Pill/Circle | cornerRadius | 9999 | radius.pill |
| Priority Pill/Label container | padding.right | 4 | space.xxs |
| Priority Pill/Label container/Label | fill[0] | #ffffff | foreground.inverse |
| Priority Pill/Label container/Label | fontSize | 14 | body.small.font size |
| Priority Pill/Label container/Label | lineHeight | 18 | body.small.line height |
| Priority Pill/Label container/Label | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Level | medium | Priority Pill | fill[0] | feedback.info.background.strong |
| Level | medium | Priority Pill/Circle | fill[0] | interactive.primary.foreground.default |
| Level | medium | Priority Pill/Label container/Label | fill[0] | interactive.primary.foreground.default |
| Level | high | Priority Pill | fill[0] | feedback.warning.background.strong |
| Level | urgent | Priority Pill | fill[0] | feedback.error.background.strong |
| Level | urgent | Priority Pill/Circle | fill[0] | interactive.destructive.foreground.default |
| Level | urgent | Priority Pill/Label container/Label | fill[0] | interactive.destructive.foreground.default |
| Variant | badge | Priority Pill | itemSpacing | — |
| Variant | badge | Priority Pill | padding.right | space.xxs |
| Variant | badge | Priority Pill/Label container | padding.right | — |
| Variant | badge | Priority Pill/Label container/Label | fill[0] | — |
| Variant | badge | Priority Pill/Label container/Label | fontSize | — |
| Variant | badge | Priority Pill/Label container/Label | lineHeight | — |
| Variant | badge | Priority Pill/Label container/Label | letterSpacing | — |
| Size | small | Priority Pill | padding.left | space.2xs |
| Size | small | Priority Pill | padding.top | space.2xs |
| Size | small | Priority Pill | padding.bottom | space.2xs |
| Size | small | Priority Pill/Circle | width | control.icon-sm |
| Size | small | Priority Pill/Circle | height | control.icon-sm |
| Size | small | Priority Pill/Label container | padding.right | space.2xs |
| Size | small | Priority Pill/Label container/Label | fontSize | indicator.small.font size |
| Size | small | Priority Pill/Label container/Label | lineHeight | indicator.small.line height |
| Size | small | Priority Pill/Label container/Label | letterSpacing | indicator.small.letter spacing |
| Leading | number | Priority Pill/Circle/Rank | fill[0] | foreground.secondary |
| Leading | number | Priority Pill/Circle/Rank | fontSize | indicator.medium.font size |
| Leading | number | Priority Pill/Circle/Rank | lineHeight | indicator.medium.line height |
| Leading | number | Priority Pill/Circle/Rank | letterSpacing | indicator.medium.letter spacing |

## Icon Indicator

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6407-416&m=dev

### Overview

A small circular marker carrying a fixed glyph, sized to sit beside text or on its own. Size is its only property and moves the circle and the glyph together. It says one thing and names nothing, so whatever it refers to has to be named beside it.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Size | small | true | The default, an inline size for sitting beside running text. |
| Size | medium | - | One step up, for a row with more room around it. |
| Size | large | - | The biggest, matching the other badges on this page at their largest so a mixed row still lines up. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The component has no interaction states and nothing beyond Size varies. |
| Size | The Size value | — | The circle and the glyph scale together. Colour and glyph shape hold. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Size is the only thing that varies. |
| Fixed meaning | The glyph does not change, so the component says exactly one thing. A different meaning has to come from a different component rather than from swapping the glyph here. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Glyph | nested Icon, fixed | A Clock at Size=small or large depending on the circle. The component chooses it and surfaces none of the Icon's own properties, so there is nothing to pass in. |

### Anatomy

1. **Surround** — A circle filled foreground/secondary, sized by Size.
2. **Glyph** — A Clock, fixed by the component and scaled with the circle.
3. **Inset** — The ring of space around the glyph. It comes from the difference between the circle and the glyph rather than from padding.

### How to use

**Do:**
- Match the size to the text it sits beside. small is the inline size, large is for a row of its own.
- Pair it with text that says what is pending. The glyph is fixed, so the component cannot name the thing it refers to.

**Don't:**
- Don't expect the glyph to change. It carries one meaning, and a different one needs a different component.
- Don't use it where a count matters. Notification Indicator carries a number, this carries none.

### Accessibility & Content Guidelines

- The glyph is fixed and there is no text. The component names nothing on its own, so what it refers to has to come from the structure around it.
- It carries one colour at one strength. Where it sits on a tinted surface, check the circle still separates from what is behind it.
- The glyph scales with the circle but keeps its shape, so at the smallest size it is 12 and detail is lost. Check it still reads at that size on the target display.
- Nothing here is focusable and nothing announces a change.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed per Size | A circle of 16, 20 or 28, carrying the glyph at 12, 16 or 24. |
| Padding | None | No padding at any size. The glyph is centred, and the ring of space around it comes from the difference between the two measurements rather than from padding. |
| Radius | Fixed | radius/pill at every size, so the surround is always a circle. |
| Fill | Fixed | foreground/secondary at every size. One colour throughout, with nothing varying it. |
| Glyph | Fixed | An Icon carrying the Clock glyph, at Size=small for the two smaller circles and Size=large for the biggest. The component sets it rather than taking one in. |

### Layer structure

- Icon Indicator (COMPONENT)
  - Icon Indicator/Icon (INSTANCE, icon: clock)

### Resolved tokens (default variant: Size=small)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Icon Indicator | width | 16 | control.icon-sm |
| Icon Indicator | height | 16 | control.icon-sm |
| Icon Indicator | fill[0] | #545963 | foreground.secondary |
| Icon Indicator | cornerRadius | 9999 | radius.pill |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | medium | Icon Indicator | width | control.icon-md |
| Size | medium | Icon Indicator | height | control.icon-md |
| Size | large | Icon Indicator | width | control.icon-lg |
| Size | large | Icon Indicator | height | control.icon-lg |
