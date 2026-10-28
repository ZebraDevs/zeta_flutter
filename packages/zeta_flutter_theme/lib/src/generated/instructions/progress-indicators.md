# Progress Indicators

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4275-1344&m=dev

## Progress Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4275-1997&m=dev

### Overview

A horizontal track that fills to show how far an ongoing process has got. Progress is a single value that grows from empty to full, with two further modes for when the extent is not known. An optional label above the bar reports the state in words. Nothing here animates, so both the fill's growth and the indeterminate movement belong to the implementation.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Progress | 0% to 100% | 0% | The bar reports one value that grows from empty to full. Figma offers it as four fixed steps only because a variant cannot hold a number, so pick the nearest when laying out and let the implementation drive the real value. The steps are samples, not thresholds worth designing around. |
| Progress | Indeterminate | - | Work is happening but its extent is unknown. The indicator becomes a short segment that a real implementation slides along the track, so it should never sit still in a shipped screen. |
| Progress | Buffering | - | Code only: a band shows how much has preloaded; the indicator never runs past it. Determinate bars only, never indeterminate. |
| Shape | rounded | true | Softened ends on both the track and the fill, matching the system's rounded controls. |
| Shape | sharp | - | Square ends, for a bar sitting flush against square surfaces. Beside rounded controls the two treatments read as different components. |
| Size | small | true | The everyday bar, thin enough to sit under a label without dominating it. |
| Size | medium | - | A heavier bar for when progress is the main thing on the surface rather than a detail beside other content. |
| Show Label | true | true | Shows the text row above the bar. The wording is fixed by the Progress value rather than set as a property, so it changes when the value does. |
| Show Label | false | - | Hides the row, leaving the bar alone. Only do this where nearby copy already names the task, because a bar on its own reports a proportion and not a subject. |
| Show Track | true | true | Shows the unfilled remainder behind the indicator, which is what makes the proportion readable. |
| Show Track | false | - | Hides it, leaving only the filled portion. The bar then shows a length with nothing to measure it against. |
| Show More Details | false | true | No trailing content in the label row. |
| Show More Details | true | - | Reveals a slot at the trailing end of the label row for supporting detail. It shares the row with the label, so a long label and a filled slot will compete for the same space. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The bar has no hover, pressed, focus or disabled states. It reports a value rather than accepting input, so the only thing that changes its appearance is the Progress value itself. |
| Indeterminate | Progress set to Indeterminate | — | The indicator becomes a short fixed-length segment rather than a measured fill. Figma draws it in one position, a real implementation moves it along the track. |
| Buffering | Progress set to Buffering | — | A band shows how much has preloaded; the indicator never runs past it. No band on an indeterminate bar; don't build Figma's moving segment over the band. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and the bar models no transition. Every Progress value is a static snapshot, so the fill growing, and the indeterminate segment travelling, both belong to the implementation. |
| Indeterminate and Buffering | Both are drawn frozen in a single position. Shipping either as a still misrepresents them, because their whole meaning is that they are moving. |
| Reflow | Width is fixed and height comes from the chosen Size, so the bar never grows with its content. A long label wraps inside the row above rather than widening the bar. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text baked per Progress value | The row above the bar. It is not a text property, so its wording is fixed by the Progress value and has to be overridden on the instance to say anything else. The shipped strings read as placeholders, for example Uploading... on Indeterminate. |
| Right Slot | slot, empty by default | Trailing content in the label row, revealed by Show More Details. It ships holding a hidden Icon and suggests no components, so it stays empty until filled. One property serves every variant, so content placed here survives a change of Progress, Shape or Size. |
| Track and indicator | fixed parts | Neither is a slot. The indicator's width is the value, so in Figma it is set by choosing the nearest step or overriding the width directly, and at runtime it is driven straight from the real number. |

### Anatomy

1. **Bar** — The outer frame. Fixed width, stacking the label row above the indicator group with a gap between them, and hugging whatever height the chosen Size produces.
2. **Label row** — Holds the text that reports the state and, when Show More Details is on, a trailing slot beside it.
3. **Indicator group** — The track, the indicator that fills it, and on Buffering a third band covering the buffered span.

