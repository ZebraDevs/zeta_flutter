# Segmented Control

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5723-658&m=dev

## Segmented Control

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5757-774&m=dev

### Overview

A row of mutually exclusive options sharing one track, where exactly one is active at a time. It ships with three segments, two placed directly and a third in a slot, so changing the count means working inside the instance. Use Tab Bar when the choice moves between views rather than switching a mode within one.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Rounded | true | true | Match the contour of the surface the control sits on. It reaches the track and every segment placed inside it, so the whole control stays consistent without touching the items. |
| Rounded | false | - | The square-cornered pairing, for surfaces built from sharp controls. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The core declares no state axis of its own. Which segment looks chosen is set on the nested items. |
| Selection | State set to active on one segment | — | That segment gains a fill and its label moves to the primary foreground. Nothing in the core enforces that only one carries it. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | The active background moves in 0.15s ease-in transition between item in the control. (Active background is not tied to the segmented item but bound to the control, so it moves easily across items) |
| Selection | The set ships with Item 1 active, there most always be an active segment on. |
| Adding segments | The count is structural rather than a property. Two segments sit directly in each variant and a third in the slot, so a fourth means duplicating inside the instance. (Figma only implementation) |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| More items Slot | slot, one segment as shipped | Holds segments beyond the first two. It hugs its content, so whatever is placed there sets how far the track extends. (Implementation makes use of the segment options) |
| Fixed segments | two placed instances, outside the slot | Item 1 and Item 2 are placed directly in each variant rather than in the slot. Removing one means detaching, and Item 1 is the one shipped active. (Figma only) |
| Segment properties | not exposed | The core surfaces none of the segment's properties. Every label, state and flavour is set by selecting into the nested instance. See the _Segmented item frame for what each one offers. (Important! In production, the core can set base properties across elements) |

### Anatomy

1. **Track** — The outer frame. A horizontal auto-layout hugging its segments, carrying the background and the corner radius.
2. **Fixed segments** — The first two segments, placed directly in the variant rather than in the slot.
3. **More items Slot** — The trailing region holding any further segments. It sits last in the row and hugs its content.

### How to use

**Do:**
- Keep the options short and parallel. The row is read in one glance, so uneven label lengths make the track look broken.
- Set exactly one segment to active. The component will not do it, and will happily show two.

**Don't:**
- Don't use it to move between screens. It switches a mode within one view, which is what separates it from Tab Bar.
- Don't grow it past a handful of segments. Each one hugs its own label, so a long list pushes the track wider than whatever contains it.

### Accessibility & Content Guidelines

- The control is one choice among several. It needs a radiogroup or tablist role rather than a row of unrelated buttons.
- No focus state exists on the core or on the segments, so arrow-key movement and a visible focus ring both have to come from code.
- The chosen segment is shown by a fill and a text-colour change. Expose the selected state in the markup rather than leaving it to colour.
- The track uses interactive/neutral/background/pressed and the active segment interactive/neutral/background/focused. Check those two against each other, because the difference between chosen and unchosen is the whole point of the control.
- Nothing prevents two segments reading as active at once. That has to be enforced, or the control contradicts itself.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug both axes | 289 by 44 as shipped with three segments. Width follows the segments, so it grows with their labels. |
| Padding and gap | Fixed | space/xs on all four sides of the track, with a space/xs gap between segments. |
| Radius | Per Rounded | radius/sm when true and radius/none when false, on the track and on every segment it places. |
| Fill | Theming | interactive/neutral/background/pressed on the track. No border and no shadow. |
| Segments | Hug | Each segment hugs its own content, so the track is the sum of the labels rather than an equal-width grid. Segments are not the same width as each other. |
| Slot | Hug | The More items Slot hugs whatever is placed in it and sits last in the row. |

### Layer structure

- Segmented Control (COMPONENT)
  - Segmented Control/_Segmented item[1] (INSTANCE)
  - Segmented Control/_Segmented item[2] (INSTANCE)
  - Segmented Control/More items Slot (SLOT)

