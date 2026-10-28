# Navigation Rail

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3182-237&m=dev

## Navigation Rail

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3453-54061&m=dev

### Overview

A vertical navigation column for the edge of a desktop view, made of a narrow icon rail and a sub menu panel beside it. It is a container rather than a fixed design, three slots hold the destinations and the variant axes control only the rail's width and whether captions show. Fill the slots with Navigation Rail Item and Sub Menu Item instances. It paints no panel of its own, sitting on surface/section and marking the boundary between rail and panel with a single border.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Expanded | false | true | The narrow icon rail. Destinations read as glyphs alone unless Label is on, so it only works where the icons are genuinely recognisable. |
| Expanded | true | - | The wide rail, with every item's label beside its icon and the header action becoming a full Button. Reach for it when the destinations cannot be told apart by glyph. It changes the rail's overall width, so the page beside it has to give up the difference. |
| Label | false | true | Icons only in the narrow rail. |
| Label | true | - | Adds a caption under each icon in the narrow rail, buying recognition without the width of Expanded. The column stays narrow, so only very short words fit. Content placed in the Menu Slot is held separately per Label setting and does not carry across a change to it. |
| Show Header Action | true | true | Shows the action under the header, a create or compose entry point rather than a destination. |
| Show Header Action | false | - | Hides it, for a rail that is purely navigational. |
| Show Toggle Item | true | true | Shows the last footer item, which carries the panel glyph and is how a user moves between the narrow and wide rail. |
| Show Toggle Item | false | - | Hides it. Only do this when something outside the rail controls Expanded, otherwise the user has no way to change it back. |
| Show Sub menu | true | true | Shows the panel beside the rail, for destinations that have a second level. |
| Show Sub menu | false | - | Hides the panel and leaves the icon rail on its own. The rail's overall width drops by the panel's width, so the layout beside it moves. |
| More Rail Items | true | true | Shows the Menu Slot below the three built-in rail items, which is where additional destinations go. |
| More Rail Items | false | - | Hides the slot along with everything placed in it, leaving only the three built-in items. |
| More Footer Items | true | true | Shows the Footer Slot above the fixed footer items. |
| More Footer Items | false | - | Hides the slot along with everything placed in it. |
| Shape | rounded | true | Code only, not drawn in Figma. Gives everything inside the rail rounded corners (radius/sm): rail items, sub menu rows, Collapsible Menu Items, the header action, and the buttons in both headers, including back. The rail's own edges never change. |
| Shape | sharp | - | Square corners (radius/none) on everything inside the rail. |
| Inverse | false | true | Code only. The rail always shows in dark mode, whatever the page's mode. Everything inside it follows the rail, and brand extensions still apply. |
| Inverse | true | - | Shows the rail in light mode instead, still regardless of the page's mode. |
| Rail Max Width | none | true | Code only. The wide rail is 200px. |
| Rail Max Width | length | - | Caps the wide rail's width. Labels that no longer fit end in an ellipsis. The narrow rail is not affected. |
| Sub Menu Max Width | none | true | Code only. The sub menu sizes to its content, never narrower than 240px. |
| Sub Menu Max Width | length | - | Caps the sub menu's width. Rows that no longer fit end in an ellipsis. A cap below 240px also lowers the 240px minimum. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The rail has no interaction states of its own. Selection, hover, press and disabled all live on the Navigation Rail Item and Sub Menu Item instances inside the slots, so the container never changes appearance. |
| Collapse / expand | Toggle item, or Expanded set from outside | animations/smooth | The icon rail widens or narrows and labels appear or leave; whatever sits beside the rail moves with it. |
| Sub menu open / close | Show Sub menu, or choosing a destination with a second level | animations/smooth | The panel opens or closes beside the rail, and the overall width follows. |
| Group open / close | Collapsible Menu Item header | animations/smooth | The group's rows reveal or hide and its caret turns. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Every opening and closing inside the rail uses animations/smooth (ease-in-out, 250ms): the rail collapsing and expanding, the sub menu panel showing and hiding, and Collapsible Menu Items opening and closing, caret included. Figma draws only the end states as variants; code animates between them. Turn motion off under prefers-reduced-motion. |
| Width change | Expanded and Show Sub menu both change the component's overall width. Whatever sits beside the rail has to absorb the difference, so plan the page for every width you intend to ship. |
| Truncated labels | Sub menu labels that don't fit end in an ellipsis. Hovering a cut-off label for 3 seconds shows it in full in a tooltip; keyboard focus shows it at once. Labels that fit show no tooltip, and the tooltip is not announced a second time to screen readers. |
| Caret | Carets turn a single glyph rather than swapping between two. Figma shows each end state with its own glyph; build one glyph that rotates, on animations/smooth inside the rail. |
| Vertical fill | The menu list takes whatever height is left between the header block and the footer, so the footer stays pinned to the bottom however many items sit above it. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Menu Slot | slot, holds Navigation Rail Item | Additional destinations below the three built-in rail items. It ships holding a Divider and three items. See the Navigation Rail Item Metadata frame. Its content is stored separately for each Label setting, so switching Label leaves the content behind. |
| Footer Slot | slot, holds Navigation Rail Item | Destinations pinned to the bottom, above the two fixed footer items. It ships holding a Divider and three items, and the same content is shared by every variant. |
| Sub Menu Slot | slot, holds Sub Menu Item and Collapsible Menu Item | The second-level list inside the panel. It ships holding one Collapsible Menu Item and four Sub Menu Items, and its content is shared by every variant. See the Sub Menu Item Metadata frame. |
| Sub Menu Header | exposed nested instance | The panel's title bar, carrying a back affordance, an editable title and a trailing slot of its own holding a Button. The rail leaves the instance exposed, so all of that is reachable without detaching. The shape of all sub elements are inherited from the main rail component. |
| Header and header action | fixed nested instances | The header is a Navigation Header showing an avatar. The action below it is an Icon Button in the narrow rail and a Button in the wide one. Neither is a slot, so changing them means overriding the nested instance. |

