# Table

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4364-1629&m=dev

## Table

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6717-3146&m=dev

### Overview

A data table with rows of content in columns, framed by an optional controls bar above and a footer below. It can select and count rows, sort, search, filter and page them, resize, show, hide and freeze columns, and open a compact actions menu per row. The controls bar, content and footer are exposed, so their own properties are set from Table.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| hasControl | true | true | Shows the controls bar above the content, holding the search field and the controls slot. Turn it off when the table doesn't need its own search or extra actions above it. |
| hasControl | false | - | Removes the controls bar entirely, the content starts at the top of the table. |
| hasFooter | true | true | Shows the footer below the content, holding the page summary text and the pagination control. Turn it off for a table short enough that pagination has nothing to do. |
| hasFooter | false | - | Removes the footer entirely, the content ends at the bottom of the table. |
| Shape | rounded | true | Every component inside the table takes its rounded option: search, buttons, checkboxes, status labels and pagination, including the table's own corners. |
| Shape | sharp | - | Every component inside the table takes its sharp option. |
| Selectable | true | true | Adds the selection column: select-all in the header and a checkbox per row. |
| Selectable | false | - | No selection column. |
| Row Actions | true | true | Adds a trailing more button per row that opens a compact menu of the row's actions. |
| Row Actions | false | - | No actions column. |
| Vertical Scroll | false | true | The content grows with its rows. |
| Vertical Scroll | true | - | Caps the content height so rows scroll under a sticky header. |
| Selected Count | true | true | An info Label at the start of the controls bar counts the selected rows. It shows only while rows are selected. |
| Selected Count | false | - | No count. |
| Column Settings | true | true | A settings button at the end of the controls bar opens the column panel to show, hide and freeze columns. |
| Column Settings | false | - | No column panel. |
| Rows Per Page | true | true | A small compact Select after the page summary sets how many rows each page shows. |
| Rows Per Page | false | - | No page size choice. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined for the controls bar or the footer appearing and disappearing. |
| Selection | A checkbox per row and select-all in the header. Select-all covers the enabled rows shown and is indeterminate while only some are selected. Selected rows take the selected fill across every column. |
| Selected count | While rows are selected, an info Label at the start of the controls bar counts them. Screen readers hear the count change. |
| Sorting | A sortable header cycles none, ascending and descending. Client-side, the table reorders the rows itself; otherwise the consumer does. |
| Search and filter | Search matches every cell's text. A filterable header opens a compact checkbox menu of the column's values, and a filtered column keeps its glyph in foreground/cursor. |
| Paging | Rows per page sets the page size. Client-side, the summary and page count are worked out, and sorting, searching or filtering returns to page 1. |
| Column resizing | Hovering a header's trailing edge shows the neutral hover border at full cell height. Dragging trades width with the next resizable columns, so the table width never changes. Arrow keys step it and a double-click resets it. |
| Column settings | The settings panel shows or hides columns and freezes up to a chosen column. The last column showing can't be hidden. |
| Row actions | The more button opens a compact menu of the row's actions. Escape closes it and returns focus to the button. |
| Sticky header | With Vertical Scroll, rows scroll under a header that sticks to the top. Frozen columns stay frozen both ways. |
| Truncation | Text cut off in a narrow column shows in full in a Tooltip after a short hover. |
| Disabled rows | A disabled row keeps the plain fill and dims everything in it. It can't be selected, clicked or opened for actions unless the table allows disabled selection. |
| Empty | With nothing to show, one row spanning every column reads the empty label. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Controls bar | Table Controls instance | Holds the selected count, a search field, the Controls Slot and the column settings button. Each is a property of the exposed instance. |
| Content | Table Content instance | Holds the selection column, the data columns and the actions column. Column Position, Horizontal Scroll, Vertical Scroll, Selectable and Row Actions are exposed. |
| Footer | Table Footer instance | Holds the page summary, rows per page and Pagination. Each is a property of the exposed instance. |
| Selection column | Table Column/Select | _Select Cell rows: select-all, checked, selected and disabled. |
| Actions column | Table Column/Actions | _Actions Cell rows: the more button, open, selected and disabled. |
| Menus | _Table Menu | Compact row actions, filter and column settings menus. |
| Empty row | _Empty Row | Spans every column when nothing matches. |
| Tooltip | Tooltip instance | Shows cut-off text in full. Hidden from assistive technology. |