### Resolved tokens (default variant: Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Segmented Control | fill[0] | #e0e3e9 | interactive.neutral.background.pressed |
| Segmented Control | cornerRadius | 4 | radius.sm |
| Segmented Control | itemSpacing | 4 | space.xxs |
| Segmented Control | padding.left | 4 | space.xxs |
| Segmented Control | padding.right | 4 | space.xxs |
| Segmented Control | padding.top | 4 | space.xxs |
| Segmented Control | padding.bottom | 4 | space.xxs |
| Segmented Control/_Segmented item[1] | fill[0] | #ffffff | interactive.neutral.background.focused |
| Segmented Control/_Segmented item[1] | cornerRadius | 4 | radius.sm |
| Segmented Control/_Segmented item[1] | itemSpacing | 4 | space.xxs |
| Segmented Control/_Segmented item[1] | padding.left | 12 | space.md |
| Segmented Control/_Segmented item[1] | padding.right | 16 | space.lg |
| Segmented Control/_Segmented item[1] | padding.top | 4 | space.xxs |
| Segmented Control/_Segmented item[1] | padding.bottom | 4 | space.xxs |
| Segmented Control/_Segmented item[2] | cornerRadius | 4 | radius.sm |
| Segmented Control/_Segmented item[2] | itemSpacing | 4 | space.xxs |
| Segmented Control/_Segmented item[2] | padding.left | 12 | space.md |
| Segmented Control/_Segmented item[2] | padding.right | 16 | space.lg |
| Segmented Control/_Segmented item[2] | padding.top | 4 | space.xxs |
| Segmented Control/_Segmented item[2] | padding.bottom | 4 | space.xxs |
| Segmented Control/More items Slot | itemSpacing | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | sharp | Segmented Control | cornerRadius | radius.none |
| Shape | sharp | Segmented Control/_Segmented item[1] | cornerRadius | radius.none |
| Shape | sharp | Segmented Control/_Segmented item[2] | cornerRadius | radius.none |

## _Segmented item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5723-1813&m=dev

### Overview

One option inside a Segmented Control, carrying a label, an icon, or both. It is private to that control, which places two directly and a third in a slot and exposes none of its properties, so every label and state is set by selecting into the nested instance.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Label | text | Item | The option's name. Keep it to one or two words, because segments hug their labels and a single long option makes the whole row uneven. |
| Rounded | true | true | Follow the parent control rather than deciding here. Each Segmented Control variant already sets a matching value on the segments it places. |
| Rounded | false | - | The square-cornered pairing, used where the parent is sharp. |
| State | default | true | An unchosen segment. Its label sits a step quieter than the others, which is what lets the chosen one stand out. |
| State | active | - | The chosen segment. Exactly one in a control should carry it, and nothing in the set enforces that. |
| State | hover | - | Pointer over an unchosen segment. It changes the label colour and adds no background, so the hover feedback is weaker here than on most controls in this system. |
| Flavour | default | true | Icon and label together, despite the name suggesting the plainest case. Use it when the icons add recognition the words alone do not. |
| Flavour | text only | - | Labels alone, and the clearest choice whenever the options are not easily iconified. |
| Flavour | icon only | - | Icons alone, for a control tight on space. Nothing names the options on screen, so the icons have to be unambiguous and the names supplied another way. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | — | — | No fill at all. The label sits at foreground/secondary. |
| hover | Pointer over the segment | — | The label moves to foreground/primary. No background appears, so hover changes one colour and nothing else. |
| active | State set to active | — | A fill of interactive/neutral/background/focused appears and the label moves to foreground/primary. That is the same label colour hover uses, so the fill is the only thing separating the two. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is authored. Becoming the chosen segment is a fill appearing, with no movement behind it. |
| Selection | The segment has no link to its siblings. Which one is active is decided entirely by whoever places them. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | Plain text set per instance, defaulting to Item. The icon only flavour has no text node for it to reach, so the property stays settable and renders nothing. |
| Icon | fixed nested Icon | An Icon at Size=small swapped to Star. None of its properties is exposed, so every segment shows the same glyph unless the instance is detached. |
| Trailing content | not provided | There is no second slot. A segment cannot carry a count or a badge without detaching. |

