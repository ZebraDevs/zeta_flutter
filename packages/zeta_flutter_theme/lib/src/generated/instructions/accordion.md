# Accordion

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5529-33&m=dev

## Accordion

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5621-1973&m=dev

### Overview

A vertically stacked list of disclosure rows sharing one container, for a page that has more sections than it has room to show at once. Selectable decides whether rows can be ticked as well as opened, and In Card decides whether the list reads as a bounded object. The rows themselves are separate components with their own frames.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Selectable | true | true | Rows carry a leading control and can be ticked, so the list doubles as a chooser. Use it when someone has to mark items, not merely read them. It is the same row component either way, with the selection turned on. |
| Selectable | false | - | Rows disclose content only, with the caret trailing the title. The right choice for content reveal, an FAQ or a settings group where nothing is being chosen. |
| rounded | false | true | Match the contour of the surface the list sits on rather than deciding per instance. Only the outer container responds, so on a long list the difference shows at the first and last rows and nowhere else. |
| rounded | true | - | The rounded pairing, for surfaces built from rounded controls. The nested row buttons inherits the rounding. |
| In Card | true | true | Treat the list as one bounded object, set apart from what surrounds it. This also turns the row dividers on, so the choice governs the internal rhythm as much as the outer edge. |
| In Card | false | - | Let the list sit directly on the page and take its separation from the surrounding layout. Dividers disappears with the outline, so rows run together and the container has to supply the breathing room. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The set declares no state axis of its own. Nothing about the container changes on hover, focus or press. |
| Row hover | Hover on a nested row | — | Handled inside the row components and documented in their frames. The container does not repaint. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing, and no expand or collapse transition is authored. The height change that opening a row implies is not modelled. |
| Open and close | No property on this set opens a row. Open sits on the nested header and reads false in all eight variants, so the set documents the collapsed list only. Only one item can have the open state at a time. |
| Interaction | Selectable switches the interaction model as well as the look. Without it the whole header toggles the row open. With it, the leading icon button takes the open and close and the rest of the header takes the selection. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Items Slot Selectable | slot, present when Selectable is true | Takes Accordion Item rows with Selectable on, one per row. This is the only part of the list a consumer adds to. Figma holds two slots, one per Selectable value, so the row content can stay locked in each. In code it is a single content slot. |
| Items Slot | slot, present when Selectable is false | The same role for the non-selectable rows. Only one of the two slots exists in any given variant, so the Selectable choice decides which one is available. This is a Figma only implementation, in code both slots are available as a single content slot. |
| First and last rows | fixed instances, outside the slot | The row above the slot and the row below it are placed instances rather than slot content. Reordering or removing them means detaching, and the last one is where the divider is deliberately switched off. The are static element in Figma only, in code the last element will always have the divider turned off |

### Anatomy

1. **Container** — The outer frame. It owns the border, the corner radius and the vertical stacking, and carries no fill of its own.
2. **Fixed rows** — The first and last rows, placed directly in the variant rather than in the slot. They are not swappable content.
3. **Items slot** — The middle region a consumer fills with rows. Which of the two slots is present follows the Selectable axis.

### How to use

**Do:**
- Pick Selectable before filling the slot. Changing it later swaps the row component and drops the titles already entered.
- Keep In Card consistent across sibling lists on one screen. It governs the dividers as well as the border, so a mixed pair reads as two different components.

**Don't:**
- Don't expect to open a row from the Accordion instance. Open lives on the nested header and is not surfaced here.
- Don't treat the first and last rows as slot content. They are fixed instances, and the last one has its divider deliberately turned off.

### Accessibility & Content Guidelines

- No focus state is modelled anywhere in the set, so the keyboard path through the rows has to be built in code.
- The caret is the only sign that a row expands. Expose expanded and collapsed as real state rather than leaving it to the glyph.
- With In Card false there is no border and no divider, so nothing separates the rows until one is hovered. Check the list still reads as a list at rest.
- Titles use title/large at 20px, which is heading sized. On a screen with real headings the hierarchy needs checking.
- Opening a row reveals content that was not previously in the reading order. That insertion has to be announced.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fill/Flexible width, hug height | Width fills available space or restricted as needed. Height always hugs the rows. |
| Border | Per In Card | A 1px inside stroke bound to border/default when In Card is true. No stroke at all when it is false. |
| Radius | Per rounded | radius/lg on all four corners when rounded is true. When false the radius is a literal 0. |
| Fill | Theming | The container carries no fill. Every surface colour in the list comes from the row components. |
| Stacking | Fixed | Vertical, zero padding, and the gap bound to space/none so rows butt directly against each other. |
| Dividers | Per In Card | With In Card true, Show Divider is on for every row except the last. With In Card false it is off on all of them. The value is baked into each instance and is not exposed. |
| Row height | Fixed | 56 per row, rising to 57 wherever a divider is switched on. |