### How to use

**Do:**
- Use Indeterminate or Buffering when the duration genuinely is not known. A measured bar sitting at a guessed percentage is worse than one that admits it cannot measure.
- Keep the label on unless nearby copy already names what is progressing. The bar reports a proportion, not a subject.

**Don't:**
- Don't ship Indeterminate or Buffering as a still. Both are drawn frozen here and only make sense in motion.
- Don't leave the shipped label copy in place. Strings like Uploading... are placeholders tied to the variant, not wording anyone chose for your screen.

### Accessibility & Content Guidelines

- The bar reports a value visually and nothing else. The current value, its range and what it refers to all have to be exposed in code.
- The label wording is fixed per Progress value and the shipped strings read as placeholders. Replace them with copy that names the actual task.
- Turning Show Track off removes the reference the fill is measured against, which makes the proportion much harder to judge.
- Indeterminate and Buffering convey that work continues through movement. Someone who cannot perceive the animation gets no signal from them, so pair either with text.
- The fill and the track are separated by colour alone. Check foreground/link against border/subtle on the surface you place the bar on.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed | 408px as drawn. The bar does not hug its content, so whoever places it decides the width. |
| Height | Hug per Size | 44px at small and 52px at medium with the label shown. The difference is the indicator group, which is 8px at small and 16px at medium. |
| Gap | Fixed | 16px (space/lg) between the label row and the indicator group. The label row's own internal gap is a raw 10px rather than a token. |
| Radius | Fixed per Shape and Size | The track and indicator take radius/sm at small and radius/md at medium while Shape is rounded, and radius/none while it is sharp. The radius scales with thickness so the ends stay fully round. |
| Indicator width | Fixed per Progress | The indicator's width is the value expressed as a share of the 408px track. Figma samples it at 0, 204 and 408px because a variant cannot carry a number, and both Indeterminate and Buffering draw a fixed 143px segment instead. |
| Buffered band | Fixed | Buffering adds a 306px band on surface/subtle at 10 percent opacity, between the indicator and the end of the track. |
| Label type | Fixed | label/medium (14/20), IBM Plex Sans Medium. |
| Colour | Theming | The indicator is foreground/link, the track border/subtle and the label foreground/secondary. The buffered band is the only element relying on an opacity rather than a token value alone. |

### Layer structure

- Progress Bar (COMPONENT)
  - Progress Bar/Details (FRAME)
    - Progress Bar/Details/Label (TEXT)
    - Progress Bar/Details/Right Slot (SLOT)
  - Progress Bar/Indicator Group (FRAME)
    - Progress Bar/Indicator Group/Indicator (RECTANGLE)
    - Progress Bar/Indicator Group/Track (RECTANGLE)
    - Progress Bar/Indicator Group/Rail (RECTANGLE)

### Resolved tokens (default variant: Progress=0%, Shape=rounded, Size=small)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Progress Bar | cornerRadius | 0 | radius.none |
| Progress Bar | itemSpacing | 16 | space.lg |
| Progress Bar/Details | itemSpacing | 10 | — |
| Progress Bar/Details/Label | fill[0] | #545963 | foreground.secondary |
| Progress Bar/Details/Label | fontSize | 14 | label.medium.font size |
| Progress Bar/Details/Label | lineHeight | 20 | label.medium.line height |
| Progress Bar/Details/Label | letterSpacing | 0 | label.medium.letter spacing |
| Progress Bar/Details/Right Slot | itemSpacing | 4 | space.xxs |
| Progress Bar/Indicator Group | cornerRadius | 4 | radius.sm |
| Progress Bar/Indicator Group | padding.right | 408 | — |
| Progress Bar/Indicator Group/Indicator | fill[0] | #1f69ff | foreground.link |
| Progress Bar/Indicator Group/Indicator | cornerRadius | 4 | radius.sm |
| Progress Bar/Indicator Group/Track | fill[0] | #e0e3e9 | surface.track |
| Progress Bar/Indicator Group/Track | cornerRadius | 4 | radius.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Progress | 100% | Progress Bar/Indicator Group | cornerRadius | — |
| Progress | Buffering | Progress Bar/Indicator Group | cornerRadius | — |
| Progress | Buffering | Progress Bar/Indicator Group/Rail | fill[0] | surface.subtle |
| Progress | Buffering | Progress Bar/Indicator Group/Rail | cornerRadius | radius.sm |
| Shape | sharp | Progress Bar/Indicator Group/Indicator | cornerRadius | radius.none |
| Shape | sharp | Progress Bar/Indicator Group/Track | cornerRadius | radius.none |
| Size | medium | Progress Bar/Indicator Group | cornerRadius | radius.none |
| Size | medium | Progress Bar/Indicator Group/Indicator | cornerRadius | radius.md |
| Size | medium | Progress Bar/Indicator Group/Track | cornerRadius | radius.md |

