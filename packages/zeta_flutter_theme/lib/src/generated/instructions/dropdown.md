# Dropdown

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2364-5903&m=dev

## Template/Dropdown

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2669-10309&m=dev

### Layer structure

- Template/Dropdown (COMPONENT)
  - Template/Dropdown/Trigger Component (FRAME)
    - Template/Dropdown/Trigger Component/Button (INSTANCE)
  - Template/Dropdown/Dropdown Menu (INSTANCE)

### Resolved tokens (default variant: Open=false, Position=bottom, Align=left)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Template/Dropdown | itemSpacing | 10 | — |
| Template/Dropdown/Trigger Component | itemSpacing | 10 | — |
| Template/Dropdown/Trigger Component/Button | height | 36 | control.sm |
| Template/Dropdown/Trigger Component/Button | fill[0] | #1f69ff | interactive.primary.background.default |
| Template/Dropdown/Trigger Component/Button | stroke[0] | #1f69ff | interactive.primary.border.default |
| Template/Dropdown/Trigger Component/Button | cornerRadius | 4 | radius.element-sm |
| Template/Dropdown/Trigger Component/Button | strokeWeight | 0 | stroke.base |
| Template/Dropdown/Trigger Component/Button | padding.left | 12 | space.md |
| Template/Dropdown/Trigger Component/Button | padding.right | 12 | space.md |
| Template/Dropdown/Trigger Component/Button | padding.top | 4 | space.xxs |
| Template/Dropdown/Trigger Component/Button | padding.bottom | 4 | space.xxs |
| Template/Dropdown/Dropdown Menu | fill[0] | #ffffff | surface.menu |
| Template/Dropdown/Dropdown Menu | cornerRadius | 6 | radius.element-md |
| Template/Dropdown/Dropdown Menu | itemSpacing | 2 | space.2xs |
| Template/Dropdown/Dropdown Menu | padding.left | 12 | space.card |
| Template/Dropdown/Dropdown Menu | padding.right | 12 | space.card |
| Template/Dropdown/Dropdown Menu | padding.top | 12 | space.card |
| Template/Dropdown/Dropdown Menu | padding.bottom | 12 | space.card |

## Menu Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2402-6508&m=dev

### Overview

A single row inside a Dropdown Menu, with a leading element, a label and an optional trailing icon. Six states cover resting, hover, selection, focus and disabled, and Type chooses what sits in the leading position. The row fills the width of the menu that holds it, so its own width is never set directly. Selection is carried by a faint tint alone, which is the thing to check when a menu sits on a busy surface.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | Default | true | The resting row. |
| State | hover | - | Documents the pointer-over treatment. The implementation drives this, so choosing it in a layout freezes the row in a state it should not be in. |
| State | selected | - | The row's option is currently chosen. It is carried by a faint background tint with the label and leading element unchanged, so it reads only as strongly as that tint does on the surface behind it. |
| State | focus | - | Keyboard focus, drawn as a ring on all four edges with the background left alone. It is the only state that adds a border, which is what keeps it tellable apart from selected. |
| State | selected focus | - | Both at once, for a keyboard user moving across an already-chosen option. Without it the two would be indistinguishable, which is the reason it exists. |
| State | disabled | - | The option is unavailable. Only the label changes, so the difference between available and unavailable rests on contrast alone. |
| Type | Icon | true | A leading Icon instance you set yourself. The glyph is exposed, so the row is configured from the menu without detaching. |
| Type | radio | - | Names the row as a single-choice option. It is built from the same exposed Icon as the Icon type, so the radio mark has to come from the glyph you pick rather than from the variant. |
| Type | checkbox | - | Names the row as a multi-choice option. Also built from the same exposed Icon, so the tick has to come from the glyph you pick. |
| Type | custom | - | Replaces the leading Icon with an empty slot, for a leading element the icon library cannot supply such as an avatar or a colour swatch. Nothing is provided by default, so the slot stays blank until filled. |
| Rounded | false | true | Square corners, for a row inside a square menu panel. Match the panel rather than choosing per row. |
| Rounded | true | - | Softened corners, for a rounded panel. Mixing the two inside one menu makes the rows look misaligned against the panel. |
| Label | text | Menu Item | The option's name. The row fills the menu's width and the text neither wraps nor truncates, so a long label widens the entire menu. |
| Leading Element | true | true | Shows the leading Icon. |
| Leading Element | false | - | Hides it and the label shifts to the leading edge. A menu mixing rows with and without it loses the alignment that makes a list scannable. |
| Trailing Icon | false | true | No trailing icon. |
| Trailing Icon | true | - | Adds an icon at the trailing edge, for a submenu arrow or an external-link mark. The label already reserves room on that side, so it takes space from the text. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Default | Resting | — | A fully transparent ghost background with the label on interactive/neutral/foreground/default. |
| hover | Pointer over the row | — | The ghost background rises to 5 percent opacity. The label and the leading element do not change. |
| selected | The option is chosen | — | A background on interactive/ghost/background/selected at 5 percent. Nothing else changes, so selected and hover sit at the same visual weight. |
| focus | Keyboard focus | — | A 1px ring on border/focus is drawn on all four edges, inside the row's own bounds. The background stays fully transparent. |
| selected focus | Focus on a chosen option | — | The selected tint and the focus ring together. It is the only state carrying both. |
| disabled | State set to disabled | — | The background stays transparent and the label moves to interactive/neutral/foreground/disabled. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Every state change is colour or opacity only, with no movement, scale or elevation. |
| Focus ring | Drawn inside the row's own bounds rather than outside, so it never overlaps the neighbouring row or the panel's padding. |
| Reflow | The row fills the width of the menu that holds it and its height is fixed, so a longer label reflows the menu rather than the row. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | The option's name. No truncation and no wrapping, the menu widens instead. |
| Leading Icon | exposed nested Icon, Types Icon, radio and checkbox | Pinned to Size=small with Framed off and left exposed, so the glyph is set per instance from the menu. See the Icon Metadata frame. It arrives holding Verified, which suits almost no real option. |
| Leading Slot | slot, Type custom only | Replaces the leading Icon when Type is custom. It carries no suggested components and is empty by default, so it stays blank until something is placed in it. |
| Trailing Icon | exposed nested Icon | Hidden until Trailing Icon is turned on, then a 16px glyph at the trailing edge. Also pinned to Size=small with Framed off and left exposed. |

