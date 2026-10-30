# Button Group

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5763-1251&m=dev

## Button Group

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5833-912&m=dev

### Overview

A row of related actions sharing one bordered surface, where each carries equal weight rather than one leading. The group owns the fill, the outline and the rules between items, and the items themselves are Figma-only wrappers around the subtle Button. Use a single Button when one action is clearly the primary one.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Size | medium | true | Match the density of the controls around the group. Size is the group's call and every button inherits it, so it is never set per item. It also decides which of the three slots is live, which is an authoring arrangement rather than part of the component. |
| Size | small | - | For dense toolbars and compact surfaces where the actions are secondary to the content. |
| Size | large | - | For touch targets and action rows that need to be reached without aiming. |
| Shape | sharp | true | Match the contour of the surface the group sits on. It reaches the group's own outline and nothing else. |
| Shape | rounded | - | The rounded pairing. Only the group's outline rounds. The buttons inside keep square corners in every wrapper variant, which never shows because they carry no fill of their own. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The group declares no hover, focus, pressed or disabled axis. Interaction belongs to the nested Button, whose own State is left at default in every wrapper. |
| Size | The Size axis | — | Changes the row height and swaps in a different wrapper and a different slot. Nothing else about the group changes. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is authored. Nothing in the set changes over time. |
| Item count | The count is structural rather than a property. One wrapper sits before the slot and one after, so a group always holds at least two actions and a third means filling the slot. That arrangement is how the group is assembled in Figma, not a limit the component imposes. |
| Dividers | Each wrapper carries a divider at its trailing edge, and the Position=end variant is the one that drops it. Setting the last item to end is a Figma authoring step, because the parent owns the rules between items. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Items Slot | Figma only, one slot per Size | Small, Medium and large each have their own slot so a designer can drop an item in without resetting that button's Size every time. The split exists for authoring and is not a property of the component. Content placed in one slot does not carry across when Size changes, and the large slot is named in lower case where the other two are capitalised. |
| Group buttons | Figma only, fixed wrappers outside the slot | One wrapper before the slot and one after, placed directly in each variant. They hold a Button and its trailing divider for authoring and are not components to use on their own. Only the subtle Button belongs inside, so swapping in another flavour breaks the single surface the group is built on. |
| Button properties | split between the group and the consumer | Size, Shape and Flavour belong to the group and are not set per item, or the row stops reading as one control. The label and the icons are the consumer's. The trailing icon ships as Expand More and the leading as Verified, and either can be swapped where the action calls for something else. |

### Anatomy

1. **Group** — The outer frame. A horizontal auto-layout hugging its items, and the only part carrying the fill and the outline.
2. **Group buttons** — The fixed wrappers at each end, each holding a subtle Button and a trailing divider.
3. **Items Slot** — The middle region for any further actions, matched to the chosen Size.

### How to use

**Do:**
- Use it where several actions are peers. If one is clearly the main action, a single Button says so more plainly.
- Set the last item's Position to end. That is what removes the trailing divider and leaves the group a clean edge.

**Don't:**
- Don't change Size after filling the slot. Each Size has its own slot, so the content does not travel with it.
- Don't expect Shape to round the buttons. It rounds the group's outline only, and every wrapper holds a square button.

### Accessibility & Content Guidelines

- The group is a set of related actions. It needs a group role and a name saying what the actions have in common.
- No focus state exists on the group or on the wrappers, so focus order and a visible focus ring both have to come from code.
- Items are told apart by a 1px divider and nothing else. Where the group's fill is close to the surface behind it, the outline is doing all the work of bounding the group.
- The nested Button ships with a Verified leading icon and an Expand More trailing icon. Icons beside a label need to be decorative or separately named, not read out twice.
- Nothing marks an action as current or chosen. A group that needs that is not modelled here.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug both axes | Height is fixed per Size, 36 at small, 40 at medium and 48 at large. Width hugs the items, running from 435 at small to 555 at large as shipped. |
| Padding and gap | Fixed | Zero padding, with the gap bound to space/none so items butt directly against each other. |
| Radius | Per Shape | radius/sm on all four corners when rounded. When sharp the radius is a literal 0 with no token behind it. |
| Fill | Theming | surface/section on the group. The wrappers carry no fill of their own, so the group's surface shows through every item. |
| Border | Fixed | A 1px stroke bound to border/default on every variant, regardless of Shape. |
| Dividers | Per Position | A 1px vertical Divider sits at the trailing edge of each wrapper. Position=end is the only variant that omits it. |
| Nested button | Fixed | A Button at Flavour=subtle with its Size matched to the group. Its own Shape stays sharp in all five wrapper variants, including the rounded ones. |