## Progress Circle

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4416-77&m=dev

### Overview

A ring that reports an ongoing process where a bar will not fit, beside an icon or inside a dense row. Five sizes cover inline through to prominent, and Upload turns it into a file-transfer control with a cancel action. Unlike Progress Bar it has no property for the amount of progress, so the arc is fixed here and the real value has to come from the implementation.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Size | xxsmall | true | The smallest ring, for sitting inside a line of text or beside a small icon. The stroke does not thin at this size, so the ring reads as heavy relative to its diameter. |
| Size | xsmall | - | A step up while still inline. The largest size at which the Upload control is not built. |
| Size | small | - | The smallest size that supports Upload, though the control nearly fills the ring at this diameter. |
| Size | medium | - | The general-purpose size, and the one where the Upload control sits comfortably inside the ring. |
| Size | large | - | For when progress is the main thing on the surface rather than an inline detail. |
| Rounded | true | true | Rounds the ends of the progress arc. Despite the name it is a line cap rather than a corner radius, and it only shows where the arc starts and stops. |
| Rounded | false | - | Squares the arc ends off, for use alongside sharp-shaped controls. The difference is visible at two points on the ring and nowhere else. |
| Upload | false | true | A plain progress ring. |
| Upload | true | - | Places a file-transfer control at the centre of the ring, reporting the percentage and offering a cancel action. It has no effect at xsmall or xxsmall, where the control is not built. |
| Show Track | true | true | Shows the unfilled remainder of the ring, which is what makes the arc's extent readable. |
| Show Track | false | - | Hides it, leaving the arc floating with nothing to measure it against. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The ring has no hover, pressed, focus or disabled states, and no progress states either. Every one of the ten variants draws the same arc. |
| Upload shown | Upload set to true | — | A control appears centred in the ring, reporting the percentage. Its own Stop property swaps that readout for a cancel button. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and the ring models no transition. The arc is drawn in one fixed position in every variant, so both a determinate sweep and an indeterminate spin belong entirely to the implementation. |
| Progress | There is no property for the amount. The arc sits at roughly three quarters in every variant, which is a placeholder rather than a value, so nothing here should be read as a real state. |
| Upload | Showing or hiding the control does not resize the ring, because the control is centred inside it rather than stacked with it. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Upload control | nested instance, toggled by Upload | The file-transfer control at the centre, left exposed so its Stop state is reachable from the ring. It is a fixed 36px whatever the ring's size, so at small it nearly fills the ring, and at xsmall and xxsmall it is not present at all. |
| Percentage readout | inside the Upload control | Part of the nested control rather than a property of the ring. It ships reading 75% and has to be overridden on the instance to say anything else. |
| Track and arc | fixed parts | Neither is a slot. The arc's sweep is what would encode a value, and it is identical in every variant. |

### Anatomy

1. **Ring** — The outer square frame, fixed at the chosen Size, holding the track and the arc concentrically.
2. **Track and arc** — Two rings drawn as strokes. The track covers the full circle and the arc covers the portion reported as complete.
3. **Upload control** — A nested control centred in the ring, hidden until Upload is turned on and absent altogether at the two smallest sizes.

