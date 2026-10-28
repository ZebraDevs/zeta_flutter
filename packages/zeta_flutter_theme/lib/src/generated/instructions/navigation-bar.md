# Navigation Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2835-796&m=dev

## Spacer

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2920-5097&m=dev

### Layer structure

- Spacer (COMPONENT)
  - Spacer/Divider (INSTANCE)

### Resolved tokens (default variant: Spacer)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Spacer | itemSpacing | 10 | — |
| Spacer/Divider | width | 1 | stroke.thin |
| Spacer/Divider | cornerRadius | 0 | radius.none |

## Navigation Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3077-8391&m=dev

### Overview

A horizontal bar of top-level destinations, pinned to one edge of a view. It is a container rather than a fixed design, three slots hold the content and the variant axes decide only how that content is arranged across the width. Fill the slots with Navigation Item instances, and turn on the Action Slot when the bar also needs a call to action. It draws no background of its own, so it takes the colour of whatever sits behind it.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Shrink Items | true | true | Items keep their natural width and the groups sit against the ends of the bar. The right choice when the number of destinations can change, because adding one does not re-space the others. |
| Shrink Items | false | - | The item row stretches to the full width and spreads the items evenly across it. Suits a fixed set of destinations, and looks unbalanced the moment the count changes. |
| Spacer | false | true | One group of items flowing from the start of the bar. Use when every destination has equal standing. |
| Spacer | true | - | Splits the items into two groups pushed to opposite ends and adds a second slot on the right. Use it to separate primary destinations from account or utility entries. Available only while Shrink Items is true. |
| Show Divider | false | true | No rule between the two groups. The gap alone carries the separation, which is enough on a plain surface. |
| Show Divider | true | - | Draws a vertical rule between the two groups. Available only when Spacer is true, because without a split there is nothing to divide. |
| Show Action Slot | false | true | No action alongside the destinations. |
| Show Action Slot | true | - | Reveals a slot at the end of the bar for a call to action that is not a destination. Placing an action among the items instead makes it read as another place to go. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The bar itself has no interaction states. Selection, hover and disabled all live on the Navigation Item instances inside the slots, so the bar never changes appearance on its own. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing, and the bar models no transition. Arrangement changes come from switching a variant, which is an authoring choice rather than something that animates at runtime. |
| Reflow | Width fills the parent and height is driven by the slot content, so taller items make a taller bar. Under Shrink Items=false, adding or removing an item re-spaces every remaining item immediately. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Slot | slot, prefers Navigation Item | The main group of destinations. It will accept other content, but Navigation Item is what the bar is built around and what sets its height. See the Navigation Item Metadata frame for what each item offers. |
| Right Slot | slot, prefers Navigation Item | The second group, present only while Spacer is true. Same content rules as Slot. Switching to a variant without Spacer removes the slot along with anything placed in it. |
| Action Slot | slot, prefers Button | A single action rather than a destination, hidden until Show Action Slot is turned on. See the Button Metadata frame. The bar does not constrain which flavour or size goes in, so match it to the surface. |
| Item count | not constrained | No slot caps how many items it holds. The bar keeps adding them well past the point where labels stay readable, so that limit is a design decision rather than one the component enforces. |

### Anatomy

1. **Bar** — The outer horizontal frame. Fills its parent's width, hugs its content vertically, and carries a top border and nothing else.
2. **Slot and Right Slot** — The groups of destinations, holding Navigation Item instances. The right group exists only while Spacer is true.
3. **Divider Section** — A vertical rule between the two groups, inset from the top and bottom edges. Present only while Show Divider is true.
4. **Action Slot** — An end-aligned slot holding a single Button, hidden until Show Action Slot is turned on.

### How to use

**Do:**
- Fill the slots with Navigation Item instances and let the bar handle the arrangement. The variant axes exist so items never have to be positioned by hand.
- Turn on Show Action Slot when the bar needs a call to action, rather than dropping a Button in among the destinations.

**Don't:**
- Don't use Shrink Items=false when the number of destinations can change. Evenly spread items re-space every time one is added or removed.
- Don't rely on the bar for a background. It has no fill of its own, so it shows whatever surface sits behind it.

### Accessibility & Content Guidelines

- The bar is a container and announces nothing itself. The destinations inside carry the meaning, so every Navigation Item needs a clear label.
- Only the top edge is drawn. On a surface close to border/default the bar's boundary disappears, so check that contrast rather than assuming the edge reads.
- Selection lives on the item, not the bar. Exactly one Navigation Item should be Active at a time, and nothing in the component enforces it.
- The Action Slot holds an action rather than a destination. Keeping it visually distinct matters more here than elsewhere, because everything else in the bar navigates.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fill | Fills its parent's width at every variant. It is not built to be given a fixed width. |
| Height | Hug | 72px, driven entirely by the items inside. Nothing sets a height on the bar, so taller slot content makes a taller bar. |
| Padding | None | Zero on all four sides. Every inset comes from the items themselves. |
| Gap | None | Item spacing is zero. Separation comes from each item's own padding and from the alignment mode, never from a gap on the bar. |
| Arrangement | Fixed per variant | Shrink Items=true lets each slot hug its content and spaces the groups apart. Shrink Items=false makes the slot fill the width and distribute its items evenly inside it. |
| Divider | Fixed | A vertical Divider inside a Divider Section, inset 8px (space/sm) top and bottom, 1px wide on stroke/thin. Present only while Show Divider is true. |
| Action Slot inset | Fixed | 16px (space/lg) of padding on its leading edge and an 8px gap, so the action separates from the last destination. |
| Border | Fixed | A 1px top border on border/default, drawn outside the bounds. No other edge is drawn, and there is no fill and no shadow. |
| Colour | Theming | The bar binds only its border, to border/default. Everything else visible in it is coloured by the items, or by the surface showing through. |