### Anatomy

1. **Main Rail** — The icon column, holding the header, the action, the menu list and the footer. Its width is what changes between the two Expanded variants.
2. **Menu List** — The middle of the rail, holding three built-in items and then the Menu Slot. It absorbs whatever height is left between the header block and the footer.
3. **Footer** — Pinned to the bottom, holding the Footer Slot and two fixed items. The last of them is the toggle a user presses to change the rail's width.
4. **Sub menu** — The panel beside the rail, holding the Sub Menu Header and the Sub Menu Slot. It carries the only vertical border in the component, on its leading edge.

### How to use

**Do:**
- Fill the Menu Slot and Footer Slot with Navigation Rail Item instances and let the rail handle the spacing and alignment.
- Keep the toggle item visible unless something outside the rail controls Expanded, since it is the only control a user has over the rail's width.

**Don't:**
- Don't place Menu Slot content and then switch Label. The two Label settings hold that slot's content separately, so the content will not come with you.
- Don't lean on Label to make destinations readable. The caption sits inside the narrow column and only the shortest words fit, Expanded is the setting that gives labels room.

### Accessibility & Content Guidelines

- The rail is a container and announces nothing itself. The destinations inside carry the meaning, so each needs a clear name even when only its glyph shows.
- Collapsed, destinations are glyph-only unless Label is on. An icon is not a name, so the accessible name has to come from code.
- Exactly one destination should read as selected across the rail and the panel together, and nothing in the component enforces that.
- The panel is separated from the rail by a single border on its leading edge. Check that border/default reads against surface/section, because nothing else marks the boundary.
- The toggle item is the only way a user changes the rail's width. Hiding it without providing another control strands anyone who needs the labels.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Hug | The narrow rail is 72px and the wide rail 200px; Rail Max Width can cap the wide rail. The sub menu sizes to its content: as wide as its widest top-level row or its header, never narrower than 240px, and all rows share that width. A Collapsible Menu Item never makes it wider. Sub Menu Max Width can cap it. Figma draws the sub menu at a fixed 240px; build it to size to its content. |
| Height | Fill | Fills its parent, drawn at 991px. The icon rail and the panel both fill it, and the menu list absorbs the space left between the header block and the footer. |
| Rail padding | Fixed | 12px on all four sides of the icon rail, space/md left and right and space/card top and bottom, with a 12px (space/md) gap between the header, the action, the menu list and the footer. |
| Item spacing | Fixed | 4px (space/xs) between items in both the menu list and the footer. The Menu Slot adds 4px (space/xs) of horizontal padding of its own. |
| Panel padding | Fixed | The Sub Menu Slot insets its rows by 8px (space/sm) on all four sides, with a 4px (space/xs) gap between them. |
| Border | Fixed | A single 1px border on border/default down the leading edge of the sub menu panel, plus a 1px bottom border on the same token under the Sub Menu Header. Nothing else in the component is stroked. |
| Fill | Theming | The rail always shows in dark mode, whatever the page's mode; Inverse shows it in light mode. It sits on surface/section, and neither the icon rail nor the panel paints a fill of its own. |
| Colour | Theming | The rail binds only its surface and its two borders. Every other colour comes from the items in the slots. |

### Layer structure

- Navigation Rail (COMPONENT)
  - Navigation Rail/Main Rail (FRAME)
    - Navigation Rail/Main Rail/Navigation Header (INSTANCE)
    - Navigation Rail/Main Rail/Icon Button (INSTANCE)
    - Navigation Rail/Main Rail/Menu List (FRAME)
      - Navigation Rail/Main Rail/Menu List/Rail Item 1 (INSTANCE)
      - Navigation Rail/Main Rail/Menu List/Rail Item 2 (INSTANCE)
      - Navigation Rail/Main Rail/Menu List/Rail Item 3 (INSTANCE)
      - Navigation Rail/Main Rail/Menu List/Menu Slot (SLOT)
    - Navigation Rail/Main Rail/Footer (FRAME)
      - Navigation Rail/Main Rail/Footer/Footer Slot (SLOT)
      - Navigation Rail/Main Rail/Footer/Footer Rail Item (INSTANCE)
      - Navigation Rail/Main Rail/Footer/Navigation Rail Item (INSTANCE)
    - Navigation Rail/Main Rail/Button (INSTANCE)
  - Navigation Rail/Sub menu (FRAME)
    - Navigation Rail/Sub menu/Sub Menu Header (INSTANCE)
    - Navigation Rail/Sub menu/Sub Menu Slot (SLOT)