### Layer structure

- Button Group (COMPONENT)
  - Button Group/_Group Button Medium[1] (INSTANCE)
  - Button Group/Items Slot Medium (SLOT)
  - Button Group/_Group Button Medium[2] (INSTANCE)
  - Button Group/_Group Button Small[1] (INSTANCE)
  - Button Group/Items Slot Small (SLOT)
  - Button Group/_Group Button Small[2] (INSTANCE)
  - Button Group/_Group Button Large[1] (INSTANCE)
  - Button Group/Items Slot large (SLOT)
  - Button Group/_Group Button Large[2] (INSTANCE)

### Resolved tokens (default variant: Size=medium, Shape=sharp)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Button Group | fill[0] | #ffffff | surface.section |
| Button Group | stroke[0] | #ced2db | border.default |
| Button Group | strokeWeight | 1 | — |
| Button Group/Items Slot Medium | itemSpacing | -1 | space.neg.xs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Button Group/Items Slot Medium | itemSpacing | — |
| Size | small | Button Group/Items Slot Medium | itemSpacing | — |
| Shape | rounded | Button Group | cornerRadius | radius.sm |

## _Group Button Small

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5915-4775&m=dev

### Layer structure

- _Group Button Small (COMPONENT)
  - _Group Button Small/Button (INSTANCE)
  - _Group Button Small/Divider (INSTANCE)

### Resolved tokens (default variant: Position=default, Shape=sharp)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Group Button Small/Button | height | 36 | control.sm |
| _Group Button Small/Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Group Button Small/Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| _Group Button Small/Button | cornerRadius | 0 | radius.none |
| _Group Button Small/Button | strokeWeight | 0 | stroke.base |
| _Group Button Small/Button | padding.left | 12 | space.md |
| _Group Button Small/Button | padding.right | 12 | space.md |
| _Group Button Small/Button | padding.top | 4 | space.xxs |
| _Group Button Small/Button | padding.bottom | 4 | space.xxs |
| _Group Button Small/Divider | width | 1 | stroke.thin |
| _Group Button Small/Divider | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Position | Position5 | _Group Button Small/Divider | width | — |
| Position | Position5 | _Group Button Small/Divider | cornerRadius | — |

## _Group Button Medium

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5915-4823&m=dev

### Layer structure

- _Group Button Medium (COMPONENT)
  - _Group Button Medium/Button (INSTANCE)
  - _Group Button Medium/Divider (INSTANCE)

### Resolved tokens (default variant: Position=default, Shape=sharp)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Group Button Medium/Button | height | 40 | control.md |
| _Group Button Medium/Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Group Button Medium/Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| _Group Button Medium/Button | cornerRadius | 0 | radius.none |
| _Group Button Medium/Button | strokeWeight | 0 | stroke.base |
| _Group Button Medium/Button | padding.left | 12 | space.md |
| _Group Button Medium/Button | padding.right | 12 | space.md |
| _Group Button Medium/Button | padding.top | 4 | space.xxs |
| _Group Button Medium/Button | padding.bottom | 4 | space.xxs |
| _Group Button Medium/Divider | width | 1 | stroke.thin |
| _Group Button Medium/Divider | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Position | end | _Group Button Medium/Divider | width | — |
| Position | end | _Group Button Medium/Divider | cornerRadius | — |

## _Group Button Large

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5915-4861&m=dev

### Layer structure

- _Group Button Large (COMPONENT)
  - _Group Button Large/Button (INSTANCE)
  - _Group Button Large/Divider (INSTANCE)

### Resolved tokens (default variant: Position=default, Shape=sharp)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Group Button Large/Button | height | 48 | control.lg |
| _Group Button Large/Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| _Group Button Large/Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| _Group Button Large/Button | cornerRadius | 0 | radius.none |
| _Group Button Large/Button | strokeWeight | 0 | stroke.base |
| _Group Button Large/Button | padding.left | 16 | space.lg |
| _Group Button Large/Button | padding.right | 16 | space.lg |
| _Group Button Large/Button | padding.top | 4 | space.xxs |
| _Group Button Large/Button | padding.bottom | 4 | space.xxs |
| _Group Button Large/Divider | width | 1 | stroke.thin |
| _Group Button Large/Divider | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Position | end | _Group Button Large/Divider | width | — |
| Position | end | _Group Button Large/Divider | cornerRadius | — |
