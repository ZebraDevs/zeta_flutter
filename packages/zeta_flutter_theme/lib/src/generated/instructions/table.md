# Table

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4364-1629&m=dev

## Table

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6717-3146&m=dev

### Overview

A data table with rows of content arranged in columns, framed by an optional controls bar above and a pagination footer below. Reading top to bottom it is the controls bar, the table content, and the footer, each of the two outer bars removable on its own without affecting the other. This instance always lays out its columns in the plain left-to-right arrangement, not the frozen or horizontally scrolling arrangement Table Content also offers.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| hasControl | true | true | Shows the controls bar above the content, holding the search field and the controls slot. Turn it off when the table doesn't need its own search or extra actions above it. |
| hasControl | false | - | Removes the controls bar entirely, the content starts at the top of the table. |
| hasFooter | true | true | Shows the footer below the content, holding the page summary text and the pagination control. Turn it off for a table short enough that pagination has nothing to do. |
| hasFooter | false | - | Removes the footer entirely, the content ends at the bottom of the table. |
| Shape | rounded | true | Every component inside the table takes its rounded option: search, buttons, checkboxes, status labels and pagination, including the table's own corners. |
| Shape | sharp | - | Every component inside the table takes its sharp option. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined for the controls bar or the footer appearing and disappearing. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Controls bar | Table Controls instance | Holds a search field (instance of the search component) fixed to its own Shape, Size and Flavour, and an open Controls Slot for whatever actions a consumer adds. Whether each shows on its own is not reachable from Table, only hasControl toggles them together. |
| Content | Table Content instance | Always the plain left-to-right column layout. Table Content also offers a frozen-column and a horizontally scrolling arrangement, neither used by this instance and neither exposed as a property of Table. |
| Footer | Table Footer instance | Holds a locked summary text and a Pagination instance set to Outline. Whether each shows on its own is not reachable from Table, only hasFooter toggles them together. |

### Anatomy

1. **Controls bar** — Holds a search field that can be toggled on/off. Controls Slot houses extra actions, and can be shown/hidden with the hasControl property.

### How to use

**Do:**
- Turn hasControl off when the table doesn't need its own search or extra actions above it.
- Turn hasFooter off for a table short enough that pagination has nothing to do.

**Don't:**
- Don't expect Table's own properties to hide just the search field or just the pagination summary on their own, hasControl and hasFooter each toggle their whole section together.
- Don't expect a frozen or horizontally scrolling column arrangement from this instance, it always uses the plain left-to-right layout no matter what fills the columns.

### Accessibility & Content Guidelines

- Nothing in this file marks keyboard navigation between cells, rows or the controls above and below them. Whether this table participates in a grid-style keyboard pattern needs confirming outside Figma.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed | 979px, held fixed rather than hugging its content. |
| Height | Hug | Hugs the controls bar, the content and the footer stacked with no gap between them. |
| Padding | Fixed | 0 on every side of the table itself, each section carries its own padding instead. |
| Controls bar | Fixed height, fixed padding | Fixed at 60px tall, 16px padding on the left and right, 12px on top and bottom. Its search field and controls slot align to the right-hand side, leaving the left side open. |
| Footer | Fixed height, fixed padding | Fixed at 60px tall, the same 16px and 12px padding as the controls bar. The summary text and the pagination control push to opposite ends rather than sitting a fixed distance apart. |
| Content | Fill | Takes whatever height is left between the controls bar and the footer, 351px with both shown. |

### Layer structure

- Table (COMPONENT)
  - Table/Table Controls (INSTANCE)
  - Table/Table Content (INSTANCE)
  - Table/Table Footer (INSTANCE)

### Resolved tokens (default variant: Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Table | cornerRadius | 6 | radius.element-md |
| Table/Table Controls | fill[0] | #ffffff | surface.section |
| Table/Table Controls | itemSpacing | 8 | space.sm |
| Table/Table Controls | padding.left | 16 | space.lg |
| Table/Table Controls | padding.right | 16 | space.lg |
| Table/Table Controls | padding.top | 12 | space.md |
| Table/Table Controls | padding.bottom | 12 | space.md |
| Table/Table Footer | fill[0] | #ffffff | surface.section |
| Table/Table Footer | itemSpacing | 178 | — |
| Table/Table Footer | padding.left | 16 | space.lg |
| Table/Table Footer | padding.right | 16 | space.lg |
| Table/Table Footer | padding.top | 12 | space.md |
| Table/Table Footer | padding.bottom | 12 | space.md |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | sharp | Table | cornerRadius | — |

## Table Footer

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5302-5897&m=dev

### Layer structure

- Table Footer (COMPONENT)
  - Table Footer/Page Details (TEXT)
  - Table Footer/Pagination (INSTANCE)

