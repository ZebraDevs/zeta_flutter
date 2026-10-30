# System Banner

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5255-2146&m=dev

## System Banner (Mobile)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5350-6261&m=dev

### Overview

A full-width message pinned to the top of a mobile screen, carrying a status colour, a title, an optional description and an optional action. Status sets the background, while four toggles decide whether the glyph, the description, the action row and the dismiss control appear. It spans the screen and stays until something clears it, so it suits news a person has to see before carrying on.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Status | Default | true | The success colour, despite the name. Use it on completion, not as a neutral default. |
| Status | negative | - | A failure that needs attention. It carries no dismiss, so it stays until the problem clears. |
| Status | warning | - | A problem the person can still act on. Use it ahead of failure, or negative loses its force. |
| Status | Info | - | Neutral news with nothing at stake. Use it where nothing is required of the reader. |
| Show Leading Icon | true | true | Keeps the status glyph. Use it so the banner survives greyscale and colour blindness. |
| Show Leading Icon | false | - | Drops the glyph. Colour alone then carries the status, which the text has to repeat. |
| Show Description | true | true | Keeps the supporting line. Use it when the title alone cannot carry the message. |
| Show Description | false | - | Title only. Use it for a short message, or the banner grows taller than the news deserves. |
| Show Actions | true | true | Keeps the action slot. Use it when there is something to do, not merely to acknowledge. |
| Show Actions | false | - | Removes the action row. Use it for a message that only informs, so nothing invites a tap. |
| Show Close | true | true | Lets the person dismiss the banner. Use it where the message stops mattering once read. |
| Show Close | false | - | Keeps the banner until the condition clears. Use it where the message must not be lost. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The banner has no interaction states of its own. Hover, focus and pressed all live on the action Button and the dismiss control inside it. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | The banner slides in from the top as it opens, pushing the content below it down. Removing it plays the same motion in reverse, pulling the content back up. Both take 400ms, easing out on the way in and in on the way out, with no motion token yet. With reduced motion it fades instead. |
| Reflow | Width is fixed and height hugs the content, so a longer description makes the banner taller rather than wider. The text wraps inside its own column. |
| Dismissal | The component offers the control and nothing more. What happens after it is pressed, and whether the banner can return, is the product's decision. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Title | text | The headline. It is not exposed as an input, so it is set on the text itself. |
| Description | text | The supporting line below the title, switched by Show Description. Also set on the text rather than through an input. |
| Action Slot | slot | Takes the controls the message needs. It holds one small outline-contrast Button by default, and the slot accepts more than one. |
| Status Icon | icon, exposed | The leading glyph. It holds Verified on all four Status values, so the glyph is chosen per use rather than following the colour. |
| Dismiss | icon | The close control, switched by Show Close. Default, warning and Info carry it. negative does not, so that banner stays until the condition clears. |
| Status Bar | Figma only | A mock phone status bar above the message, pinned to ios. It is here so the banner previews as a phone screen, and saves drawing one around every example. It is not part of what gets built. |

### Anatomy

1. **Status glyph** — The leading icon, held to the top of the message row. It is exposed, so the glyph is set per use.
2. **Content** — The title and its optional description, filling whatever width the glyph and the dismiss control leave.
3. **Action slot** — The row beneath the text, holding one small outline-contrast Button by default.
4. **Dismiss** — The close control at the trailing edge. Absent on negative, which stays until the condition clears.

### How to use

**Do:**
- Match Status to what happened rather than to the colour you want. Using negative for emphasis leaves nothing for a real failure.
- Keep the title to one line and let the description carry the detail. The banner spans the screen, so a long title pushes the message down it.

**Don't:**
- Don't let the background colour carry the status on its own. Keep the glyph on, and say what has happened in the text as well.
- Don't turn the dismiss off on a banner a person can do nothing about. That leaves a message on screen with no way to clear it.

### Accessibility & Content Guidelines

