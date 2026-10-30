# Bottom Sheet

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5207-2592&m=dev

## Bottom Sheet

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5207-3343&m=dev

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
| Bottom Sheet | padding.bottom | 24 | space.section |
| Bottom Sheet/Sheet Handle | padding.left | 24 | space.section |
| Bottom Sheet/Sheet Handle | padding.right | 24 | space.section |
| Bottom Sheet/Sheet Handle | padding.top | 16 | space.lg |
| Bottom Sheet/Sheet Handle | padding.bottom | 16 | space.lg |
| Bottom Sheet/_Sheet Header | itemSpacing | 8 | space.sm |
| Bottom Sheet/_Sheet Header | padding.left | 24 | space.section |
| Bottom Sheet/_Sheet Header | padding.right | 24 | space.section |
| Bottom Sheet/_Sheet Header | padding.top | 16 | space.gutter |
| Bottom Sheet/_Sheet Header | padding.bottom | 16 | space.gutter |
| Bottom Sheet/Menu List | itemSpacing | 4 | space.xxs |
| Bottom Sheet/Menu List | padding.left | 12 | space.card |
| Bottom Sheet/Menu List | padding.right | 12 | space.card |
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
| Bottom Sheet/_Card Footer | padding.left | 24 | space.xl |
| Bottom Sheet/_Card Footer | padding.right | 24 | space.xl |
| Bottom Sheet/_Card Footer | padding.top | 16 | space.lg |
| Bottom Sheet/_Card Footer | padding.bottom | 16 | space.lg |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Content Type | grid | Bottom Sheet/Menu List | itemSpacing | space.md |
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
| Content Type | generic | Bottom Sheet | padding.bottom | — |
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
| Content Type | generic | Bottom Sheet/Content Slot | padding.left | space.card |
| Content Type | generic | Bottom Sheet/Content Slot | padding.right | space.card |
| Content Type | generic | Bottom Sheet/Content Slot | padding.top | space.md |
| Content Type | generic | Bottom Sheet/Content Slot | padding.bottom | space.md |

## _Sheet Header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5207-2710&m=dev

### Layer structure

- _Sheet Header (COMPONENT)
  - _Sheet Header/Icon (INSTANCE, icon: arrow_back)
  - _Sheet Header/Sheet Title (TEXT)

### Resolved tokens (default variant: Alignment=start)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Sheet Header | itemSpacing | 8 | space.sm |
| _Sheet Header | padding.left | 24 | space.section |
| _Sheet Header | padding.right | 24 | space.section |
| _Sheet Header | padding.top | 16 | space.gutter |
| _Sheet Header | padding.bottom | 16 | space.gutter |
| _Sheet Header/Sheet Title | fill[0] | #0c0d0e | foreground.primary |
| _Sheet Header/Sheet Title | fontSize | 16 | title.medium.font size |
| _Sheet Header/Sheet Title | lineHeight | 20 | title.medium.line height |
| _Sheet Header/Sheet Title | letterSpacing | 0 | title.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Alignment | center | _Sheet Header | itemSpacing | space.gutter |

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
| Grid Menu Item/Label | fontSize | 16 | label.large.font size |
| Grid Menu Item/Label | lineHeight | 24 | label.large.line height |
| Grid Menu Item/Label | letterSpacing | 0 | label.large.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Active | true | Grid Menu Item/Label | fill[0] | interactive.subtle.foreground.default |
| Disabled | true | Grid Menu Item/Label | fill[0] | interactive.subtle.foreground.disabled |
| State | hover | Grid Menu Item | fill[0] | interactive.ghost.background.hover |
| State | pressed | Grid Menu Item | fill[0] | interactive.ghost.background.pressed |
| Rounded | false | Grid Menu Item | cornerRadius | radius.none |