### Resolved tokens (default variant: Label=false, Expanded=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Navigation Rail | fill[0] | #0c0d0e | surface.section |
| Navigation Rail/Main Rail | itemSpacing | 12 | space.md |
| Navigation Rail/Main Rail | padding.left | 12 | space.md |
| Navigation Rail/Main Rail | padding.right | 12 | space.md |
| Navigation Rail/Main Rail | padding.top | 12 | space.card |
| Navigation Rail/Main Rail | padding.bottom | 12 | space.card |
| Navigation Rail/Main Rail/Navigation Header | itemSpacing | 10 | — |
| Navigation Rail/Main Rail/Icon Button | width | 48 | control.lg |
| Navigation Rail/Main Rail/Icon Button | height | 48 | control.lg |
| Navigation Rail/Main Rail/Icon Button | fill[0] | #1f69ff | interactive.primary.background.default |
| Navigation Rail/Main Rail/Icon Button | stroke[0] | #1f69ff | interactive.primary.border.default |
| Navigation Rail/Main Rail/Icon Button | cornerRadius | 4 | radius.element-sm |
| Navigation Rail/Main Rail/Icon Button | strokeWeight | 0 | stroke.base |
| Navigation Rail/Main Rail/Icon Button | padding.left | 4 | space.xxs |
| Navigation Rail/Main Rail/Icon Button | padding.right | 4 | space.xxs |
| Navigation Rail/Main Rail/Icon Button | padding.top | 4 | space.xxs |
| Navigation Rail/Main Rail/Icon Button | padding.bottom | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List | itemSpacing | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Rail Item 1 | fill[0] | #d6dce200 | interactive.ghost.background.default |
| Navigation Rail/Main Rail/Menu List/Rail Item 1 | cornerRadius | 4 | radius.element-sm |
| Navigation Rail/Main Rail/Menu List/Rail Item 1 | padding.left | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Rail Item 1 | padding.right | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Rail Item 1 | padding.top | 8 | space.sm |
| Navigation Rail/Main Rail/Menu List/Rail Item 1 | padding.bottom | 8 | space.sm |
| Navigation Rail/Main Rail/Menu List/Rail Item 2 | fill[0] | #d6dce200 | interactive.ghost.background.default |
| Navigation Rail/Main Rail/Menu List/Rail Item 2 | cornerRadius | 4 | radius.element-sm |
| Navigation Rail/Main Rail/Menu List/Rail Item 2 | padding.left | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Rail Item 2 | padding.right | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Rail Item 2 | padding.top | 8 | space.sm |
| Navigation Rail/Main Rail/Menu List/Rail Item 2 | padding.bottom | 8 | space.sm |
| Navigation Rail/Main Rail/Menu List/Rail Item 3 | fill[0] | #d6dce200 | interactive.ghost.background.default |
| Navigation Rail/Main Rail/Menu List/Rail Item 3 | cornerRadius | 4 | radius.element-sm |
| Navigation Rail/Main Rail/Menu List/Rail Item 3 | padding.left | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Rail Item 3 | padding.right | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Rail Item 3 | padding.top | 8 | space.sm |
| Navigation Rail/Main Rail/Menu List/Rail Item 3 | padding.bottom | 8 | space.sm |
| Navigation Rail/Main Rail/Menu List/Menu Slot | itemSpacing | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Menu Slot | padding.left | 4 | space.xxs |
| Navigation Rail/Main Rail/Menu List/Menu Slot | padding.right | 4 | space.xxs |
| Navigation Rail/Main Rail/Footer | itemSpacing | 4 | space.xxs |
| Navigation Rail/Main Rail/Footer/Footer Slot | itemSpacing | 4 | space.xxs |
| Navigation Rail/Main Rail/Footer/Footer Rail Item | fill[0] | #d6dce200 | interactive.ghost.background.default |
| Navigation Rail/Main Rail/Footer/Footer Rail Item | cornerRadius | 4 | radius.element-sm |
| Navigation Rail/Main Rail/Footer/Footer Rail Item | padding.left | 4 | space.xxs |
| Navigation Rail/Main Rail/Footer/Footer Rail Item | padding.right | 4 | space.xxs |
| Navigation Rail/Main Rail/Footer/Footer Rail Item | padding.top | 8 | space.sm |
| Navigation Rail/Main Rail/Footer/Footer Rail Item | padding.bottom | 8 | space.sm |
| Navigation Rail/Main Rail/Footer/Navigation Rail Item | fill[0] | #d6dce200 | interactive.ghost.background.default |
| Navigation Rail/Main Rail/Footer/Navigation Rail Item | cornerRadius | 4 | radius.element-sm |
| Navigation Rail/Main Rail/Footer/Navigation Rail Item | padding.left | 4 | space.xxs |
| Navigation Rail/Main Rail/Footer/Navigation Rail Item | padding.right | 4 | space.xxs |
| Navigation Rail/Main Rail/Footer/Navigation Rail Item | padding.top | 8 | space.sm |
| Navigation Rail/Main Rail/Footer/Navigation Rail Item | padding.bottom | 8 | space.sm |
| Navigation Rail/Sub menu | stroke[0] | #545963 | border.default |
| Navigation Rail/Sub menu | strokeWeight | 1 | — |
| Navigation Rail/Sub menu/Sub Menu Header | stroke[0] | #545963 | border.default |
| Navigation Rail/Sub menu/Sub Menu Header | strokeWeight | 1 | — |
| Navigation Rail/Sub menu/Sub Menu Header | itemSpacing | 10 | — |
| Navigation Rail/Sub menu/Sub Menu Header | padding.left | 16 | space.lg |
| Navigation Rail/Sub menu/Sub Menu Header | padding.right | 16 | space.lg |
| Navigation Rail/Sub menu/Sub Menu Slot | itemSpacing | 4 | space.xxs |
| Navigation Rail/Sub menu/Sub Menu Slot | padding.left | 8 | space.sm |
| Navigation Rail/Sub menu/Sub Menu Slot | padding.right | 8 | space.sm |
| Navigation Rail/Sub menu/Sub Menu Slot | padding.top | 8 | space.sm |
| Navigation Rail/Sub menu/Sub Menu Slot | padding.bottom | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | width | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | height | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | fill[0] | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | stroke[0] | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | cornerRadius | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | strokeWeight | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | padding.left | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | padding.right | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | padding.top | — |
| Expanded | true | Navigation Rail/Main Rail/Icon Button | padding.bottom | — |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 1 | padding.left | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 1 | padding.right | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 1 | itemSpacing | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 2 | padding.left | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 2 | padding.right | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 2 | itemSpacing | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 3 | padding.left | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 3 | padding.right | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Rail Item 3 | itemSpacing | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Menu Slot | padding.left | — |
| Expanded | true | Navigation Rail/Main Rail/Menu List/Menu Slot | padding.right | — |
| Expanded | true | Navigation Rail/Main Rail/Footer/Footer Rail Item | padding.left | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Footer/Footer Rail Item | padding.right | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Footer/Footer Rail Item | itemSpacing | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Footer/Navigation Rail Item | padding.left | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Footer/Navigation Rail Item | padding.right | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Footer/Navigation Rail Item | itemSpacing | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Button | height | control.lg |
| Expanded | true | Navigation Rail/Main Rail/Button | fill[0] | interactive.primary.background.default |
| Expanded | true | Navigation Rail/Main Rail/Button | stroke[0] | interactive.primary.border.default |
| Expanded | true | Navigation Rail/Main Rail/Button | cornerRadius | radius.element-sm |
| Expanded | true | Navigation Rail/Main Rail/Button | strokeWeight | stroke.base |
| Expanded | true | Navigation Rail/Main Rail/Button | padding.left | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Button | padding.right | space.lg |
| Expanded | true | Navigation Rail/Main Rail/Button | padding.top | space.xxs |
| Expanded | true | Navigation Rail/Main Rail/Button | padding.bottom | space.xxs |

