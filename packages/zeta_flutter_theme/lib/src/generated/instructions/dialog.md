# Dialog

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2526-316&m=dev

## Dialog

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2896-877&m=dev

### Overview

A modal message that interrupts the current task until the user responds or dismisses it. A header carries the message's flavour and title, a body holds the message itself, and an optional footer offers one to three action buttons or two custom slots. Turning showFooter off removes the footer, leaving an informational dialog with nothing to decide.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Flavour | default | true | The dialog's neutral baseline, with no severity implied. Use it for confirmations and other messages that are not warning the user about anything. |
| Flavour | error | - | The header icon switches to the error glyph. Use it only when the message reports something that failed or blocks the user from continuing, not for a milder warning. |
| Flavour | info | - | The header icon switches to the info glyph. Use it for a message the user should read but that needs no decision or urgency attached to it. |
| Flavour | success | - | The header icon switches to the success glyph. Use it to confirm that an action already completed, not to ask the user to confirm one. |
| Flavour | warning | - | The header icon switches to the warning glyph. Use it when the user can still proceed but should be made aware of a consequence first. |
| Shape | round | true | Matches the surrounding surface and its other rounded controls. Also sets the shape of every button in the footer, the two cannot be mixed within one dialog. |
| Shape | sharp | - | Matches a square surface. Carries through to the footer’s action buttons as well. |
| showFooter | true | true | Shows the footer and its action buttons. |
| showFooter | false | - | Removes the footer entirely, the dialog hugs to the header and body alone. Use it only for a message with nothing for the user to decide. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined for the dialog's own header, body or footer arrangement across any of its variants. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Header | Dialog Header instance | Fixed to a single Header instance in every variant, holding a leading icon, the title and a close icon. Both the icon and the close icon are always shown, Dialog does not expose either as a property. The leading icon's glyph changes with Flavour, set directly by Dialog rather than through an exposed binding. |
| Body | Any content | Holds whatever content the message needs to show, with no fixed type or structure of its own in this file. |
| Footer | Dialog Footer instance | Fixed to a single Footer instance, hidden entirely when showFooter is off. Every variant uses the same three button layout, a Tertiary action on one side and a Secondary and Primary pair on the other. Which layout shows is fixed by Dialog, not an exposed property. |

### Anatomy

1. **Header** — A single Dialog Header instance, fixed in every variant. Holds the leading icon, the title and the close icon.
2. **Body** — An open content area with no fixed structure of its own in this file.
3. **Footer** — A single Dialog Footer instance, hidden entirely when showFooter is off.
4. **Outer padding** — 12px on every side of the dialog itself, independent of each section’s own padding.

### How to use

**Do:**
- Keep the footer to one clear action when only one response is needed. The Actions preset for one button exists for exactly this case.
- Turn showFooter off only for a message the user reads with nothing to decide. The footer is removed entirely, not replaced with an empty bar.

**Don't:**
- Don't rely on Flavour to recolour anything beyond the header icon. Every value binds that icon to the same colour token, so the body and the footer's buttons need their own styling if the message calls for it.
- Don't use the custom Actions value for a plain one, two or three button footer. The fixed presets already set each button's role and position, the custom slots exist for content that does not fit them.

### Accessibility & Content Guidelines

- The dialog's own header, body and footer carry no keyboard or focus behaviour beyond what the close icon and the footer's buttons already define on their own. Nothing in this file marks how the dialog traps focus or returns it when it closes, so that behaviour needs confirming outside Figma.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Hug | Hugs its content rather than holding a fixed width. 506px with the default content, from 12px padding on each side plus the 480px wide header, body and footer. |
| Height | Hug | Hugs the stack of header, body and footer with no gap between them. Shrinks by the footer’s own height, 64px, when showFooter is off. |
| Padding | Fixed | 12px on every side of the dialog itself. The header, body and footer sit flush against each other inside it. |
| Header padding and gap | Fixed | 12px on every side, 8px between the leading icon, title and close icon. |
| Body padding | Fixed | 12px on three sides and 24px at the bottom, wider than the others to keep the footer’s buttons clear of the last line of content. |
| Footer | Fixed width, fixed padding | Holds its own width fixed at 480px rather than hugging, with 12px padding on every side. Its content is pushed to the two opposite ends rather than spaced evenly. |
| Radius | Fixed per Shape | 0 for sharp, 6px for round. Chosen per dialog rather than inherited, and it sets the corner radius of every button in the footer as well. |
| Header icon colour | Fixed | Every Flavour value binds the leading icon to the same foreground/primary token. Flavour changes which glyph shows, never its colour. |

### Layer structure

