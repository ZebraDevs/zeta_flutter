# Bottom Sheet

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5207-2592&m=dev

## Bottom Sheet

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5207-3343&m=dev

### Overview

A surface anchored to the bottom edge of the screen, holding supplementary content or a short set of actions without moving a person off the view behind it. Content Type picks between a run of list rows, a grid of tiles, and a slot that takes whatever the product supplies. All three carry the same drag handle, header and two action footer, so the only thing that changes between them is what sits in the middle.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Content Type | list | true | Use for a run of labelled actions a person reads down. Rows are full width, so an option needing its own artwork or count will not fit. |
| Content Type | grid | — | Use where options are recognised by their icon rather than read, three to a row. Labels sit beneath the icon and stay short, so a long one wraps and lengthens the whole row. |
| Content Type | generic | — | Use when neither arrangement fits and the content is yours to supply. Nothing is laid out for you beyond the padding, so spacing between items becomes your responsibility. |
| Content Slot | slot | — | Takes the sheet’s content on generic. It is the only arrangement with a slot, so filling it has no effect on list or grid. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The sheet has no interaction states. Hover, press and focus belong to the rows, tiles and buttons placed inside it. |
| Content Type | The Content Type value | — | The region between the header and the footer is replaced outright. The handle, the header and the footer are identical across all three. |
| Row and tile states | The nested item’s own state | — | A list row carries the Menu Item states and a grid tile the Grid Menu Item states. Each is described in that component’s own frame. |
| Footer actions | The nested Button states | — | The footer holds one outline and one primary button, and their states belong to Button. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Nothing in the component describes how the sheet arrives at the bottom edge or leaves it. |
| Anchoring | Only the top two corners are rounded, which is what fixes the sheet to the bottom edge. The bottom two stay square because they sit past the edge of the screen. |
| Elevation | No shadow and no scrim are defined on the sheet. Whatever separates it from the content behind comes from the screen that presents it. |
| Height | The sheet hugs its content, so it stands as tall as the handle, header, content and footer make it. Nothing in the component caps that height. |
| Content ownership | Only generic takes a slot. list and grid lay out their own items, so moving between the three replaces the content region rather than refilling it. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Content | Content Slot, consumer owned | Live on generic only. It takes whatever the product supplies, with the sheet providing the padding around it and the spacing between items. |
| List items | Menu Item, parent owned | list lays out a run of menu rows, each set to its default state with an icon type and square corners. Menu Item is documented on the Dropdown page. |
| Grid tiles | Grid Menu Item, parent owned | grid lays out tiles three to a row, all set to rounded. They are documented in their own frame. |
| Item count | Figma only, six items drawn | The list and grid regions hold six items so the arrangement can be read at a glance without a designer building one. Both take a run of items, and how many is the product’s decision. |
| Header | _Sheet Header, parent owned | Carries the sheet title and an optional leading icon. Bottom Sheet always sets it to start, where the icon leads and the title reads from the left. Its own center value centres the title and moves the icon after it. |
| Header text | Not exposed | The title belongs to the header rather than to the sheet, so it is set on that part rather than passed in from here. |
| Handle | Sheet Handle, parent owned | The drag affordance along the top edge. It declares nothing, so it is identical on all three arrangements. |
| Footer | _Card Footer, parent owned | Set to its two action arrangement, an outline button beside a primary one, both set to small. It is Card’s footer reused here. |

### Anatomy

1. **Handle** — The drag affordance along the top edge, centred above the header. It is the same on every arrangement.
2. **Header** — The sheet’s title, with an optional leading icon before it. The title belongs to the header rather than to the sheet.
3. **Content region** — A run of rows, a grid of tiles, or a slot, depending on Content Type. It is the only part that changes between the three.
4. **Footer** — Two actions closing the sheet off, an outline button beside a primary one. It is present on every arrangement.

### How to use

**Do:**
- Pick Content Type for how a person reads the options. list is for reading down a set of labels, grid for recognising them by icon.
- Use generic when the content is not a set of options at all. It is the only arrangement that takes a slot.

