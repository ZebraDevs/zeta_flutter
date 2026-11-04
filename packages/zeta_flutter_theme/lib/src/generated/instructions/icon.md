# Icon

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2046-15004&m=dev

## Icon

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2046-15010&m=dev

### Overview

Wraps a single glyph from the icon library so it can be sized consistently and embedded in other components. Three sizes, plus an optional box that pads the glyph to a 40px touch target. Button, Icon Button, Dropdown, Search, Avatar, Top App Bar, Navigation Bar and Navigation Rail all embed it, and almost every one of them locks Size and Framed, leaving the glyph as the only decision. On its own it is decorative, the meaning has to come from somewhere else.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Name | instance swap | Verified | The glyph itself, swapped from the icon library. This is the one property most embedding components leave open, so it is usually the only decision left to make. It arrives set to Verified, which is the right answer for almost nothing. |
| Size | small | true | 16px. The dense step, and what Button and Icon Button use at their own small size. |
| Size | medium | - | 20px. The most widely used step in the file, and what Button and Icon Button use at both medium and large. |
| Size | large | - | 28px. Used by exactly one component in this file, Navigation Header. Use it only where the icon is genuinely the focal point. |
| Framed | false | true | The frame hugs the glyph exactly, so the component takes up only the glyph's own box. Correct whenever the parent already provides padding or a target area, which is nearly always. |
| Framed | true | - | Pads the glyph to a fixed 40px box so it meets the minimum touch target on its own. It adds space and nothing visible, so it suits a standalone tappable icon and is wrong inside a control that is already sized. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | Icon has no interaction states of its own. It takes its colour from whatever embeds it, so hover, pressed, focus and disabled are all rendered by the parent. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | None modelled in Figma. Icon is a static graphic, and any transition belongs to the component that embeds it. |
| Colour | Not set here. The glyph inherits the foreground token of its parent, which is why the same Icon reads light on a filled button and accent-coloured on an outline one. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Name | instance swap, icon library | Any glyph from the library the property points at, and the only content this component carries. |
| Glyph colour | inherited, not a property | The glyph follows the parent's foreground token. Recolour the parent rather than overriding the vector here, or the parent's states will stop working. |

### Anatomy

1. **Frame** — The component's own box. With Framed off it hugs the glyph exactly, with Framed on it becomes a fixed 40px square with the glyph centred.
2. **Glyph** — The swapped icon instance. Carries the artwork and takes its colour from the parent that embeds it.

### How to use

**Do:**
- Set the glyph deliberately every time. The component arrives holding Verified, which is the right answer for almost nothing.
- Turn Framed on only where the icon is tappable on its own. Inside a button or a menu row the parent already provides the target.

**Don't:**
- Don't override the glyph's colour on the instance. It inherits from the parent, and overriding it breaks every state the parent renders.
- Don't rely on an icon alone to carry meaning. It has no text of its own, so pair it with a visible label or give it an accessible name in code.

### Accessibility & Content Guidelines

- Icon carries no text. Anything it communicates has to be repeated in a visible label or an accessible name in code.
- Framed pads the glyph to 40px (control/target-min), the minimum tappable size. A bare 16px or 20px icon is not a target on its own.
- The glyph inherits its parent's foreground colour, so contrast is a property of the surface it lands on rather than of this component.
- There are no interaction states here. Focus and disabled treatments come from the embedding component.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed per Size | 16px at small, 20px at medium, 28px at large, always square. |
| Framed box | Fixed | 40px square when Framed is true, bound to control/target-min, at every Size. The glyph keeps its own size and is centred inside. |
| Padding | None | Zero on every variant. With Framed off the frame hugs the glyph, with Framed on the space comes from centring inside the fixed box rather than from padding. |
| Fill and radius | None | The framed box has no fill and no corner radius, so Framed adds room and nothing visible. |
| Colour | Inherited | Not bound on this component. The glyph takes the foreground token of whatever embeds it. |

### Layer structure

- Icon (COMPONENT)
  - Icon/Verified (INSTANCE)

### Resolved tokens (default variant: Size=small, Framed=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | xsmall | Icon | width | control.icon-xs |
| Size | xsmall | Icon | height | control.icon-xs |
| Framed | true | Icon | height | control.target-min |
| Framed | true | Icon/Verified | width | control.icon-sm |
| Framed | true | Icon/Verified | height | control.icon-sm |