### Layer structure

- Accordion (COMPONENT)
  - Accordion/_Accordion Item Selectable[1] (INSTANCE)
  - Accordion/Items Slot Selectable (SLOT)
  - Accordion/_Accordion Item Selectable[2] (INSTANCE)
  - Accordion/_Accordion Item[1] (INSTANCE)
  - Accordion/Items Slot (SLOT)
  - Accordion/_Accordion Item[2] (INSTANCE)

### Resolved tokens (default variant: Selectable=true, rounded=false, In Card=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Accordion | stroke[0] | #ced2db | border.default |
| Accordion | strokeWeight | 1 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| rounded | true | Accordion | cornerRadius | radius.lg |
| In Card | false | Accordion | stroke[0] | — |

## _Accordion Header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5529-4858&m=dev

### Layer structure

- _Accordion Header (COMPONENT)
  - _Accordion Header/Heading Content (FRAME)
    - _Accordion Header/Heading Content/Title (FRAME)
      - _Accordion Header/Heading Content/Title/Heading (TEXT)
  - _Accordion Header/Caret Indicator (INSTANCE)

### Resolved tokens (default variant: State=Default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Accordion Header | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Accordion Header | itemSpacing | 8 | space.sm |
| _Accordion Header | padding.left | 16 | space.lg |
| _Accordion Header | padding.right | 16 | space.lg |
| _Accordion Header | padding.top | 16 | space.lg |
| _Accordion Header | padding.bottom | 16 | space.lg |
| _Accordion Header/Heading Content | itemSpacing | 2 | space.2xs |
| _Accordion Header/Heading Content/Title | itemSpacing | 4 | space.xxs |
| _Accordion Header/Heading Content/Title/Heading | fill[0] | #0c0d0e | foreground.primary |
| _Accordion Header/Heading Content/Title/Heading | fontSize | 16 | title.medium.font size |
| _Accordion Header/Heading Content/Title/Heading | lineHeight | 20 | title.medium.line height |
| _Accordion Header/Heading Content/Title/Heading | letterSpacing | 0 | title.medium.letter spacing |
| _Accordion Header/Caret Indicator | itemSpacing | 10 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | _Accordion Header | fill[0] | interactive.ghost.background.hover |

## _Accordion Header Selectable

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5593-1444&m=dev

### Layer structure

- _Accordion Header Selectable (COMPONENT)
  - _Accordion Header Selectable/Icon Button (INSTANCE)
  - _Accordion Header Selectable/Heading Content (FRAME)
    - _Accordion Header Selectable/Heading Content/Title (FRAME)
      - _Accordion Header Selectable/Heading Content/Title/Heading (TEXT)
  - _Accordion Header Selectable/Selected (INSTANCE, icon: check_mark)

### Resolved tokens (default variant: Selected=false, State=Default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Accordion Header Selectable | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Accordion Header Selectable | itemSpacing | 4 | space.xxs |
| _Accordion Header Selectable | padding.left | 8 | space.sm |
| _Accordion Header Selectable | padding.right | 8 | space.sm |
| _Accordion Header Selectable | padding.top | 8 | space.sm |
| _Accordion Header Selectable | padding.bottom | 8 | space.sm |
| _Accordion Header Selectable/Icon Button | width | 40 | control.md |
| _Accordion Header Selectable/Icon Button | height | 40 | control.md |
| _Accordion Header Selectable/Icon Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Accordion Header Selectable/Icon Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| _Accordion Header Selectable/Icon Button | cornerRadius | 0 | radius.none |
| _Accordion Header Selectable/Icon Button | strokeWeight | 0 | stroke.base |
| _Accordion Header Selectable/Icon Button | padding.left | 4 | space.xxs |
| _Accordion Header Selectable/Icon Button | padding.right | 4 | space.xxs |
| _Accordion Header Selectable/Icon Button | padding.top | 4 | space.xxs |
| _Accordion Header Selectable/Icon Button | padding.bottom | 4 | space.xxs |
| _Accordion Header Selectable/Heading Content | itemSpacing | 2 | space.2xs |
| _Accordion Header Selectable/Heading Content/Title | itemSpacing | 4 | space.xxs |
| _Accordion Header Selectable/Heading Content/Title/Heading | fill[0] | #0c0d0e | foreground.primary |
| _Accordion Header Selectable/Heading Content/Title/Heading | fontSize | 16 | title.medium.font size |
| _Accordion Header Selectable/Heading Content/Title/Heading | lineHeight | 20 | title.medium.line height |
| _Accordion Header Selectable/Heading Content/Title/Heading | letterSpacing | 0 | title.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Selected | true | _Accordion Header Selectable/Selected | height | control.target-min |
| State | hover | _Accordion Header Selectable | fill[0] | interactive.ghost.background.hover |