- A banner appears without being asked for, so it has to announce itself. Nothing in the component does that, and the product has to send the message to the screen reader as it opens.
- Status is carried by the background colour and by a glyph that is the same on all four values, so the text has to say what has happened. Someone who cannot separate the colours has only the words.
- The dismiss control is 40 square including its frame. Check it still meets your minimum target size once the surrounding padding is counted.
- Title and description both sit on foreground/on-strong over a strong feedback background. Check the contrast on each Status rather than assuming the pair holds across all four.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 412px wide, with the height following the content. The banner spans the screen rather than sitting inside a column. |
| Padding | Fixed | 8px (space/sm) on all four sides of the message row, with a further 8px (space/sm) above and below the text column. |
| Gap | Fixed | 4px (space/xxs) between the glyph, the text column and the dismiss control. 8px (space/sm) between the text block and the action row. |
| Radius | None | Square on every corner. The banner meets both screen edges, so a radius would leave a gap at the sides. |
| Colour | Theming | The background is feedback/<status>/background/strong, one token per Status. Default resolves to the success token rather than a neutral one. Every variant is locked to the Dark palette mode, whatever mode its container uses. |
| Typography | Fixed | Title is label/large, description is body/small and the action label is label/medium. Title and description sit on foreground/on-strong; the action label takes the outline-contrast Button's foreground/primary. The Dark lock keeps that label white beside them. |
| Status glyph | Fixed | A medium framed Icon at 40×40px including its frame, held to the top of the message row. |
| Dismiss control | Fixed | 40×40px including its frame, sitting inside the message row's 8px padding at the trailing edge. |

### Layer structure

- System Banner (Mobile) (COMPONENT)
  - System Banner (Mobile)/Status Bar (INSTANCE)
  - System Banner (Mobile)/Container (FRAME)
    - System Banner (Mobile)/Container/Status Icon (INSTANCE, icon: verified)
    - System Banner (Mobile)/Container/Content (FRAME)
      - System Banner (Mobile)/Container/Content/Text (FRAME)
        - System Banner (Mobile)/Container/Content/Text/Title (TEXT)
        - System Banner (Mobile)/Container/Content/Text/Description Container (FRAME)
          - System Banner (Mobile)/Container/Content/Text/Description Container/Description (TEXT)
      - System Banner (Mobile)/Container/Content/Action Slot (SLOT)
    - System Banner (Mobile)/Container/Dismiss (INSTANCE)

