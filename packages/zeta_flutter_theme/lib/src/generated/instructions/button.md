# Button

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2024-6729&m=dev

## Button

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2060-15072&m=dev

### Overview

Triggers an action from a text label, with optional icons on either side. Eleven flavours set how much weight the action carries (contrast and outline-contrast are experimental), three sizes and three shapes fit it to the surface it sits on. The label is the only content a consumer writes, everything else is a variant choice. When an action has no text label, use Icon Button rather than hiding this one's label.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Flavour | primary | true | The single most important action in a view, one per group. If two buttons both read as primary, the view has two competing goals and that is a layout problem rather than a property one. |
| Flavour | positive | - | Confirms a constructive outcome such as approving or publishing. Reserve it for the confirmation itself, not for every agreeable action, or it stops signalling anything. |
| Flavour | negative | - | Destructive actions the user cannot undo, such as delete or revoke. If the cancel beside it is styled any stronger than subtle, the safe choice becomes the harder one to find. |
| Flavour | subtle | - | A neutral action meant to sit quietly beside a stronger one, typically the cancel next to a primary. It leans on that neighbour for contrast, so on its own it may not read as interactive. |
| Flavour | text | - | A tertiary action inside dense content. It has nothing behind it at rest, so on a coloured or busy surface it stops looking like a control. |
| Flavour | outline-subtle | - | A secondary action on a busy surface where an accent border would compete. It reads as neutral, so it is the wrong choice for the main action on that surface. |
| Flavour | outline | - | A secondary action that still needs to look clickable on its own. Two of them side by side read as equal weight, which is rarely what was intended. |
| Flavour | gradient | - | One promotional or high-emphasis moment, such as an upgrade prompt. It outranks primary, so a screen carrying two of them has no hierarchy left. |
| Flavour | text-gradient | - | The promotional treatment without the filled weight, for a high-emphasis action inside content. The gradient runs across the label itself, so a very short label barely shows it. |
| Flavour | contrast | - | The strongest neutral against the page, near-black in light mode and near-white in dark. Beside a primary it competes for weight, so pair it with outline or text instead. |
| Flavour | outline-contrast | - | A secondary action that pairs with contrast. Its border and label follow the page, near-black in light mode and near-white in dark. |
| Size | medium | true | The default, for standard forms, dialogs and general-purpose actions. |
| Size | large | - | For a prominent call to action or a roomier target on a touch surface. |
| Size | small | - | For compact toolbars, table rows and dense forms where controls sit close together. |
| Shape | rounded | true | The default shape, matching the system's other rounded controls. |
| Shape | sharp | - | Square corners, for surfaces and controls with sharp edges. |
| Shape | full | - | A deliberately soft treatment for standalone or promotional actions. Beside rounded controls in the same group it looks unintentional. |
| State | default | true | The resting state, and the only one to use when laying out a static screen. |
| State | hover | - | Documents the pointer-over treatment. The implementation drives this, so choosing it in a layout freezes the button in a state it should not be in. |
| State | pressed | - | Documents the pointer-down treatment, with the same caveat as hover. |
| State | focus | - | Documents the keyboard focus treatment. The one state whose treatment is identical on every flavour. |
| Disabled | false | true | The control accepts input. |
| Disabled | true | - | The action is unavailable. Say why somewhere nearby, because a disabled control with no explanation is indistinguishable from a broken one. |
| Label | text | Button | The action the user is about to perform, written as a verb. The button hugs whatever it is given, so a long label widens the control and can break a toolbar row. |
| Leading Icon | false | true | No icon before the label. |
| Leading Icon | true | - | Adds an icon before the label to reinforce the action at a glance. Choose the glyph deliberately, the slot arrives holding a default that suits almost nothing. |
| Trailing Icon | false | true | No icon after the label. |
| Trailing Icon | true | - | Turning both icons on at small leaves very little room for the label itself. Use a trailing icon for directional or disclosure actions. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Resting | — | Background, border and label sit on the default tokens of the chosen flavour. |
| hover | Pointer over the control | — | Filled flavours move their own background token one step. Outline flavours hold their border and shift a neutral background underneath instead. Text flavours raise a ghost scrim from fully transparent. The gradient flavours keep their gradient and slide it toward the end colour rather than swapping it (see Gradient transition). outline-contrast steps its border and raises the ghost scrim. Apart from text-gradient, the label colour does not change on any flavour. |
| pressed | Pointer held down | — | The same mechanism as hover carried one step further. The gradient flavours slide the other way, toward the start colour, rather than collapsing to a flat token (see Gradient transition). |
| focus | Keyboard focus | — | A focus ring is drawn outside the bounds, replacing the resting border rather than adding to it. Identical on all eleven flavours, and the only state that changes the control's outer footprint. |
| disabled | Disabled set to true | — | Background and label swap to the disabled tokens of their family, and the icon follows the label. No flavour keeps its accent colour, so disabled buttons of different flavours look alike. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing. Every state change is colour-only, with no scale, shadow or elevation shift on any flavour, so a transition should read as a tint change rather than movement. The gradient flavours are the one exception to a plain tint: their gradient moves (see Gradient transition). |
| Gradient transition | gradient and text-gradient keep their gradient through every state and move it rather than replace it. On hover the gradient slides until its end colour covers 100% of the fill (the label's own text on text-gradient); on press it slides the other way until its start colour covers 100%. Leaving or releasing slides it back to the resting two-stop gradient. It must never jump from the gradient to a flat colour: a browser cannot interpolate between a gradient and a solid fill, so that swap shows as a flicker. The hover and pressed variants show where each slide ends, not a separate flat fill. |
| Focus ring | The only change that alters the control's outer footprint, because the ring is drawn outside the bounds. Leave room around a button in a tight row so the ring is not clipped. |
| Resize | The control re-hugs its label whenever the text changes, so a label swapped at runtime shifts the position of everything beside it in a row. |
| Outline contrast | Experimental. outline-contrast takes its border from interactive/inverse/border/* and its label from foreground/primary, so it follows the mode. Its states sit on interactive/ghost/background/*. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | text property | A verb phrase naming the action. The button hugs whatever length it is given, there is no truncation and no wrapping. |
| Leading Icon | boolean, toggles a nested Icon | Toggles visibility only. Button does not re-declare Icon's other properties, but the instance stays exposed, so Icon's glyph, Size and Framed are still reachable in the properties panel. See the Icon Metadata frame for what Icon itself offers, and leave its Size alone, Button pairs it to the label. |
| Trailing Icon | boolean, toggles a nested Icon | The same slot mechanics as Leading Icon, placed after the label instead. |
| Icon glyph | instance swap on the nested Icon | Any glyph from the icon library. Both slots arrive holding Verified, which suits almost no real action, so set it deliberately whenever a slot is turned on. |

### Anatomy

1. **Container** — The button's own horizontal auto-layout frame. Carries the background, the border and the radius, and holds the height fixed for the chosen Size.
2. **Leading Icon** — An Icon instance before the label, hidden until Leading Icon is turned on. Button sets its size and leaves the instance exposed.
3. **Label** — A wrapper frame around the text. Its own horizontal padding is what separates the text from the icons, the row itself has no gap.
4. **Trailing Icon** — An Icon instance after the label, hidden until Trailing Icon is turned on.

### How to use

**Do:**
- Use one primary per view or per group. Everything else steps down to outline, subtle or text so the single most important action stays findable.
- Write the label as the verb the user is about to perform, Save rather than OK, so the action still reads clearly on its own.

**Don't:**
- Don't build an icon-only button by hiding this one's label. Icon Button is a separate square component made for that, and it keeps the touch target correct.
- Don't mix Shape values inside one button group. A pill beside a rounded button reads as a mistake rather than a deliberate distinction.

### Accessibility & Content Guidelines

- Focus is drawn as a ring outside the control and is identical on every flavour, so it stays visible whatever the button sits on.
- Disabled is a visual state only. Figma cannot carry the reason an action is unavailable, so put that in nearby text in the implementation.
- The icon repeats the label rather than adding to it. An action with no visible label belongs in Icon Button, which still needs an accessible name in code.
- Every state change is colour-only, so anything signalled by hover or pressed alone will not reach a keyboard or screen reader user.
- Write labels as the verb the user is about to carry out, Save rather than OK, so the action is understandable when read out of context.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Hug | Always hugs the label and any visible icons, never fixed. Small grows by 16px for each icon shown, medium and large by 20px. |
| Height | Fixed per Size | 36px at small (control/sm), 40px at medium (control/md), 48px at large (control/lg). Not resizable independently of Size. |
| Horizontal padding | Fixed per Size | 12px (space/md) at small and medium, 16px (space/lg) at large. |
| Vertical padding | Fixed | 4px (space/xs) at every size. The fixed height does the real work. |
| Gap | None on the row | Item spacing is space/none. The visible separation between an icon and the label comes from the Label wrapper's own horizontal padding, 4px (space/xs) at small and 8px (space/sm) at medium and large. |
| Radius | Fixed per Shape | 0 (radius/none) for sharp, 4px (radius/element-sm) for rounded, 9999 (radius/pill) for full. All three are token-bound, so match the container rather than overriding on the instance. |
| Border | Fixed per Flavour | 1px drawn inside on outline, outline-subtle and outline-contrast, none on the other eight at rest. Focus replaces it with a 2px ring drawn outside the bounds. |
| Icon size | Fixed per Size | 16px at small, 20px at medium and large. Large reuses Icon's medium step, so Icon's own large (28px) never appears inside a Button. |
| Label type | Fixed per Size | label/medium (14/20) at small, label/large (16/24) at medium and large, IBM Plex Sans Medium. |
| Colour | Theming | Every fill, border and label colour is bound to an interactive/* token for the flavour. Gradient draws from surface/gradient/*, text-gradient from foreground/gradient/*, contrast from interactive/inverse/*, outline-contrast from interactive/inverse/border/* and foreground/primary, and focus from border/focus. No variant hardcodes a colour. |

### Layer structure

- Button (COMPONENT)
  - Button/Leading Icon (INSTANCE, icon: verified)
  - Button/Label (FRAME)
    - Button/Label/Label (TEXT)
  - Button/Trailing Icon (INSTANCE, icon: verified)

### Resolved tokens (default variant: Size=medium, Shape=rounded, Flavour=primary, State=default, Disabled=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Button | height | 40 | control.md |
| Button | fill[0] | #1f69ff | interactive.primary.background.default |
| Button | stroke[0] | #1f69ff | interactive.primary.border.default |
| Button | cornerRadius | 4 | radius.element-sm |
| Button | strokeWeight | 0 | stroke.base |
| Button | padding.left | 12 | space.md |
| Button | padding.right | 12 | space.md |
| Button | padding.top | 4 | space.xxs |
| Button | padding.bottom | 4 | space.xxs |
| Button/Label | padding.left | 8 | space.sm |
| Button/Label | padding.right | 8 | space.sm |
| Button/Label/Label | fill[0] | #ffffff | interactive.primary.foreground.default |
| Button/Label/Label | fontSize | 16 | label.large.font size |
| Button/Label/Label | lineHeight | 24 | label.large.line height |
| Button/Label/Label | letterSpacing | 0 | label.large.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Button | height | control.lg |
| Size | large | Button | padding.left | space.lg |
| Size | large | Button | padding.right | space.lg |
| Size | small | Button | height | control.sm |
| Size | small | Button/Label | padding.left | space.xxs |
| Size | small | Button/Label | padding.right | space.xxs |
| Size | small | Button/Label/Label | fontSize | label.medium.font size |
| Size | small | Button/Label/Label | lineHeight | label.medium.line height |
| Size | small | Button/Label/Label | letterSpacing | label.medium.letter spacing |
| Shape | sharp | Button | cornerRadius | radius.none |
| Shape | full | Button | cornerRadius | radius.pill |
| Flavour | positive | Button | fill[0] | interactive.positive.background.default |
| Flavour | positive | Button | stroke[0] | interactive.positive.border.default |
| Flavour | positive | Button/Label/Label | fill[0] | interactive.positive.foreground.default |
| Flavour | negative | Button | fill[0] | interactive.destructive.background.default |
| Flavour | negative | Button | stroke[0] | interactive.destructive.border.default |
| Flavour | negative | Button/Label/Label | fill[0] | interactive.destructive.foreground.default |
| Flavour | outline | Button | fill[0] | interactive.neutral.background.default |
| Flavour | outline | Button | stroke[0] | interactive.ghost.border.default |
| Flavour | outline | Button | strokeWeight | stroke.thin |
| Flavour | outline | Button/Label/Label | fill[0] | interactive.ghost.foreground.default |
| Flavour | outline-subtle | Button | fill[0] | interactive.ghost.background.default |
| Flavour | outline-subtle | Button | stroke[0] | interactive.neutral.border.default |
| Flavour | outline-subtle | Button | strokeWeight | stroke.thin |
| Flavour | outline-subtle | Button/Label/Label | fill[0] | interactive.neutral.foreground.default |
| Flavour | text | Button | fill[0] | interactive.ghost.background.default |
| Flavour | text | Button | stroke[0] | interactive.ghost.border.default |
| Flavour | text | Button/Label/Label | fill[0] | interactive.ghost.foreground.default |
| Flavour | subtle | Button | fill[0] | interactive.ghost.background.default |
| Flavour | subtle | Button | stroke[0] | interactive.neutral.border.default |
| Flavour | subtle | Button/Label/Label | fill[0] | interactive.neutral.foreground.default |
| Flavour | gradient | Button | fill[0] | linear-gradient(135deg, surface.gradient.start 0%, surface.gradient.end 87%) |
| Flavour | text-gradient | Button | fill[0] | interactive.ghost.background.default |
| Flavour | text-gradient | Button | stroke[0] | interactive.ghost.border.default |
| Flavour | text-gradient | Button/Label/Label | fill[0] | linear-gradient(129deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | contrast | Button | fill[0] | interactive.inverse.background.default |
| Flavour | contrast | Button | stroke[0] | interactive.inverse.border.default |
| Flavour | contrast | Button/Label/Label | fill[0] | interactive.inverse.foreground.default |
| Flavour | outline-contrast | Button | fill[0] | interactive.ghost.background.default |
| Flavour | outline-contrast | Button | stroke[0] | interactive.inverse.border.default |
| Flavour | outline-contrast | Button | strokeWeight | stroke.thin |
| Flavour | outline-contrast | Button/Label/Label | fill[0] | foreground.primary |
| State | hover | Button | fill[0] | interactive.primary.background.hover |
| State | hover | Button | stroke[0] | interactive.primary.border.hover |
| State | pressed | Button | fill[0] | interactive.primary.background.pressed |
| State | pressed | Button | stroke[0] | interactive.primary.border.pressed |
| State | focus | Button | fill[0] | interactive.primary.background.focused |
| State | focus | Button | stroke[0] | border.focus |
| State | focus | Button | strokeWeight | stroke.thick |
| Disabled | true | Button | fill[0] | interactive.primary.background.disabled |
| Disabled | true | Button | stroke[0] | interactive.primary.border.disabled |
| Disabled | true | Button/Label/Label | fill[0] | interactive.primary.foreground.disabled |

## Icon Button

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2338-1763&m=dev

### Overview

Triggers an action from a single glyph, with no text label. Square at every size, and it carries the same eleven flavours (contrast and outline-contrast are experimental), three shapes and four states as Button so the two sit together consistently. Nothing on it is readable, so every instance needs an accessible name in code. When the action can carry a word, use Button instead.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Flavour | primary | true | The one action in a cluster that matters most, such as the confirm in a toolbar. More than one primary in a row of icon buttons removes the distinction it exists to make. |
| Flavour | positive | - | Confirms a constructive outcome. With no label the colour is doing all the work, so reserve it for cases where the glyph already reads as approval. |
| Flavour | negative | - | Destructive actions such as delete. Colour alone is a weak warning, so back it with a confirmation step rather than relying on the red to stop anyone. |
| Flavour | subtle | - | A quiet action that should not compete with its neighbours, the usual choice for secondary toolbar controls. |
| Flavour | text | - | A tertiary action inside dense content. Nothing sits behind it at rest, so on a busy surface the target becomes hard to find even though it is still there. |
| Flavour | outline-subtle | - | A secondary action that needs a visible edge without pulling attention, for toolbars that are already busy. |
| Flavour | outline | - | A secondary action that still needs to read as a control on its own, carrying the accent edge. |
| Flavour | gradient | - | One promotional moment. In a row of icon buttons it wins every time, which is only useful when that is the intent. |
| Flavour | text-gradient | - | The promotional treatment without the filled weight. The gradient runs across a single small glyph, so it reads as a colour shift more than a gradient. |
| Flavour | contrast | - | The strongest neutral against the page, near-black in light mode and near-white in dark. Beside a primary icon button it competes for weight, so pair it with outline or text. |
| Flavour | outline-contrast | - | A secondary action that pairs with contrast. Its border and glyph follow the page, near-black in light mode and near-white in dark. |
| Size | medium | true | The default, for general-purpose icon actions and comfortable interaction targets. |
| Size | large | - | For a prominent standalone action or a roomier target on a touch surface. |
| Size | small | - | For compact toolbars and table rows. Ensure the interaction target remains accessible. |
| Shape | rounded | true | The default shape, matching the system's other rounded controls. |
| Shape | sharp | - | Square corners, for surfaces and controls with sharp edges. |
| Shape | full | - | A circular button, the usual choice for a floating or standalone action. It reads as clearly separate from a form control, which is why it looks wrong inside one. |
| State | default | true | The resting state, and the only one to use when laying out a static screen. |
| State | hover | - | Documents the pointer-over treatment. The implementation drives this, so choosing it in a layout freezes the button in a state it should not be in. |
| State | pressed | - | Documents the pointer-down treatment, with the same caveat as hover. |
| State | focus | - | Documents the keyboard focus treatment. The one state whose treatment is identical on every flavour. |
| Disabled | false | true | The control accepts input. |
| Disabled | true | - | The action is unavailable. With no label there is nothing on the control to explain why, so put the reason in a tooltip or adjacent text. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Resting | — | Background, border and glyph sit on the default tokens of the chosen flavour. |
| hover | Pointer over the control | — | Filled flavours move their own background token one step. Outline flavours hold their border and shift a neutral background underneath instead. Text flavours raise a ghost scrim from fully transparent. The gradient flavours keep their gradient and slide it toward the end colour rather than swapping it (see Gradient transition). outline-contrast steps its border and raises the ghost scrim. Apart from text-gradient, the glyph colour does not change on any flavour. |
| pressed | Pointer held down | — | The same mechanism as hover carried one step further. The gradient flavours slide the other way, toward the start colour, rather than collapsing to a flat token (see Gradient transition). |
| focus | Keyboard focus | — | A focus ring is drawn outside the bounds, replacing the resting border rather than adding to it. Identical on all eleven flavours, and the only state that changes the control's outer footprint. |
| disabled | Disabled set to true | — | Background and glyph swap to the disabled tokens of their family. No flavour keeps its accent colour, so a disabled destructive button is indistinguishable from any other disabled one. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing. Every state change is colour-only, with no scale, shadow or elevation shift on any flavour, so a transition should read as a tint change rather than movement. The gradient flavours are the one exception to a plain tint: their gradient moves (see Gradient transition). |
| Gradient transition | gradient and text-gradient keep their gradient through every state and move it rather than replace it. On hover the gradient slides until its end colour covers 100% of the fill (the glyph on text-gradient); on press it slides the other way until its start colour covers 100%. Leaving or releasing slides it back to the resting two-stop gradient. It must never jump from the gradient to a flat colour: a browser cannot interpolate between a gradient and a solid fill, so that swap shows as a flicker. The hover and pressed variants show where each slide ends, not a separate flat fill. |
| Outline contrast | Experimental. outline-contrast takes its border from interactive/inverse/border/* and its glyph from foreground/primary, so it follows the mode. Its states sit on interactive/ghost/background/*. |
| Focus ring | The only change that alters the control's outer footprint, because the ring is drawn outside the bounds. Leave room around a button in a tight toolbar so the ring is not clipped. |
| Resize | The control never resizes with its content. Both axes are fixed per Size, so swapping the glyph changes nothing about the footprint. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Icon glyph | instance swap on the nested Icon | The only content this component has. It arrives holding More Horizontal, which reads as an overflow menu, so leaving it unchanged will actively mislead. |
| Icon Size and Framed | exposed on the nested instance | Icon Button does not re-declare them, but the nested Icon stays exposed so both remain reachable in the properties panel. The button already pairs the glyph size to its own Size, and Framed would nest a 40px box inside an already-sized control. See the Icon Metadata frame for what Icon offers on its own terms. |

### Anatomy

1. **Container** — The button's own frame, fixed square at every size. Carries the background, the border and the radius, and never hugs its content.
2. **Icon** — A single Icon instance, always visible and centred. Icon Button sets its size and leaves the instance exposed.

### How to use

**Do:**
- Give every icon button an accessible name in code. Nothing on the control is readable, so without one it is announced only as a button.
- Use medium or large wherever the control will be tapped. Small is 36px, under the 40px minimum target the system sets for itself.

**Don't:**
- Don't leave the default More Horizontal glyph in place. It reads as an overflow menu and will be understood as one.
- Don't use an icon button where the action needs explaining. If it takes a word to be clear, Button carries one and this component cannot.

### Accessibility & Content Guidelines

- Nothing in this component is readable, so every instance needs an accessible name in code. The glyph is decorative on its own.
- Small is 36px square, below the 40px minimum target the system defines as control/target-min. Prefer medium or large wherever the control is tapped.
- Focus is drawn as a ring outside the control and is identical on every flavour, so it stays visible whatever the button sits on.
- Disabled is visual only, and with no label there is nothing on the control to explain why. Put the reason in a tooltip or adjacent text.
- Colour is the only thing separating a destructive icon button from a neutral one, so back a destructive action with a confirmation step.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed square per Size | 36×36 at small (control/sm), 40×40 at medium (control/md), 48×48 at large (control/lg). Both axes bind to the same token, so it is always square and never hugs its content. |
| Padding | Fixed | 4px (space/xs) on all four sides at every size. |
| Radius | Fixed per Shape | 0 (radius/none) for sharp, 4px (radius/element-sm) for rounded, 9999 (radius/pill) for full, which gives a circle. All three are token-bound, so match the container rather than overriding on the instance. |
| Border | Fixed per Flavour | 1px drawn inside on outline, outline-subtle and outline-contrast, none on the other eight at rest. Focus replaces it with a 2px ring drawn outside the bounds. |
| Glyph size | Fixed per Size | 16px at small, 20px at medium and large. Large reuses Icon's medium step, so the glyph does not grow between medium and large even though the button does. |
| Touch target | Fixed per Size | Small is 36px, under the 40px control/target-min the system defines. Medium meets it exactly and large exceeds it. |
| Colour | Theming | Every fill, border and glyph colour is bound to an interactive/* token for the flavour. Gradient draws from surface/gradient/*, text-gradient from foreground/gradient/*, contrast from interactive/inverse/*, outline-contrast from interactive/inverse/border/* and foreground/primary, and focus from border/focus. No variant hardcodes a colour. |

### Layer structure

- Icon Button (COMPONENT)
  - Icon Button/Icon (INSTANCE, icon: more_horizontal)

### Resolved tokens (default variant: Size=medium, Shape=rounded, Flavour=primary, State=default, Disabled=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Icon Button | width | 40 | control.md |
| Icon Button | height | 40 | control.md |
| Icon Button | fill[0] | #1f69ff | interactive.primary.background.default |
| Icon Button | stroke[0] | #1f69ff | interactive.primary.border.default |
| Icon Button | cornerRadius | 4 | radius.element-sm |
| Icon Button | strokeWeight | 0 | stroke.base |
| Icon Button | padding.left | 4 | space.xxs |
| Icon Button | padding.right | 4 | space.xxs |
| Icon Button | padding.top | 4 | space.xxs |
| Icon Button | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Icon Button | width | control.lg |
| Size | large | Icon Button | height | control.lg |
| Size | small | Icon Button | width | control.sm |
| Size | small | Icon Button | height | control.sm |
| Shape | sharp | Icon Button | cornerRadius | radius.none |
| Shape | full | Icon Button | cornerRadius | radius.pill |
| Flavour | positive | Icon Button | fill[0] | interactive.positive.background.default |
| Flavour | positive | Icon Button | stroke[0] | interactive.positive.border.default |
| Flavour | negative | Icon Button | fill[0] | interactive.destructive.background.default |
| Flavour | negative | Icon Button | stroke[0] | interactive.destructive.border.default |
| Flavour | subtle | Icon Button | fill[0] | interactive.ghost.background.default |
| Flavour | subtle | Icon Button | stroke[0] | interactive.neutral.border.default |
| Flavour | text | Icon Button | fill[0] | interactive.ghost.background.default |
| Flavour | text | Icon Button | stroke[0] | interactive.ghost.border.default |
| Flavour | outline-subtle | Icon Button | fill[0] | interactive.ghost.background.default |
| Flavour | outline-subtle | Icon Button | stroke[0] | interactive.neutral.border.default |
| Flavour | outline-subtle | Icon Button | strokeWeight | stroke.thin |
| Flavour | outline | Icon Button | fill[0] | interactive.neutral.background.default |
| Flavour | outline | Icon Button | stroke[0] | interactive.ghost.border.default |
| Flavour | outline | Icon Button | strokeWeight | stroke.thin |
| Flavour | gradient | Icon Button | fill[0] | linear-gradient(135deg, surface.gradient.start 0%, surface.gradient.end 87%) |
| Flavour | text-gradient | Icon Button | fill[0] | interactive.ghost.background.default |
| Flavour | text-gradient | Icon Button | stroke[0] | interactive.ghost.border.default |
| Flavour | contrast | Icon Button | fill[0] | interactive.inverse.background.default |
| Flavour | contrast | Icon Button | stroke[0] | interactive.inverse.border.default |
| Flavour | outline-contrast | Icon Button | fill[0] | interactive.ghost.background.default |
| Flavour | outline-contrast | Icon Button | stroke[0] | interactive.inverse.border.default |
| Flavour | outline-contrast | Icon Button | strokeWeight | stroke.thin |
| State | hover | Icon Button | fill[0] | interactive.primary.background.hover |
| State | hover | Icon Button | stroke[0] | interactive.primary.border.hover |
| State | pressed | Icon Button | fill[0] | interactive.primary.background.pressed |
| State | pressed | Icon Button | stroke[0] | interactive.primary.border.pressed |
| State | focus | Icon Button | fill[0] | interactive.primary.background.focused |
| State | focus | Icon Button | stroke[0] | border.focus |
| State | focus | Icon Button | strokeWeight | stroke.thick |
| Disabled | true | Icon Button | fill[0] | interactive.primary.background.disabled |
| Disabled | true | Icon Button | stroke[0] | interactive.primary.border.disabled |
