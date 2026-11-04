# Tab Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3607-237&m=dev

## Tab Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3635-1151&m=dev

### Layer structure

- Tab Item (COMPONENT)
  - Tab Item/Icon (INSTANCE, icon: star)
  - Tab Item/Tab Item (TEXT)
  - Tab Item/Notification Indicator (INSTANCE)

### Resolved tokens (default variant: State=default, Disabled=false, Selected=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Tab Item | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Tab Item | stroke[0] | #0c0d0e00 | border.transparent |
| Tab Item | cornerRadius | 0 | radius.none |
| Tab Item | strokeWeight | 1 | — |
| Tab Item | itemSpacing | 8 | space.sm |
| Tab Item | padding.left | 16 | space.gutter |
| Tab Item | padding.right | 16 | space.gutter |
| Tab Item | padding.top | 12 | space.md |
| Tab Item | padding.bottom | 12 | space.md |
| Tab Item/Tab Item | fill[0] | #545963 | foreground.secondary |
| Tab Item/Tab Item | fontSize | 14 | — |
| Tab Item/Tab Item | lineHeight | 20 | — |
| Tab Item/Tab Item | letterSpacing | 0 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Tab Item | fill[0] | interactive.ghost.background.hover |
| State | hover | Tab Item/Tab Item | fontSize | label.medium.font size |
| State | hover | Tab Item/Tab Item | lineHeight | label.medium.line height |
| State | hover | Tab Item/Tab Item | letterSpacing | label.medium.letter spacing |

## Tab Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3640-2127&m=dev

### Overview

A row of tabs for switching between views at the same level. Flavour decides whether the row fills its container or hugs its tabs. The tabs arrive through a slot, so the bar sets the arrangement and the product sets how many.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Flavour | full width | true | Tabs divide the row evenly. Use it where the bar owns the full width of its container. |
| Flavour | condensed | - | Tabs take only the width they need. Use it where the bar shares a row with other content. |
| Tab Slot | slot | — | Holds the tabs. The bar arranges them, the product decides how many. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Resting | — | Ghost surface, label at foreground/secondary, underline transparent. |
| hover | Pointer over the tab | — | The surface moves to its hover token. Label and underline hold. |
| selected | Tab chosen | — | The underline takes interactive/primary/border/default and the label darkens. |
| disabled | — | — | The label drops to its disabled token. The surface does not move, so the label carries it alone. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Selection is a swap of the underline and label colours. |
| Selection model | Exactly one tab is selected. Nothing in the component enforces that, so the surrounding structure has to. |
| Flavour and width | full width divides the row, condensed hugs. Switching changes how tabs size, never how many there are. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Tab Slot | slot, product filled | Takes the tabs. Four is what it is drawn with, not a limit it enforces. |
| Tab item | nested, four states | Each tab carries its own state, icon toggle and badge toggle. The bar exposes none of them, so every tab is set on itself. |
| Tab label | not parameterised | Not exposed as an input, so the words come from the implementation. |
| Tab badge | nested, off by default | A notification dot on the tab, hidden until Show Badge turns it on. |

### Anatomy

1. **Tab slot** — Where the tabs go. Flavour decides whether they fill or hug.
2. **Tab item** — Icon, label and an optional badge, carrying its own four states.
3. **Underline** — A 2px bottom border on every tab, coloured only when selected.

### How to use

**Do:**
- Keep one tab selected at all times. A bar with none says nothing about where a person is.
- Use condensed where the bar shares a row. full width divides whatever container it is given, however wide.

**Don't:**
- Don't use tabs for actions. Tabs switch between views, and one that does something is a button in the wrong clothes.
- Don't disable a tab that has content behind it. A view a person cannot reach needs explaining, not hiding.

### Accessibility & Content Guidelines

- Tab labels are not exposed as inputs, so whatever names each tab comes from the implementation and has to be real words.
- Selection is carried by an underline colour and a label colour, both colour alone. The selected tab has to be marked in the structure as well.
- Disabled changes the label colour and nothing else. The surface holds, so check the label still carries enough contrast to read.
- Arrow keys should move between tabs with the selected one as the tab stop. Nothing in the component provides that.
- The badge is a dot with no text. Where it stands for a count or an alert, that has to be available to a reader some other way.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Per Flavour | 48 tall. 708 and fixed at full width, hugging to 472 at condensed with four tabs. |
| Surface | Fixed | surface/section across the row, with no padding, gap or radius of its own. |
| Tab slot | Per Flavour | Tabs fill the row at full width, 177 each with four. At condensed they hug, 118 each. |
| Tab item | Fixed | 48 tall, space/md top and bottom, space/gutter each side, space/sm between icon and label. |
| Selection underline | Theming | A 2px bottom border on every tab, border/transparent until selected and interactive/primary/border/default after. The space is always held, so selecting shifts nothing. |
| Tab label | Theming | label/medium at 14px. foreground/secondary at rest, interactive/neutral/foreground/default selected, and the disabled token when off. |

### Layer structure

- Tab Bar (COMPONENT)
  - Tab Bar/ Tab Slot (SLOT)

### Resolved tokens (default variant: Flavour=full width)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Tab Bar | fill[0] | #ffffff | surface.section |