**Don't:**
- Don't try to set the title through the sheet. The header owns that text, so it is set on the header rather than passed in.
- Don't rely on the sheet to cap its own height. It hugs whatever it holds, so a long run of items has to be limited by the screen presenting it.

### Accessibility & Content Guidelines

- A bottom sheet arrives over the content a person was reading, so the screen presenting it has to say what it is and move focus into it. Nothing in the component does that on its own. The drag handle is a visual affordance with no label and no focusable control behind it, so dismissing the sheet has to be reachable another way, through the footer or through a gesture the screen supplies. The title in the header is the sheet’s accessible name, so it should read as a short noun phrase a person would recognise out of context. The footer’s two actions are the only controls present on every arrangement, which makes them the dependable way out.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 360 wide. Height follows the content, standing at 452 on list, 380 on grid and 388 on generic at the item counts drawn. |
| Direction | Column | Handle, header, content region and footer stacked with no gap between them, since each part carries its own padding. |
| Surface | Tokenised | surface/sheet across all three arrangements. |
| Radius | Top corners only | radius/container on the top two corners, with the bottom two left square. |
| Padding | Tokenised | space/card below the footer on all three arrangements. |
| Handle | Fill width | Padded space/lg above and below and space/section at the sides. The bar itself is control/target-min wide at radius/pill, drawn in border/default. |
| Header | Fixed width | Padded space/gutter above and below and space/section at the sides, with space/sm between the icon and the title. The title is title/medium in foreground/primary. |
| Content region | Fill | Padded space/md above and below, with space/lg at the sides on list and space/gutter on grid and generic. Items sit space/xxs apart on list, and space/md apart on grid and generic. |
| Grid rows | Fill | Three tiles to a row, space/md apart, each taking an equal share of the row width. |
| Footer | Set to two actions | Its two buttons each fill an equal share of the row. The padding and spacing around them belong to _Card Footer. |
| Elevation | None defined | No shadow and no scrim sit on the sheet. |

### Layer structure

- Bottom Sheet (COMPONENT)
  - Bottom Sheet/Sheet Handle (INSTANCE)
  - Bottom Sheet/_Sheet Header (INSTANCE)
  - Bottom Sheet/Menu List (FRAME)
    - Bottom Sheet/Menu List/Menu Item[1] (INSTANCE)
    - Bottom Sheet/Menu List/Menu Item[2] (INSTANCE)
    - Bottom Sheet/Menu List/Menu Item[3] (INSTANCE)
    - Bottom Sheet/Menu List/Menu Item[4] (INSTANCE)
    - Bottom Sheet/Menu List/Menu Item[5] (INSTANCE)
    - Bottom Sheet/Menu List/Menu Item[6] (INSTANCE)
    - Bottom Sheet/Menu List/Row[1] (FRAME)
      - Bottom Sheet/Menu List/Row[1]/Grid Menu Item[1] (INSTANCE)
      - Bottom Sheet/Menu List/Row[1]/Grid Menu Item[2] (INSTANCE)
      - Bottom Sheet/Menu List/Row[1]/Grid Menu Item[3] (INSTANCE)
    - Bottom Sheet/Menu List/Row[2] (FRAME)
      - Bottom Sheet/Menu List/Row[2]/Grid Menu Item[1] (INSTANCE)
      - Bottom Sheet/Menu List/Row[2]/Grid Menu Item[2] (INSTANCE)
      - Bottom Sheet/Menu List/Row[2]/Grid Menu Item[3] (INSTANCE)
  - Bottom Sheet/_Card Footer (INSTANCE)
  - Bottom Sheet/Content Slot (SLOT)