### Anatomy

1. **Controls bar** — Holds a search field that can be toggled on/off. Controls Slot houses extra actions, and can be shown/hidden with the hasControl property.

### How to use

**Do:**
- Turn hasControl off when the table doesn't need its own search or extra actions above it.
- Turn hasFooter off for a table short enough that pagination has nothing to do.
- Turn Selectable on only when selected rows feed an action, such as a bulk delete.

**Don't:**
- Don't try to hide the last column in the settings panel. The table keeps one showing.
- Don't rely on slotted controls in a disabled row. They ignore the pointer unless disabled selection is allowed.

### Accessibility & Content Guidelines

- A captioned table with column headers and aria-sort on sortable columns. Checkboxes are named, such as Select all rows and Select row: Name. Resize grips are focusable separators with a name and a value. Menus are named, move with the arrow keys and close on Escape, returning focus to their trigger. The selected count is a live region. Tooltips repeat visible text and are hidden from assistive technology.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed | 979px, held fixed rather than hugging its content. |
| Height | Hug | Hugs the controls bar, the content and the footer stacked with no gap between them. |
| Padding | Fixed | 0 on every side of the table itself, each section carries its own padding instead. |
| Controls bar | Fixed height, fixed padding | Fixed at 60px tall, 16px padding on the left and right, 12px on top and bottom. Its search field and controls slot align to the right-hand side, leaving the left side open. |
| Footer | Fixed height, fixed padding | Fixed at 60px tall, the same 16px and 12px padding as the controls bar. The summary text and the pagination control push to opposite ends rather than sitting a fixed distance apart. |
| Content | Fill | Takes the height left between the controls bar and the footer, 351px with both shown. With Vertical Scroll it caps its height and scrolls. |
| Columns | Resizable | Resizing trades width between columns, so the table width holds. |

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
  - Table Footer/Footer Start (FRAME)
    - Table Footer/Footer Start/Page Details (TEXT)
    - Table Footer/Footer Start/Rows Per Page (FRAME)
      - Table Footer/Footer Start/Rows Per Page/Rows Per Page Label (TEXT)
      - Table Footer/Footer Start/Rows Per Page/Page Size (INSTANCE)
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
| Table Footer/Footer Start | itemSpacing | 24 | space.xl |
| Table Footer/Footer Start/Page Details | fill[0] | #545963 | foreground.secondary |
| Table Footer/Footer Start/Page Details | fontSize | 14 | body.small.font size |
| Table Footer/Footer Start/Page Details | lineHeight | 18 | body.small.line height |
| Table Footer/Footer Start/Page Details | letterSpacing | 0 | body.small.letter spacing |
| Table Footer/Footer Start/Rows Per Page | itemSpacing | 8 | space.sm |
| Table Footer/Footer Start/Rows Per Page/Rows Per Page Label | fill[0] | #545963 | foreground.secondary |
| Table Footer/Footer Start/Rows Per Page/Rows Per Page Label | fontSize | 12 | — |
| Table Footer/Footer Start/Rows Per Page/Rows Per Page Label | lineHeight | 14.522727012634277 | — |
| Table Footer/Footer Start/Rows Per Page/Rows Per Page Label | letterSpacing | 0 | — |
| Table Footer/Footer Start/Rows Per Page/Page Size | height | 36 | control.sm |
| Table Footer/Footer Start/Rows Per Page/Page Size | fill[0] | #ffffff | interactive.neutral.background.default |
| Table Footer/Footer Start/Rows Per Page/Page Size | stroke[0] | #ced2db | interactive.neutral.border.default |
| Table Footer/Footer Start/Rows Per Page/Page Size | cornerRadius | 0 | radius.none |
| Table Footer/Footer Start/Rows Per Page/Page Size | strokeWeight | 1 | stroke.thin |
| Table Footer/Footer Start/Rows Per Page/Page Size | itemSpacing | 4 | space.xxs |
| Table Footer/Footer Start/Rows Per Page/Page Size | padding.left | 12 | space.md |
| Table Footer/Footer Start/Rows Per Page/Page Size | padding.right | 12 | space.md |
| Table Footer/Footer Start/Rows Per Page/Page Size | padding.top | 8 | space.sm |
| Table Footer/Footer Start/Rows Per Page/Page Size | padding.bottom | 8 | space.sm |
| Table Footer/Pagination | itemSpacing | 8 | space.sm |

