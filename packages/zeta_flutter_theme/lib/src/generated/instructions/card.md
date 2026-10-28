# Card

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3007-796&m=dev

## Card base

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3201-53&m=dev

### Overview

The empty card shell, three stacked slots inside a bordered surface. It decides the surface, the border, the corner treatment and the fact that content is clipped to the frame, and nothing else. Header and Footer can each be switched off, Body is always present. Reach for a Card Template when you want a card already assembled, and for this when you are composing one yourself.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Shape | sharp | true | Square corners, matching surfaces and controls that are also square. |
| Shape | rounded | - | Softened corners, for a card that should read as a distinct object on the page. Content is clipped to the corner, so a full-bleed image inside follows the curve rather than squaring it off. |
| hasHeader | true | true | Shows the header slot above the body, for a title row or a heading with actions. |
| hasHeader | false | - | Hides the header slot along with anything placed in it. The body then meets the top edge, which is what a media-led card wants. |
| hasFooter | true | true | Shows the footer slot below the body, for the actions that close out the card. |
| hasFooter | false | - | Hides the footer slot and everything in it. Use when the card is purely informational and has nothing to act on. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The shell has no interaction states. Hover, focus and selection all belong to whatever is placed in its slots, so the card itself never changes appearance. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and the shell models no transition. Showing or hiding a slot is a property change rather than something that animates here. |
| Reflow | Width is fixed and height hugs the slots, so the card grows downward as content is added and never sideways. |
| Clipping | The shell and all three slots clip their content. Anything larger than the card is cut at the edge rather than overflowing, which is what lets a full-bleed image sit flush inside a rounded corner. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Header | slot, prefers _Card Heading | A title row at the top, hidden by hasHeader. It ships empty, and _Card Heading is the part built for it. |
| Body | slot, always present | The card's main content. It has no visibility toggle, so unlike the other two it cannot be switched off. _Card Body, _Card Image and _Card Heading are all offered, and the media templates stack several of them. |
| Footer | slot, prefers _Card Footer | The actions that close out the card, hidden by hasFooter. _Card Footer carries the one, two and custom action arrangements. |
| Slot content | shared across variants | Each slot uses a single property across both Shape variants, so switching Shape keeps whatever has been placed in them. |

### Anatomy

1. **Card** — The outer frame. Fixed width, hugging height, carrying the surface, the border and the radius. It clips everything inside it.
2. **Header** — The top slot, for a title row or a heading with actions. Switched off as a whole by hasHeader.
3. **Body** — The middle slot and the card's main content. It is the one slot with no visibility toggle.
4. **Footer** — The bottom slot, for closing actions. Switched off as a whole by hasFooter.

### How to use

**Do:**
- Switch off the header for a media-led card, so the image meets the top edge rather than sitting under an empty row.
- Let the card grow downward. Height hugs the slots, so adding content is safe in a way that widening it is not.

**Don't:**
- Don't expect the card to widen for its content. Width is fixed, so a long unbroken string is clipped at the edge rather than pushing the card out.
- Don't rely on Body being optional. It has no toggle, so a card with nothing to put there still reserves the space.

### Accessibility & Content Guidelines

- The shell is a container and announces nothing itself. Whatever meaning the card carries comes from the parts placed in its slots.
- Content is clipped at the card's edge, so text that overflows disappears rather than wrapping outside. Check long strings at the fixed width.
- The card is not interactive here. If the whole card is meant to be clickable, that target and its focus treatment have to be built in code.
- The border is the only thing separating the card from the page. Check border/default against the surface behind it.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed | 330px as drawn. The shell does not hug horizontally, so whoever places it decides the width. |
| Height | Hug | Grows with the slots. With all three shown and empty it stands at 214px. |
| Padding and gap | None | Zero on the shell and zero between the slots. Every inset comes from the parts placed inside, which is why an empty card reads as three touching bands. |
| Radius | Fixed per Shape | radius/none when sharp, radius/sm when rounded. The shell clips to this radius, so inner content follows the curve. |
| Border | Fixed | 1px (stroke/thin) on border/default, on all four edges, at both Shape values. |
| Fill | Theming | surface/card on the shell and on each of the three slots, so a slot left empty still reads as card surface rather than a hole. |
| Elevation | None | No shadow at either Shape. The card sits flat and is separated from the page by its border alone. |

### Layer structure