### Resolved tokens (default variant: Content Type=list)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Bottom Sheet | fill[0] | #ffffff | surface.sheet |
| Bottom Sheet | cornerRadius | 0 | radius.container |
| Bottom Sheet | padding.bottom | 12 | space.card |
| Bottom Sheet/Sheet Handle | padding.left | 24 | space.section |
| Bottom Sheet/Sheet Handle | padding.right | 24 | space.section |
| Bottom Sheet/Sheet Handle | padding.top | 16 | space.lg |
| Bottom Sheet/Sheet Handle | padding.bottom | 16 | space.lg |
| Bottom Sheet/_Sheet Header | itemSpacing | 4 | space.xxs |
| Bottom Sheet/_Sheet Header | padding.left | 16 | space.lg |
| Bottom Sheet/_Sheet Header | padding.right | 16 | space.lg |
| Bottom Sheet/_Sheet Header | padding.top | 8 | space.sm |
| Bottom Sheet/_Sheet Header | padding.bottom | 8 | space.sm |
| Bottom Sheet/Menu List | itemSpacing | 4 | space.xxs |
| Bottom Sheet/Menu List | padding.left | 16 | space.lg |
| Bottom Sheet/Menu List | padding.right | 16 | space.lg |
| Bottom Sheet/Menu List | padding.top | 12 | space.md |
| Bottom Sheet/Menu List | padding.bottom | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[1] | height | 40 | control.md |
| Bottom Sheet/Menu List/Menu Item[1] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Bottom Sheet/Menu List/Menu Item[1] | cornerRadius | 0 | radius.none |
| Bottom Sheet/Menu List/Menu Item[1] | itemSpacing | 8 | space.sm |
| Bottom Sheet/Menu List/Menu Item[1] | padding.left | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[1] | padding.right | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[1] | padding.top | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[1] | padding.bottom | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[2] | height | 40 | control.md |
| Bottom Sheet/Menu List/Menu Item[2] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Bottom Sheet/Menu List/Menu Item[2] | cornerRadius | 0 | radius.none |
| Bottom Sheet/Menu List/Menu Item[2] | itemSpacing | 8 | space.sm |
| Bottom Sheet/Menu List/Menu Item[2] | padding.left | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[2] | padding.right | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[2] | padding.top | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[2] | padding.bottom | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[3] | height | 40 | control.md |
| Bottom Sheet/Menu List/Menu Item[3] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Bottom Sheet/Menu List/Menu Item[3] | cornerRadius | 0 | radius.none |
| Bottom Sheet/Menu List/Menu Item[3] | itemSpacing | 8 | space.sm |
| Bottom Sheet/Menu List/Menu Item[3] | padding.left | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[3] | padding.right | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[3] | padding.top | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[3] | padding.bottom | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[4] | height | 40 | control.md |
| Bottom Sheet/Menu List/Menu Item[4] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Bottom Sheet/Menu List/Menu Item[4] | cornerRadius | 0 | radius.none |
| Bottom Sheet/Menu List/Menu Item[4] | itemSpacing | 8 | space.sm |
| Bottom Sheet/Menu List/Menu Item[4] | padding.left | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[4] | padding.right | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[4] | padding.top | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[4] | padding.bottom | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[5] | height | 40 | control.md |
| Bottom Sheet/Menu List/Menu Item[5] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Bottom Sheet/Menu List/Menu Item[5] | cornerRadius | 0 | radius.none |
| Bottom Sheet/Menu List/Menu Item[5] | itemSpacing | 8 | space.sm |
| Bottom Sheet/Menu List/Menu Item[5] | padding.left | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[5] | padding.right | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[5] | padding.top | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[5] | padding.bottom | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[6] | height | 40 | control.md |
| Bottom Sheet/Menu List/Menu Item[6] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Bottom Sheet/Menu List/Menu Item[6] | cornerRadius | 0 | radius.none |
| Bottom Sheet/Menu List/Menu Item[6] | itemSpacing | 8 | space.sm |
| Bottom Sheet/Menu List/Menu Item[6] | padding.left | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[6] | padding.right | 12 | space.md |
| Bottom Sheet/Menu List/Menu Item[6] | padding.top | 4 | space.xxs |
| Bottom Sheet/Menu List/Menu Item[6] | padding.bottom | 4 | space.xxs |
| Bottom Sheet/_Card Footer | itemSpacing | 8 | space.sm |
| Bottom Sheet/_Card Footer | padding.left | 16 | space.lg |
| Bottom Sheet/_Card Footer | padding.right | 16 | space.lg |
| Bottom Sheet/_Card Footer | padding.top | 16 | space.lg |
| Bottom Sheet/_Card Footer | padding.bottom | 16 | space.lg |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Content Type | grid | Bottom Sheet/Menu List | itemSpacing | space.md |
| Content Type | grid | Bottom Sheet/Menu List | padding.left | space.gutter |
| Content Type | grid | Bottom Sheet/Menu List | padding.right | space.gutter |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[1] | height | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[1] | fill[0] | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[1] | cornerRadius | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[1] | itemSpacing | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[1] | padding.left | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[1] | padding.right | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[1] | padding.top | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[1] | padding.bottom | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[2] | height | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[2] | fill[0] | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[2] | cornerRadius | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[2] | itemSpacing | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[2] | padding.left | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[2] | padding.right | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[2] | padding.top | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[2] | padding.bottom | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[3] | height | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[3] | fill[0] | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[3] | cornerRadius | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[3] | itemSpacing | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[3] | padding.left | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[3] | padding.right | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[3] | padding.top | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[3] | padding.bottom | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[4] | height | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[4] | fill[0] | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[4] | cornerRadius | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[4] | itemSpacing | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[4] | padding.left | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[4] | padding.right | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[4] | padding.top | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[4] | padding.bottom | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[5] | height | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[5] | fill[0] | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[5] | cornerRadius | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[5] | itemSpacing | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[5] | padding.left | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[5] | padding.right | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[5] | padding.top | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[5] | padding.bottom | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[6] | height | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[6] | fill[0] | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[6] | cornerRadius | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[6] | itemSpacing | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[6] | padding.left | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[6] | padding.right | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[6] | padding.top | — |
| Content Type | grid | Bottom Sheet/Menu List/Menu Item[6] | padding.bottom | — |
| Content Type | grid | Bottom Sheet/Menu List/Row[1] | itemSpacing | space.md |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[1] | fill[0] | interactive.ghost.background.default |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[1] | cornerRadius | radius.element-sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[1] | itemSpacing | space.sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[1] | padding.left | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[1] | padding.right | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[1] | padding.top | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[1] | padding.bottom | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[2] | fill[0] | interactive.ghost.background.default |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[2] | cornerRadius | radius.element-sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[2] | itemSpacing | space.sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[2] | padding.left | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[2] | padding.right | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[2] | padding.top | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[2] | padding.bottom | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[3] | fill[0] | interactive.ghost.background.default |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[3] | cornerRadius | radius.element-sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[3] | itemSpacing | space.sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[3] | padding.left | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[3] | padding.right | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[3] | padding.top | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[1]/Grid Menu Item[3] | padding.bottom | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2] | itemSpacing | space.md |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[1] | fill[0] | interactive.ghost.background.default |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[1] | cornerRadius | radius.element-sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[1] | itemSpacing | space.sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[1] | padding.left | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[1] | padding.right | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[1] | padding.top | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[1] | padding.bottom | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[2] | fill[0] | interactive.ghost.background.default |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[2] | cornerRadius | radius.element-sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[2] | itemSpacing | space.sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[2] | padding.left | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[2] | padding.right | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[2] | padding.top | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[2] | padding.bottom | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[3] | fill[0] | interactive.ghost.background.default |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[3] | cornerRadius | radius.element-sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[3] | itemSpacing | space.sm |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[3] | padding.left | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[3] | padding.right | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[3] | padding.top | space.lg |
| Content Type | grid | Bottom Sheet/Menu List/Row[2]/Grid Menu Item[3] | padding.bottom | space.lg |
| Content Type | generic | Bottom Sheet/Menu List | itemSpacing | — |
| Content Type | generic | Bottom Sheet/Menu List | padding.left | — |
| Content Type | generic | Bottom Sheet/Menu List | padding.right | — |
| Content Type | generic | Bottom Sheet/Menu List | padding.top | — |
| Content Type | generic | Bottom Sheet/Menu List | padding.bottom | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[1] | height | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[1] | fill[0] | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[1] | cornerRadius | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[1] | itemSpacing | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[1] | padding.left | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[1] | padding.right | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[1] | padding.top | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[1] | padding.bottom | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[2] | height | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[2] | fill[0] | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[2] | cornerRadius | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[2] | itemSpacing | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[2] | padding.left | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[2] | padding.right | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[2] | padding.top | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[2] | padding.bottom | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[3] | height | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[3] | fill[0] | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[3] | cornerRadius | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[3] | itemSpacing | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[3] | padding.left | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[3] | padding.right | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[3] | padding.top | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[3] | padding.bottom | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[4] | height | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[4] | fill[0] | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[4] | cornerRadius | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[4] | itemSpacing | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[4] | padding.left | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[4] | padding.right | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[4] | padding.top | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[4] | padding.bottom | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[5] | height | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[5] | fill[0] | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[5] | cornerRadius | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[5] | itemSpacing | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[5] | padding.left | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[5] | padding.right | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[5] | padding.top | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[5] | padding.bottom | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[6] | height | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[6] | fill[0] | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[6] | cornerRadius | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[6] | itemSpacing | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[6] | padding.left | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[6] | padding.right | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[6] | padding.top | — |
| Content Type | generic | Bottom Sheet/Menu List/Menu Item[6] | padding.bottom | — |
| Content Type | generic | Bottom Sheet/Content Slot | itemSpacing | space.md |
| Content Type | generic | Bottom Sheet/Content Slot | padding.left | space.gutter |
| Content Type | generic | Bottom Sheet/Content Slot | padding.right | space.gutter |
| Content Type | generic | Bottom Sheet/Content Slot | padding.top | space.md |
| Content Type | generic | Bottom Sheet/Content Slot | padding.bottom | space.md |