## Navigation Rail Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3453-54230&m=dev

### Overview

A single destination in a Navigation Rail, shown as a glyph in a square target or, in the wide form, a glyph and label on one row. It is the content the rail's Menu and Footer slots are built around, and the rail sets nothing on it beyond visibility, so every property here is yours per instance. Selection recolours the glyph and label rather than laying a scrim behind them, which is what keeps it distinct from hover and press.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | default | true | The resting destination. |
| State | hover | - | Documents the pointer-over treatment. The implementation drives this, so choosing it in a layout freezes the item in a state it should not be in. |
| State | active | - | Documents the pointer-down treatment, with the same caveat as hover. |
| State | selected | - | The destination the user is currently on. It is the only state that recolours the glyph and label instead of laying a scrim behind them, so it stays legible whatever the rail sits on. Exactly one item across the rail should carry it. |
| Disabled | false | true | The destination can be selected. |
| Disabled | true | - | The destination is unavailable, and nothing on the item explains why. Offered on the resting state only, so an item cannot be shown selected and disabled at once. |
| Expanded | false | true | The narrow form, a glyph in a square target with the caption hidden unless Show Label is on. |
| Expanded | true | - | The wide form, glyph and label side by side on a single row. This should match the rail the item sits in, since the rail sets its own width independently. |
| Label | text | Label | The destination's name. It always shows in the wide form, and in the narrow form only when Show Label is on, where the column is too narrow for anything but a very short word. |
| Show Label | false | true | Glyph only in the narrow form. |
| Show Label | true | - | Adds the caption under the glyph in the narrow form. It has no effect in the wide form, where the label shows regardless. |
| Show Icon | true | true | Shows the glyph. |
| Show Icon | false | - | Hides it. In the narrow form with Show Label off this leaves an empty target with nothing to read, so only turn it off in the wide form. |
| Show Badge | false | true | No badge on the glyph. |
| Show Badge | true | - | Reveals a notification dot over the glyph's top-right corner. It sits outside the layout, so turning it on never changes the item's size or shifts its neighbours. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Resting | — | A fully transparent ghost background, with glyph and label on interactive/neutral/foreground/default. |
| hover | Pointer over the item | — | The ghost background rises to 5 percent opacity. Glyph and label do not change, so the scrim alone carries the feedback. |
| active | Pointer held down | — | The same scrim at 10 percent. Glyph and label still do not change. |
| selected | Marked as the current destination | — | No scrim at all. The glyph and label move to interactive/subtle/foreground/default instead, which is what separates selection from hover and press. |
| disabled | Disabled set to true | — | The background fill is dropped entirely and glyph and label move to interactive/subtle/foreground/disabled. |
| focus | Not modelled | — | There is no focus variant. Keyboard focus has to be rendered by the implementation. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is modelled. Every state change is colour or opacity only, with no movement, scale or elevation. |
| Badge | The badge is positioned absolutely over the glyph and sits outside the layout, so showing or hiding it never reflows the item or the rail. |
| Form change | Switching Expanded changes the layout direction, the padding and the text style all at once. It is a different shape rather than a resize, so it is set by the rail rather than animated. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | The destination's name. There is no truncation and no wrapping, so in the narrow form a long word simply overflows its column. |
| Icon | exposed nested Icon instance | The item pins Icon to Size=small with Framed off and leaves the instance exposed, so the glyph can be swapped per instance while the sizing stays consistent. See the Icon Metadata frame. It arrives holding Star, a placeholder rather than a real destination glyph. |
| Badge | nested Notification Indicator, toggled by Show Badge | Pinned to Size=small, the dot with no number. The item does not leave this instance exposed, so its value and size cannot be changed without detaching. At this size the dot signals that something is waiting, not how much. |

### Anatomy

1. **Item** — The outer frame. Vertical and hugging in the narrow form, horizontal and fixed-width in the wide one, with a minimum on both axes so the target never shrinks below it.
2. **Icon box** — The box holding the glyph, and the anchor the badge is positioned against. It does not clip, which is what lets the badge overhang its corner.
3. **Label** — The destination's name. Hidden by default in the narrow form and always shown in the wide one, with a different text style in each.

### How to use

**Do:**
- Set exactly one item across the whole rail to selected. Selection is the item's job and neither the rail nor the panel manages it.
- Swap the glyph on every item. It ships holding a Star placeholder, which says nothing about where the destination goes.

**Don't:**
- Don't turn Show Icon off in the narrow form. With the caption hidden too, the item becomes an empty target with nothing to read.
- Don't rely on Show Label to hide labels in the wide form. It only controls the narrow one, where the label is hidden by default anyway.

### Accessibility & Content Guidelines