### Anatomy

1. **Row** — The outer horizontal frame. Fills the width of the menu that holds it and keeps a fixed height, so rows line up whatever they contain.
2. **Leading element** — An exposed Icon for the Icon, radio and checkbox types, and an empty slot for custom.
3. **Label** — A wrapper frame holding the text. Its own padding sets the text away from the leading element and reserves room on the trailing side.
4. **Trailing Icon** — An exposed Icon at the trailing edge, hidden until its toggle is turned on.

### How to use

**Do:**
- Set the leading glyph on every row. It holds Verified by default, which says nothing about the option the row represents.
- Match Rounded to the menu panel that holds the row, rather than choosing it row by row.

**Don't:**
- Don't expect radio or checkbox to draw a control. All three of those types are built from the same exposed Icon, so the mark comes from the glyph you pick.
- Don't rely on selection alone being obvious. Selected is a 5 percent tint with no change to the label, which is a small difference on a light panel.

### Accessibility & Content Guidelines

- Selection is carried by a faint background tint alone, with no change to the label or the leading element. It needs to be conveyed in code as well.
- Focus is drawn as a ring inside the row's bounds and is the only state adding a border, which is what keeps it distinguishable from selection.
- Radio and checkbox are named roles rather than built controls. Whatever role the row plays has to be set in code, the variant name does not carry it.
- Disabled changes the label colour only, so the difference between an available and an unavailable option is contrast alone.
- The leading icon decorates or repeats the label rather than replacing it, so the label has to stand on its own.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fill | Fills the menu that holds it, drawn at 221px. The row never hugs its label, so the menu's width sets it. |
| Height | Fixed | 40px on control/md at every variant. |
| Padding | Fixed | 4px (space/xs) top and bottom, 12px (space/md) left and right. |
| Gap | Fixed | 8px (space/sm) between the leading element, the label and the trailing icon. |
| Label inset | Fixed | The label wrapper adds 4px (space/xs) on its leading edge and reserves 24px (space/xl) on its trailing edge, which keeps labels clear of a trailing icon even when one is not shown. |
| Radius | Fixed per Rounded | radius/none when false, radius/sm when true. |
| Leading and trailing icons | Fixed | Both 16px Icon instances at Size=small with Framed off. |
| Border | Fixed per State | None at rest. Focus and selected focus add a 1px ring on border/focus, drawn on all four edges inside the row. |
| Label type | Fixed | label/medium (14/20), IBM Plex Sans Medium. |
| Colour | Theming | Backgrounds come from the interactive/ghost family, transparent at rest, 5 percent on hover and on selected, transparent again on focus and disabled. The label is interactive/neutral/foreground/default, dropping to interactive/neutral/foreground/disabled when disabled. |

