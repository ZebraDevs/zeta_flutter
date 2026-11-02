# Breadcrump

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7662-814&m=dev

## Breadcrumb

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7667-447&m=dev

### Overview

Shows where a page sits in the hierarchy, as a trail of links ending on the current page. Each crumb goes back up a level. A long trail collapses its middle into an overflow menu, so every crumb stays reachable.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Flavour | default | true | Sets the current page in foreground/primary. Use it unless the trail needs to stand out. |
| Flavour | accent | — | Sets the current page and its icon in foreground/link. In code this is flavour. |
| Shape | rounded | true | Matches surfaces built from rounded controls. Reaches the overflow control and its menu only. |
| Shape | sharp | — | Matches square surfaces. The crumbs are text, so they do not change. |
| Collapsed | false | true | Shows every crumb. Figma only: derived from maxItems, not a prop. |
| Collapsed | true | — | Keeps the first crumb and the last ones. The rest move to the overflow menu. |
| Open | false | true | The overflow menu is closed. Figma only: derived from the menu, not a prop. |
| Open | true | — | Shows the compact menu below the overflow control. Drawn with Collapsed on. |
| items | array | — | The path, root first. Each item takes label, href, icon and onSelect. The last item is the current page. |
| maxItems | number | — | How many crumbs show before the middle collapses. Unset shows them all. The minimum is 2. |
| label | string | — | Accessible name of the trail. Defaults to Breadcrumb. |
| overflowLabel | string | — | Accessible name of the overflow control. Defaults to Show hidden pages. |
| portalContainer | element | — | Where the overflow menu mounts. Set it when the theme is scoped below body. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | — | — | Text in foreground/secondary. |
| hover | Pointer over a crumb | — | Text moves to foreground/link. The icon holds its colour. A CSS state, not a prop. |
| focus | Keyboard focus on a crumb | — | A stroke/thick ring in border/focus. A CSS state, not a prop. |
| current | Being the last item | — | Text in foreground/primary, with no link. Derived from position. accent moves it and its icon to foreground/link. |
| Overflow control | Its own Icon Button states | — | Hover, press and focus belong to Icon Button. |
| Open | Activating the overflow control | — | Opens Dropdown Menu with Compact on. The control reports itself as expanded. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Crumbs change colour at once. |
| Collapse | With maxItems set and a longer trail, the first crumb stays, then maxItems minus one from the end. The rest move to the menu, in order. |
| Dropdown | The overflow control is the Template/Dropdown trigger. The menu opens below it, left aligned, space/sm away. It is Dropdown Menu with Compact on, so a short list stays tight. |
| Menu rows | Each hidden crumb is a Menu Item, with its icon if it has one. Choosing a row runs onSelect, follows href, and closes the menu. |
| Keyboard | Enter or Space opens the menu. Arrow keys move through the rows. Escape closes it and returns focus to the control. |
| Portal | Figma only: the menu is drawn inside the component. In code it mounts in a portal and is positioned against the control, with collision handling. |
| Wrapping | A long trail wraps, with lines space/xxs apart. The separator stays at the end of a line, so each line starts on a crumb. Figma draws one line. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Crumbs | items, consumer owned | The path. Keep labels short, because the trail reads as one line. |
| Label | Text property | The crumb's name. It is the only required part of an item. |
| Icon | Show Icon, nested Icon | An optional glyph before the label. Figma only: an exposed instance. In code it is the item's icon. |
| Separator | Parent owned | chevron-right at small. Figma only: Show Separator. In code it renders after every crumb but the last. |
| Overflow control | Icon Button, parent owned | Small and outline-subtle, with more-horizontal. Its shape follows Shape. |
| Overflow menu | Dropdown Menu, parent owned | Compact on, with Rounded following Shape. Its rows are Menu Items for the hidden crumbs. |
| Sample trail | Figma only | The labels and the number of crumbs are sample content, not API. |

### Anatomy

1. **Crumb** — A link back up the hierarchy, with an optional icon.
2. **Separator** — The chevron after each crumb. Decorative, so hidden from assistive tech.
3. **Overflow control** — Holds the hidden crumbs, and opens the compact menu.
4. **Current page** — The last item. It is text, not a link.

### How to use

**Do:**
- Use it on pages more than one level deep, with the root first.
- Set maxItems where the trail could outgrow its row.

**Don't:**
- Don't use it for steps in a flow. Stepper is for a sequence, and a breadcrumb is for a place.
- Don't give the current page a link. It is never one, even with an href.