### Resolved tokens (default variant: Table Footer)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Table Footer | fill[0] | #ffffff | surface.section |
| Table Footer | itemSpacing | 178 | — |
| Table Footer | padding.left | 16 | space.lg |
| Table Footer | padding.right | 16 | space.lg |
| Table Footer | padding.top | 12 | space.md |
| Table Footer | padding.bottom | 12 | space.md |
| Table Footer/Page Details | fill[0] | #545963 | foreground.secondary |
| Table Footer/Page Details | fontSize | 14 | body.small.font size |
| Table Footer/Page Details | lineHeight | 18 | body.small.line height |
| Table Footer/Page Details | letterSpacing | 0 | body.small.letter spacing |
| Table Footer/Pagination | itemSpacing | 8 | space.sm |

## Table Controls

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5302-5786&m=dev

### Layer structure

- Table Controls (COMPONENT)
  - Table Controls/Search (INSTANCE)
  - Table Controls/Controls Slot (SLOT)

### Resolved tokens (default variant: Table Controls)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Table Controls | fill[0] | #ffffff | surface.section |
| Table Controls | itemSpacing | 8 | space.sm |
| Table Controls | padding.left | 16 | space.lg |
| Table Controls | padding.right | 16 | space.lg |
| Table Controls | padding.top | 12 | space.md |
| Table Controls | padding.bottom | 12 | space.md |
| Table Controls/Search | height | 36 | control.sm |
| Table Controls/Search | fill[0] | #ffffff | interactive.neutral.background.default |
| Table Controls/Search | stroke[0] | #ced2db | interactive.neutral.border.default |
| Table Controls/Search | cornerRadius | 0 | radius.none |
| Table Controls/Search | strokeWeight | 1 | stroke.thin |
| Table Controls/Search | itemSpacing | 4 | space.xxs |
| Table Controls/Search | padding.left | 12 | space.md |
| Table Controls/Search | padding.right | 12 | space.md |
| Table Controls/Search | padding.top | 8 | space.sm |
| Table Controls/Search | padding.bottom | 8 | space.sm |
| Table Controls/Controls Slot | itemSpacing | 8 | space.sm |

## _Avatar and text

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5137-325&m=dev

### Layer structure

- _Avatar and text (COMPONENT)
  - _Avatar and text/Avatar (INSTANCE)
  - _Avatar and text/Title + Subtitle (FRAME)
    - _Avatar and text/Title + Subtitle/Title (TEXT)
    - _Avatar and text/Title + Subtitle/Subtitle (TEXT)

### Resolved tokens (default variant: State=enabled)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Avatar and text | itemSpacing | 8 | space.sm |
| _Avatar and text/Title + Subtitle/Title | fill[0] | #0c0d0e | foreground.primary |
| _Avatar and text/Title + Subtitle/Title | fontSize | 14 | body.small.font size |
| _Avatar and text/Title + Subtitle/Title | lineHeight | 18 | body.small.line height |
| _Avatar and text/Title + Subtitle/Title | letterSpacing | 0 | body.small.letter spacing |
| _Avatar and text/Title + Subtitle/Subtitle | fill[0] | #545963 | foreground.secondary |
| _Avatar and text/Title + Subtitle/Subtitle | fontSize | 12 | body.xsmall.font size |
| _Avatar and text/Title + Subtitle/Subtitle | lineHeight | 16 | body.xsmall.line height |
| _Avatar and text/Title + Subtitle/Subtitle | letterSpacing | 0 | body.xsmall.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | disabled | _Avatar and text/Title + Subtitle/Title | fill[0] | foreground.disabled |
| State | disabled | _Avatar and text/Title + Subtitle/Subtitle | fill[0] | foreground.disabled |

## _Label

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5145-1505&m=dev

### Layer structure

- _Label (COMPONENT)
  - _Label/Label (FRAME)
    - _Label/Label/Label (TEXT)
    - _Label/Label/_Sort (INSTANCE)
  - _Label/Trailing Icon (INSTANCE, icon: filter)

### Resolved tokens (default variant: State=enabled)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Label | itemSpacing | 17 | — |
| _Label/Label | itemSpacing | 4 | space.xxs |
| _Label/Label/Label | fill[0] | #0c0d0e | foreground.primary |
| _Label/Label/Label | fontSize | 14 | label.medium.font size |
| _Label/Label/Label | lineHeight | 20 | label.medium.line height |
| _Label/Label/Label | letterSpacing | 0 | label.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | disabled | _Label/Label/Label | fill[0] | foreground.disabled |

## _Data Cell

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5203-3689&m=dev

### Layer structure

- _Data Cell (COMPONENT)
  - _Data Cell/Cell (FRAME)
    - _Data Cell/Cell/Content (FRAME)
      - _Data Cell/Cell/Content/_Avatar and text (INSTANCE)