## _Sheet Header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5207-2710&m=dev

### Layer structure

- _Sheet Header (COMPONENT)
  - _Sheet Header/Icon Button (INSTANCE)
  - _Sheet Header/Sheet Title (TEXT)

### Resolved tokens (default variant: Alignment=start)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Sheet Header | itemSpacing | 4 | space.xxs |
| _Sheet Header | padding.left | 16 | space.lg |
| _Sheet Header | padding.right | 16 | space.lg |
| _Sheet Header | padding.top | 8 | space.sm |
| _Sheet Header | padding.bottom | 8 | space.sm |
| _Sheet Header/Icon Button | width | 36 | control.sm |
| _Sheet Header/Icon Button | height | 36 | control.sm |
| _Sheet Header/Icon Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Sheet Header/Icon Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| _Sheet Header/Icon Button | cornerRadius | 4 | radius.element-sm |
| _Sheet Header/Icon Button | strokeWeight | 0 | stroke.base |
| _Sheet Header/Icon Button | padding.left | 4 | space.xxs |
| _Sheet Header/Icon Button | padding.right | 4 | space.xxs |
| _Sheet Header/Icon Button | padding.top | 4 | space.xxs |
| _Sheet Header/Icon Button | padding.bottom | 4 | space.xxs |
| _Sheet Header/Sheet Title | fill[0] | #0c0d0e | foreground.primary |
| _Sheet Header/Sheet Title | fontSize | 16 | title.medium.font size |
| _Sheet Header/Sheet Title | lineHeight | 20 | title.medium.line height |
| _Sheet Header/Sheet Title | letterSpacing | 0 | title.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Alignment | center | _Sheet Header | itemSpacing | space.gutter |
| Alignment | center | _Sheet Header | padding.top | space.gutter |
| Alignment | center | _Sheet Header | padding.bottom | space.gutter |