- Card base (COMPONENT)
  - Card base/Header (SLOT)
  - Card base/Body (SLOT)
  - Card base/Footer (SLOT)

### Resolved tokens (default variant: Shape=sharp)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Card base | fill[0] | #f8fbff | surface.card |
| Card base | stroke[0] | #ced2db | border.default |
| Card base | cornerRadius | 0 | radius.none |
| Card base | strokeWeight | 1 | stroke.thin |
| Card base/Header | fill[0] | #f8fbff | surface.card |
| Card base/Body | fill[0] | #f8fbff | surface.card |
| Card base/Footer | fill[0] | #f8fbff | surface.card |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | rounded | Card base | cornerRadius | radius.sm |

## Collapsible Card

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3400-364&m=dev

### Overview

A card whose body opens and closes behind a header that is always visible. The header carries a title, a description and a leading chevron that flips with the state, and the body slot appears only when expanded. Flavor chooses between a plain card and one outlined with the brand gradient. Unlike Card base it has no header or footer slot of its own, the header is built in.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | collapsed | true | Header only, with the body slot hidden. The resting state, and the one to lay out against when several cards stack. |
| State | expanded | - | Reveals the body slot below the header. The card roughly triples in height, so a column of expanded cards pushes everything below it well down the page. |
| Flavor | default | true | A plain card with no outline, for a list where no single card should stand out. |
| Flavor | gradient | - | Outlines the card with the brand gradient, for the one card that should draw the eye. More than one in a list removes the distinction it exists to make. |
| Shape | sharp | true | Square corners, matching surfaces and controls that are also square. |
| Shape | rounded | - | Softened corners, for a card that should read as a distinct object. The card clips to the curve, so inner content follows it. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| collapsed | Resting | — | The header alone. The body slot is hidden and the leading icon shows its closed chevron. |
| expanded | The card is opened | — | The body slot appears below the header with its own padding, and the leading icon flips to its open chevron. Nothing else about the header changes. |
| gradient outline | Flavor set to gradient | — | A gradient stroke is drawn around all four edges, which also makes the card slightly taller and narrows the header by the same amount. No fill or text colour changes with it. |
| header hover | Through the nested header | — | The header is an exposed _Container header carrying its own default and hover flavours. The card pins it to default in every variant, so a hover treatment has to be set on that instance. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Expand and collapse apply a 0.2s ease-in-out transition to height and chevron rotation, giving the card a smooth, continuous reveal. |
| Height change | Expanding roughly triples the card's height and the card hugs that change, so everything below it moves. Plan the surrounding layout against the expanded height rather than the collapsed one. |
| Chevron | The leading icon carries its own open and closed states and the card sets them to match State. Anything driving the card at runtime has to move both together. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Body | slot, one property per expanded variant | The content revealed when the card opens. It is stored separately for each of the four expanded variants, so content placed while default and sharp does not appear after switching to gradient or rounded. Fill the variant you intend to ship. |
| Header | exposed nested _Container header | Always visible and not a slot. It carries the title, the description and the leading chevron. The instance is exposed, so all of that is reachable without detaching. |
| Leading icon | exposed nested _Leading Icon | The chevron in the header, tied to State by the card. It is exposed, so it can be hidden through the header's own hasLeading toggle. |

### Anatomy

1. **Card** — The outer frame. Fixed width, hugging height, carrying the surface, the radius and, at the gradient flavour, the outline. It clips everything inside it.
2. **Header** — Always visible and not a slot. An exposed _Container header holding the leading chevron, the title and the description.
3. **Body** — The slot revealed when the card expands. Hidden entirely while collapsed, and inset on three sides when shown.

### How to use

**Do:**
- Fill the Body of the exact variant you intend to ship. The four expanded variants hold their body content separately.
- Use gradient for at most one card in a group. It exists to single a card out, and a list of them says nothing.

**Don't:**
- Don't lay a column out against the collapsed height. Expanding roughly triples the card, so everything below it moves a long way.
- Don't reach for this when the content is always visible. Card base is the shell for a card that does not open and close, and it has a real footer slot.

### Accessibility & Content Guidelines