- Dialog (COMPONENT)
  - Dialog/_Dialog Header (INSTANCE)
  - Dialog/Dialog Body (FRAME)
    - Dialog/Dialog Body/Content (FRAME)
      - Dialog/Dialog Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. (TEXT)
  - Dialog/_Dialog Footer (INSTANCE)

### Resolved tokens (default variant: Flavour=default, Shape=round)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Dialog | fill[0] | #ffffff | surface.dialog |
| Dialog | stroke[0] | #ced2db | border.default |
| Dialog | cornerRadius | 6 | radius.element-md |
| Dialog | strokeWeight | 1 | stroke.thin |
| Dialog | padding.left | 12 | space.md |
| Dialog | padding.right | 12 | space.md |
| Dialog | padding.top | 12 | space.md |
| Dialog | padding.bottom | 12 | space.md |
| Dialog/_Dialog Header | height | 48 | control.lg |
| Dialog/_Dialog Header | cornerRadius | 0 | radius.none |
| Dialog/_Dialog Header | itemSpacing | 8 | space.sm |
| Dialog/_Dialog Header | padding.left | 12 | space.md |
| Dialog/_Dialog Header | padding.right | 12 | space.md |
| Dialog/_Dialog Header | padding.top | 12 | space.md |
| Dialog/_Dialog Header | padding.bottom | 12 | space.md |
| Dialog/Dialog Body | cornerRadius | 0 | radius.none |
| Dialog/Dialog Body | padding.left | 12 | space.md |
| Dialog/Dialog Body | padding.right | 12 | space.md |
| Dialog/Dialog Body | padding.top | 12 | space.md |
| Dialog/Dialog Body | padding.bottom | 24 | space.section |
| Dialog/Dialog Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. | fill[0] | #0c0d0e | foreground.primary |
| Dialog/Dialog Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. | fontSize | 16 | body.medium.font size |
| Dialog/Dialog Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. | lineHeight | 24 | body.medium.line height |
| Dialog/Dialog Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. | letterSpacing | 0 | body.medium.letter spacing |
| Dialog/_Dialog Footer | itemSpacing | 159 | — |
| Dialog/_Dialog Footer | padding.left | 12 | space.md |
| Dialog/_Dialog Footer | padding.right | 12 | space.md |
| Dialog/_Dialog Footer | padding.top | 12 | space.md |
| Dialog/_Dialog Footer | padding.bottom | 12 | space.md |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | sharp | Dialog | cornerRadius | radius.none |

## _Dialog Header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2644-3298&m=dev

### Layer structure

- _Dialog Header (COMPONENT)
  - _Dialog Header/Title (FRAME)
    - _Dialog Header/Title/Block (INSTANCE)
    - _Dialog Header/Title/Dialog Title (TEXT)
  - _Dialog Header/Icon (INSTANCE, icon: close)

### Resolved tokens (default variant: _Dialog Header)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Dialog Header | height | 48 | control.lg |
| _Dialog Header | cornerRadius | 0 | radius.none |
| _Dialog Header | itemSpacing | 8 | space.sm |
| _Dialog Header | padding.left | 12 | space.md |
| _Dialog Header | padding.right | 12 | space.md |
| _Dialog Header | padding.top | 12 | space.md |
| _Dialog Header | padding.bottom | 12 | space.md |
| _Dialog Header/Title | itemSpacing | 8 | space.sm |
| _Dialog Header/Title/Dialog Title | fill[0] | #0c0d0e | foreground.primary |
| _Dialog Header/Title/Dialog Title | fontSize | 20 | title.large.font size |
| _Dialog Header/Title/Dialog Title | lineHeight | 24 | title.large.line height |
| _Dialog Header/Title/Dialog Title | letterSpacing | 0 | title.large.letter spacing |

## _Dialog Footer

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2644-3185&m=dev

### Layer structure

- _Dialog Footer (COMPONENT)
  - _Dialog Footer/Tertiary (INSTANCE)
  - _Dialog Footer/Right Button Group (FRAME)
    - _Dialog Footer/Right Button Group/Secondary (INSTANCE)
    - _Dialog Footer/Right Button Group/Primary (INSTANCE)
  - _Dialog Footer/Secondary (INSTANCE)
  - _Dialog Footer/Primary (INSTANCE)
  - _Dialog Footer/Left Action (SLOT)
  - _Dialog Footer/Right Action (SLOT)