### Resolved tokens (default variant: State=enabled)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Data Cell | stroke[0] | #e0e3e9 | border.subtle |
| _Data Cell | strokeWeight | 1 | — |
| _Data Cell/Cell | fill[0] | #ffffff | interactive.neutral.background.default |
| _Data Cell/Cell | stroke[0] | #ced2db | border.default |
| _Data Cell/Cell | strokeWeight | 0 | stroke.base |
| _Data Cell/Cell | padding.left | 16 | space.lg |
| _Data Cell/Cell | padding.right | 16 | space.lg |
| _Data Cell/Cell | padding.top | 12 | space.md |
| _Data Cell/Cell | padding.bottom | 12 | space.md |
| _Data Cell/Cell/Content/_Avatar and text | itemSpacing | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | disabled | _Data Cell/Cell | fill[0] | — |
| State | hover | _Data Cell/Cell | fill[0] | interactive.neutral.background.hover |
| State | selected | _Data Cell/Cell | fill[0] | interactive.neutral.background.selected |

## _Header Cell

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5238-5166&m=dev

### Layer structure

- _Header Cell (COMPONENT)
  - _Header Cell/Cell (FRAME)
    - _Header Cell/Cell/Content (FRAME)
      - _Header Cell/Cell/Content/_Label (INSTANCE)

### Resolved tokens (default variant: State=enabled, Sorted=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Header Cell | stroke[0] | #ced2db | border.default |
| _Header Cell | strokeWeight | 1 | stroke.thin |
| _Header Cell/Cell | fill[0] | #ffffff | interactive.neutral.background.default |
| _Header Cell/Cell | stroke[0] | #ced2db | border.default |
| _Header Cell/Cell | strokeWeight | 0 | stroke.base |
| _Header Cell/Cell | padding.left | 16 | space.lg |
| _Header Cell/Cell | padding.right | 16 | space.lg |
| _Header Cell/Cell | padding.top | 12 | space.md |
| _Header Cell/Cell | padding.bottom | 12 | space.md |
| _Header Cell/Cell/Content/_Label | itemSpacing | 17 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | disabled | _Header Cell/Cell | fill[0] | interactive.neutral.background.disabled |
| State | hover | _Header Cell/Cell | fill[0] | interactive.neutral.background.hover |
| State | focus | _Header Cell/Cell | fill[0] | interactive.neutral.background.focused |
| State | focus | _Header Cell/Cell | stroke[0] | border.focus |
| State | focus | _Header Cell/Cell | strokeWeight | stroke.thick |

## Slot

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5365-6222&m=dev

### Layer structure

- Slot (COMPONENT)
  - Slot/Slot (SLOT)

### Resolved tokens (default variant: Slot)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Slot/Slot | itemSpacing | 8 | space.sm |

## _Sort

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5413-1195&m=dev

### Layer structure

- _Sort (COMPONENT)
  - _Sort/Caret Sort (FRAME)
    - _Sort/Caret Sort/Icon (VECTOR)

### Resolved tokens (default variant: State=default, Direction=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Sort/Caret Sort/Icon | fill[0] | #7a8190 | foreground.tertiary |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | _Sort/Caret Sort/Icon | fill[0] | foreground.secondary |
| State | disabled | _Sort/Caret Sort/Icon | fill[0] | foreground.disabled |

## Table Column/Default

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5302-5898&m=dev

### Layer structure

- Table Column/Default (COMPONENT)
  - Table Column/Default/_Header Cell (INSTANCE)
  - Table Column/Default/_Data Cell[1] (INSTANCE)
  - Table Column/Default/_Data Cell[2] (INSTANCE)
  - Table Column/Default/_Data Cell[3] (INSTANCE)
  - Table Column/Default/Slot Container (SLOT)

### Resolved tokens (default variant: Table Column/Default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Table Column/Default/_Header Cell | stroke[0] | #ced2db | border.default |
| Table Column/Default/_Header Cell | strokeWeight | 1 | stroke.thin |
| Table Column/Default/_Data Cell[1] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Default/_Data Cell[1] | strokeWeight | 1 | — |
| Table Column/Default/_Data Cell[2] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Default/_Data Cell[2] | strokeWeight | 1 | — |
| Table Column/Default/_Data Cell[3] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Default/_Data Cell[3] | strokeWeight | 1 | — |

## Table Content

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6057-7556&m=dev

### Layer structure

- Table Content (COMPONENT)
  - Table Content/Table Column/Default[1] (INSTANCE)
  - Table Content/Table Column/Default[2] (INSTANCE)
  - Table Content/Slot Container (SLOT)
  - Table Content/Frozen Slot Container (SLOT)
  - Table Content/Scrollable Columns (FRAME)
    - Table Content/Scrollable Columns/Columns (FRAME)
      - Table Content/Scrollable Columns/Columns/Slot Container (SLOT)
    - Table Content/Scrollable Columns/Scrollbar (INSTANCE)

### Resolved tokens (default variant: Column Position=default, Horizontal Scroll=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Column Position | frozen | Table Content/Frozen Slot Container | stroke[0] | border.default |
