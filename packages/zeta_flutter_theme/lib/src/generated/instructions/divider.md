# Divider

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2152-8795&m=dev

## Divider

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2152-8803&m=dev

### Overview

A thin line used to visually separate content into distinct sections or groups, such as list rows, cards, or menu items. Orientation sets whether the line runs horizontal or vertical. It's a static, non-interactive element with no content of its own, choose the orientation that matches the layout direction it needs to divide.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Orientation | horizontal | true | Use to separate stacked content in a vertical layout, like rows in a list or sections on a page. |
| Orientation | vertical | - | Use to separate side-by-side content, like items in a horizontal row or a toolbar. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | Divider has no interactive states. Orientation is fixed at placement and never changes at runtime. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | None. Divider is a static visual element, it does not animate or transition between states or orientations. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Content | none | Divider has no content slots. It renders only the separator line and holds no text, icon, or nested elements. |

### Anatomy

1. **Line** — The only visible part. Renders as a horizontal or vertical stroke depending on Orientation, 1px thick (stroke/thin token)
2. **Length** — Resizes via constraints to fill the width (horizontal) or height (vertical) of its container. The default 320×1 / 1×40 size is a starting size, not a fixed limit
3. **Corner radius** — 0px on all corners (radius/none token), the same for both orientations

### How to use

**Do:**
- Choose Orientation to match the layout direction, horizontal to separate stacked content, vertical to separate side-by-side content.
- Resize the instance to fill its container rather than leaving it at the default 320×1 (or 1×40) size, the line stretches with the frame.

**Don't:**
- Don't use Divider as a spacing or margin mechanism, it's a visual line with no built-in padding, use layout gap for spacing between elements instead.

### Accessibility & Content Guidelines

- Non-interactive and not focusable, Divider carries no keyboard or focus behavior of its own
- In code, expose it with the platform's separator role (and an orientation attribute for the vertical variant) so assistive technology announces it correctly
- Uses the border/default semantic token for its color, which resolves separately for light and dark mode, don't override it with a hardcoded color

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Thickness | Fixed | 1px, bound to the stroke/thin token, the same for both orientations. |
| Length | Resizable | Not fixed. Constraints on the internal line stretch it to fill the available width (horizontal) or height (vertical) when the instance is resized. |
| Corner radius | Fixed | 0px, bound to the radius/none token, hard edges on both orientations. |
| Color | Theming | border/default token. Resolves to a light neutral gray in light mode and a darker neutral gray in dark mode, so it stays visible in both themes automatically. |

### Layer structure

- Divider (COMPONENT)
  - Divider/Horizontal (LINE)
  - Divider/Vertical (LINE)

### Resolved tokens (default variant: Orientation=horizontal)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Divider | height | 1 | stroke.thin |
| Divider | cornerRadius | 0 | radius.none |
| Divider/Horizontal | stroke[0] | #ced2db | border.default |
| Divider/Horizontal | strokeWeight | 1 | stroke.thin |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Orientation | vertical | Divider | height | — |
| Orientation | vertical | Divider | width | stroke.thin |
| Orientation | vertical | Divider/Horizontal | stroke[0] | — |
| Orientation | vertical | Divider/Horizontal | strokeWeight | — |
| Orientation | vertical | Divider/Vertical | stroke[0] | border.default |
| Orientation | vertical | Divider/Vertical | strokeWeight | stroke.thin |