## _Accordion Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5593-74&m=dev

### Overview

One row of an Accordion, holding a title, a disclosure control, and the content it reveals. Selectable decides whether the row also carries a selection, which changes the controls it offers and how a tap is divided between them. Open, the title, the divider and the content behave the same either way.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Selectable | true | true | The row carries a selection as well as disclosure. A leading control takes the open and close and the rest of the row takes the selection, so the two actions never share a target. |
| Selectable | false | - | Disclosure only. The whole row is a single target that opens and closes it, and the caret trails the title instead of leading. |
| Open | false | true | Collapsed, showing the title alone. |
| Open | true | - | Expanded, with the content sitting below the title and the caret rotated to match. |
| Selected | false | true | Not chosen. It only carries meaning while Selectable is on, because nothing else offers a way to choose. |
| Selected | true | - | Chosen. A mark trails the title and the heading gives up the width it needs. |
| State | Default | true | The resting row. |
| State | hover | - | Pointer over the row. Only the background answers, so hover is the weakest of the signals this row gives. |
| Title | text | Heading | The row's label. Name the section it opens, because the caret says that a row opens but never what is inside it. |
| Show Divider | true | true | A rule closing the row off from the next one. |
| Show Divider | false | - | No rule. Which rows carry one is decided by the Accordion placing them, not by the row itself. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Default | — | — | The resting row, with nothing emphasised. |
| hover | Pointer over the row | — | The background lifts. The title, the caret and any selection mark all hold, so the background carries the whole change. |
| Open | Open set to true | — | The content appears below the title and the caret rotates to point at it. The row grows to fit whatever the content needs. |
| Selected | Selected set to true, while Selectable is on | — | A mark appears at the trailing edge and the heading narrows to make room for it. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Opening a row is the content appearing and the caret rotating, with nothing specified in between. |
| Interaction | Without Selectable the whole row is one target that opens and closes it. With Selectable the leading control takes the open and close and the rest of the row takes the selection, so the two actions never share a target. |
| Selection | Nothing links one row's selection to another. Whether one row or many may be chosen is decided where the rows are placed. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Title | text property | Plain text, defaulting to Heading. The only text the row takes. |
| Content Slot | slot, present when Open is true | Holds whatever the row reveals. It takes any content and is what sets the row's open height. |
| Leading control | nested, present when Selectable is on | An Icon Button carrying the caret. It owns the open and close, runs its own interaction states, and takes its shape from the Accordion around it. |
| Caret | nested, present when Selectable is off | A Caret Indicator trailing the title, rotating with the open state. It is not a control of its own, because the whole row is the target. |
| Selection mark | nested, present when Selected is true | A framed check icon at the trailing edge. It reports the selection rather than offering it, since the row body is what toggles it. |
| Two sets in Figma | Figma only | Selectable and non-selectable rows are built as two component sets so the slot content can stay locked in each. They are one component with a Selectable variant, and the split carries no meaning beyond authoring. |

### Anatomy

1. **Row** — The frame holding the header and, when open, the content beneath it.
2. **Header** — The title with its disclosure control. The control leads when Selectable is on and trails when it is off.
3. **Content and divider** — What the row reveals when open, with a rule closing it off from the next row.

### How to use

**Do:**
- Write titles that name the section. The caret says that a row opens, the title has to say what is inside it.
- Decide Selectable once for a whole list. A row that selects sitting next to rows that only open reads as two different controls.

**Don't:**
- Don't put a second control inside a non-selectable row. The whole row is one target, so anything else competes with it.
- Don't use Selected without Selectable. The mark appears with no control behind it to change it.

### Accessibility & Content Guidelines

