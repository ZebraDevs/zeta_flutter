# Tooltip

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5470-1664&m=dev

## Tooltip

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5508-57&m=dev

### Overview

A short floating message that names what an adjacent control does. Point decides which edge the arrow sits on, which is how the bubble anchors to its trigger from any of four sides. It holds one run of text and nothing else, so for status that stays on screen and sits inline, reach for Status Label instead.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Label | text | Label | The whole message. Name the control's action in a few words. A tooltip that needs a full sentence is usually carrying information that belongs in the interface itself rather than in a transient hint. |
| Point | bottom | true | Picks the edge the arrow sits on, which is the edge facing the trigger, so bottom puts the bubble above the thing it describes. The right choice wherever there is clear space above the trigger. |
| Point | top | - | Puts the bubble below its trigger. Use where the trigger sits near the top of its container and a bubble above it would be cut off. |
| Point | left | - | Puts the bubble to the right of its trigger. Use in a vertical list or rail, where going above or below would cover the neighbouring rows. |
| Point | right | - | Puts the bubble to the left of its trigger. The mirror of left, for a control sitting against the right edge of its container. |
| Shape | rounded | true | Follow the contour the surrounding controls already use rather than deciding per tooltip. Mixing both contours on one screen reads as a mistake rather than a distinction. |
| Shape | sharp | - | The square-cornered pairing, for surfaces built from sharp controls. It changes the arrow tip as well as the corners, so the bubble stays internally consistent either way. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The set carries no hover, focus, pressed or disabled axis. All eight variants render the same way, and the only differences between them are which edge the arrow sits on and which contour the corners take. |
| Shown or hidden | Owned by the trigger | — | Nothing in the set models appearing or disappearing. A tooltip is either placed or it is not, so whatever reveals and dismisses it lives outside this component. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Code only: fades in while sliding toward its trigger (from the side away from the tip), and fades out, on animations/smooth. No motion under reduced motion. |
| Placement | Point names the edge the arrow sits on, but nothing in the set positions the bubble against a real trigger. Choosing a variant states the intended side, and the actual anchoring has to be done wherever the tooltip is placed. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | The only content the set exposes, and plain text at that. There is no instance-swap slot anywhere in the component, so an icon cannot be placed beside the text or in place of it without detaching the instance. |
| Pointer | fixed part | Not a slot. Which edge it sits on and which tip it takes both follow the variant, and there is no property to hide it or move it from an instance. |

### Anatomy

1. **Bubble** — The component frame itself. A horizontal auto-layout that hugs the label and carries the fill, the corner radius and the shadow.
2. **Label** — The one text property, centred on both axes inside the padding. A single run of text with nothing else allowed beside it.
3. **Pointer** — A vector drawn outside the frame's bounds rather than inside them. Which edge it sits on and which tip it takes both come from the variant.

### How to use

**Do:**
- Write the label as a short action phrase. A tooltip earns its place by naming the control, not by describing it.
- Pick Point from where the trigger actually sits. The arrow is the only thing tying the bubble to its control, so the wrong edge breaks the connection.

**Don't:**
- Don't mix rounded and sharp across one screen. The contour belongs to the surface the tooltip opens over, not to the individual hint.
- Don't rely on it as the only description of a control. It carries no focus state, so anyone who never hovers never gets the message.

### Accessibility & Content Guidelines

- The set models no focus state, so the keyboard path to whatever reveals the tooltip has to be built in code.
- A tooltip that is the only description of a control is unreachable for anyone who never hovers. Give the control its own accessible name as well.
- The bubble is surface/inverse carrying foreground/inverse text. Check that pairing still clears contrast against whatever surface it floats above.
- Content is one run of text with no wrapping authored, so a long label becomes a layout problem before it becomes a reading problem.
- Nothing here times out or dismisses itself. Persistence and dismissal both belong to the implementation.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug both axes | The bubble hugs its label on both axes, so the width follows the text. At the default Label it measures 46 by 24, and the height holds at 24 because one 16px line sits inside 4px of vertical padding. |
| Padding | Fixed | space/xs top and bottom, space/sm left and right. Identical across all eight variants. |
| Radius | Per Shape | radius/sm on rounded and radius/none on sharp, bound on all four corners. Both are tokens, so the value follows the theme and only the choice between them is made per instance. |
| Pointer | Fixed, absolute | Absolutely positioned, centred on its edge and drawn outside the bubble, which is why the component does not clip its contents. 8 by 4 on top and bottom, 4 by 8 on left and right. The rounded tips measure 3.586 on the pointing axis rather than 4, because the curve stops short of the point the sharp triangle reaches. |
| Fill | Theming | surface/inverse on the bubble and on the pointer, so the two read as one shape. The label is foreground/inverse. |
| Type | Theming | label/small, which is IBM Plex Sans Medium at 12 over a 16px line. Bound to the label/small typography variables as well as the text style, so it follows the responsive modes. |
| Elevation | Fixed | Shadow/medium on every variant, a two-layer drop shadow whose colour, blur and offsets are all bound to tokens. |

### Layer structure

- Tooltip (COMPONENT)
  - Tooltip/Label (TEXT)
  - Tooltip/Pointer (VECTOR)

### Resolved tokens (default variant: Point=bottom, Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Tooltip | fill[0] | #1d1e23 | surface.inverse |
| Tooltip | cornerRadius | 4 | radius.sm |
| Tooltip | padding.left | 8 | space.sm |
| Tooltip | padding.right | 8 | space.sm |
| Tooltip | padding.top | 4 | space.xxs |
| Tooltip | padding.bottom | 4 | space.xxs |
| Tooltip/Label | fill[0] | #ffffff | foreground.inverse |
| Tooltip/Label | fontSize | 12 | label.small.font size |
| Tooltip/Label | lineHeight | 16 | label.small.line height |
| Tooltip/Label | letterSpacing | 0 | label.small.letter spacing |
| Tooltip/Pointer | fill[0] | #1d1e23 | surface.inverse |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | sharp | Tooltip | cornerRadius | radius.none |