- The chevron is the only indication the card opens. Whether it is expanded has to be exposed in code, the icon direction alone does not carry it.
- The header is the control that toggles the card, but nothing here models it as a button. That target, its focus treatment and its keyboard behaviour all belong to the implementation.
- The gradient outline is decorative and carries no meaning of its own, so it should not be the only thing marking a card as important.
- Collapsed content is hidden rather than removed. Make sure it is genuinely unavailable to assistive technology when closed, and available when open.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed | 385px at every variant. The card does not hug horizontally. |
| Height | Hug | 78px collapsed and 257px expanded at the default flavour. Gradient adds 4px to both, 82px and 261px, because its outline is drawn on the frame itself. |
| Header padding | Fixed | 16px (space/lg) top and bottom, 24px (space/xl) left and right, with 8px (space/sm) between the leading icon and the heading block. |
| Body padding | Fixed per State | None while collapsed, since the slot is hidden. Expanded it insets 24px (space/xl) left, right and bottom, with nothing on top so the body sits tight under the header. |
| Heading spacing | Fixed | 2px (space/2xs) between the title and the description, and 4px (space/xs) inside the title row. |
| Radius | Fixed per Shape | radius/none when sharp, radius/sm when rounded. The card clips to it. |
| Outline | Fixed per Flavor | None at the default flavour. Gradient draws a 2px (stroke/thick) linear gradient from foreground/gradient/start to foreground/gradient/end around all four edges. |
| Fill | Theming | surface/card on the card. The header sits on a fully transparent interactive/ghost/background/default, so the card surface shows through it. |
| Leading icon | Fixed | A 28px Icon at Size=large with Framed off. |
| Description type | Theming | The header's description sits on foreground/secondary. |

### Layer structure

- Collapsible Card (COMPONENT)
  - Collapsible Card/_Container header (INSTANCE)
  - Collapsible Card/Body (SLOT)