### Accessibility & Content Guidelines

- A labelled nav holding an ordered list. The last item carries aria-current="page" and is not a link. Separators are hidden from assistive tech. The overflow control has no visible text, so overflowLabel names it. Opening the menu moves focus to its rows, and Escape returns it to the control. Hover is colour alone, so keyboard users rely on the focus ring.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug | Hugs the trail. A collapsed trail stands at control/sm, because of the overflow control, so it is taller than a full one. |
| Direction | Row, wrapping | Crumbs and separators in a row, space/md apart. Wrapped lines sit space/xxs apart. |
| Crumb | Tokenised | body/medium, with space/sm between icon and label. foreground/secondary, foreground/link on hover, foreground/primary when current. |
| Icon | Set to small | foreground/primary in every state. foreground/link on an accent current page. |
| Separator | Set to small | chevron-right in foreground/primary. |
| Overflow control | Set to small | Icon Button, outline-subtle. Rounded or sharp from Shape. |
| Overflow menu | Compact | Dropdown Menu with Compact on: space/xs padding, space/none between rows, on surface/menu. It sits space/sm below the control. |

### Layer structure

- Breadcrumb (COMPONENT)
  - Breadcrumb/Sites (INSTANCE)
  - Breadcrumb/North America (INSTANCE)
  - Breadcrumb/Warehouse 12 (INSTANCE)
  - Breadcrumb/Receiving (INSTANCE)
  - Breadcrumb/Dock 4 (INSTANCE)
  - Breadcrumb/Overflow (FRAME)
    - Breadcrumb/Overflow/Overflow Button (INSTANCE)
    - Breadcrumb/Overflow/Separator (INSTANCE, icon: chevron_right)
  - Breadcrumb/Dropdown Menu (INSTANCE)

### Resolved tokens (default variant: Collapsed=false, Shape=rounded, Flavour=default, Open=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Breadcrumb | itemSpacing | 12 | space.md |
| Breadcrumb/Sites | itemSpacing | 12 | space.md |
| Breadcrumb/North America | itemSpacing | 12 | space.md |
| Breadcrumb/Warehouse 12 | itemSpacing | 12 | space.md |
| Breadcrumb/Receiving | itemSpacing | 12 | space.md |
| Breadcrumb/Dock 4 | itemSpacing | 12 | space.md |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Collapsed | true | Breadcrumb/North America | itemSpacing | — |
| Collapsed | true | Breadcrumb/Overflow | itemSpacing | space.md |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | width | control.sm |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | height | control.sm |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | fill[0] | interactive.ghost.background.default |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | stroke[0] | interactive.neutral.border.default |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | cornerRadius | radius.element-sm |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | strokeWeight | stroke.thin |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | padding.left | space.xxs |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | padding.right | space.xxs |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | padding.top | space.xxs |
| Collapsed | true | Breadcrumb/Overflow/Overflow Button | padding.bottom | space.xxs |

## _Breadcrumb Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7665-138&m=dev

### Layer structure

- _Breadcrumb Item (COMPONENT)
  - _Breadcrumb Item/Crumb (FRAME)
    - _Breadcrumb Item/Crumb/Icon (INSTANCE, icon: location)
    - _Breadcrumb Item/Crumb/Label (TEXT)
  - _Breadcrumb Item/Separator (INSTANCE, icon: chevron_right)

### Resolved tokens (default variant: State=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Breadcrumb Item | itemSpacing | 12 | space.md |
| _Breadcrumb Item/Crumb | cornerRadius | 4 | radius.sm |
| _Breadcrumb Item/Crumb | itemSpacing | 8 | space.sm |
| _Breadcrumb Item/Crumb/Label | fill[0] | #545963 | foreground.secondary |
| _Breadcrumb Item/Crumb/Label | fontSize | 16 | body.medium.font size |
| _Breadcrumb Item/Crumb/Label | lineHeight | 24 | body.medium.line height |
| _Breadcrumb Item/Crumb/Label | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | _Breadcrumb Item/Crumb/Label | fill[0] | foreground.link |
| State | focus | _Breadcrumb Item/Crumb | stroke[0] | border.focus |
| State | focus | _Breadcrumb Item/Crumb | strokeWeight | stroke.thick |
| State | current | _Breadcrumb Item/Crumb/Label | fill[0] | foreground.primary |
| State | current accent | _Breadcrumb Item/Crumb/Label | fill[0] | foreground.link |