### Resolved tokens (default variant: Actions=3)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Dialog Footer | itemSpacing | 159 | — |
| _Dialog Footer | padding.left | 12 | space.md |
| _Dialog Footer | padding.right | 12 | space.md |
| _Dialog Footer | padding.top | 12 | space.md |
| _Dialog Footer | padding.bottom | 12 | space.md |
| _Dialog Footer/Tertiary | height | 40 | control.md |
| _Dialog Footer/Tertiary | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Dialog Footer/Tertiary | stroke[0] | #1f69ff | interactive.ghost.border.default |
| _Dialog Footer/Tertiary | cornerRadius | 4 | radius.element-sm |
| _Dialog Footer/Tertiary | strokeWeight | 0 | stroke.base |
| _Dialog Footer/Tertiary | padding.left | 12 | space.md |
| _Dialog Footer/Tertiary | padding.right | 12 | space.md |
| _Dialog Footer/Tertiary | padding.top | 4 | space.xxs |
| _Dialog Footer/Tertiary | padding.bottom | 4 | space.xxs |
| _Dialog Footer/Right Button Group | itemSpacing | 8 | space.sm |
| _Dialog Footer/Right Button Group/Secondary | height | 40 | control.md |
| _Dialog Footer/Right Button Group/Secondary | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Dialog Footer/Right Button Group/Secondary | stroke[0] | #ced2db | interactive.neutral.border.default |
| _Dialog Footer/Right Button Group/Secondary | cornerRadius | 4 | radius.element-sm |
| _Dialog Footer/Right Button Group/Secondary | strokeWeight | 1 | stroke.thin |
| _Dialog Footer/Right Button Group/Secondary | padding.left | 12 | space.md |
| _Dialog Footer/Right Button Group/Secondary | padding.right | 12 | space.md |
| _Dialog Footer/Right Button Group/Secondary | padding.top | 4 | space.xxs |
| _Dialog Footer/Right Button Group/Secondary | padding.bottom | 4 | space.xxs |
| _Dialog Footer/Right Button Group/Primary | height | 40 | control.md |
| _Dialog Footer/Right Button Group/Primary | fill[0] | #1f69ff | interactive.primary.background.default |
| _Dialog Footer/Right Button Group/Primary | stroke[0] | #1f69ff | interactive.primary.border.default |
| _Dialog Footer/Right Button Group/Primary | cornerRadius | 4 | radius.element-sm |
| _Dialog Footer/Right Button Group/Primary | strokeWeight | 0 | stroke.base |
| _Dialog Footer/Right Button Group/Primary | padding.left | 12 | space.md |
| _Dialog Footer/Right Button Group/Primary | padding.right | 12 | space.md |
| _Dialog Footer/Right Button Group/Primary | padding.top | 4 | space.xxs |
| _Dialog Footer/Right Button Group/Primary | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Actions | 2 | _Dialog Footer | itemSpacing | space.sm |
| Actions | 2 | _Dialog Footer | cornerRadius | radius.none |
| Actions | 2 | _Dialog Footer/Tertiary | height | — |
| Actions | 2 | _Dialog Footer/Tertiary | fill[0] | — |
| Actions | 2 | _Dialog Footer/Tertiary | stroke[0] | — |
| Actions | 2 | _Dialog Footer/Tertiary | cornerRadius | — |
| Actions | 2 | _Dialog Footer/Tertiary | strokeWeight | — |
| Actions | 2 | _Dialog Footer/Tertiary | padding.left | — |
| Actions | 2 | _Dialog Footer/Tertiary | padding.right | — |
| Actions | 2 | _Dialog Footer/Tertiary | padding.top | — |
| Actions | 2 | _Dialog Footer/Tertiary | padding.bottom | — |
| Actions | 2 | _Dialog Footer/Right Button Group | itemSpacing | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | height | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | fill[0] | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | stroke[0] | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | cornerRadius | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | strokeWeight | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | padding.left | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | padding.right | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | padding.top | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Secondary | padding.bottom | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | height | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | fill[0] | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | stroke[0] | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | cornerRadius | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | strokeWeight | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | padding.left | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | padding.right | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | padding.top | — |
| Actions | 2 | _Dialog Footer/Right Button Group/Primary | padding.bottom | — |
| Actions | 2 | _Dialog Footer/Secondary | height | control.md |
| Actions | 2 | _Dialog Footer/Secondary | fill[0] | interactive.ghost.background.default |
| Actions | 2 | _Dialog Footer/Secondary | stroke[0] | interactive.neutral.border.default |
| Actions | 2 | _Dialog Footer/Secondary | cornerRadius | radius.element-sm |
| Actions | 2 | _Dialog Footer/Secondary | strokeWeight | stroke.thin |
| Actions | 2 | _Dialog Footer/Secondary | padding.left | space.md |
| Actions | 2 | _Dialog Footer/Secondary | padding.right | space.md |
| Actions | 2 | _Dialog Footer/Secondary | padding.top | space.xxs |
| Actions | 2 | _Dialog Footer/Secondary | padding.bottom | space.xxs |
| Actions | 2 | _Dialog Footer/Primary | height | control.md |
| Actions | 2 | _Dialog Footer/Primary | fill[0] | interactive.primary.background.default |
| Actions | 2 | _Dialog Footer/Primary | stroke[0] | interactive.primary.border.default |
| Actions | 2 | _Dialog Footer/Primary | cornerRadius | radius.element-sm |
| Actions | 2 | _Dialog Footer/Primary | strokeWeight | stroke.base |
| Actions | 2 | _Dialog Footer/Primary | padding.left | space.md |
| Actions | 2 | _Dialog Footer/Primary | padding.right | space.md |
| Actions | 2 | _Dialog Footer/Primary | padding.top | space.xxs |
| Actions | 2 | _Dialog Footer/Primary | padding.bottom | space.xxs |
| Actions | 1 | _Dialog Footer | itemSpacing | space.sm |
| Actions | 1 | _Dialog Footer | cornerRadius | radius.none |
| Actions | 1 | _Dialog Footer/Tertiary | height | — |
| Actions | 1 | _Dialog Footer/Tertiary | fill[0] | — |
| Actions | 1 | _Dialog Footer/Tertiary | stroke[0] | — |
| Actions | 1 | _Dialog Footer/Tertiary | cornerRadius | — |
| Actions | 1 | _Dialog Footer/Tertiary | strokeWeight | — |
| Actions | 1 | _Dialog Footer/Tertiary | padding.left | — |
| Actions | 1 | _Dialog Footer/Tertiary | padding.right | — |
| Actions | 1 | _Dialog Footer/Tertiary | padding.top | — |
| Actions | 1 | _Dialog Footer/Tertiary | padding.bottom | — |
| Actions | 1 | _Dialog Footer/Right Button Group | itemSpacing | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | height | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | fill[0] | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | stroke[0] | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | cornerRadius | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | strokeWeight | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | padding.left | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | padding.right | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | padding.top | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Secondary | padding.bottom | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | height | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | fill[0] | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | stroke[0] | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | cornerRadius | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | strokeWeight | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | padding.left | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | padding.right | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | padding.top | — |
| Actions | 1 | _Dialog Footer/Right Button Group/Primary | padding.bottom | — |
| Actions | 1 | _Dialog Footer/Primary | height | control.md |
| Actions | 1 | _Dialog Footer/Primary | fill[0] | interactive.primary.background.default |
| Actions | 1 | _Dialog Footer/Primary | stroke[0] | interactive.primary.border.default |
| Actions | 1 | _Dialog Footer/Primary | cornerRadius | radius.element-sm |
| Actions | 1 | _Dialog Footer/Primary | strokeWeight | stroke.base |
| Actions | 1 | _Dialog Footer/Primary | padding.left | space.md |
| Actions | 1 | _Dialog Footer/Primary | padding.right | space.md |
| Actions | 1 | _Dialog Footer/Primary | padding.top | space.xxs |
| Actions | 1 | _Dialog Footer/Primary | padding.bottom | space.xxs |
| Actions | custom | _Dialog Footer | cornerRadius | radius.none |
| Actions | custom | _Dialog Footer/Tertiary | height | — |
| Actions | custom | _Dialog Footer/Tertiary | fill[0] | — |
| Actions | custom | _Dialog Footer/Tertiary | stroke[0] | — |
| Actions | custom | _Dialog Footer/Tertiary | cornerRadius | — |
| Actions | custom | _Dialog Footer/Tertiary | strokeWeight | — |
| Actions | custom | _Dialog Footer/Tertiary | padding.left | — |
| Actions | custom | _Dialog Footer/Tertiary | padding.right | — |
| Actions | custom | _Dialog Footer/Tertiary | padding.top | — |
| Actions | custom | _Dialog Footer/Tertiary | padding.bottom | — |
| Actions | custom | _Dialog Footer/Right Button Group | itemSpacing | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | height | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | fill[0] | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | stroke[0] | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | cornerRadius | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | strokeWeight | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | padding.left | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | padding.right | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | padding.top | — |
| Actions | custom | _Dialog Footer/Right Button Group/Secondary | padding.bottom | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | height | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | fill[0] | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | stroke[0] | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | cornerRadius | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | strokeWeight | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | padding.left | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | padding.right | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | padding.top | — |
| Actions | custom | _Dialog Footer/Right Button Group/Primary | padding.bottom | — |
| Actions | custom | _Dialog Footer/Left Action | itemSpacing | space.sm |
| Actions | custom | _Dialog Footer/Right Action | itemSpacing | space.sm |