### Resolved tokens (default variant: Status=Default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| System Banner (Mobile) | fill[0] | #00864f | feedback.success.background.strong |
| System Banner (Mobile)/Status Bar | itemSpacing | 67 | — |
| System Banner (Mobile)/Status Bar | padding.left | 16 | space.lg |
| System Banner (Mobile)/Status Bar | padding.right | 16 | space.lg |
| System Banner (Mobile)/Status Bar | padding.top | 16 | space.gutter |
| System Banner (Mobile)/Status Bar | padding.bottom | 16 | space.gutter |
| System Banner (Mobile)/Container | itemSpacing | 4 | space.xxs |
| System Banner (Mobile)/Container | padding.left | 8 | space.sm |
| System Banner (Mobile)/Container | padding.right | 8 | space.sm |
| System Banner (Mobile)/Container | padding.top | 8 | space.sm |
| System Banner (Mobile)/Container | padding.bottom | 8 | space.sm |
| System Banner (Mobile)/Container/Status Icon | height | 40 | control.target-min |
| System Banner (Mobile)/Container/Content | itemSpacing | 8 | space.sm |
| System Banner (Mobile)/Container/Content | padding.top | 8 | space.sm |
| System Banner (Mobile)/Container/Content | padding.bottom | 8 | space.sm |
| System Banner (Mobile)/Container/Content/Text/Title | fill[0] | #ffffff | foreground.primary |
| System Banner (Mobile)/Container/Content/Text/Title | fontSize | 16 | label.large.font size |
| System Banner (Mobile)/Container/Content/Text/Title | lineHeight | 24 | label.large.line height |
| System Banner (Mobile)/Container/Content/Text/Title | letterSpacing | 0 | label.large.letter spacing |
| System Banner (Mobile)/Container/Content/Text/Description Container | itemSpacing | 10 | — |
| System Banner (Mobile)/Container/Content/Text/Description Container | padding.top | 8 | space.sm |
| System Banner (Mobile)/Container/Content/Text/Description Container | padding.bottom | 8 | space.sm |
| System Banner (Mobile)/Container/Content/Text/Description Container/Description | fill[0] | #ffffff | foreground.primary |
| System Banner (Mobile)/Container/Content/Text/Description Container/Description | fontSize | 14 | body.small.font size |
| System Banner (Mobile)/Container/Content/Text/Description Container/Description | lineHeight | 18 | body.small.line height |
| System Banner (Mobile)/Container/Content/Text/Description Container/Description | letterSpacing | 0 | body.small.letter spacing |
| System Banner (Mobile)/Container/Content/Action Slot | itemSpacing | 8 | space.sm |
| System Banner (Mobile)/Container/Content/Action Slot | padding.top | 4 | space.xxs |
| System Banner (Mobile)/Container/Content/Action Slot | padding.bottom | 4 | space.xxs |
| System Banner (Mobile)/Container/Dismiss | width | 40 | control.md |
| System Banner (Mobile)/Container/Dismiss | height | 40 | control.md |
| System Banner (Mobile)/Container/Dismiss | fill[0] | #d6dce200 | interactive.ghost.background.default |
| System Banner (Mobile)/Container/Dismiss | stroke[0] | #545963 | interactive.neutral.border.default |
| System Banner (Mobile)/Container/Dismiss | cornerRadius | 4 | radius.element-sm |
| System Banner (Mobile)/Container/Dismiss | strokeWeight | 0 | stroke.base |
| System Banner (Mobile)/Container/Dismiss | padding.left | 4 | space.xxs |
| System Banner (Mobile)/Container/Dismiss | padding.right | 4 | space.xxs |
| System Banner (Mobile)/Container/Dismiss | padding.top | 4 | space.xxs |
| System Banner (Mobile)/Container/Dismiss | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | negative | System Banner (Mobile) | fill[0] | feedback.error.background.strong |
| Status | negative | System Banner (Mobile)/Container/Dismiss | width | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | height | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | fill[0] | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | stroke[0] | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | cornerRadius | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | strokeWeight | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | padding.left | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | padding.right | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | padding.top | — |
| Status | negative | System Banner (Mobile)/Container/Dismiss | padding.bottom | — |
| Status | warning | System Banner (Mobile) | fill[0] | feedback.warning.background.strong |
| Status | Info | System Banner (Mobile) | fill[0] | feedback.info.background.strong |

## System Banner (Desktop)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5406-9998&m=dev

### Overview

