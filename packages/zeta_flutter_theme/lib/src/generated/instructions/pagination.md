# Pagination

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3853-1209&m=dev

## Pagination

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4489-1925&m=dev

### Overview

A horizontal bar of page controls, first/previous/next/last jump buttons, a row of page number indicators, and an optional overflow marker for a long page range. Used inside Table Footer and anywhere else a result set needs to be split across pages. If there is only ever one page of results, do not include it at all, an empty or single page pagination bar signals a feature that was not finished.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Show Controls | Boolean | true | Shows First Page, Chevron Left, Chevron Right, and Last Page, the four jump controls, as one group. The default. |
| Show Controls | Boolean | - | Hides all four jump controls at once. Use when only direct page number navigation is offered, no first, last, previous, or next jumping. |
| Show More | Boolean | true | Shows the overflow control, the "..." button, together with the trailing page number indicator that follows it, as one paired group. The default. |
| Show More | Boolean | - | Hides the overflow control and its paired trailing indicator together. Use when the full page range fits without collapsing pages behind an ellipsis. |
| Outline | Variant | true | Every control and indicator renders filled, with no border. The default. |
| Outline | Variant | - | Every control and indicator gains a 1px border. Applies to the whole bar at once, there is no per-button override. |
| Rounded | Variant | true | Sharp corners on every control and indicator. The default. |
| Rounded | Variant | - | 4px corners on every control and indicator. Applies to the whole bar at once, there is no per-button override. |
| Main Slot | Figma only, holds the page number indicators | — | Four separate slot properties exist, Main Slot 1, Main Slot2, Main Slot 3, Main Slot 4, one per Outline × Rounded combination, rather than one shared slot, so custom page number content set under one combination does not carry over when switching Outline or Rounded. Spares the file from a shared-slot mechanism Figma variants do not support, at the cost of re-entering content after changing either axis. A fifth, identically named Main Slot 1 property is also defined but wired to nothing in any of the four variants, an orphaned leftover, ignore it. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Page numbers | _indicators instances, up to 3 shown, state enabled or selected | The repeatable part. One indicator carries State=selected for the current page, the rest stay enabled. Consumer owned, but lives inside whichever Main Slot matches the current Outline/Rounded combination, see Property Breakdown. |
| Jump controls | _controls instances, fixed to First Page, Chevron Left, Chevron Right, Last Page | Parent owned. The four icons and their order are fixed, Show Controls toggles all four together, there is no way to show only one. |
| Overflow | _controls instance, fixed to the more_horizontal icon | Parent owned, fixed glyph. Paired with one trailing _indicators instance under Show More, the two always show or hide together. |

### Anatomy

1. **First Page, Chevron Left** — The leading pair of the jump controls group, toggled together with the trailing pair by Show Controls.
2. **Page numbers** — The repeatable indicator slot, one marked selected for the current page.
3. **Overflow** — The "..." control and its paired trailing indicator, shown or hidden together by Show More.
4. **Chevron Right, Last Page** — The trailing pair of the jump controls group, toggled together with the leading pair by Show Controls.

### How to use

**Do:**
- Use Show Controls and Show More independently, turn off the jump buttons for a short list while keeping the overflow indicator for a long one, or the reverse.
- Set Outline and Rounded once for the whole bar. They are whole-bar styling choices, not something to vary button by button.

**Don't:**
- Don’t expect page number content set in the slot to survive switching Outline or Rounded. Each combination owns its own separate slot, re-enter it after changing either.
- Don’t reach for the Main Slot 1 property with key 4489:15, it isn’t wired to any variant. Use whichever Main Slot property your current Outline/Rounded combination actually shows.

### Accessibility & Content Guidelines

- Keyboard and focus behaviour belongs to the nested _controls and _indicators states, not to Pagination itself. The overflow control has no visible label, it needs an accessible name supplied in code, something like "more pages" rather than reading the glyph.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Control size | 36×36 each | Every control and indicator is the same fixed square, regardless of Outline or Rounded. |
| Gap | 8px, not token bound | itemSpacing between every top-level item in the bar, controls, the slot, and indicators alike. |
| Corner radius | Manual, per Outline×Rounded variant | sharp = 0, rounded = 4, set directly on each variant’s controls and indicators, not bound to a radius variable. |
| Border | Manual, per Outline×Rounded variant | Outline=true adds a 1px stroke to every control and indicator, Outline=false removes it entirely. Also not token bound. |
| Container | Hugs content, 388px at the 3-indicator default | Width is not fixed, it grows or shrinks with however many page number indicators the active slot holds. |

### Layer structure