## Sheet Handle

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5207-2714&m=dev

### Layer structure

- Sheet Handle (COMPONENT)
  - Sheet Handle/Handle bar (RECTANGLE)

### Resolved tokens (default variant: Sheet Handle)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Sheet Handle | padding.left | 24 | space.section |
| Sheet Handle | padding.right | 24 | space.section |
| Sheet Handle | padding.top | 16 | space.lg |
| Sheet Handle | padding.bottom | 16 | space.lg |
| Sheet Handle/Handle bar | width | 40 | control.target-min |
| Sheet Handle/Handle bar | fill[0] | #ced2db | border.default |
| Sheet Handle/Handle bar | cornerRadius | 9999 | radius.pill |

## Grid Menu Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5224-5199&m=dev

### Overview

One tile of the grid arrangement inside a bottom sheet: an icon above a short label on a tappable square. State carries the ordinary pointer feedback, while Active marks the option a person is on and Disabled puts one out of reach. Bottom Sheet places it three to a row rather than a consumer using it on its own.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | default | true | The resting tile. Use it for every option a person is not currently touching. |
| State | hover | — | Pointer feedback on the tile’s ground. It is the only thing that moves, so the icon and label stay as they are. |
| State | pressed | — | The moment of the tap, a step further than hover. It reports contact rather than selection, so it does not persist. |
| Active | false | true | An ordinary tile that is not the current choice. |
| Active | true | — | Marks the option a person is on now. It recolours the label and leaves the ground untouched, so it reads as a quiet mark rather than a strong one. |
| Disabled | false | true | A tile that can be chosen. |
| Disabled | true | — | Puts the option out of reach. The label mutes and nothing else changes, so the tile keeps the same ground as an available one. |
| Rounded | true | true | Use inside a sheet whose other surfaces are rounded, which is how Bottom Sheet places it. |
| Rounded | false | — | Squares the tile’s corners. Nothing else differs between the two. |
| Label | text | Label | Names the option beneath its icon. The tile holds a fixed width, so a long label wraps and makes every tile in the row taller. |
| Show Badge | false | true | Leaves the tile unmarked, which is the ordinary case. |
| Show Badge | true | — | Adds a dot over the icon for an option needing attention. It carries no number, so it says that something is there and not how much. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | State=default | — | interactive/ghost/background/default behind the icon, with the label in foreground/primary. |
| hover | State=hover | — | The ground moves to interactive/ghost/background/hover. The icon and the label are unchanged. |
| pressed | State=pressed | — | The ground moves to interactive/ghost/background/pressed. The icon and the label are unchanged. |
| active | Active=true | — | The label takes interactive/subtle/foreground/default. The ground stays at its default, so the label is the only signal. |
| disabled | Disabled=true | — | The label takes interactive/subtle/foreground/disabled. The ground and the icon are unchanged. |
| Combinations | Active or Disabled with hover or pressed | — | Active and Disabled are each drawn at the default state, so pointer feedback and those two marks do not combine. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. A tile changes by taking a different state, and nothing animates between one and the next. |
| Signal strength | Active and Disabled both change the label colour and nothing else. The ground reports pointer feedback alone, so selection and availability are carried entirely by the text. |
| State coverage | State pairs with neither Active nor Disabled. Each of those two is drawn at the default state only. |
| Width | On its own the tile is a fixed square. Bottom Sheet stretches it to fill an equal share of its row, so the drawn width is not the width a reader meets. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | Consumer owned, set through Label. It is the only text the tile holds. |
| Icon | Icon, parent owned | Set to large. It is not exposed as an input, so the glyph is fixed rather than chosen per tile. |
| Badge | Notification Indicator, parent owned | Set to small and shown by Show Badge. Its own colour and shape belong to Notification Indicator, and it carries no number. |