A full-width message pinned to the top of a desktop view, carrying a status colour, a title, an optional description and an optional action. Status sets the background and the glyph together, while Content Type decides whether the message runs to one line or two. It spans the view and stays until something clears it, so it suits news a person has to see before carrying on.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Status | Default | true | The success colour, despite the name. Use it on completion, not as a neutral default. |
| Status | negative | - | A failure that needs attention. It carries no dismiss, so it stays until the problem clears. |
| Status | warning | - | A problem the person can still act on. Use it ahead of failure, or negative loses its force. |
| Status | Info | - | Neutral news with nothing at stake. Use it where nothing is required of the reader. |
| Content Type | single line | true | Title and action on one row. Use it when the message fits in a few words. |
| Content Type | multiline | - | Adds a description under the title. Use it when the title alone leaves the reason unclear. |
| Title | text | Banner Title | The headline. Use it to say what happened and leave the detail to the description. |
| Show Leading Icon | true | true | Keeps the status glyph, which follows Status. Use it so the banner survives greyscale. |
| Show Leading Icon | false | - | Drops the glyph. Colour alone then carries the status, which the text has to repeat. |
| Show Actions | true | true | Keeps the action slot. Use it when there is something to do, not merely to acknowledge. |
| Show Actions | false | - | Removes the action row. Use it for a message that only informs, so nothing invites a click. |
| Show Close | true | true | Lets the person dismiss the banner. Use it where the message stops mattering once read. |
| Show Close | false | - | Keeps the banner until the condition clears. Use it where the message must not be lost. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The banner has no interaction states of its own. Hover, focus and pressed all live on the action Button and the dismiss Icon Button inside it. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | The banner slides in from the top as it opens, pushing the content below it down. Removing it plays the same motion in reverse, pulling the content back up. Both take 400ms, easing out on the way in and in on the way out, with no motion token yet. With reduced motion it fades instead. |
| Reflow | Width is fixed and height follows the content. single line holds one row, multiline grows with the description, and the text wraps inside its own column. |
| Dismissal | The component offers the control and nothing more. What happens after it is pressed, and whether the banner can return, is the product's decision. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Title | text, exposed | The headline, set through the Title input rather than on the text itself. |
| Description | text | The supporting line, present only on multiline. It is not exposed as an input, so it is set on the text. |
| Action Slot | slot | Takes the controls the message needs. It holds one small outline-contrast Button by default, and the slot accepts more than one. |
| Status Icon | icon, parent-owned | The leading glyph, following Status: Check Circle, Error, Warning and Info. It is not a consumer choice. |
| Dismiss | Icon Button | The close control, switched by Show Close. Default, warning and Info carry it. negative does not, so that banner stays until the condition clears. |
| Action Button | nested instance | One small rounded outline-contrast Button. The flavour is the banner's call, so changing it per message breaks the pairing with the background. |

### Anatomy

1. **Status glyph** — The leading icon inside its own square, following Status rather than being chosen per message.
2. **Content** — The title and, on multiline, its description. It fills whatever width the glyph and the dismiss control leave.
3. **Action slot** — Sits beside the text on single line and beneath it on multiline, holding one small outline-contrast Button by default.
4. **Dismiss** — The close control at the trailing edge. Absent on negative, which stays until the condition clears.

### How to use

**Do:**
- Match Status to what happened rather than to the colour you want. Using negative for emphasis leaves nothing for a real failure.
- Use single line when the title says everything. multiline earns its height only when the reason needs spelling out.

**Don't:**
- Don't let the background colour carry the status on its own. Keep the glyph on, and say what has happened in the text as well.
- Don't turn the dismiss off on a banner a person can do nothing about. That leaves a message on screen with no way to clear it.

### Accessibility & Content Guidelines

- A banner appears without being asked for, so it has to announce itself. Nothing in the component does that, and the product has to send the message to the screen reader as it opens.
- The glyph follows Status here, so colour is not the only carrier. The text should still name what has happened, because the glyph alone is a small difference at this size.
- The dismiss control is a 36 square Icon Button. Check it still meets your minimum target size, and that it is reachable by keyboard in the same order it appears.
- Title and description both sit on foreground/on-strong over a strong feedback background. Check the contrast on each Status rather than assuming the pair holds across all four.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 983px wide. 68px tall on single line and 142px on multiline, with the height following the description. |
| Padding | Fixed | 16px on all four sides of the message row, with a further 4px (space/xxs) above and below the text on multiline. |
| Gap | Fixed | 8px between the glyph, the content and the dismiss control. 16px (space/lg) inside the content between the text and the action row. |
| Radius | None | Square on every corner. The banner spans the full width of the view, so a radius would leave a gap at the sides. |
| Colour | Theming | The background is feedback/<status>/background/strong, one token per Status. Default resolves to the success token rather than a neutral one. Every variant is locked to the Dark palette mode, whatever mode its container uses. |
| Typography | Fixed | Title is label/medium, description is body/small and the action label is label/medium. Title and description sit on foreground/on-strong; the action label takes the outline-contrast Button's foreground/primary. The Dark lock keeps that label white beside them. |
| Status glyph | Fixed | A medium unframed Icon inside a 36×36px container, held to the top of the message row. |
| Dismiss control | Fixed | A 36×36px Icon Button with 4px (space/xxs) around a 20px glyph, at the trailing edge of the row. |