### Anatomy

1. **Segment** — The component frame. A horizontal auto-layout hugging its content, and the surface that carries the fill on the chosen state.
2. **Icon** — The leading glyph, present on the default and icon only flavours.
3. **Label** — The option's name, present on the default and text only flavours.

### How to use

**Do:**
- Pick one Flavour and hold it across every segment in a control. An icon-only segment dropped into a row of labelled ones breaks the row.
- Let the parent's Rounded decide the contour. Setting it per segment is how a control ends up with mismatched corners.

**Don't:**
- Don't rely on hover to show what is chosen. Hover and active share a label colour, and only the fill tells them apart.
- Don't use icon only without naming the options elsewhere. The glyph is a locked Star in every variant as drawn.

### Accessibility & Content Guidelines

- No focus state exists in any of the eighteen variants, so keyboard focus has to be built entirely in code.
- The chosen state is a fill plus a label-colour change. Both are colour, so the selected state has to be exposed in the markup as well.
- Hover and active share foreground/primary on the label. Anyone who cannot make out the fill cannot tell the two apart.
- The icon only flavour carries no text at all. Those segments need an accessible name from somewhere outside the component.
- The label uses label/medium at 14px over a 20px line, and is the option's only name in two of the three flavours.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug width, fixed height | 36 tall in all eighteen variants. Width follows the content, 80 at the default flavour, 64 at text only and 48 at icon only with the shipped label. |
| Padding | Per Flavour | space/xs top and bottom throughout. Horizontally space/md on the default flavour and space/lg on both text only and icon only, so dropping a part widens the padding rather than narrowing the segment. |
| Gap | Per Flavour | space/xs on the default flavour. Text only and icon only declare space/sm, which separates nothing because each has a single child. |
| Radius | Per Rounded | radius/sm when true and radius/none when false. |
| Fill | Per State | Only active carries one, interactive/neutral/background/focused. default and hover have no fill at all. |
| Label | Theming | label/medium, IBM Plex Sans Medium 14 over a 20px line. foreground/secondary at default, foreground/primary on both hover and active. |
| Icon | Fixed | Icon at Size=small, 16 square, swapped to Star in every variant that shows one. |

### Layer structure

- _Segmented item (COMPONENT)
  - _Segmented item/Icon (INSTANCE, icon: star)
  - _Segmented item/Item (TEXT)

### Resolved tokens (default variant: Rounded=true, State=default, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Segmented item | cornerRadius | 4 | radius.sm |
| _Segmented item | itemSpacing | 4 | space.xxs |
| _Segmented item | padding.left | 12 | space.md |
| _Segmented item | padding.right | 16 | space.lg |
| _Segmented item | padding.top | 4 | space.xxs |
| _Segmented item | padding.bottom | 4 | space.xxs |
| _Segmented item/Item | fill[0] | #545963 | foreground.secondary |
| _Segmented item/Item | fontSize | 14 | label.medium.font size |
| _Segmented item/Item | lineHeight | 20 | label.medium.line height |
| _Segmented item/Item | letterSpacing | 0 | label.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Rounded | false | _Segmented item | cornerRadius | radius.none |
| State | active | _Segmented item | fill[0] | interactive.neutral.background.focused |
| State | active | _Segmented item/Item | fill[0] | foreground.primary |
| State | hover | _Segmented item/Item | fill[0] | foreground.primary |
| Flavour | text only | _Segmented item | itemSpacing | space.sm |
| Flavour | text only | _Segmented item | padding.left | space.lg |
| Flavour | icon only | _Segmented item | itemSpacing | space.sm |
| Flavour | icon only | _Segmented item | padding.left | space.lg |
| Flavour | icon only | _Segmented item/Item | fill[0] | — |
| Flavour | icon only | _Segmented item/Item | fontSize | — |
| Flavour | icon only | _Segmented item/Item | lineHeight | — |
| Flavour | icon only | _Segmented item/Item | letterSpacing | — |