### Layer structure

- Menu Item (COMPONENT)
  - Menu Item/Leading Icon (INSTANCE, icon: verified)
  - Menu Item/Label (FRAME)
    - Menu Item/Label/Label (TEXT)
  - Menu Item/Trailing Icon (INSTANCE, icon: chevron_right)
  - Menu Item/Leading Slot (SLOT)

### Resolved tokens (default variant: State=Default, Type=Icon, Rounded=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Menu Item | height | 40 | control.md |
| Menu Item | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Menu Item | cornerRadius | 0 | radius.none |
| Menu Item | itemSpacing | 8 | space.sm |
| Menu Item | padding.left | 12 | space.md |
| Menu Item | padding.right | 12 | space.md |
| Menu Item | padding.top | 4 | space.xxs |
| Menu Item | padding.bottom | 4 | space.xxs |
| Menu Item/Label | padding.left | 4 | space.xxs |
| Menu Item/Label | padding.right | 24 | space.xl |
| Menu Item/Label/Label | fill[0] | #0c0d0e | interactive.neutral.foreground.default |
| Menu Item/Label/Label | fontSize | 14 | label.medium.font size |
| Menu Item/Label/Label | lineHeight | 20 | label.medium.line height |
| Menu Item/Label/Label | letterSpacing | 0 | label.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Menu Item | fill[0] | interactive.ghost.background.hover |
| State | selected | Menu Item | fill[0] | interactive.ghost.background.selected |
| State | focus | Menu Item | fill[0] | interactive.ghost.background.focused |
| State | focus | Menu Item | stroke[0] | border.focus |
| State | focus | Menu Item | strokeWeight | stroke.thin |
| State | selected focus | Menu Item | fill[0] | interactive.ghost.background.selected |
| State | selected focus | Menu Item | stroke[0] | border.focus |
| State | selected focus | Menu Item | strokeWeight | stroke.thin |
| State | disabled | Menu Item | fill[0] | interactive.ghost.background.disabled |
| State | disabled | Menu Item/Label/Label | fill[0] | interactive.neutral.foreground.disabled |
| Rounded | true | Menu Item | cornerRadius | radius.sm |

## Dropdown Menu

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2666-6863&m=dev

### Overview

The surface a dropdown opens onto, a floating panel holding a list of Menu Item rows. It brings its own menu surface and elevation, so it needs nothing behind it. Two built-in rows sit above a slot that takes the rest. Rounded sets the corner treatment and Compact tightens the inset for a menu with little room to spare. Place it through the Dropdown Template so its position relative to a trigger comes from a property rather than from nudging it by hand.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Rounded | false | true | Square corners, for a panel sitting against surfaces and inputs that are also square. The rows inside square off with it. |
| Rounded | true | - | Softened corners, for a panel that should read as a floating object rather than part of the surface beneath. The rows round with it, so panel and contents stay in agreement. |
| Compact | false | true | The default inset. Use it unless the menu has to fit a rail that cannot spare the room. |
| Compact | true | - | Tightens the inset for a cramped rail. A long list then reads as one dense block. |
| More Items | true | true | Shows the slot below the two built-in rows, which is where the rest of the menu goes. |
| More Items | false | - | Hides the slot along with everything placed in it, leaving only the two built-in rows. Fine for a deliberately short menu, but it will also hide content someone else added. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The panel has no interaction states of its own. Hover, selection, focus and disabled all live on the Menu Item rows inside it, so the menu never changes appearance on its own. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Opening and closing is driven by the Dropdown Template's Open property, which is a variant switch rather than something that animates here. |
| Elevation | The panel carries the Shadow/medium style, two stacked drop shadows. That is the only thing separating it from the surface beneath, and it does not change with any property. |
| Reflow | Both axes hug their content, so the panel grows with the number and width of the rows placed in it. A long label widens the whole menu rather than wrapping inside a row. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Slot Container | slot, holds Menu Item | Where the rest of the menu goes, below the two built-in rows. It takes two Menu Item instances by default. See the Menu Item Metadata frame. Figma only: the default variant stores its slot content separately from the other three, so content placed there does not carry when Rounded or Compact changes. |
| Built-in rows | fixed nested instances | Two Menu Item instances above the slot, pinned to the menu's own Rounded value. Neither is a slot, so changing them means overriding the nested instance. |
| Leading icon on a row | exposed nested Icon | Every Menu Item leaves its leading Icon exposed, so the glyph is reachable from the menu without detaching. See the Icon Metadata frame. |
| Row count | not constrained | Nothing caps how many rows the slot holds. The panel neither scrolls nor limits its height, so a menu long enough to run past the viewport is a design decision rather than one the component prevents. |