- In the narrow form the destination is a glyph alone unless Show Label is on. An icon is not a name, so the accessible name has to come from code.
- Selection is carried by colour on the glyph and label, with no scrim, underline or indicator bar. It needs to be conveyed in code as well.
- Hover and press are carried by a translucent scrim alone and leave the glyph and label unchanged, so neither reaches a keyboard or screen reader user.
- There is no focus variant. Keyboard focus has to be rendered by the implementation.
- Disabled is visual only and nothing on the item explains why a destination is unavailable.
- The badge is a dot with no number at the size this component pins, so whatever it signals needs a text equivalent.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Hug in the narrow form, fixed in the wide one | 48px collapsed, growing only if a caption is wider. 176px expanded, fixed regardless of label length. |
| Height | Hug with a floor | 48px in both forms, held up by a control/lg minimum on both axes so the target never drops below it. |
| Padding | Fixed per form | 8px (space/sm) top and bottom in both. 4px (space/xs) left and right collapsed, 16px (space/lg) expanded. |
| Gap | Fixed per form | None collapsed, where the caption sits directly under the glyph. 16px (space/lg) expanded, between glyph and label. |
| Radius | Fixed | radius/sm on every variant. |
| Icon | Fixed | A 16px Icon at Size=small with Framed off, in a 16px box that does not clip its content. |
| Badge | Absolute | An 8px Notification Indicator at Size=small, placed at 12,-4 against the 16px glyph box so it overhangs the top-right corner, outside the layout flow. |
| Label type | Fixed per form | indicator/small (10/12, Regular) collapsed, label/medium (14/20, Medium) expanded. |
| Colour | Theming | interactive/neutral/foreground/default at rest, hover and press. interactive/subtle/foreground/default when selected, interactive/subtle/foreground/disabled when disabled. Backgrounds come from the interactive/ghost family. Glyph and label take the same token in every state. |

### Layer structure

- Navigation Rail Item (COMPONENT)
  - Navigation Rail Item/Indicator (FRAME)
    - Navigation Rail Item/Indicator/Icon (INSTANCE, icon: star)
    - Navigation Rail Item/Indicator/Notification Indicator (INSTANCE)
  - Navigation Rail Item/Label (TEXT)

### Resolved tokens (default variant: State=default, Disabled=false, Expanded=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Navigation Rail Item | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Navigation Rail Item | cornerRadius | 4 | radius.sm |
| Navigation Rail Item | padding.left | 4 | space.xxs |
| Navigation Rail Item | padding.right | 4 | space.xxs |
| Navigation Rail Item | padding.top | 8 | space.sm |
| Navigation Rail Item | padding.bottom | 8 | space.sm |
| Navigation Rail Item/Indicator | itemSpacing | 10 | — |
| Navigation Rail Item/Indicator/Notification Indicator | fill[0] | #d70015 | interactive.destructive.background.default |
| Navigation Rail Item/Indicator/Notification Indicator | stroke[0] | #ffffff | border.inverse |
| Navigation Rail Item/Indicator/Notification Indicator | cornerRadius | 9999 | radius.pill |
| Navigation Rail Item/Indicator/Notification Indicator | strokeWeight | 0 | stroke.base |
| Navigation Rail Item/Label | fill[0] | #0c0d0e | interactive.neutral.foreground.default |
| Navigation Rail Item/Label | fontSize | 10 | indicator.small.font size |
| Navigation Rail Item/Label | lineHeight | 12 | indicator.small.line height |
| Navigation Rail Item/Label | letterSpacing | 0 | indicator.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Navigation Rail Item | fill[0] | interactive.ghost.background.hover |
| State | selected | Navigation Rail Item/Label | fill[0] | interactive.subtle.foreground.default |
| State | active | Navigation Rail Item | fill[0] | interactive.ghost.background.pressed |
| Disabled | true | Navigation Rail Item | fill[0] | — |
| Disabled | true | Navigation Rail Item/Label | fill[0] | interactive.subtle.foreground.disabled |
| Expanded | true | Navigation Rail Item | padding.left | space.lg |
| Expanded | true | Navigation Rail Item | padding.right | space.lg |
| Expanded | true | Navigation Rail Item | itemSpacing | space.lg |
| Expanded | true | Navigation Rail Item/Label | fontSize | label.medium.font size |
| Expanded | true | Navigation Rail Item/Label | lineHeight | label.medium.line height |
| Expanded | true | Navigation Rail Item/Label | letterSpacing | label.medium.letter spacing |

## Sub Menu Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3453-54275&m=dev

### Overview

A row in the Navigation Rail's sub menu panel, with a leading glyph, a label, an optional badge and an optional caret. It is the content the rail's Sub Menu Slot is built around, placed either directly or inside a Collapsible Menu Item. Nesting is a property rather than a layout, indenting the row and quietening its label so one level of hierarchy reads without connector lines.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | default | true | The resting row. |
| State | hover | - | Documents the pointer-over treatment. The implementation drives this, so choosing it in a layout freezes the row in a state it should not be in. |
| State | active | - | Documents the pointer-down treatment. It also shifts the label token, which hover does not. |
| State | selected | - | The row the user is currently on. It is the only state with a background of its own rather than a borrowed scrim, and it recolours the label as well. |
| Disabled | false | true | The row can be selected. |
| Disabled | true | - | The row is unavailable, and nothing on it explains why. Offered on the resting state only, so a row cannot be shown selected and disabled at once. |
| Nested | false | true | A first-level row in the panel. |
| Nested | true | - | A child row under a collapsible parent. It indents from the leading edge and steps the label down to a quieter token and a smaller type style, so depth reads without a connector line. Only one level of nesting is built. |
| Label | text | Label | The row's name. The row is a fixed width and the text does not truncate or wrap, so a long name overflows rather than shortening. |
| Show Leading Icon | true | true | Shows a glyph before the label, which is what keeps rows scannable in a long list. |
| Show Leading Icon | false | - | Hides it. The label shifts to the leading edge, so a list mixing rows with and without icons loses its alignment. |
| Sub Menu | true | true | Shows the caret at the trailing edge, marking the row as one that opens a further level. |
| Sub Menu | false | - | Hides the caret, for a row that navigates straight to its destination. Leaving it on for a row that opens nothing promises a level that is not there. |
| Show Badge | false | true | No badge on the row. |
| Show Badge | true | - | Reveals a notification indicator between the label and the trailing caret. Unlike the rail item's badge this one sits in the layout, so it takes space from the label. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Resting | — | No background at all. The label sits on foreground/primary, or foreground/secondary when nested. |
| hover | Pointer over the row | — | A ghost scrim at 5 percent opacity appears behind the row. The label does not change. |
| active | Pointer held down | — | The ghost scrim at 10 percent, and the label moves to interactive/neutral/foreground/default. This is the one state where nested and unnested rows converge on the same label token. |
| selected | Marked as the current row | — | A background on interactive/ghost/background/selected at 5 percent, the only state with a token of its own rather than a borrowed scrim, with the label on interactive/ghost/foreground/default. |
| disabled | Disabled set to true | — | The background is dropped entirely and the label moves to foreground/disabled. |
| focus | Not modelled | — | There is no focus variant. Keyboard focus has to be rendered by the implementation. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is modelled. Every state change is colour or opacity only, with no movement, scale or elevation. |
| Caret | The caret has its own open and closed states, but this component does not drive them. Whatever expands the row is responsible for turning the caret with it. |
| Badge | The badge sits inside the row's layout rather than floating over it, so turning it on takes width away from the label. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | The row's name. Fixed row width with no truncation and no wrapping, so length has to be controlled by the writing. |
| Leading icon | exposed nested Icon instance | Pinned to Size=small with Framed off and left exposed, so the glyph can be swapped per instance while the sizing stays consistent. See the Icon Metadata frame. It arrives holding Verified, a placeholder rather than a real destination glyph. |
| Badge | exposed nested Notification Indicator | Pinned to Size=medium, which is the counter rather than the bare dot, and left exposed so its value stays editable. This is a different size from the one the rail item pins, so the two badges are not interchangeable. |
| Caret | exposed nested Caret Indicator | Pinned to the horizontal direction and the closed position, and left exposed so the open state is reachable. Toggled as a whole by Sub Menu. |

