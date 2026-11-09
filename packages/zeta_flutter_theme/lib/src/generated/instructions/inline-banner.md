# inline Banner

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=8051-4995&m=dev

## Inline Banner

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=8053-85&m=dev

### Overview

A status message placed inside the content it is about: a form, a card, a panel. It sits in the flow at its container's width. Status sets the colour and glyph; Appearance sets how loud it is. Solid interrupts, for the one message on a view that must be seen now. Subtle informs, for context and guidance, and several can share a page.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Status | info | true | News that helps the reader, with nothing at stake. |
| Status | neutral | - | General guidance or a tip, with no status attached. |
| Status | positive | - | Something finished as intended. Confirm it, then let it go. |
| Status | warning | - | A problem the person can still act on, or a limit on what they can do now. |
| Status | negative | - | A failure that needs attention. Announced immediately. |
| Appearance | subtle | true | Tinted surface, status border, status glyph. Informs without interrupting; several can share a page. |
| Appearance | solid | - | Strong status fill, always-white text. Interrupts: one per view, for what must be seen now. |
| Shape | rounded | true | radius/sm corners. The actions and the dismiss take the same shape. |
| Shape | sharp | - | radius/none corners, for edge-to-edge containers. The actions and the dismiss follow. |
| Title | text | Inline banner title | The headline: what happened. |
| Description | text | Supporting line: why, and what to do next. | Why, and what to do next. Shown by Show Description. |
| Show Description | true | true | Shows the supporting line when one is set. |
| Show Description | false | - | Title only, for messages that need no reason. |
| Show Icon | true | true | Keeps the status glyph so the banner survives greyscale. |
| Show Icon | false | - | Drops the glyph. The text must then name the status. |
| Show Actions | true | true | Shows the action slot when it holds actions. |
| Show Actions | false | - | No actions, for a message that only informs. |
| Show Close | false | true | No dismiss. The banner stays while its condition holds. |
| Show Close | true | - | Adds the dismiss. Pressing it reports the dismissal; the product removes the banner. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | No interaction states of its own. Hover, focus and pressed live on the action Button and the dismiss Icon Button. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | None. It appears and disappears with the content it sits in. There is no motion token; add one before animating it. |
| Reflow | Fills its container's width; height follows the content. The text keeps a minimum width, and the actions wrap beneath it when the container is narrower. That minimum has no size token yet. See the narrow sample under Anatomy. |
| Dismissal | The component offers the control and reports the dismissal. Removing the banner, and whether it comes back, is the product's decision. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Title | text, exposed | The headline, set through the Title input. |
| Description | text, exposed | The supporting line, set through the Description input and shown by Show Description. |
| Action Slot | slot | Holds the controls the message needs, normally one small Button: outline-subtle on subtle, outline-contrast on solid. The banner passes its Shape to them. |
| Status Icon | icon, parent-owned | Follows Status: Lightbulb, Info, Check Circle, Warning, Error. A product can override the glyph. |
| Dismiss | Icon Button | A small subtle Icon Button, switched by Show Close. Available on every status. |
| Action Button | nested instance | Sample content for the slot, not part of the API. On solid it sits in palette Dark so it draws white. That is Figma-only: code gives the controls a dark-mode scope. |

### Anatomy

1. **Status glyph** — Leading icon centred on the title's first line. Status colour on subtle, foreground/on-strong on solid.
2. **Content** — Title and optional description. Takes the width the glyph and the dismiss leave.
3. **Action slot** — Beside the text when there is room, beneath it when the container is narrow.
4. **Dismiss** — Optional close control at the trailing edge, on every status.

### How to use

**Do:**
- Use solid for the one message on a view that blocks or changes what the person can do. Make everything else subtle.
- Place it next to what it is about: above the form, inside the card, at the top of the panel.

**Don't:**
- Don't stack several solid banners. They compete, and the page reads as an alarm.
- Don't use it for page-wide or system news. That is System Banner, pinned to the top of the view.

### Accessibility & Content Guidelines

- Announced politely; negative is announced immediately.
- Keep the glyph on, or name the status in the text, so colour is never the only signal.
- The action and the dismiss carry their own focus states.
- Known gap: foreground/on-strong falls below 4.5:1 on solid neutral (both modes) and solid warning (dark mode).

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fill width, hug height | Spans its container. The 640 width in Figma is a preview only. |
| Padding | Fixed | space/md block, space/lg inline. |
| Gap | Fixed | space/sm between glyph, content and dismiss. space/lg between text and actions, space/sm when they wrap. space/2xs between title and description. |
| Radius | Shape | radius/sm on rounded, radius/none on sharp. Border stroke/thin on both appearances. |
| Colour | Theming | Subtle: feedback/<status>/background/subtle fill, border/<status> border (border/default on neutral), feedback/<status>/foreground glyph, foreground/primary text. Solid: feedback/<status>/background/strong fill and border, foreground/on-strong text and glyph. positive maps to success, negative to error. |
| Typography | Fixed | Title label/large, description body/small. |
| Status glyph | Fixed | A medium Icon centred in a box as tall as label/large's line height. |
| Dismiss control | Fixed | A small subtle Icon Button at the trailing edge. |