## Table Controls

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5302-5786&m=dev

### Layer structure

- Table Controls (COMPONENT)
  - Table Controls/Selected Count (FRAME)
    - Table Controls/Selected Count/Count Label (INSTANCE)
  - Table Controls/Search (INSTANCE)
  - Table Controls/Controls Slot (SLOT)
  - Table Controls/Column Settings (INSTANCE)

### Resolved tokens (default variant: Table Controls)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Table Controls | fill[0] | #ffffff | surface.section |
| Table Controls | itemSpacing | 8 | space.sm |
| Table Controls | padding.left | 16 | space.lg |
| Table Controls | padding.right | 16 | space.lg |
| Table Controls | padding.top | 12 | space.md |
| Table Controls | padding.bottom | 12 | space.md |
| Table Controls/Selected Count/Count Label | fill[0] | #0073e6 | feedback.info.background.strong |
| Table Controls/Selected Count/Count Label | stroke[0] | #0073e6 | feedback.info.background.strong |
| Table Controls/Selected Count/Count Label | cornerRadius | 0 | radius.none |
| Table Controls/Selected Count/Count Label | strokeWeight | 1 | stroke.thin |
| Table Controls/Selected Count/Count Label | itemSpacing | 2 | space.2xs |
| Table Controls/Selected Count/Count Label | padding.left | 4 | space.xxs |
| Table Controls/Selected Count/Count Label | padding.right | 4 | space.xxs |
| Table Controls/Selected Count/Count Label | padding.top | 4 | space.xxs |
| Table Controls/Selected Count/Count Label | padding.bottom | 4 | space.xxs |
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
| Table Controls/Column Settings | width | 36 | control.sm |
| Table Controls/Column Settings | height | 36 | control.sm |
| Table Controls/Column Settings | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Table Controls/Column Settings | stroke[0] | #ced2db | interactive.neutral.border.default |
| Table Controls/Column Settings | cornerRadius | 0 | radius.none |
| Table Controls/Column Settings | strokeWeight | 1 | stroke.thin |
| Table Controls/Column Settings | padding.left | 4 | space.xxs |
| Table Controls/Column Settings | padding.right | 4 | space.xxs |
| Table Controls/Column Settings | padding.top | 4 | space.xxs |
| Table Controls/Column Settings | padding.bottom | 4 | space.xxs |

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

### Resolved tokens (default variant: State=enabled, Filtered=false)

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
| State | hover | _Data Cell/Cell | fill[0] | interactive.neutral.background.hover |
| State | selected | _Data Cell/Cell | fill[0] | interactive.neutral.background.selected |

## _Header Cell

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5238-5166&m=dev

### Layer structure

- _Header Cell (COMPONENT)
  - _Header Cell/Cell (FRAME)
    - _Header Cell/Cell/Content (FRAME)
      - _Header Cell/Cell/Content/_Label (INSTANCE)
  - _Header Cell/Resize Grip (RECTANGLE)