### Anatomy

1. **Panel** — The outer frame. Hugs its content on both axes and carries the menu surface, the radius and the elevation.
2. **Content** — The vertical stack inside the padding, holding the two built-in rows and then the slot.
3. **Slot Container** — The open region for additional Menu Item rows. More Items hides it as a whole, along with anything inside it.

### How to use

**Do:**
- Place the menu through the Dropdown Template so its position relative to a trigger comes from a property rather than manual nudging.
- Keep Rounded consistent with the surfaces around it. The rows inherit the choice, so the panel and its contents stay in agreement.

**Don't:**
- Don't fill the slot and then switch Rounded. Each Rounded variant holds that slot's content separately, so the content will not come with you.
- Don't add a background or shadow behind the menu. It already carries its own surface and elevation, and a second one reads as two stacked panels.

### Accessibility & Content Guidelines

- The panel is a container and announces nothing itself. The rows inside carry the meaning, so each needs a clear label.
- Elevation is the only thing separating the menu from the content behind it. Check Shadow/medium reads on the surfaces you open it over, because there is no border.
- The panel neither traps focus nor caps its own height. Both belong to the implementation.
- Rows are the interactive targets, not the panel. Keyboard movement between them has to be built in code, nothing here models it.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug on both axes | 213×196px at the default density and 201×184px when Compact is true, growing with whatever is placed inside. There is no fixed width, so the longest row sets the panel width. |
| Padding | Fixed | 12px (space/card) on all four sides, dropping to 6px (space/xs) when Compact is true. |
| Gap | Fixed | 4px (space/xxs) between rows, both in the built-in stack and inside the slot. The panel's own item spacing is 2px (space/2xs), or none when Compact is true, but it holds a single content frame so that spacing never shows. |
| Radius | Fixed per Rounded | radius/none when Rounded is false, radius/element-md when true. The rows inside take radius/none and radius/sm respectively, a lighter step than the panel itself. |
| Elevation | Fixed | The Shadow/medium effect style, two stacked drop shadows. Applied to the panel only and unchanged by any property. |
| Colour | Theming | The panel is surface/menu and binds nothing else. Every other colour in the menu comes from the rows. |

### Layer structure

- Dropdown Menu (COMPONENT)
  - Dropdown Menu/Content (FRAME)
    - Dropdown Menu/Content/Menu Item[1] (INSTANCE)
    - Dropdown Menu/Content/Menu Item[2] (INSTANCE)
    - Dropdown Menu/Content/Slot Container (SLOT)

### Resolved tokens (default variant: Rounded=false, Compact=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Dropdown Menu | fill[0] | #ffffff | surface.menu |
| Dropdown Menu | cornerRadius | 0 | radius.none |
| Dropdown Menu | itemSpacing | 2 | space.2xs |
| Dropdown Menu | padding.left | 12 | space.card |
| Dropdown Menu | padding.right | 12 | space.card |
| Dropdown Menu | padding.top | 12 | space.card |
| Dropdown Menu | padding.bottom | 12 | space.card |
| Dropdown Menu/Content | itemSpacing | 4 | space.xxs |
| Dropdown Menu/Content/Menu Item[1] | height | 40 | control.md |
| Dropdown Menu/Content/Menu Item[1] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Dropdown Menu/Content/Menu Item[1] | cornerRadius | 0 | radius.none |
| Dropdown Menu/Content/Menu Item[1] | itemSpacing | 8 | space.sm |
| Dropdown Menu/Content/Menu Item[1] | padding.left | 12 | space.md |
| Dropdown Menu/Content/Menu Item[1] | padding.right | 12 | space.md |
| Dropdown Menu/Content/Menu Item[1] | padding.top | 4 | space.xxs |
| Dropdown Menu/Content/Menu Item[1] | padding.bottom | 4 | space.xxs |
| Dropdown Menu/Content/Menu Item[2] | height | 40 | control.md |
| Dropdown Menu/Content/Menu Item[2] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Dropdown Menu/Content/Menu Item[2] | cornerRadius | 0 | radius.none |
| Dropdown Menu/Content/Menu Item[2] | itemSpacing | 8 | space.sm |
| Dropdown Menu/Content/Menu Item[2] | padding.left | 12 | space.md |
| Dropdown Menu/Content/Menu Item[2] | padding.right | 12 | space.md |
| Dropdown Menu/Content/Menu Item[2] | padding.top | 4 | space.xxs |
| Dropdown Menu/Content/Menu Item[2] | padding.bottom | 4 | space.xxs |
| Dropdown Menu/Content/Slot Container | itemSpacing | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Rounded | true | Dropdown Menu | cornerRadius | radius.element-md |
| Rounded | true | Dropdown Menu/Content/Menu Item[1] | cornerRadius | radius.sm |
| Rounded | true | Dropdown Menu/Content/Menu Item[2] | cornerRadius | radius.sm |
| Compact | true | Dropdown Menu | itemSpacing | — |
| Compact | true | Dropdown Menu | padding.left | space.xs |
| Compact | true | Dropdown Menu | padding.right | space.xs |
| Compact | true | Dropdown Menu | padding.top | space.xs |
| Compact | true | Dropdown Menu | padding.bottom | space.xs |