### Anatomy

1. **Row** — The outer frame. Fills the width of the slot it sits in and holds a minimum height, so rows in a list line up whatever they contain.
2. **Icon and Title** — The leading glyph and the label, kept together so the label starts at the same place on every row that has an icon.
3. **Badge** — A notification indicator between the label and the caret. It sits inside the layout, so it takes width rather than overhanging.
4. **Trailing Slot** — The caret marking a row that opens a further level. Toggled as a whole by the Sub Menu property.

### How to use

**Do:**
- Turn Sub Menu off for rows that navigate straight to a destination. The caret is a promise that another level exists.
- Keep the leading icon on for every row in a list, or off for all of them. Mixing the two breaks the label alignment down the panel.

**Don't:**
- Don't nest more than one level. Only a single indent step is built, so a deeper tree will read as though everything sits at the same depth.
- Don't treat this badge as interchangeable with the rail item's. This one is the counter size and sits in the layout, that one is a bare dot that floats over the glyph.

### Accessibility & Content Guidelines

- Nesting is conveyed by indent, a quieter label token and a smaller type style, with no connector line. The hierarchy has to be expressed in code as well.
- Selection is the only state with a background of its own. Hover and press borrow a translucent scrim and leave the label alone, so neither reaches a keyboard or screen reader user.
- There is no focus variant. Keyboard focus has to be rendered by the implementation.
- Disabled is visual only and nothing on the row explains why it is unavailable.
- The caret marks a row that opens another level but does not describe what is inside it, so the label has to carry that on its own.
- Nested rows drop to a 12px type style, which is small for a navigation target. Check it against your minimum readable size.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fill | Fills the slot it sits in, drawn at 184px. It does not hug its label, so rows in a list are all the same width. |
| Height | Hug with a floor | 48px, held up by a control/lg minimum so the target never drops below it. |
| Padding | Fixed per Nested | 4px (space/xs) top and bottom throughout. 12px (space/md) left and right unnested, with the left edge stepping to 24px when nested. |
| Gap | Fixed | 8px (space/sm) between the icon, the label, the badge and the caret. |
| Radius | Fixed | radius/sm on every variant. |
| Icon and caret | Fixed | Both 16px, the icon an Icon at Size=small and the caret a Caret Indicator in its horizontal direction. |
| Badge | In flow | A 16px Notification Indicator at Size=medium, sitting between the label and the caret rather than overhanging the row. |
| Label type | Fixed per Nested | label/medium (14/20, Medium) unnested, indicator/medium (12/14, Medium) nested. |
| Colour | Theming | foreground/primary at rest, foreground/secondary when nested, interactive/ghost/foreground/default when selected, interactive/neutral/foreground/default when pressed and foreground/disabled when disabled. Backgrounds come from the interactive/ghost family. |

### Layer structure

- Sub Menu Item (COMPONENT)
  - Sub Menu Item/Icon and Title (FRAME)
    - Sub Menu Item/Icon and Title/Icon (INSTANCE, icon: verified)
    - Sub Menu Item/Icon and Title/Page Title (FRAME)
      - Sub Menu Item/Icon and Title/Page Title/Title (TEXT)
  - Sub Menu Item/Badge (FRAME)
    - Sub Menu Item/Badge/Notification Indicator (INSTANCE)
  - Sub Menu Item/Trailing Slot (FRAME)
    - Sub Menu Item/Trailing Slot/Caret Indicator (INSTANCE)
  - Sub Menu Item/Trailing Slot[1] (FRAME)
    - Sub Menu Item/Trailing Slot[1]/Caret Indicator (INSTANCE)
  - Sub Menu Item/Trailing Slot[2] (FRAME)
    - Sub Menu Item/Trailing Slot[2]/Caret Indicator (INSTANCE)