### Layer structure

- System Banner (Desktop) (COMPONENT)
  - System Banner (Desktop)/Container (FRAME)
    - System Banner (Desktop)/Container/Icon Container (FRAME)
      - System Banner (Desktop)/Container/Icon Container/Status Icon (INSTANCE, icon: check_circle)
    - System Banner (Desktop)/Container/Content (FRAME)
      - System Banner (Desktop)/Container/Content/Text (FRAME)
        - System Banner (Desktop)/Container/Content/Text/Title (TEXT)
        - System Banner (Desktop)/Container/Content/Text/Description (TEXT)
      - System Banner (Desktop)/Container/Content/Action Slot (SLOT)
    - System Banner (Desktop)/Container/Dismiss (INSTANCE)

### Resolved tokens (default variant: Status=Default, Content Type=single line)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| System Banner (Desktop) | fill[0] | #00864f | feedback.success.background.strong |
| System Banner (Desktop) | itemSpacing | 8 | — |
| System Banner (Desktop)/Container | itemSpacing | 8 | space.sm |
| System Banner (Desktop)/Container | padding.left | 16 | space.lg |
| System Banner (Desktop)/Container | padding.right | 16 | space.lg |
| System Banner (Desktop)/Container | padding.top | 16 | space.lg |
| System Banner (Desktop)/Container | padding.bottom | 16 | space.lg |
| System Banner (Desktop)/Container/Icon Container | width | 36 | control.sm |
| System Banner (Desktop)/Container/Icon Container | height | 36 | control.sm |
| System Banner (Desktop)/Container/Icon Container | itemSpacing | 10 | — |
| System Banner (Desktop)/Container/Content | itemSpacing | 16 | space.lg |
| System Banner (Desktop)/Container/Content/Text | itemSpacing | 12 | space.card |
| System Banner (Desktop)/Container/Content/Text | padding.top | 8 | space.sm |
| System Banner (Desktop)/Container/Content/Text | padding.bottom | 8 | space.sm |
| System Banner (Desktop)/Container/Content/Text/Title | fill[0] | #ffffff | foreground.primary |
| System Banner (Desktop)/Container/Content/Text/Title | fontSize | 14 | label.medium.font size |
| System Banner (Desktop)/Container/Content/Text/Title | lineHeight | 20 | label.medium.line height |
| System Banner (Desktop)/Container/Content/Text/Title | letterSpacing | 0 | label.medium.letter spacing |
| System Banner (Desktop)/Container/Content/Action Slot | itemSpacing | 8 | space.sm |
| System Banner (Desktop)/Container/Dismiss | width | 36 | control.sm |
| System Banner (Desktop)/Container/Dismiss | height | 36 | control.sm |
| System Banner (Desktop)/Container/Dismiss | fill[0] | #d6dce200 | interactive.ghost.background.default |
| System Banner (Desktop)/Container/Dismiss | stroke[0] | #545963 | interactive.neutral.border.default |
| System Banner (Desktop)/Container/Dismiss | cornerRadius | 4 | radius.element-sm |
| System Banner (Desktop)/Container/Dismiss | strokeWeight | 0 | stroke.base |
| System Banner (Desktop)/Container/Dismiss | padding.left | 4 | space.xxs |
| System Banner (Desktop)/Container/Dismiss | padding.right | 4 | space.xxs |
| System Banner (Desktop)/Container/Dismiss | padding.top | 4 | space.xxs |
| System Banner (Desktop)/Container/Dismiss | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | negative | System Banner (Desktop) | fill[0] | feedback.error.background.strong |
| Status | negative | System Banner (Desktop)/Container/Dismiss | width | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | height | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | fill[0] | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | stroke[0] | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | cornerRadius | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | strokeWeight | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | padding.left | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | padding.right | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | padding.top | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | padding.bottom | — |
| Status | warning | System Banner (Desktop) | fill[0] | feedback.warning.background.strong |
| Status | warning | System Banner (Desktop) | itemSpacing | space.sm |
| Status | Info | System Banner (Desktop) | fill[0] | feedback.info.background.strong |
| Content Type | multiline | System Banner (Desktop)/Container/Content | padding.top | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content | padding.bottom | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text | itemSpacing | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text | padding.top | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text | padding.bottom | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text/Description | fill[0] | foreground.primary |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text/Description | fontSize | body.small.font size |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text/Description | lineHeight | body.small.line height |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text/Description | letterSpacing | body.small.letter spacing |

