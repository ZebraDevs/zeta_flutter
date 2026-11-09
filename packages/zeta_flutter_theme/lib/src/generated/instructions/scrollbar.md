# Scrollbar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6057-11947&m=dev

## Scrollbar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6068-12030&m=dev

### Overview

The scroll indicator for a region that clips its content. A padded gutter holds a pill handle whose position and length mirror the scroll offset; hovering raises a track scrim so the grab target reads. Two orientations draw the same bar on either axis, and the scrolling region, not the bar, owns the behaviour.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Orientation | vertical | true | The axis the region scrolls. Vertical stands against the trailing edge of the content and the handle slides up and down. |
| Orientation | horizontal | - | Lies along the bottom edge for content that pans sideways, as the Table's frozen arrangement uses it. |
| State | default | true | The resting bar. The track is invisible and the handle sits quiet, so the bar reads as part of the content's edge rather than a control. |
| State | hover | - | Pointer over the gutter. The track raises the ghost scrim and the handle darkens, which is what makes the grab target readable. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Resting | — | The handle draws in foreground/disabled over an invisible track. Only the colours are modelled; the handle's position and length come from the scrolling region. |
| hover | Pointer over the gutter | — | The track raises interactive/ghost/background/hover and the handle moves to foreground/secondary. No pressed or dragging treatment exists. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is authored. Whether the bar fades in with scroll activity and out when it stops belongs to the implementation. |
| Value | The handle's length is the viewport's share of the content and its offset mirrors the scroll position. The set draws one sample; nothing in it encodes a value. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Handle | fixed part | Not a slot. A pill that takes its length from the value and its colour from the state; there is no property to restyle or hide it per instance. |
| Track | fixed part | Not a slot. The full-length gutter behind the handle, invisible at rest and scrimmed on hover. |

### Anatomy

1. **Bar** — The component frame: a gutter holding the handle, padded space/2xs on every side so the handle floats clear of the content edge. It runs the full length of the scrolling region's edge.
2. **Track** — A rectangle filling the bar behind the handle, interactive/ghost/background/default at rest and the hover token under the pointer — the same ghost scrim the buttons use.
3. **Handle** — The pill that shows the position: radius/pill, foreground/disabled at rest and foreground/secondary on hover. Its length is a sample of the value, not a property.

### How to use

**Do:**
- Let the scrolling region own it. The bar reports position; wiring scroll, drag and keyboard belongs to the region that clips the content.
- Match Orientation to the overflow axis — vertical beside a scrolling list, horizontal under the Table's frozen columns.

**Don't:**
- Don't restyle the handle to look like a control. It has no focus state, so anything that invites clicking promises more than the set models.
- Don't rely on hover to reveal the bar. A touch screen never hovers, so the resting handle has to be visible on its own.

### Accessibility & Content Guidelines

- The set models no focus, pressed or dragging state, so keyboard scrolling and drag behaviour belong entirely to the implementation.
- The resting handle is foreground/disabled on the page surface. Check it stays visible against the surfaces the region scrolls over.
- Assistive technology reaches scrolling through the region, not the bar: expose the region and keep the bar presentational.
- Hover is the only state change and colour its only signal, so nothing here reaches someone who cannot see the bar move.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Thickness | Fixed | The gutter is 12 and the handle 4 as drawn, with neither bound to a token. The length runs the scrolling region's full edge. |
| Padding | Fixed | space/2xs on all four sides, which is what centres the handle in the gutter and keeps it clear of the content edge. |
| Radius | Fixed | radius/pill on the handle in every variant. The track has no radius of its own. |
| Handle length | Value | Drawn at a sample 64. In use the length is the viewport's share of the content and is never a property. |
| Fill | Theming | The handle is foreground/disabled at rest and foreground/secondary on hover. The track is interactive/ghost/background/default, rising to the hover token under the pointer. |
| Orientation | Per Orientation | vertical and horizontal swap the axes and nothing else: the same padding, colours and radius on both. |

### Layer structure

- Scrollbar (COMPONENT)
  - Scrollbar/Handle (RECTANGLE)
  - Scrollbar/Track (RECTANGLE)

### Resolved tokens (default variant: Orientation=vertical, State=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Scrollbar | padding.left | 4 | space.2xs |
| Scrollbar | padding.right | 4 | space.2xs |
| Scrollbar | padding.top | 4 | space.2xs |
| Scrollbar | padding.bottom | 4 | space.2xs |
| Scrollbar/Handle | fill[0] | #8d95a3 | foreground.disabled |
| Scrollbar/Handle | cornerRadius | 9999 | radius.pill |
| Scrollbar/Track | fill[0] | #0c0d0e00 | interactive.ghost.background.default |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Scrollbar/Handle | fill[0] | foreground.secondary |
| State | hover | Scrollbar/Track | fill[0] | interactive.ghost.background.hover |