- Pagination (COMPONENT)
  - Pagination/_controls sharp no-outline[1] (INSTANCE)
  - Pagination/_controls sharp no-outline[2] (INSTANCE)
  - Pagination/Main Slot 1 (SLOT)
  - Pagination/_controls sharp no-outline[3] (INSTANCE)
  - Pagination/_indicators sharp no-outline (INSTANCE)
  - Pagination/_controls sharp no-outline[4] (INSTANCE)
  - Pagination/_controls sharp no-outline[5] (INSTANCE)
  - Pagination/_controls sharp outline[1] (INSTANCE)
  - Pagination/_controls sharp outline[2] (INSTANCE)
  - Pagination/Main Slot2 (SLOT)
  - Pagination/_controls sharp outline[3] (INSTANCE)
  - Pagination/_controls sharp outline[4] (INSTANCE)
  - Pagination/_controls sharp outline[5] (INSTANCE)
  - Pagination/_controls round no-outline[1] (INSTANCE)
  - Pagination/_controls round no-outline[2] (INSTANCE)
  - Pagination/Main Slot 3 (SLOT)
  - Pagination/_controls round no-outline[3] (INSTANCE)
  - Pagination/_indicators round no-outline (INSTANCE)
  - Pagination/_controls round no-outline[4] (INSTANCE)
  - Pagination/_controls round no-outline[5] (INSTANCE)
  - Pagination/_controls round outline[1] (INSTANCE)
  - Pagination/_controls round outline[2] (INSTANCE)
  - Pagination/Main Slot 4 (SLOT)
  - Pagination/_controls round outline[3] (INSTANCE)
  - Pagination/_indicators round outline (INSTANCE)
  - Pagination/_controls round outline[4] (INSTANCE)
  - Pagination/_controls round outline[5] (INSTANCE)