- Without Selectable the whole row is one control. It needs a single focusable target carrying its expanded state.
- With Selectable there are two targets, the leading control for open and close and the rest of the row for selection. Each needs its own name, or one of the two actions cannot be reached.
- The caret's rotation is the only sign that a row is open. Expanded and collapsed have to be exposed in the markup rather than left to the glyph.
- Selection shows as a trailing mark. It needs a real selected state alongside it.
- Hover changes the background and nothing else, so anyone not using a pointer gets no equivalent signal.
- The title is set at 20px, which is heading sized. On a screen carrying real headings the hierarchy needs checking.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fill width, hug height | Fills its container. The header is 56 tall and a row carrying its divider is 57. Open rows grow to whatever the content needs. |
| Padding | Per Selectable | space/lg on all four sides of the header without Selectable, and space/sm with it, because the leading control is taller than the title. |
| Gap | Per Selectable | space/sm between the title and the caret without Selectable, space/xs between the control, the title and the mark with it. |
| Background | Theming | interactive/ghost/background/default at rest and interactive/ghost/background/hover on hover. No border and no corner radius. |
| Title | Theming | title/large, IBM Plex Sans Medium 20 over a 24px line, in foreground/primary. |
| Caret | Fixed | Caret Indicator at Size=medium, 20 square, trailing the title when Selectable is off. |
| Leading control | Fixed | Icon Button at Size=medium, 40 square, Flavour=subtle, leading the title when Selectable is on. |
| Selection mark | Fixed | A framed Icon at 40 square on the trailing edge, present only while Selected is true. |
| Divider | Per Show Divider | A 1px horizontal rule beneath the row, adding 1 to its height when shown. |

### Layer structure

- _Accordion Item (COMPONENT)
  - _Accordion Item/_Accordion Header (INSTANCE)
  - _Accordion Item/Divider (INSTANCE)
  - _Accordion Item/Content Slot (SLOT)

### Resolved tokens (default variant: Open=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Accordion Item/_Accordion Header | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Accordion Item/_Accordion Header | itemSpacing | 8 | space.sm |
| _Accordion Item/_Accordion Header | padding.left | 16 | space.lg |
| _Accordion Item/_Accordion Header | padding.right | 16 | space.lg |
| _Accordion Item/_Accordion Header | padding.top | 16 | space.lg |
| _Accordion Item/_Accordion Header | padding.bottom | 16 | space.lg |
| _Accordion Item/Divider | height | 1 | stroke.thin |
| _Accordion Item/Divider | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Open | true | _Accordion Item/Content Slot | itemSpacing | space.sm |
| Open | true | _Accordion Item/Content Slot | padding.left | space.lg |
| Open | true | _Accordion Item/Content Slot | padding.right | space.lg |
| Open | true | _Accordion Item/Content Slot | padding.top | space.lg |
| Open | true | _Accordion Item/Content Slot | padding.bottom | space.lg |

## _Accordion Item Selectable

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5622-3386&m=dev

### Layer structure

- _Accordion Item Selectable (COMPONENT)
  - _Accordion Item Selectable/_Accordion Header Selectable (INSTANCE)
  - _Accordion Item Selectable/Divider (INSTANCE)
  - _Accordion Item Selectable/Content Slot (SLOT)

### Resolved tokens (default variant: Open=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Accordion Item Selectable/_Accordion Header Selectable | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Accordion Item Selectable/_Accordion Header Selectable | itemSpacing | 4 | space.xxs |
| _Accordion Item Selectable/_Accordion Header Selectable | padding.left | 8 | space.sm |
| _Accordion Item Selectable/_Accordion Header Selectable | padding.right | 8 | space.sm |
| _Accordion Item Selectable/_Accordion Header Selectable | padding.top | 8 | space.sm |
| _Accordion Item Selectable/_Accordion Header Selectable | padding.bottom | 8 | space.sm |
| _Accordion Item Selectable/Divider | height | 1 | stroke.thin |
| _Accordion Item Selectable/Divider | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Open | true | _Accordion Item Selectable/Content Slot | itemSpacing | space.sm |
| Open | true | _Accordion Item Selectable/Content Slot | padding.left | space.lg |
| Open | true | _Accordion Item Selectable/Content Slot | padding.right | space.lg |
| Open | true | _Accordion Item Selectable/Content Slot | padding.top | space.lg |
| Open | true | _Accordion Item Selectable/Content Slot | padding.bottom | space.lg |
