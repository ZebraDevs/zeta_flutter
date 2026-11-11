# Scrim

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=8221-400&m=dev

## Scrim

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=8223-374&m=dev

### Overview

The translucent barrier between a raised surface and the page behind it. Dialog, Lightbox and Bottom Sheet draw it under their panels: it dims everything behind, keeps the page from being read as interactive, and catches the click that dismisses. It is one fill stretched edge to edge — overlay/scrim — with an opaque modal tone (overlay/modal) for a full takeover. It has no content, no shape and no motion of its own; the owning component carries all three.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Tone | scrim | true | The translucent barrier — overlay/scrim, the fill every backdrop in the system uses. Content behind stays visible but reads as unavailable. |
| Tone | modal | - | The opaque takeover — overlay/modal, for the rare surface where the page behind must not show at all. It cannot serve as a see-through backdrop. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| shown | An overlay component opens | — | Appears with its owner — the scrim defines no timing of its own; the owner’s entry carries it. |
| pressed | Click or tap on the scrim | — | Dismisses the owner when the owner is dismissible. The scrim only forwards the event; it decides nothing itself. |
| hidden | The owner closes | — | Leaves with the owner; nothing lingers. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Ownership | The scrim belongs to the component it sits under. Dialog, Lightbox and Bottom Sheet draw it as their native backdrop bound to overlay/scrim — it is never placed by hand over a page, and a product never opens a bare scrim. |
| Stacking | One scrim per open surface, ordered by the native top layer. Never draw a second scrim to darken further: one overlay/scrim is the system’s entire dimming scale. |
| Dismissal | A click on the scrim closes the owner only when the owner allows it (dismissible); Escape is the keyboard parity, handled by the owner. The scrim never closes anything on its own. |
| Motion | None of its own. No motion token exists for a fade, and the owner’s entry carries the scrim with it — in code the backdrop simply appears with the dialog. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Content | none | A scrim carries nothing. Anything readable or interactive sits on the raised surface above it, never on the barrier itself. |

### Anatomy

1. **Barrier** — The whole component: one rectangle, fill bound to overlay/scrim (or overlay/modal), stretched over the owning surface’s viewport. No children, no stroke, no radius, no shadow — everything else on screen belongs to the surface above or the page below.

### How to use

**Do:**
- Let the owning component draw the scrim — Dialog, Lightbox and Bottom Sheet already do — so there is exactly one per open surface and it leaves when the surface does.
- Dim with the scrim tone. Reserve modal for a takeover where the page behind must not read at all — a first-run flow, not an everyday dialog.

**Don't:**
- Don’t stack scrims or darken one with an opacity override. One overlay/scrim is the system’s entire dimming scale, in every mode and extension.
- Don’t put text or controls on the scrim. It makes no contrast promise against what is behind it, so nothing on it is reliably readable.

### Accessibility & Content Guidelines

- The scrim is decorative: never focusable, never named — the owning dialog traps focus and makes the page behind inert.
- Dismissing by clicking the scrim always has keyboard parity: Escape on the owner.
- The scrim makes no contrast promise for the content behind it; nothing that must stay readable may rely on showing through.
- overlay/scrim and overlay/modal are semantic tokens, so the barrier holds its role in light, dark and every brand extension.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fills parent | Edge to edge over the owning surface’s viewport — the native backdrop in code, stretch constraints in a layout. Never a fixed size; the 640×400 variants are drawing surfaces. |
| Fill | Theming | overlay/scrim for the translucent tone, overlay/modal for the opaque takeover. Both semantic; nothing hardcodes a colour. |
| Radius | None | radius/none — the scrim has no shape of its own. |
| Elevation | None | No shadow. The raised surface above carries the elevation; the scrim is what it is raised above. |

### Layer structure

- Scrim (COMPONENT)

### Resolved tokens (default variant: Tone=scrim)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Scrim | fill[0] | #0c0d0e99 | overlay.scrim |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Tone | modal | Scrim | fill[0] | overlay.modal |