### Resolved tokens (default variant: State=enabled, Sorted=true, Resize=none)

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
| Resize | hover | _Header Cell/Resize Grip | width | stroke.thick |
| Resize | hover | _Header Cell/Resize Grip | fill[0] | interactive.neutral.border.hover |
| Resize | focus | _Header Cell/Resize Grip | width | stroke.thick |
| Resize | focus | _Header Cell/Resize Grip | fill[0] | border.focus |

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
  - Table Content/Table Column/Select (INSTANCE)
  - Table Content/Table Column/Default (INSTANCE)
  - Table Content/Slot Container (SLOT)
  - Table Content/Table Column/Actions (INSTANCE)
  - Table Content/Frozen Slot Container (SLOT)
  - Table Content/Scrollable Columns (FRAME)
    - Table Content/Scrollable Columns/Columns (FRAME)
      - Table Content/Scrollable Columns/Columns/Slot Container (SLOT)
      - Table Content/Scrollable Columns/Columns/Table Column/Actions (INSTANCE)
    - Table Content/Scrollable Columns/Scrollbar (INSTANCE)
  - Table Content/Scrollbar (INSTANCE)

### Resolved tokens (default variant: Column Position=default, Horizontal Scroll=false, Vertical Scroll=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Column Position | frozen | Table Content/Frozen Slot Container | stroke[0] | border.default |
| Vertical Scroll | true | Table Content/Scrollbar | padding.left | space.xxs |
| Vertical Scroll | true | Table Content/Scrollbar | padding.right | space.xxs |
| Vertical Scroll | true | Table Content/Scrollbar | padding.top | space.xxs |
| Vertical Scroll | true | Table Content/Scrollbar | padding.bottom | space.xxs |

## _Select Cell

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7605-2680&m=dev

### Layer structure

- _Select Cell (COMPONENT)
  - _Select Cell/Cell (FRAME)
    - _Select Cell/Cell/Checkbox (INSTANCE)

### Resolved tokens (default variant: Type=header, Checked=false, Disabled=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Select Cell | stroke[0] | #ced2db | border.default |
| _Select Cell | strokeWeight | 0 | stroke.thin |
| _Select Cell/Cell | fill[0] | #ffffff | interactive.neutral.background.default |
| _Select Cell/Cell | padding.left | 12 | space.md |
| _Select Cell/Cell | padding.right | 12 | space.md |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | data | _Select Cell | stroke[0] | border.subtle |
| Type | data | _Select Cell | strokeWeight | — |

## _Actions Cell

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7605-2707&m=dev

### Layer structure

- _Actions Cell (COMPONENT)
  - _Actions Cell/Cell (FRAME)
    - _Actions Cell/Cell/More (INSTANCE)

### Resolved tokens (default variant: Type=header, State=enabled)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Actions Cell | stroke[0] | #ced2db | border.default |
| _Actions Cell | strokeWeight | 0 | stroke.thin |
| _Actions Cell/Cell | fill[0] | #ffffff | interactive.neutral.background.default |
| _Actions Cell/Cell | padding.left | 12 | space.md |
| _Actions Cell/Cell | padding.right | 12 | space.md |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | data | _Actions Cell | stroke[0] | border.subtle |
| Type | data | _Actions Cell | strokeWeight | — |
| Type | data | _Actions Cell/Cell/More | width | control.sm |
| Type | data | _Actions Cell/Cell/More | height | control.sm |
| Type | data | _Actions Cell/Cell/More | fill[0] | interactive.ghost.background.default |
| Type | data | _Actions Cell/Cell/More | stroke[0] | interactive.neutral.border.default |
| Type | data | _Actions Cell/Cell/More | cornerRadius | radius.none |
| Type | data | _Actions Cell/Cell/More | strokeWeight | stroke.base |
| Type | data | _Actions Cell/Cell/More | padding.left | space.xxs |
| Type | data | _Actions Cell/Cell/More | padding.right | space.xxs |
| Type | data | _Actions Cell/Cell/More | padding.top | space.xxs |
| Type | data | _Actions Cell/Cell/More | padding.bottom | space.xxs |

## _Empty Row

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7605-2708&m=dev

### Layer structure

- _Empty Row (COMPONENT)
  - _Empty Row/Empty Label (TEXT)