### Layer structure

- Inline Banner (COMPONENT)
  - Inline Banner/Container (FRAME)
    - Inline Banner/Container/Icon Container (FRAME)
      - Inline Banner/Container/Icon Container/Status Icon (INSTANCE, icon: info)
    - Inline Banner/Container/Content (FRAME)
      - Inline Banner/Container/Content/Text (FRAME)
        - Inline Banner/Container/Content/Text/Title (TEXT)
        - Inline Banner/Container/Content/Text/Description (TEXT)
      - Inline Banner/Container/Content/Action Slot (SLOT)
    - Inline Banner/Container/Dismiss (INSTANCE)

### Resolved tokens (default variant: Status=info, Appearance=subtle, Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Inline Banner | fill[0] | #f1f8ff | feedback.info.background.subtle |
| Inline Banner | stroke[0] | #0073e6 | border.info |
| Inline Banner | cornerRadius | 4 | radius.sm |
| Inline Banner | strokeWeight | 1 | stroke.thin |
| Inline Banner/Container | padding.left | 6 | space.xs |
| Inline Banner/Container | padding.right | 6 | space.xs |
| Inline Banner/Container | padding.top | 6 | space.xs |
| Inline Banner/Container | padding.bottom | 6 | space.xs |
| Inline Banner/Container/Icon Container | padding.left | 6 | space.xs |
| Inline Banner/Container/Icon Container | padding.right | 6 | space.xs |
| Inline Banner/Container/Icon Container | padding.top | 8 | space.sm |
| Inline Banner/Container/Icon Container | padding.bottom | 8 | space.sm |
| Inline Banner/Container/Content | itemSpacing | 16 | space.lg |
| Inline Banner/Container/Content | padding.left | 6 | space.xs |
| Inline Banner/Container/Content | padding.right | 6 | space.xs |
| Inline Banner/Container/Content | padding.top | 6 | space.xs |
| Inline Banner/Container/Content | padding.bottom | 6 | space.xs |
| Inline Banner/Container/Content/Text | itemSpacing | 4 | space.2xs |
| Inline Banner/Container/Content/Text/Title | fill[0] | #0c0d0e | foreground.primary |
| Inline Banner/Container/Content/Text/Title | fontSize | 16 | label.large.font size |
| Inline Banner/Container/Content/Text/Title | lineHeight | 24 | label.large.line height |
| Inline Banner/Container/Content/Text/Title | letterSpacing | 0 | label.large.letter spacing |
| Inline Banner/Container/Content/Text/Description | fill[0] | #0c0d0e | foreground.primary |
| Inline Banner/Container/Content/Text/Description | fontSize | 14 | body.small.font size |
| Inline Banner/Container/Content/Text/Description | lineHeight | 18 | body.small.line height |
| Inline Banner/Container/Content/Text/Description | letterSpacing | 0 | body.small.letter spacing |
| Inline Banner/Container/Content/Action Slot | itemSpacing | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | negative | Inline Banner | fill[0] | feedback.error.background.subtle |
| Status | negative | Inline Banner | stroke[0] | border.error |
| Status | warning | Inline Banner | fill[0] | feedback.warning.background.subtle |
| Status | warning | Inline Banner | stroke[0] | border.warning |
| Status | neutral | Inline Banner | fill[0] | feedback.neutral.background.subtle |
| Status | neutral | Inline Banner | stroke[0] | border.default |
| Status | positive | Inline Banner | fill[0] | feedback.success.background.subtle |
| Status | positive | Inline Banner | stroke[0] | border.success |
| Appearance | solid | Inline Banner | fill[0] | feedback.info.background.strong |
| Appearance | solid | Inline Banner | stroke[0] | feedback.info.background.strong |
| Appearance | solid | Inline Banner/Container/Content/Text/Title | fill[0] | foreground.on-strong |
| Appearance | solid | Inline Banner/Container/Content/Text/Description | fill[0] | foreground.on-strong |
| Shape | sharp | Inline Banner | cornerRadius | radius.none |