### Layer structure

- Navigation Bar (COMPONENT)
  - Navigation Bar/Slot (SLOT)
  - Navigation Bar/Action Slot (SLOT)
  - Navigation Bar/Right Slot (SLOT)
  - Navigation Bar/Divider Section[1] (FRAME)
    - Navigation Bar/Divider Section[1]/Divider (INSTANCE)
  - Navigation Bar/Divider Section[2] (FRAME)
    - Navigation Bar/Divider Section[2]/Divider (INSTANCE)

### Resolved tokens (default variant: Shrink Items=true, Spacer=false, Show Divider=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Navigation Bar | stroke[0] | #ced2db | border.default |
| Navigation Bar | strokeWeight | 1 | — |
| Navigation Bar/Action Slot | itemSpacing | 8 | — |
| Navigation Bar/Action Slot | padding.left | 16 | space.lg |

## Navigation Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2841-3535&m=dev

### Overview

A single destination inside a Navigation Bar, shown as an icon above a label with an optional badge. It is the content the bar's slots are built around, and the bar sets nothing on it, so every property here is yours to set per instance. Selection is expressed with Active, and exactly one item in a bar should carry it.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Active | false | true | The resting destination, reading as available rather than chosen. |
| Active | true | - | Marks the destination the user is currently on. Exactly one item in a bar should carry it, and nothing in the component enforces that, so a bar with two active items or none is easy to ship. |
| Disabled | false | true | The destination can be selected. |
| Disabled | true | - | The destination is unavailable. Nothing on the item explains why, so if the reason matters it has to come from the surrounding context. Offered on inactive items. |
| Label | text | Label | The destination's name, and the only text on the item. One or two words, because the item hugs its label and a long one makes that destination wider than the rest of the row. |
| Show Badge | false | true | No badge on the icon. |
| Show Badge | true | - | Reveals a Notification Indicator over the icon's top-right corner, signalling that something is waiting. It sits outside the layout, so turning it on never changes the item's size or shifts its neighbours. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Resting | — | Icon and label both sit on foreground/primary. |
| active | Active set to true | — | Icon and label both move to interactive/subtle/foreground/default. Nothing else changes, there is no background, underline or indicator bar, so colour alone carries selection. |
| disabled | Disabled set to true | — | Icon and label both move to interactive/subtle/foreground/disabled. Offered on inactive items. |
| badge shown | Show Badge set to true | — | A Notification Indicator appears over the icon's top-right corner. It is absolutely positioned, so the item's footprint does not change. |
| hover and pressed | Not modelled | — | The component has no hover or pressed variants. Any pointer feedback comes from the implementation rather than from here. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is modelled. Moving between states is a colour change only, with no movement, scale or elevation. |
| Badge | The badge sits outside the layout flow, so showing or hiding it never reflows the item or the bar around it. |
| Reflow | The item re-hugs its label whenever the text changes, which shifts every item beside it in the bar. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | The destination's name. There is no truncation and no wrapping, the item simply grows. |
| Icon | exposed nested Icon instance | Navigation Item pins Icon to Size=medium with Framed off and leaves the instance exposed, so the glyph can be swapped per instance while the sizing stays consistent. See the Icon Metadata frame. It arrives holding Star, a placeholder rather than a real destination glyph. |
| Badge | exposed nested Notification Indicator, toggled by Show Badge | Navigation Item exposes only its visibility and pins it to Size=small, the dot with no number, where the Notification Indicator's own default is large. The instance stays exposed, so its Value and Size remain reachable. At this size the dot signals that something is there, not how much. |

### Anatomy

1. **Item** — The outer vertical frame. Hugs its label horizontally and holds a fixed height, so every item in a bar lines up regardless of label length.
2. **Icon box** — The 20px box holding the icon, and the anchor the badge is positioned against. It does not clip, which is what lets the badge overhang its corner.
3. **Label** — The destination's name, sitting under the icon and taking the same colour as it in every state.

### How to use

**Do:**
- Set exactly one item in a bar to Active. Selection is the item's job, and the bar does nothing to manage it.
- Swap the icon on every item. It ships holding a Star placeholder, which says nothing about where the destination goes.