### Resolved tokens (default variant: State=collapsed, Flavor=default, Shape=sharp)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Collapsible Card | fill[0] | #f8fbff | surface.card |
| Collapsible Card | cornerRadius | 0 | radius.none |
| Collapsible Card/_Container header | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Collapsible Card/_Container header | itemSpacing | 8 | space.sm |
| Collapsible Card/_Container header | padding.left | 16 | space.lg |
| Collapsible Card/_Container header | padding.right | 16 | space.lg |
| Collapsible Card/_Container header | padding.top | 16 | space.lg |
| Collapsible Card/_Container header | padding.bottom | 16 | space.lg |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | expanded | Collapsible Card/Body | padding.left | space.lg |
| State | expanded | Collapsible Card/Body | padding.right | space.lg |
| State | expanded | Collapsible Card/Body | padding.bottom | space.lg |
| Flavor | gradient | Collapsible Card | stroke[0] | linear-gradient(129deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavor | gradient | Collapsible Card | strokeWeight | stroke.thick |
| Shape | rounded | Collapsible Card | cornerRadius | radius.sm |

## _Container header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3395-6505&m=dev

### Layer structure

- _Container header (COMPONENT)
  - _Container header/Caret Indicator (INSTANCE)
  - _Container header/Heading Content (FRAME)
    - _Container header/Heading Content/Title (FRAME)
      - _Container header/Heading Content/Title/Heading (TEXT)
      - _Container header/Heading Content/Title/* (TEXT)
    - _Container header/Heading Content/Description (TEXT)

### Resolved tokens (default variant: Flavor=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Container header | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Container header | itemSpacing | 8 | space.sm |
| _Container header | padding.left | 16 | space.lg |
| _Container header | padding.right | 16 | space.lg |
| _Container header | padding.top | 16 | space.lg |
| _Container header | padding.bottom | 16 | space.lg |
| _Container header/Caret Indicator | itemSpacing | 10 | — |
| _Container header/Heading Content | itemSpacing | 2 | space.2xs |
| _Container header/Heading Content/Title | itemSpacing | 4 | space.xxs |
| _Container header/Heading Content/Title/Heading | fill[0] | #0c0d0e | foreground.primary |
| _Container header/Heading Content/Title/Heading | fontSize | 20 | title.large.font size |
| _Container header/Heading Content/Title/Heading | lineHeight | 24 | title.large.line height |
| _Container header/Heading Content/Title/Heading | letterSpacing | 0 | title.large.letter spacing |
| _Container header/Heading Content/Title/* | fill[0] | #d70015 | foreground.error |
| _Container header/Heading Content/Title/* | fontSize | 20 | title.large.font size |
| _Container header/Heading Content/Title/* | lineHeight | 24 | title.large.line height |
| _Container header/Heading Content/Title/* | letterSpacing | 0 | title.large.letter spacing |
| _Container header/Heading Content/Description | fill[0] | #545963 | foreground.secondary |
| _Container header/Heading Content/Description | fontSize | 16 | title.medium.font size |
| _Container header/Heading Content/Description | lineHeight | 20 | title.medium.line height |
| _Container header/Heading Content/Description | letterSpacing | 0 | title.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Flavor | hover | _Container header | fill[0] | interactive.ghost.background.hover |

## _Card Heading

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3311-1213&m=dev

### Layer structure

- _Card Heading (COMPONENT)
  - _Card Heading/Leading Content (SLOT)
  - _Card Heading/Heading Content (FRAME)
    - _Card Heading/Heading Content/Heading (TEXT)
    - _Card Heading/Heading Content/Subheading (TEXT)
  - _Card Heading/Trailing Content (SLOT)

### Resolved tokens (default variant: _Card Heading)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Card Heading | itemSpacing | 16 | space.lg |
| _Card Heading | padding.left | 16 | space.lg |
| _Card Heading | padding.right | 16 | space.lg |
| _Card Heading | padding.top | 16 | space.lg |
| _Card Heading | padding.bottom | 16 | space.lg |
| _Card Heading/Leading Content | itemSpacing | 8 | space.sm |
| _Card Heading/Heading Content/Heading | fill[0] | #0c0d0e | foreground.primary |
| _Card Heading/Heading Content/Heading | fontSize | 16 | title.medium.font size |
| _Card Heading/Heading Content/Heading | lineHeight | 20 | title.medium.line height |
| _Card Heading/Heading Content/Heading | letterSpacing | 0 | title.medium.letter spacing |
| _Card Heading/Heading Content/Subheading | fill[0] | #545963 | foreground.secondary |
| _Card Heading/Heading Content/Subheading | fontSize | 14 | body.small.font size |
| _Card Heading/Heading Content/Subheading | lineHeight | 18 | body.small.line height |
| _Card Heading/Heading Content/Subheading | letterSpacing | 0 | body.small.letter spacing |

## _Card Body

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3311-2061&m=dev

### Layer structure

- _Card Body (COMPONENT)
  - _Card Body/Content (FRAME)
    - _Card Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. (TEXT)

### Resolved tokens (default variant: _Card Body)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Card Body | cornerRadius | 0 | radius.none |
| _Card Body | padding.left | 16 | space.lg |
| _Card Body | padding.right | 16 | space.lg |
| _Card Body | padding.top | 16 | space.lg |
| _Card Body | padding.bottom | 16 | space.lg |
| _Card Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. | fill[0] | #545963 | foreground.secondary |
| _Card Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. | fontSize | 14 | body.small.font size |
| _Card Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. | lineHeight | 18 | body.small.line height |
| _Card Body/Content/Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. | letterSpacing | 0 | body.small.letter spacing |

## _Card Image

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3637-581&m=dev

### Layer structure

- _Card Image (COMPONENT)
  - _Card Image/Image (FRAME)

### Resolved tokens (default variant: _Card Image)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |

## _Card Footer

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3311-3383&m=dev

### Layer structure

- _Card Footer (COMPONENT)
  - _Card Footer/Button (INSTANCE)
  - _Card Footer/Button[1] (INSTANCE)
  - _Card Footer/Button[2] (INSTANCE)
  - _Card Footer/Slot (SLOT)

### Resolved tokens (default variant: Actions=1)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Card Footer | padding.left | 16 | space.lg |
| _Card Footer | padding.right | 16 | space.lg |
| _Card Footer | padding.top | 16 | space.lg |
| _Card Footer | padding.bottom | 16 | space.lg |
| _Card Footer/Button | height | 36 | control.sm |
| _Card Footer/Button | fill[0] | #1f69ff | interactive.primary.background.default |
| _Card Footer/Button | stroke[0] | #1f69ff | interactive.primary.border.default |
| _Card Footer/Button | cornerRadius | 0 | radius.none |
| _Card Footer/Button | strokeWeight | 0 | stroke.base |
| _Card Footer/Button | padding.left | 12 | space.md |
| _Card Footer/Button | padding.right | 12 | space.md |
| _Card Footer/Button | padding.top | 4 | space.xxs |
| _Card Footer/Button | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Actions | 2 | _Card Footer | itemSpacing | space.sm |
| Actions | 2 | _Card Footer/Button | height | — |
| Actions | 2 | _Card Footer/Button | fill[0] | — |
| Actions | 2 | _Card Footer/Button | stroke[0] | — |
| Actions | 2 | _Card Footer/Button | cornerRadius | — |
| Actions | 2 | _Card Footer/Button | strokeWeight | — |
| Actions | 2 | _Card Footer/Button | padding.left | — |
| Actions | 2 | _Card Footer/Button | padding.right | — |
| Actions | 2 | _Card Footer/Button | padding.top | — |
| Actions | 2 | _Card Footer/Button | padding.bottom | — |
| Actions | 2 | _Card Footer/Button[1] | height | control.sm |
| Actions | 2 | _Card Footer/Button[1] | fill[0] | interactive.neutral.background.default |
| Actions | 2 | _Card Footer/Button[1] | stroke[0] | interactive.ghost.border.default |
| Actions | 2 | _Card Footer/Button[1] | cornerRadius | radius.none |
| Actions | 2 | _Card Footer/Button[1] | strokeWeight | stroke.thin |
| Actions | 2 | _Card Footer/Button[1] | padding.left | space.md |
| Actions | 2 | _Card Footer/Button[1] | padding.right | space.md |
| Actions | 2 | _Card Footer/Button[1] | padding.top | space.xxs |
| Actions | 2 | _Card Footer/Button[1] | padding.bottom | space.xxs |
| Actions | 2 | _Card Footer/Button[2] | height | control.sm |
| Actions | 2 | _Card Footer/Button[2] | fill[0] | interactive.primary.background.default |
| Actions | 2 | _Card Footer/Button[2] | stroke[0] | interactive.primary.border.default |
| Actions | 2 | _Card Footer/Button[2] | cornerRadius | radius.none |
| Actions | 2 | _Card Footer/Button[2] | strokeWeight | stroke.base |
| Actions | 2 | _Card Footer/Button[2] | padding.left | space.md |
| Actions | 2 | _Card Footer/Button[2] | padding.right | space.md |
| Actions | 2 | _Card Footer/Button[2] | padding.top | space.xxs |
| Actions | 2 | _Card Footer/Button[2] | padding.bottom | space.xxs |
| Actions | custom | _Card Footer | itemSpacing | space.sm |
| Actions | custom | _Card Footer/Button | height | — |
| Actions | custom | _Card Footer/Button | fill[0] | — |
| Actions | custom | _Card Footer/Button | stroke[0] | — |
| Actions | custom | _Card Footer/Button | cornerRadius | — |
| Actions | custom | _Card Footer/Button | strokeWeight | — |
| Actions | custom | _Card Footer/Button | padding.left | — |
| Actions | custom | _Card Footer/Button | padding.right | — |
| Actions | custom | _Card Footer/Button | padding.top | — |
| Actions | custom | _Card Footer/Button | padding.bottom | — |
| Actions | custom | _Card Footer/Slot | itemSpacing | space.sm |

## Default

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4545-545&m=dev

### Layer structure

- Default (COMPONENT)
  - Default/Card base (INSTANCE)

### Resolved tokens (default variant: Shape=sharp, Layout=text)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Default/Card base | fill[0] | #f8fbff | surface.card |
| Default/Card base | stroke[0] | #ced2db | border.default |
| Default/Card base | cornerRadius | 0 | radius.none |
| Default/Card base | strokeWeight | 1 | stroke.thin |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | round | Default/Card base | cornerRadius | radius.sm |

## Collapsible

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4934-562&m=dev

### Layer structure

- Collapsible (COMPONENT)
  - Collapsible/Collapsible Card (INSTANCE)

### Resolved tokens (default variant: Shape=sharp, Flavor=gradient, State=collapsed)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Collapsible/Collapsible Card | fill[0] | #f8fbff | surface.card |
| Collapsible/Collapsible Card | stroke[0] | linear-gradient(129deg, #43008f 0%, #1a2154 100%) | linear-gradient(129deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Collapsible/Collapsible Card | cornerRadius | 0 | radius.none |
| Collapsible/Collapsible Card | strokeWeight | 2 | stroke.thick |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | round | Collapsible/Collapsible Card | cornerRadius | radius.sm |
| Flavor | default | Collapsible/Collapsible Card | stroke[0] | — |
| Flavor | default | Collapsible/Collapsible Card | strokeWeight | — |

## Card Template Default (documentation only)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3007-796&m=dev

### Overview

A ready-made card built on Card base, offered in three content layouts and two corner treatments. It declares no properties of its own beyond those two axes, so everything else is configured through the exposed Card base instance inside it. This is a condensed record, the shell and its slots are documented in the Card base Metadata frame.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Layout | text | true | A heading row, a block of body text and a footer of actions. The everyday card, and the only layout with no image in it. |
| Layout | media inset | - | Adds an image inside the body above a second heading and the text, keeping the card's own header row on top. Use it when the card needs both an owner row and a picture. |
| Layout | media | - | Drops the header row entirely and leads with the image. It is wider than the other two, so it will not line up with them in a grid. |
| Shape | sharp | true | Square corners. It sets the shell's Shape to sharp. |
| Shape | round | - | Softened corners. It sets the shell's Shape to rounded, and the shell clips its content to the curve. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Card base | exposed nested instance | The shell the template is built on. Exposed, so its Shape, its header and footer toggles and all three slots stay reachable. See the Card base Metadata frame. |
| Header content | filled per Layout | _Card Heading with an Avatar and an Icon Button in the text and media inset layouts. The media layout leaves the header off entirely. |
| Body content | filled per Layout | _Card Body alone in the text layout. _Card Image, a second _Card Heading and _Card Body stacked in both media layouts. |
| Footer content | filled per Layout | _Card Footer in every layout, carrying a Button in the text layout. |

### Accessibility & Content Guidelines

- The template is a composition rather than a component with behaviour. Everything interactive in it, the avatar, the icon button and the footer actions, is documented by its own component.
- The media layouts lead with an image that carries no text. Give it a description in code, or make sure the heading below it does that work.
- Card content is clipped at the shell's edge, so check long headings and body text at the template's fixed width.
- Nothing here makes the card itself clickable. If the whole card is a link, that target and its focus treatment belong to the implementation.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed per Layout | 360px for text and media inset, 394px for media. The shell itself ships at 330px, so the template resizes it. |
| Height | Hug | 228px for text, 523px for media inset and 451px for media, growing with whatever replaces the placeholder content. |
| Shape | Passed to the shell | The template's Shape sets the shell's, so the corner treatment and the clipping that follows from it both come from Card base. |
| Surface and border | From the shell | The template paints nothing of its own. surface/card, the border and the clipping all belong to Card base. |

## Card Template Collapsible (documentation only)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3007-796&m=dev

### Overview

A ready-made collapsible card built on Collapsible Card, with the body already filled. It declares no properties of its own beyond its three axes, so everything else is configured through the exposed shell instance. This is a condensed record, the shell is documented in the Collapsible Card Metadata frame.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | collapsed | true | Header only. The resting state, and the one to lay out against. |
| State | expanded | - | Reveals the filled body. What appears differs by Flavor, because the shell stores its body content separately for each expanded variant. |
| Flavor | gradient | true | The gradient-outlined card, and this template's default. Note the shell's own default is the plain flavour, so the two disagree. |
| Flavor | default | - | The plain card with no outline. Its expanded body ships with an image that the gradient flavour's does not have. |
| Shape | sharp | true | Square corners. It sets the shell's Shape to sharp. |
| Shape | round | - | Softened corners. It sets the shell's Shape to rounded. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Collapsible Card | exposed nested instance | The shell the template is built on. Exposed, so its State, Flavor, Shape and body slot all stay reachable. See the Collapsible Card Metadata frame. |
| Body content | differs per Flavor | The default flavour's expanded body holds _Card Body, _Card Image and _Card Footer. The gradient flavour's holds _Card Body and _Card Footer with no image. That difference follows from the shell storing body content separately for each expanded variant. |

### Accessibility & Content Guidelines

- Expanding is not modelled as a behaviour. The toggle target, its focus treatment and its expanded state all belong to the implementation.
- The two flavours ship with different body content, so what a reader sees on opening depends on a choice that looks purely decorative.
- The gradient outline carries no meaning of its own and should not be the only marker of importance.
- Collapsed content is hidden rather than removed, so make sure assistive technology reaches it only when the card is open.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed | 385px at every variant, inherited from the shell. |
| Height | Hug | 78px collapsed and 481px expanded at the default flavour, 82px and 226px at gradient. The two flavours differ by far more than the 4px their outline accounts for, because their bodies hold different content. |
| Shape and Flavor | Passed to the shell | Both map straight onto the shell's own axes. The surface, the outline and the clipping all belong to Collapsible Card. |