### Anatomy

1. **Tile** — The tappable square. Its ground is what answers hover and press, and its corner follows Rounded.
2. **Indicator** — The icon, with the badge sitting over it when Show Badge is on. The glyph is fixed rather than chosen per tile.
3. **Label** — The option’s name beneath the icon. It is the only text the tile holds, and the only part that changes on Active or Disabled.

### How to use

**Do:**
- Keep labels to a word or two. The row aligns to its tallest tile, so one label that wraps lengthens every tile beside it.
- Use Show Badge for something needing attention rather than for a count. The dot carries no number of its own.

**Don't:**
- Don't rely on Active to stand out by itself. It recolours the label and leaves the ground alone, so pair it with whatever else marks the current choice.
- Don't expect hover or press to show on an active or a disabled tile. Both of those are drawn at the default state only.

### Accessibility & Content Guidelines

- Active and Disabled are both carried by the label’s colour alone, with no change of ground, shape or icon, so neither is distinguishable to a person who cannot rely on hue. Both need announcing as state, and a disabled tile needs taking out of the tab order rather than only dimming. The icon is what a person recognises the option by and it carries no text of its own, so the label has to name the option rather than qualify it. The badge is a dot with no number and no label, so whatever it reports needs saying in words wherever that matters.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | A 92 square on its own. Inside a bottom sheet it fills an equal share of its row, which brings it to 101 at three to a row. |
| Direction | Column | Icon above label, space/sm apart, centred on both axes. |
| Padding | Tokenised | space/lg on all four sides. |
| Radius | Per Rounded | radius/element-sm when true and radius/none when false. |
| Ground | Per State | interactive/ghost/background at default, hover and pressed. Active and Disabled leave it alone. |
| Label | Per Active and Disabled | label/medium in foreground/primary normally, interactive/subtle/foreground/default when Active, and interactive/subtle/foreground/disabled when Disabled. |
| Icon | Set to large | The glyph above the label. It does not change with any state. |
| Badge | Set to small | Sits over the icon when Show Badge is on, within the same block the icon occupies. |