## Status Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5255-2738&m=dev

### Layer structure

- Status Bar (COMPONENT)
  - Status Bar/Android/Time (FRAME)
    - Status Bar/Android/Time/clock (FRAME)
      - Status Bar/Android/Time/clock/Hours (TEXT)
      - Status Bar/Android/Time/clock/:[1] (TEXT)
      - Status Bar/Android/Time/clock/Minutes (TEXT)
      - Status Bar/Android/Time/clock/:[2] (TEXT)
      - Status Bar/Android/Time/clock/Seconds (TEXT)
    - Status Bar/Android/Time/PM (TEXT)
  - Status Bar/Icons (FRAME)
    - Status Bar/Icons/Android/Bluetooth (FRAME)
      - Status Bar/Icons/Android/Bluetooth/bluetooth (VECTOR)
    - Status Bar/Icons/Android/WiFi (FRAME)
      - Status Bar/Icons/Android/WiFi/Bar 1 (VECTOR)
      - Status Bar/Icons/Android/WiFi/Bar 2 (VECTOR)
      - Status Bar/Icons/Android/WiFi/Bar 3 (VECTOR)
      - Status Bar/Icons/Android/WiFi/Bar 4 (VECTOR)
    - Status Bar/Icons/Android/Cellular Signal (FRAME)
      - Status Bar/Icons/Android/Cellular Signal/5G (TEXT)
      - Status Bar/Icons/Android/Cellular Signal/bars (GROUP)
        - Status Bar/Icons/Android/Cellular Signal/bars/Bar 1 (VECTOR)
        - Status Bar/Icons/Android/Cellular Signal/bars/Bar 2 (VECTOR)
        - Status Bar/Icons/Android/Cellular Signal/bars/Bar 3 (VECTOR)
        - Status Bar/Icons/Android/Cellular Signal/bars/Bar 4 (VECTOR)
    - Status Bar/Icons/Android/Battery (FRAME)
      - Status Bar/Icons/Android/Battery/outline (VECTOR)
      - Status Bar/Icons/Android/Battery/indicator (RECTANGLE)
    - Status Bar/Icons/Cellular Signal (FRAME)
      - Status Bar/Icons/Cellular Signal/Bar 1 (VECTOR)
      - Status Bar/Icons/Cellular Signal/Bar 2 (VECTOR)
      - Status Bar/Icons/Cellular Signal/Bar 3 (VECTOR)
      - Status Bar/Icons/Cellular Signal/Bar 4 (VECTOR)
    - Status Bar/Icons/Wifi (FRAME)
      - Status Bar/Icons/Wifi/Bar 1 (VECTOR)
      - Status Bar/Icons/Wifi/Bar 2 (VECTOR)
      - Status Bar/Icons/Wifi/Bar 3 (VECTOR)
    - Status Bar/Icons/Battery (FRAME)
      - Status Bar/Icons/Battery/border (VECTOR)
      - Status Bar/Icons/Battery/indicator (RECTANGLE)
      - Status Bar/Icons/Battery/cap (VECTOR)
  - Status Bar/Time (FRAME)
    - Status Bar/Time/clock (FRAME)
      - Status Bar/Time/clock/Hours (TEXT)
      - Status Bar/Time/clock/: (TEXT)
      - Status Bar/Time/clock/Minutes (TEXT)
    - Status Bar/Time/location arrow (VECTOR)