**Don't:**
- Don't use Show Badge to show a count. It is pinned to the small size, which is a dot with no readable number in it.
- Don't give items long labels. Each one hugs its own text, so a single long name makes that destination wider than everything beside it.

### Accessibility & Content Guidelines

- Selection is carried by colour alone. There is no underline, background or indicator bar, so the active destination has to be conveyed in code as well.
- The icon repeats the label rather than adding to it, so the label has to stand on its own.
- Disabled is visual only, and nothing on the item explains why a destination is unavailable.
- The badge is a dot with no number at the size this component pins, so whatever it signals needs a text equivalent.
- Icon and label move together between states, so they stay consistent with each other. Check interactive/subtle/foreground/disabled against the surface the bar sits on.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Hug | Hugs the label, so an item is as wide as its text plus 16px (space/lg) of padding each side. Items in a row are not equal width unless their labels are. |
| Height | Fixed | 72px at every variant. This is what sets the Navigation Bar's height, because the bar hugs its content. |
| Padding | Fixed | 8px (space/sm) top and bottom, 16px (space/lg) left and right. |
| Gap | Fixed | 8px (space/sm) between the icon box and the label. |
| Icon | Fixed | A 20px Icon at Size=medium with Framed off, sitting in a 20px box that does not clip its content. |
| Badge | Absolute | An 8px Notification Indicator at Size=small, placed at 16,-4 against the 20px icon box so it overhangs the top-right corner. It is outside the layout flow. |
| Label type | Fixed | Body/body small (14/20), IBM Plex Sans Regular. |
| Colour | Theming | foreground/primary at rest, interactive/subtle/foreground/default when Active, interactive/subtle/foreground/disabled when Disabled. Icon and label take the same token in every state, and the item has no fill of its own. |

### Layer structure

- Navigation Item (COMPONENT)
  - Navigation Item/Indicator (FRAME)
    - Navigation Item/Indicator/Icon (INSTANCE, icon: star)
    - Navigation Item/Indicator/Notification Indicator (INSTANCE)
  - Navigation Item/Label (TEXT)

### Resolved tokens (default variant: Active=false, Disabled=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Navigation Item | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Navigation Item | itemSpacing | 8 | space.sm |
| Navigation Item | padding.left | 16 | space.lg |
| Navigation Item | padding.right | 16 | space.lg |
| Navigation Item | padding.top | 8 | space.sm |
| Navigation Item | padding.bottom | 8 | space.sm |
| Navigation Item/Indicator | itemSpacing | 10 | — |
| Navigation Item/Indicator/Notification Indicator | fill[0] | #d70015 | interactive.destructive.background.default |
| Navigation Item/Indicator/Notification Indicator | stroke[0] | #ffffff | border.inverse |
| Navigation Item/Indicator/Notification Indicator | cornerRadius | 9999 | radius.pill |
| Navigation Item/Indicator/Notification Indicator | strokeWeight | 0 | stroke.base |
| Navigation Item/Label | fill[0] | #0c0d0e | foreground.primary |
| Navigation Item/Label | fontSize | 14 | — |
| Navigation Item/Label | lineHeight | 20 | — |
| Navigation Item/Label | letterSpacing | 0 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Active | true | Navigation Item/Label | fill[0] | interactive.subtle.foreground.default |
| Disabled | true | Navigation Item/Label | fill[0] | interactive.subtle.foreground.disabled |

## Notification Indicator

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2837-1489&m=dev

### Layer structure

- Notification Indicator (COMPONENT)
  - Notification Indicator/2 (TEXT)

### Resolved tokens (default variant: Size=medium)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Notification Indicator | fill[0] | #d70015 | interactive.destructive.background.default |
| Notification Indicator | stroke[0] | #ffffff | border.inverse |
| Notification Indicator | cornerRadius | 9999 | radius.pill |
| Notification Indicator | strokeWeight | 1 | stroke.thin |
| Notification Indicator/2 | fill[0] | #ffffff | foreground.inverse |
| Notification Indicator/2 | fontSize | 12 | indicator.medium.font size |
| Notification Indicator/2 | lineHeight | 14 | indicator.medium.line height |
| Notification Indicator/2 | letterSpacing | 0 | indicator.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | small | Notification Indicator | padding.left | space.xxs |
| Size | small | Notification Indicator | padding.right | space.xxs |
| Size | small | Notification Indicator | padding.top | space.xxs |
| Size | small | Notification Indicator | padding.bottom | space.xxs |
| Size | small | Notification Indicator/2 | fill[0] | — |
| Size | small | Notification Indicator/2 | fontSize | — |
| Size | small | Notification Indicator/2 | lineHeight | — |
| Size | small | Notification Indicator/2 | letterSpacing | — |
| Size | large | Notification Indicator | cornerRadius | radius.element-sm |
| Size | large | Notification Indicator | padding.left | space.xxs |
| Size | large | Notification Indicator | padding.right | space.xxs |
| Size | large | Notification Indicator | padding.top | space.xxs |
| Size | large | Notification Indicator | padding.bottom | space.xxs |