### Layer structure

- Grid Menu Item (COMPONENT)
  - Grid Menu Item/Indicator (FRAME)
    - Grid Menu Item/Indicator/Icon (INSTANCE, icon: star)
    - Grid Menu Item/Indicator/Notification Indicator (INSTANCE)
  - Grid Menu Item/Label (TEXT)

### Resolved tokens (default variant: Active=false, Disabled=false, State=default, Rounded=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Grid Menu Item | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Grid Menu Item | cornerRadius | 4 | radius.element-sm |
| Grid Menu Item | itemSpacing | 8 | space.sm |
| Grid Menu Item | padding.left | 16 | space.lg |
| Grid Menu Item | padding.right | 16 | space.lg |
| Grid Menu Item | padding.top | 16 | space.lg |
| Grid Menu Item | padding.bottom | 16 | space.lg |
| Grid Menu Item/Indicator | itemSpacing | 10 | — |
| Grid Menu Item/Indicator/Notification Indicator | fill[0] | #d70015 | interactive.destructive.background.default |
| Grid Menu Item/Indicator/Notification Indicator | stroke[0] | #ffffff | border.inverse |
| Grid Menu Item/Indicator/Notification Indicator | cornerRadius | 9999 | radius.pill |
| Grid Menu Item/Indicator/Notification Indicator | strokeWeight | 0 | stroke.base |
| Grid Menu Item/Label | fill[0] | #0c0d0e | foreground.primary |
| Grid Menu Item/Label | fontSize | 14 | label.medium.font size |
| Grid Menu Item/Label | lineHeight | 20 | label.medium.line height |
| Grid Menu Item/Label | letterSpacing | 0 | label.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Active | true | Grid Menu Item/Label | fill[0] | interactive.subtle.foreground.default |
| Disabled | true | Grid Menu Item/Label | fill[0] | interactive.subtle.foreground.disabled |
| State | hover | Grid Menu Item | fill[0] | interactive.ghost.background.hover |
| State | pressed | Grid Menu Item | fill[0] | interactive.ghost.background.pressed |
| Rounded | false | Grid Menu Item | cornerRadius | radius.none |