### Resolved tokens (default variant: _Empty Row)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Empty Row | fill[0] | #ffffff | interactive.neutral.background.default |
| _Empty Row | stroke[0] | #e0e3e9 | border.subtle |
| _Empty Row | strokeWeight | 0 | — |
| _Empty Row | padding.left | 16 | space.lg |
| _Empty Row | padding.right | 16 | space.lg |
| _Empty Row | padding.top | 12 | space.md |
| _Empty Row | padding.bottom | 12 | space.md |
| _Empty Row/Empty Label | fill[0] | #545963 | foreground.secondary |
| _Empty Row/Empty Label | fontSize | 12 | — |
| _Empty Row/Empty Label | lineHeight | 14.522727012634277 | — |
| _Empty Row/Empty Label | letterSpacing | 0 | — |

## Table Column/Select

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7607-3061&m=dev

### Layer structure

- Table Column/Select (COMPONENT)
  - Table Column/Select/_Select Cell[1] (INSTANCE)
  - Table Column/Select/_Select Cell[2] (INSTANCE)
  - Table Column/Select/_Select Cell[3] (INSTANCE)
  - Table Column/Select/_Select Cell[4] (INSTANCE)
  - Table Column/Select/_Select Cell[5] (INSTANCE)
  - Table Column/Select/_Select Cell[6] (INSTANCE)

### Resolved tokens (default variant: Table Column/Select)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Table Column/Select/_Select Cell[1] | stroke[0] | #ced2db | border.default |
| Table Column/Select/_Select Cell[1] | strokeWeight | 0 | stroke.thin |
| Table Column/Select/_Select Cell[2] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Select/_Select Cell[2] | strokeWeight | 0 | — |
| Table Column/Select/_Select Cell[3] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Select/_Select Cell[3] | strokeWeight | 0 | — |
| Table Column/Select/_Select Cell[4] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Select/_Select Cell[4] | strokeWeight | 0 | — |
| Table Column/Select/_Select Cell[5] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Select/_Select Cell[5] | strokeWeight | 0 | — |
| Table Column/Select/_Select Cell[6] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Select/_Select Cell[6] | strokeWeight | 0 | — |

## Table Column/Actions

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7607-3104&m=dev

### Layer structure

- Table Column/Actions (COMPONENT)
  - Table Column/Actions/_Actions Cell[1] (INSTANCE)
  - Table Column/Actions/_Actions Cell[2] (INSTANCE)
  - Table Column/Actions/_Actions Cell[3] (INSTANCE)
  - Table Column/Actions/_Actions Cell[4] (INSTANCE)
  - Table Column/Actions/_Actions Cell[5] (INSTANCE)
  - Table Column/Actions/_Actions Cell[6] (INSTANCE)

### Resolved tokens (default variant: Table Column/Actions)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Table Column/Actions/_Actions Cell[1] | stroke[0] | #ced2db | border.default |
| Table Column/Actions/_Actions Cell[1] | strokeWeight | 0 | stroke.thin |
| Table Column/Actions/_Actions Cell[2] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Actions/_Actions Cell[2] | strokeWeight | 0 | — |
| Table Column/Actions/_Actions Cell[3] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Actions/_Actions Cell[3] | strokeWeight | 0 | — |
| Table Column/Actions/_Actions Cell[4] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Actions/_Actions Cell[4] | strokeWeight | 0 | — |
| Table Column/Actions/_Actions Cell[5] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Actions/_Actions Cell[5] | strokeWeight | 0 | — |
| Table Column/Actions/_Actions Cell[6] | stroke[0] | #e0e3e9 | border.subtle |
| Table Column/Actions/_Actions Cell[6] | strokeWeight | 0 | — |

## _Table Menu

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7607-3440&m=dev

### Layer structure

- _Table Menu (COMPONENT)
  - _Table Menu/Dropdown Menu (INSTANCE)

### Resolved tokens (default variant: Type=row actions)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Table Menu/Dropdown Menu | fill[0] | #ffffff | surface.menu |
| _Table Menu/Dropdown Menu | cornerRadius | 6 | radius.element-md |
| _Table Menu/Dropdown Menu | padding.left | 6 | space.xs |
| _Table Menu/Dropdown Menu | padding.right | 6 | space.xs |
| _Table Menu/Dropdown Menu | padding.top | 6 | space.xs |
| _Table Menu/Dropdown Menu | padding.bottom | 6 | space.xs |