### Resolved tokens (default variant: State=hover, Disabled=false, Nested=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Sub Menu Item | fill[0] | #0c0d0e0d | interactive.ghost.background.hover |
| Sub Menu Item | cornerRadius | 4 | radius.sm |
| Sub Menu Item | itemSpacing | 8 | space.sm |
| Sub Menu Item | padding.left | 12 | space.md |
| Sub Menu Item | padding.right | 12 | space.md |
| Sub Menu Item | padding.top | 4 | space.xxs |
| Sub Menu Item | padding.bottom | 4 | space.xxs |
| Sub Menu Item/Icon and Title | itemSpacing | 12 | space.md |
| Sub Menu Item/Icon and Title/Page Title | itemSpacing | 8 | space.sm |
| Sub Menu Item/Icon and Title/Page Title/Title | fill[0] | #0c0d0e | foreground.primary |
| Sub Menu Item/Icon and Title/Page Title/Title | fontSize | 14 | label.medium.font size |
| Sub Menu Item/Icon and Title/Page Title/Title | lineHeight | 20 | label.medium.line height |
| Sub Menu Item/Icon and Title/Page Title/Title | letterSpacing | 0 | label.medium.letter spacing |
| Sub Menu Item/Badge | itemSpacing | 10 | — |
| Sub Menu Item/Badge/Notification Indicator | fill[0] | #d70015 | interactive.destructive.background.default |
| Sub Menu Item/Badge/Notification Indicator | stroke[0] | #ffffff | border.inverse |
| Sub Menu Item/Badge/Notification Indicator | cornerRadius | 9999 | radius.pill |
| Sub Menu Item/Badge/Notification Indicator | strokeWeight | 1 | stroke.thin |
| Sub Menu Item/Trailing Slot | itemSpacing | 10 | — |
| Sub Menu Item/Trailing Slot/Caret Indicator | itemSpacing | 10 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | selected | Sub Menu Item | fill[0] | interactive.ghost.background.selected |
| State | selected | Sub Menu Item/Icon and Title/Page Title/Title | fill[0] | interactive.ghost.foreground.default |
| State | default | Sub Menu Item | fill[0] | — |
| State | active | Sub Menu Item | fill[0] | interactive.ghost.background.pressed |
| State | active | Sub Menu Item/Icon and Title/Page Title/Title | fill[0] | interactive.neutral.foreground.default |
| Nested | true | Sub Menu Item | padding.left | space.xl |
| Nested | true | Sub Menu Item/Icon and Title/Page Title/Title | fill[0] | foreground.secondary |
| Nested | true | Sub Menu Item/Icon and Title/Page Title/Title | fontSize | indicator.medium.font size |
| Nested | true | Sub Menu Item/Icon and Title/Page Title/Title | lineHeight | indicator.medium.line height |
| Nested | true | Sub Menu Item/Icon and Title/Page Title/Title | letterSpacing | indicator.medium.letter spacing |

## Navigation Header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3453-54312&m=dev

### Layer structure

- Navigation Header (COMPONENT)
  - Navigation Header/Avatar with Title (FRAME)
    - Navigation Header/Avatar with Title/Avatar (INSTANCE)
    - Navigation Header/Avatar with Title/Page Title (FRAME)
      - Navigation Header/Avatar with Title/Page Title/Title (TEXT)
  - Navigation Header/Icon Button (INSTANCE)
  - Navigation Header/Avatar (FRAME)
    - Navigation Header/Avatar/Avatar (INSTANCE)
    - Navigation Header/Avatar/Icon (INSTANCE)
  - Navigation Header/Logo with Title (FRAME)
    - Navigation Header/Logo with Title/Icon (INSTANCE)
    - Navigation Header/Logo with Title/Page Title (FRAME)
      - Navigation Header/Logo with Title/Page Title/Title (TEXT)

### Resolved tokens (default variant: Type=avatar, Expanded=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Navigation Header | itemSpacing | 10 | — |
| Navigation Header/Avatar with Title | itemSpacing | 8 | space.sm |
| Navigation Header/Avatar with Title | padding.left | 4 | space.xxs |
| Navigation Header/Avatar with Title | padding.right | 4 | space.xxs |
| Navigation Header/Avatar with Title/Page Title | itemSpacing | 8 | space.sm |
| Navigation Header/Avatar with Title/Page Title/Title | fill[0] | #0c0d0e | foreground.primary |
| Navigation Header/Avatar with Title/Page Title/Title | fontSize | 14 | label.medium.font size |
| Navigation Header/Avatar with Title/Page Title/Title | lineHeight | 20 | label.medium.line height |
| Navigation Header/Avatar with Title/Page Title/Title | letterSpacing | 0 | label.medium.letter spacing |
| Navigation Header/Icon Button | width | 36 | control.sm |
| Navigation Header/Icon Button | height | 36 | control.sm |
| Navigation Header/Icon Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Navigation Header/Icon Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| Navigation Header/Icon Button | cornerRadius | 0 | radius.none |
| Navigation Header/Icon Button | strokeWeight | 0 | stroke.base |
| Navigation Header/Icon Button | padding.left | 4 | space.xxs |
| Navigation Header/Icon Button | padding.right | 4 | space.xxs |
| Navigation Header/Icon Button | padding.top | 4 | space.xxs |
| Navigation Header/Icon Button | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | logo | Navigation Header/Avatar with Title | itemSpacing | — |
| Type | logo | Navigation Header/Avatar with Title | padding.left | — |
| Type | logo | Navigation Header/Avatar with Title | padding.right | — |
| Type | logo | Navigation Header/Avatar with Title/Page Title | itemSpacing | — |
| Type | logo | Navigation Header/Avatar with Title/Page Title/Title | fill[0] | — |
| Type | logo | Navigation Header/Avatar with Title/Page Title/Title | fontSize | — |
| Type | logo | Navigation Header/Avatar with Title/Page Title/Title | lineHeight | — |
| Type | logo | Navigation Header/Avatar with Title/Page Title/Title | letterSpacing | — |
| Type | logo | Navigation Header/Logo with Title | itemSpacing | space.sm |
| Type | logo | Navigation Header/Logo with Title | padding.left | space.xxs |
| Type | logo | Navigation Header/Logo with Title | padding.right | space.xxs |
| Type | logo | Navigation Header/Logo with Title/Icon | height | control.target-min |
| Type | logo | Navigation Header/Logo with Title/Page Title | itemSpacing | space.sm |
| Type | logo | Navigation Header/Logo with Title/Page Title/Title | fill[0] | foreground.primary |
| Type | logo | Navigation Header/Logo with Title/Page Title/Title | fontSize | label.medium.font size |
| Type | logo | Navigation Header/Logo with Title/Page Title/Title | lineHeight | label.medium.line height |
| Type | logo | Navigation Header/Logo with Title/Page Title/Title | letterSpacing | label.medium.letter spacing |
| Expanded | false | Navigation Header/Avatar with Title | itemSpacing | — |
| Expanded | false | Navigation Header/Avatar with Title | padding.left | — |
| Expanded | false | Navigation Header/Avatar with Title | padding.right | — |
| Expanded | false | Navigation Header/Avatar with Title/Page Title | itemSpacing | — |
| Expanded | false | Navigation Header/Avatar with Title/Page Title/Title | fill[0] | — |
| Expanded | false | Navigation Header/Avatar with Title/Page Title/Title | fontSize | — |
| Expanded | false | Navigation Header/Avatar with Title/Page Title/Title | lineHeight | — |
| Expanded | false | Navigation Header/Avatar with Title/Page Title/Title | letterSpacing | — |
| Expanded | false | Navigation Header/Icon Button | width | — |
| Expanded | false | Navigation Header/Icon Button | height | — |
| Expanded | false | Navigation Header/Icon Button | fill[0] | — |
| Expanded | false | Navigation Header/Icon Button | stroke[0] | — |
| Expanded | false | Navigation Header/Icon Button | cornerRadius | — |
| Expanded | false | Navigation Header/Icon Button | strokeWeight | — |
| Expanded | false | Navigation Header/Icon Button | padding.left | — |
| Expanded | false | Navigation Header/Icon Button | padding.right | — |
| Expanded | false | Navigation Header/Icon Button | padding.top | — |
| Expanded | false | Navigation Header/Icon Button | padding.bottom | — |
| Expanded | false | Navigation Header/Avatar | itemSpacing | space.xl |
| Expanded | false | Navigation Header/Avatar | padding.left | space.xxs |
| Expanded | false | Navigation Header/Avatar | padding.right | space.xxs |