## Dropdown Template (documentation only)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2364-5903&m=dev

### Overview

A pattern rather than a component, pairing a trigger with a Dropdown Menu and placing the menu relative to it. Open shows or hides the menu, Position picks which side it opens on and Align pins which edges line up. The menu is positioned absolutely and sits outside the template's bounds, so a layout only reserves the trigger's space. This is a condensed record, the panel and its rows are documented in their own frames.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Open | false | true | The resting state, trigger only. The menu is still present but hidden, so anything placed in it is kept. |
| Open | true | - | Reveals the menu. Only one closed variant is built, so Position and Align have no effect until Open is true. |
| Position | bottom | true | Opens below the trigger. The default, and the right choice unless the trigger sits low in the viewport. |
| Position | top | - | Opens above the trigger, for a trigger near the bottom of the view. |
| Position | right | - | Opens to the trailing side, for a trigger in a narrow column or a side rail. |
| Position | left | - | Opens to the leading side, for a trigger near the trailing edge of the view. |
| Align | left | true | With Position bottom or top, lines the menu's leading edge up with the trigger's. |
| Align | right | - | With Position bottom or top, lines the trailing edges up instead, for a trigger near the trailing edge. |
| Align | top | - | With Position left or right, lines the top edges up. It has no effect while Position is bottom or top. |
| Align | bottom | - | With Position left or right, lines the bottom edges up. It has no effect while Position is bottom or top. |
| Trigger Component | instance swap | Button | The control the menu opens from. Button and Icon Button are the suggested options, and the instance stays exposed so the trigger's own label and flavour remain editable. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Trigger Component | instance swap, prefers Button or Icon Button | The control the menu opens from. Swap it through the property rather than replacing the layer, and the instance stays exposed so the trigger's own properties remain reachable. |
| Dropdown Menu | exposed nested instance | The panel itself, pinned to Rounded=true. Exposed, so its More Items toggle and its slot are reachable from the template. See the Dropdown Menu Metadata frame. |
| Menu content | through the nested menu | Rows go into the menu's slot, not into the template. The template surfaces the Rounded=true slot, so anything placed here belongs to that variant of the menu. |

### Accessibility & Content Guidelines

- Open is a static variant, not a behaviour. Showing and hiding the menu, returning focus to the trigger and closing on escape all belong to the implementation.
- The menu sits outside the template's bounds, so nothing here stops it opening off-screen. Flipping Position near a viewport edge is the implementation's job.
- The trigger needs an accessible name and a state saying whether the menu is open. Neither is modelled here.
- Rows inside the menu are the interactive targets. Keyboard movement between them is not modelled by this pattern.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Bounds | Hug the trigger only | 76×36px, the size of its trigger. The menu is absolutely positioned and sits outside those bounds, so a layout containing this pattern reserves no space for the open menu. |
| Offset | Fixed | The menu clears the trigger by 8px on whichever side Position selects. |
| Alignment | Fixed per Align | Align pins opposite edges together. With Position bottom or top the menu's leading or trailing edge lines up with the trigger's, with Position left or right its top or bottom edge does. |
| Fill and elevation | None on the template | The template paints nothing of its own. The surface and the shadow both belong to the menu. |