### Resolved tokens (default variant: Platform=ios)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Status Bar | itemSpacing | 67 | — |
| Status Bar | padding.left | 16 | space.lg |
| Status Bar | padding.right | 16 | space.lg |
| Status Bar | padding.top | 16 | space.gutter |
| Status Bar | padding.bottom | 16 | space.gutter |
| Status Bar/Time | itemSpacing | 4 | — |
| Status Bar/Time/clock | fill[0] | #ffffff | — |
| Status Bar/Time/clock/Hours | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Time/clock/Hours | fontSize | 14 | — |
| Status Bar/Time/clock/Hours | lineHeight | 16.70703125 | — |
| Status Bar/Time/clock/Hours | letterSpacing | 0 | — |
| Status Bar/Time/clock/: | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Time/clock/: | fontSize | 14 | — |
| Status Bar/Time/clock/: | lineHeight | 16.70703125 | — |
| Status Bar/Time/clock/: | letterSpacing | 0 | — |
| Status Bar/Time/clock/Minutes | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Time/clock/Minutes | fontSize | 14 | — |
| Status Bar/Time/clock/Minutes | lineHeight | 16.70703125 | — |
| Status Bar/Time/clock/Minutes | letterSpacing | 0 | — |
| Status Bar/Time/location arrow | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons | itemSpacing | 8.5 | — |
| Status Bar/Icons/Cellular Signal/Bar 1 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Cellular Signal/Bar 2 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Cellular Signal/Bar 3 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Cellular Signal/Bar 4 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Wifi | fill[0] | #ffffff | — |
| Status Bar/Icons/Wifi/Bar 1 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Wifi/Bar 2 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Wifi/Bar 3 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Battery | fill[0] | #ffffff | — |
| Status Bar/Icons/Battery/border | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Battery/indicator | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Battery/indicator | cornerRadius | 1 | — |
| Status Bar/Icons/Battery/cap | fill[0] | #0c0d0e | foreground.primary |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Platform | android | Status Bar | padding.left | space.page |
| Platform | android | Status Bar | padding.right | space.page |
| Platform | android | Status Bar | padding.top | space.sm |
| Platform | android | Status Bar | padding.bottom | space.sm |
| Platform | android | Status Bar/Time/clock/Hours | fill[0] | — |
| Platform | android | Status Bar/Time/clock/: | fill[0] | — |
| Platform | android | Status Bar/Time/clock/Minutes | fill[0] | — |
| Platform | android | Status Bar/Time/location arrow | fill[0] | — |
| Platform | android | Status Bar/Icons/Cellular Signal/Bar 1 | fill[0] | — |
| Platform | android | Status Bar/Icons/Cellular Signal/Bar 2 | fill[0] | — |
| Platform | android | Status Bar/Icons/Cellular Signal/Bar 3 | fill[0] | — |
| Platform | android | Status Bar/Icons/Cellular Signal/Bar 4 | fill[0] | — |
| Platform | android | Status Bar/Icons/Wifi/Bar 1 | fill[0] | — |
| Platform | android | Status Bar/Icons/Wifi/Bar 2 | fill[0] | — |
| Platform | android | Status Bar/Icons/Wifi/Bar 3 | fill[0] | — |
| Platform | android | Status Bar/Icons/Battery/border | fill[0] | — |
| Platform | android | Status Bar/Icons/Battery/indicator | fill[0] | — |
| Platform | android | Status Bar/Icons/Battery/cap | fill[0] | — |
| Platform | android | Status Bar/Android/Time/clock/Hours | fill[0] | foreground.primary |
| Platform | android | Status Bar/Android/Time/clock/:[1] | fill[0] | foreground.primary |
| Platform | android | Status Bar/Android/Time/clock/Minutes | fill[0] | foreground.primary |
| Platform | android | Status Bar/Android/Time/PM | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Bluetooth/bluetooth | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/WiFi/Bar 1 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/WiFi/Bar 2 | stroke[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/WiFi/Bar 3 | stroke[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/WiFi/Bar 4 | stroke[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/5G | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/bars/Bar 1 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/bars/Bar 2 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/bars/Bar 3 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/bars/Bar 4 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Battery/outline | stroke[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Battery/indicator | fill[0] | foreground.primary |