### How to use

**Do:**
- Use medium or large whenever Upload is on. The control is a fixed size, so the smaller rings leave it almost no margin.
- Pair the ring with nearby text. On its own it says that something is happening but never what.

**Don't:**
- Don't read the arc as a value. It is identical in every variant, so a screen with several rings will show them all at the same apparent progress.
- Don't reach for Upload at xsmall or xxsmall. The property is offered at those sizes but the control is not built, so turning it on does nothing.

### Accessibility & Content Guidelines

- The ring reports progress visually and nothing else. The value, its range and what it refers to all have to be exposed in code.
- The ring carries no label of its own, so on its own it signals that something is happening but not what. Pair it with nearby text.
- The stroke is the same weight at every size, so at xxsmall the ring is proportionally far heavier than at large. Check the smallest sizes still read as a ring.
- The arc and the track are separated by colour alone. Check border/info against border/subtle on the surface behind them.
- The Upload control's cancel action is a real control. It needs an accessible name and a keyboard path, neither of which is modelled here.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed square per Size | 24, 36, 40, 48 and 64px across the five steps. Always square, and never hugging its content. |
| Stroke weight | Fixed | 4px (stroke/heavy) at every size. It does not scale, so the ring is roughly a sixth of the diameter at xxsmall and a sixteenth at large. |
| Arc | Fixed | The track covers the full circle. The arc begins at twelve o'clock and runs about three quarters of the way round, identically in all ten variants. |
| Line cap | Fixed per Rounded | The arc's ends are round when Rounded is true and square when it is false. The track's ends are always square, though a full circle hides them. |
| Upload control | Fixed | 36px regardless of the ring's size, centred, and present only at small, medium and large. |
| Colour | Theming | The arc is border/info and the track border/subtle. The arc also carries a foreground/link fill which does not render, because the shape is drawn with no inner area and the stroke does the visible work. |

### Layer structure

- Progress Circle (COMPONENT)
  - Progress Circle/Track (ELLIPSE)
  - Progress Circle/Indicator (ELLIPSE)
  - Progress Circle/_Upload (INSTANCE)

### Resolved tokens (default variant: Size=xxsmall, Rounded=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Progress Circle/Track | stroke[0] | #e0e3e9 | border.subtle |
| Progress Circle/Track | cornerRadius | 0 | radius.none |
| Progress Circle/Track | strokeWeight | 4 | stroke.heavy |
| Progress Circle/Indicator | fill[0] | #1f69ff | foreground.link |
| Progress Circle/Indicator | stroke[0] | #0073e6 | border.info |
| Progress Circle/Indicator | strokeWeight | 4 | stroke.heavy |

## _Upload

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4416-123&m=dev

### Layer structure

- _Upload (COMPONENT)
  - _Upload/Icon Button (INSTANCE)
  - _Upload/75% (TEXT)

### Resolved tokens (default variant: Stop=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Upload/Icon Button | width | 36 | control.sm |
| _Upload/Icon Button | height | 36 | control.sm |
| _Upload/Icon Button | fill[0] | #0c0d0e0d | interactive.ghost.background.hover |
| _Upload/Icon Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| _Upload/Icon Button | cornerRadius | 9999 | radius.pill |
| _Upload/Icon Button | strokeWeight | 0 | stroke.base |
| _Upload/Icon Button | padding.left | 4 | space.xxs |
| _Upload/Icon Button | padding.right | 4 | space.xxs |
| _Upload/Icon Button | padding.top | 4 | space.xxs |
| _Upload/Icon Button | padding.bottom | 4 | space.xxs |
| _Upload/75% | fill[0] | #000000 | — |
| _Upload/75% | fontSize | 12 | indicator.medium.font size |
| _Upload/75% | lineHeight | 14 | indicator.medium.line height |
| _Upload/75% | letterSpacing | 0 | indicator.medium.letter spacing |