## Sub Menu Header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3453-54332&m=dev

### Layer structure

- Sub Menu Header (COMPONENT)
  - Sub Menu Header/Icon and Title (FRAME)
    - Sub Menu Header/Icon and Title/Icon (INSTANCE, icon: verified)
    - Sub Menu Header/Icon and Title/Page Title (FRAME)
      - Sub Menu Header/Icon and Title/Page Title/Title (TEXT)
    - Sub Menu Header/Icon and Title/Icon Button (INSTANCE)
  - Sub Menu Header/Trailing Actions Slot (SLOT)

### Resolved tokens (default variant: Type=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Sub Menu Header | stroke[0] | #ced2db | border.default |
| Sub Menu Header | strokeWeight | 1 | — |
| Sub Menu Header | itemSpacing | 10 | — |
| Sub Menu Header | padding.left | 16 | space.lg |
| Sub Menu Header | padding.right | 16 | space.lg |
| Sub Menu Header/Icon and Title | itemSpacing | 12 | space.md |
| Sub Menu Header/Icon and Title/Page Title | itemSpacing | 8 | space.sm |
| Sub Menu Header/Icon and Title/Page Title/Title | fill[0] | #0c0d0e | foreground.primary |
| Sub Menu Header/Icon and Title/Page Title/Title | fontSize | 14 | label.medium.font size |
| Sub Menu Header/Icon and Title/Page Title/Title | lineHeight | 20 | label.medium.line height |
| Sub Menu Header/Icon and Title/Page Title/Title | letterSpacing | 0 | label.medium.letter spacing |
| Sub Menu Header/Trailing Actions Slot | itemSpacing | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | sub page | Sub Menu Header/Icon and Title | itemSpacing | space.sm |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | width | control.sm |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | height | control.sm |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | fill[0] | interactive.ghost.background.default |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | stroke[0] | interactive.neutral.border.default |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | cornerRadius | radius.none |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | strokeWeight | stroke.base |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | padding.left | space.xxs |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | padding.right | space.xxs |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | padding.top | space.xxs |
| Type | sub page | Sub Menu Header/Icon and Title/Icon Button | padding.bottom | space.xxs |

## Caret Indicator

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3453-54347&m=dev

### Layer structure

- Caret Indicator (COMPONENT)
  - Caret Indicator/Icon (INSTANCE, icon: expand_more)

### Resolved tokens (default variant: Open=false, Direction=vertical, Size=small)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Caret Indicator | itemSpacing | 10 | — |

## Collapsible Menu Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3453-54352&m=dev

### Layer structure

- Collapsible Menu Item (COMPONENT)
  - Collapsible Menu Item/Sub Menu Item (INSTANCE)
  - Collapsible Menu Item/Sub Menu Slot (SLOT)

### Resolved tokens (default variant: Open=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Collapsible Menu Item/Sub Menu Item | cornerRadius | 4 | radius.sm |
| Collapsible Menu Item/Sub Menu Item | itemSpacing | 8 | space.sm |
| Collapsible Menu Item/Sub Menu Item | padding.left | 12 | space.md |
| Collapsible Menu Item/Sub Menu Item | padding.right | 12 | space.md |
| Collapsible Menu Item/Sub Menu Item | padding.top | 4 | space.xxs |
| Collapsible Menu Item/Sub Menu Item | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Open | true | Collapsible Menu Item | cornerRadius | radius.sm |
| Open | true | Collapsible Menu Item/Sub Menu Item | fill[0] | interactive.ghost.background.pressed |
| Open | true | Collapsible Menu Item/Sub Menu Slot | fill[0] | surface.menu |
| Open | true | Collapsible Menu Item/Sub Menu Slot | itemSpacing | space.xxs |
| Open | true | Collapsible Menu Item/Sub Menu Slot | padding.left | space.sm |
| Open | true | Collapsible Menu Item/Sub Menu Slot | padding.right | space.sm |
| Open | true | Collapsible Menu Item/Sub Menu Slot | padding.top | space.sm |
| Open | true | Collapsible Menu Item/Sub Menu Slot | padding.bottom | space.sm |