### Resolved tokens (default variant: Outline=false, Rounded=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Pagination | itemSpacing | 8 | space.sm |
| Pagination/_controls sharp no-outline[1] | height | 36 | control.sm |
| Pagination/_controls sharp no-outline[1] | fill[0] | #ffffff | interactive.neutral.background.default |
| Pagination/_controls sharp no-outline[1] | stroke[0] | #ced2db | interactive.neutral.border.default |
| Pagination/_controls sharp no-outline[1] | cornerRadius | 0 | radius.none |
| Pagination/_controls sharp no-outline[1] | strokeWeight | 0 | stroke.base |
| Pagination/_controls sharp no-outline[1] | padding.left | 8 | space.sm |
| Pagination/_controls sharp no-outline[1] | padding.right | 8 | space.sm |
| Pagination/_controls sharp no-outline[1] | padding.top | 8 | space.sm |
| Pagination/_controls sharp no-outline[1] | padding.bottom | 8 | space.sm |
| Pagination/_controls sharp no-outline[2] | height | 36 | control.sm |
| Pagination/_controls sharp no-outline[2] | fill[0] | #ffffff | interactive.neutral.background.default |
| Pagination/_controls sharp no-outline[2] | stroke[0] | #ced2db | interactive.neutral.border.default |
| Pagination/_controls sharp no-outline[2] | cornerRadius | 0 | radius.none |
| Pagination/_controls sharp no-outline[2] | strokeWeight | 0 | stroke.base |
| Pagination/_controls sharp no-outline[2] | padding.left | 8 | space.sm |
| Pagination/_controls sharp no-outline[2] | padding.right | 8 | space.sm |
| Pagination/_controls sharp no-outline[2] | padding.top | 8 | space.sm |
| Pagination/_controls sharp no-outline[2] | padding.bottom | 8 | space.sm |
| Pagination/Main Slot 1 | itemSpacing | 8 | space.sm |
| Pagination/_controls sharp no-outline[3] | height | 36 | control.sm |
| Pagination/_controls sharp no-outline[3] | fill[0] | #ffffff | interactive.neutral.background.default |
| Pagination/_controls sharp no-outline[3] | stroke[0] | #ced2db | interactive.neutral.border.default |
| Pagination/_controls sharp no-outline[3] | cornerRadius | 0 | radius.none |
| Pagination/_controls sharp no-outline[3] | strokeWeight | 0 | stroke.base |
| Pagination/_controls sharp no-outline[3] | padding.left | 8 | space.sm |
| Pagination/_controls sharp no-outline[3] | padding.right | 8 | space.sm |
| Pagination/_controls sharp no-outline[3] | padding.top | 8 | space.sm |
| Pagination/_controls sharp no-outline[3] | padding.bottom | 8 | space.sm |
| Pagination/_indicators sharp no-outline | height | 36 | control.sm |
| Pagination/_indicators sharp no-outline | fill[0] | #ffffff | interactive.neutral.background.default |
| Pagination/_indicators sharp no-outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| Pagination/_indicators sharp no-outline | cornerRadius | 0 | radius.none |
| Pagination/_indicators sharp no-outline | strokeWeight | 0 | stroke.base |
| Pagination/_controls sharp no-outline[4] | height | 36 | control.sm |
| Pagination/_controls sharp no-outline[4] | fill[0] | #ffffff | interactive.neutral.background.default |
| Pagination/_controls sharp no-outline[4] | stroke[0] | #ced2db | interactive.neutral.border.default |
| Pagination/_controls sharp no-outline[4] | cornerRadius | 0 | radius.none |
| Pagination/_controls sharp no-outline[4] | strokeWeight | 0 | stroke.base |
| Pagination/_controls sharp no-outline[4] | padding.left | 8 | space.sm |
| Pagination/_controls sharp no-outline[4] | padding.right | 8 | space.sm |
| Pagination/_controls sharp no-outline[4] | padding.top | 8 | space.sm |
| Pagination/_controls sharp no-outline[4] | padding.bottom | 8 | space.sm |
| Pagination/_controls sharp no-outline[5] | height | 36 | control.sm |
| Pagination/_controls sharp no-outline[5] | fill[0] | #ffffff | interactive.neutral.background.default |
| Pagination/_controls sharp no-outline[5] | stroke[0] | #ced2db | interactive.neutral.border.default |
| Pagination/_controls sharp no-outline[5] | cornerRadius | 0 | radius.none |
| Pagination/_controls sharp no-outline[5] | strokeWeight | 0 | stroke.base |
| Pagination/_controls sharp no-outline[5] | padding.left | 8 | space.sm |
| Pagination/_controls sharp no-outline[5] | padding.right | 8 | space.sm |
| Pagination/_controls sharp no-outline[5] | padding.top | 8 | space.sm |
| Pagination/_controls sharp no-outline[5] | padding.bottom | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Outline | true | Pagination/_controls sharp no-outline[1] | height | — |
| Outline | true | Pagination/_controls sharp no-outline[1] | fill[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[1] | stroke[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[1] | cornerRadius | — |
| Outline | true | Pagination/_controls sharp no-outline[1] | strokeWeight | — |
| Outline | true | Pagination/_controls sharp no-outline[1] | padding.left | — |
| Outline | true | Pagination/_controls sharp no-outline[1] | padding.right | — |
| Outline | true | Pagination/_controls sharp no-outline[1] | padding.top | — |
| Outline | true | Pagination/_controls sharp no-outline[1] | padding.bottom | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | height | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | fill[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | stroke[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | cornerRadius | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | strokeWeight | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | padding.left | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | padding.right | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | padding.top | — |
| Outline | true | Pagination/_controls sharp no-outline[2] | padding.bottom | — |
| Outline | true | Pagination/Main Slot 1 | itemSpacing | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | height | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | fill[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | stroke[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | cornerRadius | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | strokeWeight | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | padding.left | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | padding.right | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | padding.top | — |
| Outline | true | Pagination/_controls sharp no-outline[3] | padding.bottom | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | height | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | fill[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | stroke[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | cornerRadius | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | strokeWeight | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | padding.left | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | padding.right | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | padding.top | — |
| Outline | true | Pagination/_controls sharp no-outline[4] | padding.bottom | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | height | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | fill[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | stroke[0] | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | cornerRadius | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | strokeWeight | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | padding.left | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | padding.right | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | padding.top | — |
| Outline | true | Pagination/_controls sharp no-outline[5] | padding.bottom | — |
| Outline | true | Pagination/_controls sharp outline[1] | height | control.sm |
| Outline | true | Pagination/_controls sharp outline[1] | fill[0] | interactive.neutral.background.default |
| Outline | true | Pagination/_controls sharp outline[1] | stroke[0] | interactive.neutral.border.default |
| Outline | true | Pagination/_controls sharp outline[1] | cornerRadius | radius.none |
| Outline | true | Pagination/_controls sharp outline[1] | strokeWeight | stroke.thin |
| Outline | true | Pagination/_controls sharp outline[1] | padding.left | space.sm |
| Outline | true | Pagination/_controls sharp outline[1] | padding.right | space.sm |
| Outline | true | Pagination/_controls sharp outline[1] | padding.top | space.sm |
| Outline | true | Pagination/_controls sharp outline[1] | padding.bottom | space.sm |
| Outline | true | Pagination/_controls sharp outline[2] | height | control.sm |
| Outline | true | Pagination/_controls sharp outline[2] | fill[0] | interactive.neutral.background.default |
| Outline | true | Pagination/_controls sharp outline[2] | stroke[0] | interactive.neutral.border.default |
| Outline | true | Pagination/_controls sharp outline[2] | cornerRadius | radius.none |
| Outline | true | Pagination/_controls sharp outline[2] | strokeWeight | stroke.thin |
| Outline | true | Pagination/_controls sharp outline[2] | padding.left | space.sm |
| Outline | true | Pagination/_controls sharp outline[2] | padding.right | space.sm |
| Outline | true | Pagination/_controls sharp outline[2] | padding.top | space.sm |
| Outline | true | Pagination/_controls sharp outline[2] | padding.bottom | space.sm |
| Outline | true | Pagination/Main Slot2 | itemSpacing | space.sm |
| Outline | true | Pagination/_controls sharp outline[3] | height | control.sm |
| Outline | true | Pagination/_controls sharp outline[3] | fill[0] | interactive.neutral.background.default |
| Outline | true | Pagination/_controls sharp outline[3] | stroke[0] | interactive.neutral.border.default |
| Outline | true | Pagination/_controls sharp outline[3] | cornerRadius | radius.none |
| Outline | true | Pagination/_controls sharp outline[3] | strokeWeight | stroke.thin |
| Outline | true | Pagination/_controls sharp outline[3] | padding.left | space.sm |
| Outline | true | Pagination/_controls sharp outline[3] | padding.right | space.sm |
| Outline | true | Pagination/_controls sharp outline[3] | padding.top | space.sm |
| Outline | true | Pagination/_controls sharp outline[3] | padding.bottom | space.sm |
| Outline | true | Pagination/_controls sharp outline[4] | height | control.sm |
| Outline | true | Pagination/_controls sharp outline[4] | fill[0] | interactive.neutral.background.default |
| Outline | true | Pagination/_controls sharp outline[4] | stroke[0] | interactive.neutral.border.default |
| Outline | true | Pagination/_controls sharp outline[4] | cornerRadius | radius.none |
| Outline | true | Pagination/_controls sharp outline[4] | strokeWeight | stroke.thin |
| Outline | true | Pagination/_controls sharp outline[4] | padding.left | space.sm |
| Outline | true | Pagination/_controls sharp outline[4] | padding.right | space.sm |
| Outline | true | Pagination/_controls sharp outline[4] | padding.top | space.sm |
| Outline | true | Pagination/_controls sharp outline[4] | padding.bottom | space.sm |
| Outline | true | Pagination/_controls sharp outline[5] | height | control.sm |
| Outline | true | Pagination/_controls sharp outline[5] | fill[0] | interactive.neutral.background.default |
| Outline | true | Pagination/_controls sharp outline[5] | stroke[0] | interactive.neutral.border.default |
| Outline | true | Pagination/_controls sharp outline[5] | cornerRadius | radius.none |
| Outline | true | Pagination/_controls sharp outline[5] | strokeWeight | stroke.thin |
| Outline | true | Pagination/_controls sharp outline[5] | padding.left | space.sm |
| Outline | true | Pagination/_controls sharp outline[5] | padding.right | space.sm |
| Outline | true | Pagination/_controls sharp outline[5] | padding.top | space.sm |
| Outline | true | Pagination/_controls sharp outline[5] | padding.bottom | space.sm |
| Rounded | true | Pagination/_controls sharp no-outline[1] | height | — |
| Rounded | true | Pagination/_controls sharp no-outline[1] | fill[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[1] | stroke[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[1] | cornerRadius | — |
| Rounded | true | Pagination/_controls sharp no-outline[1] | strokeWeight | — |
| Rounded | true | Pagination/_controls sharp no-outline[1] | padding.left | — |
| Rounded | true | Pagination/_controls sharp no-outline[1] | padding.right | — |
| Rounded | true | Pagination/_controls sharp no-outline[1] | padding.top | — |
| Rounded | true | Pagination/_controls sharp no-outline[1] | padding.bottom | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | height | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | fill[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | stroke[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | cornerRadius | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | strokeWeight | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | padding.left | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | padding.right | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | padding.top | — |
| Rounded | true | Pagination/_controls sharp no-outline[2] | padding.bottom | — |
| Rounded | true | Pagination/Main Slot 1 | itemSpacing | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | height | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | fill[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | stroke[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | cornerRadius | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | strokeWeight | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | padding.left | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | padding.right | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | padding.top | — |
| Rounded | true | Pagination/_controls sharp no-outline[3] | padding.bottom | — |
| Rounded | true | Pagination/_indicators sharp no-outline | height | — |
| Rounded | true | Pagination/_indicators sharp no-outline | fill[0] | — |
| Rounded | true | Pagination/_indicators sharp no-outline | stroke[0] | — |
| Rounded | true | Pagination/_indicators sharp no-outline | cornerRadius | — |
| Rounded | true | Pagination/_indicators sharp no-outline | strokeWeight | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | height | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | fill[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | stroke[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | cornerRadius | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | strokeWeight | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | padding.left | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | padding.right | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | padding.top | — |
| Rounded | true | Pagination/_controls sharp no-outline[4] | padding.bottom | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | height | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | fill[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | stroke[0] | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | cornerRadius | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | strokeWeight | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | padding.left | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | padding.right | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | padding.top | — |
| Rounded | true | Pagination/_controls sharp no-outline[5] | padding.bottom | — |
| Rounded | true | Pagination/_controls round no-outline[1] | height | control.sm |
| Rounded | true | Pagination/_controls round no-outline[1] | fill[0] | interactive.neutral.background.default |
| Rounded | true | Pagination/_controls round no-outline[1] | stroke[0] | interactive.neutral.border.default |
| Rounded | true | Pagination/_controls round no-outline[1] | cornerRadius | radius.sm |
| Rounded | true | Pagination/_controls round no-outline[1] | strokeWeight | stroke.base |
| Rounded | true | Pagination/_controls round no-outline[1] | padding.left | space.sm |
| Rounded | true | Pagination/_controls round no-outline[1] | padding.right | space.sm |
| Rounded | true | Pagination/_controls round no-outline[1] | padding.top | space.sm |
| Rounded | true | Pagination/_controls round no-outline[1] | padding.bottom | space.sm |
| Rounded | true | Pagination/_controls round no-outline[2] | height | control.sm |
| Rounded | true | Pagination/_controls round no-outline[2] | fill[0] | interactive.neutral.background.default |
| Rounded | true | Pagination/_controls round no-outline[2] | stroke[0] | interactive.neutral.border.default |
| Rounded | true | Pagination/_controls round no-outline[2] | cornerRadius | radius.sm |
| Rounded | true | Pagination/_controls round no-outline[2] | strokeWeight | stroke.base |
| Rounded | true | Pagination/_controls round no-outline[2] | padding.left | space.sm |
| Rounded | true | Pagination/_controls round no-outline[2] | padding.right | space.sm |
| Rounded | true | Pagination/_controls round no-outline[2] | padding.top | space.sm |
| Rounded | true | Pagination/_controls round no-outline[2] | padding.bottom | space.sm |
| Rounded | true | Pagination/Main Slot 3 | itemSpacing | space.sm |
| Rounded | true | Pagination/_controls round no-outline[3] | height | control.sm |
| Rounded | true | Pagination/_controls round no-outline[3] | fill[0] | interactive.neutral.background.default |
| Rounded | true | Pagination/_controls round no-outline[3] | stroke[0] | interactive.neutral.border.default |
| Rounded | true | Pagination/_controls round no-outline[3] | cornerRadius | radius.sm |
| Rounded | true | Pagination/_controls round no-outline[3] | strokeWeight | stroke.base |
| Rounded | true | Pagination/_controls round no-outline[3] | padding.left | space.sm |
| Rounded | true | Pagination/_controls round no-outline[3] | padding.right | space.sm |
| Rounded | true | Pagination/_controls round no-outline[3] | padding.top | space.sm |
| Rounded | true | Pagination/_controls round no-outline[3] | padding.bottom | space.sm |
| Rounded | true | Pagination/_indicators round no-outline | height | control.sm |
| Rounded | true | Pagination/_indicators round no-outline | fill[0] | interactive.neutral.background.default |
| Rounded | true | Pagination/_indicators round no-outline | stroke[0] | interactive.neutral.border.default |
| Rounded | true | Pagination/_indicators round no-outline | cornerRadius | radius.sm |
| Rounded | true | Pagination/_indicators round no-outline | strokeWeight | stroke.base |
| Rounded | true | Pagination/_controls round no-outline[4] | height | control.sm |
| Rounded | true | Pagination/_controls round no-outline[4] | fill[0] | interactive.neutral.background.default |
| Rounded | true | Pagination/_controls round no-outline[4] | stroke[0] | interactive.neutral.border.default |
| Rounded | true | Pagination/_controls round no-outline[4] | cornerRadius | radius.sm |
| Rounded | true | Pagination/_controls round no-outline[4] | strokeWeight | stroke.base |
| Rounded | true | Pagination/_controls round no-outline[4] | padding.left | space.sm |
| Rounded | true | Pagination/_controls round no-outline[4] | padding.right | space.sm |
| Rounded | true | Pagination/_controls round no-outline[4] | padding.top | space.sm |
| Rounded | true | Pagination/_controls round no-outline[4] | padding.bottom | space.sm |
| Rounded | true | Pagination/_controls round no-outline[5] | height | control.sm |
| Rounded | true | Pagination/_controls round no-outline[5] | fill[0] | interactive.neutral.background.default |
| Rounded | true | Pagination/_controls round no-outline[5] | stroke[0] | interactive.neutral.border.default |
| Rounded | true | Pagination/_controls round no-outline[5] | cornerRadius | radius.sm |
| Rounded | true | Pagination/_controls round no-outline[5] | strokeWeight | stroke.base |
| Rounded | true | Pagination/_controls round no-outline[5] | padding.left | space.sm |
| Rounded | true | Pagination/_controls round no-outline[5] | padding.right | space.sm |
| Rounded | true | Pagination/_controls round no-outline[5] | padding.top | space.sm |
| Rounded | true | Pagination/_controls round no-outline[5] | padding.bottom | space.sm |

## _indicators sharp no-outline

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4485-1775&m=dev

### Layer structure

- _indicators sharp no-outline (COMPONENT)
  - _indicators sharp no-outline/10 (TEXT)

### Resolved tokens (default variant: State=enabled, Outline=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _indicators sharp no-outline | height | 36 | control.sm |
| _indicators sharp no-outline | fill[0] | #ffffff | interactive.neutral.background.default |
| _indicators sharp no-outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| _indicators sharp no-outline | cornerRadius | 0 | radius.none |
| _indicators sharp no-outline | strokeWeight | 0 | stroke.base |
| _indicators sharp no-outline/10 | fill[0] | #0c0d0e | foreground.primary |
| _indicators sharp no-outline/10 | fontSize | 14 | body.small.font size |
| _indicators sharp no-outline/10 | lineHeight | 18 | body.small.line height |
| _indicators sharp no-outline/10 | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | _indicators sharp no-outline | fill[0] | interactive.neutral.background.hover |
| State | selected | _indicators sharp no-outline | fill[0] | interactive.inverse.background.selected |
| State | selected | _indicators sharp no-outline | stroke[0] | interactive.inverse.border.default |
| State | selected | _indicators sharp no-outline/10 | fill[0] | foreground.inverse |
| State | focused | _indicators sharp no-outline | stroke[0] | border.focus |
| State | focused | _indicators sharp no-outline | strokeWeight | stroke.thick |
| State | disabled | _indicators sharp no-outline | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _indicators sharp no-outline | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | _indicators sharp no-outline/10 | fill[0] | foreground.disabled |
| State | pressed | _indicators sharp no-outline | fill[0] | interactive.neutral.background.pressed |

## _indicators sharp outline

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4485-1801&m=dev

### Layer structure

- _indicators sharp outline (COMPONENT)
  - _indicators sharp outline/10 (TEXT)

### Resolved tokens (default variant: State=enabled, Outline=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _indicators sharp outline | height | 36 | control.sm |
| _indicators sharp outline | fill[0] | #ffffff | interactive.neutral.background.default |
| _indicators sharp outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| _indicators sharp outline | cornerRadius | 0 | radius.none |
| _indicators sharp outline | strokeWeight | 1 | stroke.thin |
| _indicators sharp outline/10 | fill[0] | #0c0d0e | foreground.primary |
| _indicators sharp outline/10 | fontSize | 14 | body.small.font size |
| _indicators sharp outline/10 | lineHeight | 18 | body.small.line height |
| _indicators sharp outline/10 | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | _indicators sharp outline | fill[0] | interactive.neutral.background.hover |
| State | hover | _indicators sharp outline | stroke[0] | interactive.neutral.border.hover |
| State | selected | _indicators sharp outline | fill[0] | interactive.inverse.background.selected |
| State | selected | _indicators sharp outline | stroke[0] | — |
| State | selected | _indicators sharp outline | strokeWeight | — |
| State | selected | _indicators sharp outline/10 | fill[0] | foreground.inverse |
| State | focused | _indicators sharp outline | stroke[0] | border.focus |
| State | focused | _indicators sharp outline | strokeWeight | stroke.thick |
| State | disabled | _indicators sharp outline | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _indicators sharp outline | stroke[0] | interactive.primary.border.disabled |
| State | disabled | _indicators sharp outline/10 | fill[0] | foreground.disabled |
| State | pressed | _indicators sharp outline | fill[0] | interactive.neutral.background.pressed |
| State | pressed | _indicators sharp outline | stroke[0] | interactive.neutral.border.pressed |

## _indicators round no-outline

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4489-1815&m=dev

### Layer structure

- _indicators round no-outline (COMPONENT)
  - _indicators round no-outline/10 (TEXT)

### Resolved tokens (default variant: State=enabled, Outline=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _indicators round no-outline | height | 36 | control.sm |
| _indicators round no-outline | fill[0] | #ffffff | interactive.neutral.background.default |
| _indicators round no-outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| _indicators round no-outline | cornerRadius | 4 | radius.sm |
| _indicators round no-outline | strokeWeight | 0 | stroke.base |
| _indicators round no-outline/10 | fill[0] | #0c0d0e | foreground.primary |
| _indicators round no-outline/10 | fontSize | 14 | body.small.font size |
| _indicators round no-outline/10 | lineHeight | 18 | body.small.line height |
| _indicators round no-outline/10 | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | _indicators round no-outline | fill[0] | interactive.neutral.background.hover |
| State | selected | _indicators round no-outline | fill[0] | interactive.inverse.background.selected |
| State | selected | _indicators round no-outline | stroke[0] | interactive.inverse.border.default |
| State | selected | _indicators round no-outline/10 | fill[0] | foreground.inverse |
| State | focused | _indicators round no-outline | stroke[0] | border.focus |
| State | focused | _indicators round no-outline | strokeWeight | stroke.thick |
| State | disabled | _indicators round no-outline | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _indicators round no-outline | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | _indicators round no-outline/10 | fill[0] | foreground.disabled |
| State | pressed | _indicators round no-outline | fill[0] | interactive.neutral.background.pressed |

## _indicators round outline

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4489-1828&m=dev

### Layer structure

- _indicators round outline (COMPONENT)
  - _indicators round outline/10 (TEXT)

### Resolved tokens (default variant: State=enabled, Outline=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _indicators round outline | height | 36 | control.sm |
| _indicators round outline | fill[0] | #ffffff | interactive.neutral.background.default |
| _indicators round outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| _indicators round outline | cornerRadius | 4 | radius.sm |
| _indicators round outline | strokeWeight | 1 | stroke.thin |
| _indicators round outline/10 | fill[0] | #0c0d0e | foreground.primary |
| _indicators round outline/10 | fontSize | 14 | body.small.font size |
| _indicators round outline/10 | lineHeight | 18 | body.small.line height |
| _indicators round outline/10 | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | _indicators round outline | fill[0] | interactive.neutral.background.hover |
| State | hover | _indicators round outline | stroke[0] | interactive.neutral.border.hover |
| State | selected | _indicators round outline | fill[0] | interactive.inverse.background.selected |
| State | selected | _indicators round outline | stroke[0] | — |
| State | selected | _indicators round outline | strokeWeight | — |
| State | selected | _indicators round outline/10 | fill[0] | foreground.inverse |
| State | focused | _indicators round outline | stroke[0] | border.focus |
| State | focused | _indicators round outline | strokeWeight | stroke.thick |
| State | disabled | _indicators round outline | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _indicators round outline | stroke[0] | interactive.primary.border.disabled |
| State | disabled | _indicators round outline/10 | fill[0] | foreground.disabled |
| State | pressed | _indicators round outline | fill[0] | interactive.neutral.background.pressed |
| State | pressed | _indicators round outline | stroke[0] | border.default |

## _controls sharp no-outline

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4484-5928&m=dev

### Layer structure

- _controls sharp no-outline (COMPONENT)
  - _controls sharp no-outline/Icon (INSTANCE, icon: chevron_left)

### Resolved tokens (default variant: State=enabled, Outline=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _controls sharp no-outline | height | 36 | control.sm |
| _controls sharp no-outline | fill[0] | #ffffff | interactive.neutral.background.default |
| _controls sharp no-outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| _controls sharp no-outline | cornerRadius | 0 | radius.none |
| _controls sharp no-outline | strokeWeight | 0 | stroke.base |
| _controls sharp no-outline | padding.left | 8 | space.sm |
| _controls sharp no-outline | padding.right | 8 | space.sm |
| _controls sharp no-outline | padding.top | 8 | space.sm |
| _controls sharp no-outline | padding.bottom | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | pressed | _controls sharp no-outline | fill[0] | interactive.neutral.background.pressed |
| State | pressed | _controls sharp no-outline | stroke[0] | interactive.neutral.border.pressed |
| State | hover | _controls sharp no-outline | fill[0] | interactive.neutral.background.hover |
| State | focused | _controls sharp no-outline | stroke[0] | border.focus |
| State | focused | _controls sharp no-outline | strokeWeight | stroke.thick |
| State | disabled | _controls sharp no-outline | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _controls sharp no-outline | stroke[0] | interactive.neutral.border.disabled |

## _controls sharp outline

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4484-5969&m=dev

### Layer structure

- _controls sharp outline (COMPONENT)
  - _controls sharp outline/Icon (INSTANCE, icon: chevron_left)

### Resolved tokens (default variant: State=enabled, Outline=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _controls sharp outline | height | 36 | control.sm |
| _controls sharp outline | fill[0] | #ffffff | interactive.neutral.background.default |
| _controls sharp outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| _controls sharp outline | cornerRadius | 0 | radius.none |
| _controls sharp outline | strokeWeight | 1 | stroke.thin |
| _controls sharp outline | padding.left | 8 | space.sm |
| _controls sharp outline | padding.right | 8 | space.sm |
| _controls sharp outline | padding.top | 8 | space.sm |
| _controls sharp outline | padding.bottom | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | pressed | _controls sharp outline | fill[0] | interactive.neutral.background.pressed |
| State | pressed | _controls sharp outline | stroke[0] | interactive.neutral.border.pressed |
| State | hover | _controls sharp outline | fill[0] | interactive.neutral.background.hover |
| State | hover | _controls sharp outline | stroke[0] | interactive.neutral.border.hover |
| State | focused | _controls sharp outline | stroke[0] | border.focus |
| State | focused | _controls sharp outline | strokeWeight | stroke.thick |
| State | disabled | _controls sharp outline | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _controls sharp outline | stroke[0] | interactive.neutral.border.disabled |

## _controls round no-outline

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4485-1647&m=dev

### Layer structure

- _controls round no-outline (COMPONENT)
  - _controls round no-outline/Icon (INSTANCE, icon: chevron_left)

### Resolved tokens (default variant: State=enabled, Outline=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _controls round no-outline | height | 36 | control.sm |
| _controls round no-outline | fill[0] | #ffffff | interactive.neutral.background.default |
| _controls round no-outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| _controls round no-outline | cornerRadius | 4 | radius.sm |
| _controls round no-outline | strokeWeight | 0 | stroke.base |
| _controls round no-outline | padding.left | 8 | space.sm |
| _controls round no-outline | padding.right | 8 | space.sm |
| _controls round no-outline | padding.top | 8 | space.sm |
| _controls round no-outline | padding.bottom | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | pressed | _controls round no-outline | fill[0] | interactive.neutral.background.pressed |
| State | pressed | _controls round no-outline | stroke[0] | interactive.neutral.border.pressed |
| State | hover | _controls round no-outline | fill[0] | interactive.neutral.background.hover |
| State | focused | _controls round no-outline | stroke[0] | border.focus |
| State | focused | _controls round no-outline | strokeWeight | stroke.thick |
| State | disabled | _controls round no-outline | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _controls round no-outline | stroke[0] | interactive.neutral.border.disabled |

## _controls round outline

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4485-1658&m=dev

### Layer structure

- _controls round outline (COMPONENT)
  - _controls round outline/Icon (INSTANCE, icon: chevron_left)

### Resolved tokens (default variant: State=enabled, Outline=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _controls round outline | height | 36 | control.sm |
| _controls round outline | fill[0] | #ffffff | interactive.neutral.background.default |
| _controls round outline | stroke[0] | #ced2db | interactive.neutral.border.default |
| _controls round outline | cornerRadius | 4 | radius.sm |
| _controls round outline | strokeWeight | 1 | stroke.thin |
| _controls round outline | padding.left | 8 | space.sm |
| _controls round outline | padding.right | 8 | space.sm |
| _controls round outline | padding.top | 8 | space.sm |
| _controls round outline | padding.bottom | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | pressed | _controls round outline | fill[0] | interactive.neutral.background.pressed |
| State | pressed | _controls round outline | stroke[0] | interactive.neutral.border.pressed |
| State | hover | _controls round outline | fill[0] | interactive.neutral.background.hover |
| State | hover | _controls round outline | stroke[0] | interactive.neutral.border.hover |
| State | focused | _controls round outline | stroke[0] | border.focus |
| State | focused | _controls round outline | strokeWeight | stroke.thick |
| State | disabled | _controls round outline | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _controls round outline | stroke[0] | interactive.neutral.border.disabled |
