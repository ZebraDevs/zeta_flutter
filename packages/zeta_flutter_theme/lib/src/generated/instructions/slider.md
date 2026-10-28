# Slider

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6125-1084&m=dev

## Step Indicators

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6132-2568&m=dev

### Layer structure

- Step Indicators (COMPONENT)
  - Step Indicators/Dot Slots (SLOT)

### Resolved tokens (default variant: Step Indicators)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Step Indicators | itemSpacing | 10 | — |
| Step Indicators/Dot Slots | itemSpacing | 10 | — |
| Step Indicators/Dot Slots | padding.left | 2 | space.2xs |
| Step Indicators/Dot Slots | padding.right | 2 | space.2xs |

## _Dot Indicator

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6132-2551&m=dev

### Layer structure

- _Dot Indicator (COMPONENT)
  - _Dot Indicator/Ellipse 1 (ELLIPSE)

### Resolved tokens (default variant: _Dot Indicator)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Dot Indicator | fill[0] | #ffffff | — |
| _Dot Indicator/Ellipse 1 | fill[0] | #ffffff | foreground.inverse |

## Slider

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6132-3190&m=dev

### Overview

A control for choosing a value along a range by dragging a thumb. State, Stepped and Range are the slider's own properties, and the track, the step indicators and the thumb all take their appearance from them rather than being set individually. Stepped marks the valid stops, and Range adds a second thumb so a span can be chosen instead of a single value.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Shape | rounded | true | Match the contour of the controls around the slider. It reaches the track ends and the thumb together, so the two never disagree. |
| Shape | sharp | - | The square-cornered pairing, for surfaces built from sharp controls. |
| State | default | true | The resting control. State belongs to the slider and the track, the thumb and the step indicators all inherit it, so it is never set on the parts individually. |
| State | hover | - | Pointer over a thumb. Only that thumb grows; the fill and, in range mode, the other thumb hold. It is the only state that depends on a pointer being present. |
| State | selected | - | A thumb is pressed or has keyboard focus. The active fill and both thumbs take the selected foreground, and only the thumb under the pointer takes the larger size. This is the state to show while a drag is in progress. |
| State | disabled | - | The value cannot be changed. Both the track and the thumb drop to the disabled foreground, so the control still reads as a slider rather than disappearing. |
| Stepped | true | true | Used when specific values are assignable in the range and also marks the valid stops along the track. Without the dots the control implies anything in the range is reachable smoothly. |
| Stepped | false | - | A continuous range with no stops drawn and a smooth transition between values, allowing finer adjustments. |
| Range | false | true | A single value, with one thumb. |
| Range | true | - | A span rather than a value. A second thumb marks the start, so both ends are chosen on the same track and each needs its own value. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | — | — | The resting control. Nothing is emphasised and the thumb sits at its base size. |
| hover | Pointer over a thumb | — | Only the hovered thumb grows. The active fill and, in range mode, the other thumb hold, so that thumb carries the whole change and the track looks untouched. |
| selected | A thumb is pressed or has keyboard focus | — | The active fill and both thumbs shift to the selected foreground. Only the thumb under the pointer takes the larger size; the other keeps its base size. |
| disabled | — | — | The active fill and the thumb both drop to the disabled foreground, and the thumb returns to its base size. |
| Stepped | Stepped set to true | — | Dots appear along the track marking each valid stop. Nothing else moves, because they sit above both track layers rather than between them. |
| Range | Range set to true | — | A second thumb appears at the start of the active fill. Both thumbs run on the same track and carry the same state. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Moving the thumb is a width change on the active fill, with nothing specified between one position and the next. |
| Value | The active fill's width is the value, and the thumb is pinned to its trailing edge. Position and fill move together rather than being set as two separate things. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Step indicators | slot, dots supplied with the content | Holds the dots marking each stop. The count arrives with the content rather than from a number on the slider, and the dots are spaced evenly across the full track so they cross the active fill and the base alike. |
| Thumb | fixed element, inherits state and shape | One thumb at the value, and a second at the start when range is on. Its colour follows the slider's state and its size follows the pointer, so it is never styled on its own. |
| Track | fixed element, two layers | A full-width base and an active fill that runs from the minimum to the value. Neither takes content, and the base is the only part that does not change with state. |

### Anatomy

1. **Track** — Two layers. The base runs the full width, and the active fill runs from the minimum to the value.
2. **Step indicators** — The dots marking each stop. They span the full track, so they sit above the active fill and the base alike and below the thumb.
3. **Thumb** — Sits at the value, above everything else. A second thumb marks the start of the span in range mode.

### How to use

**Do:**
- Reach for it where the range matters more than the exact figure. A value that has to be precise is quicker to type than to drag.
- Turn steps on whenever only certain values are valid, so the dots say where the thumb can land.

**Don't:**
- Don't set state on the track or the thumb separately. State is the slider's, and the parts follow it.
- Don't use Shape to carry meaning. It matches the controls around the slider and says nothing about the value.

### Accessibility & Content Guidelines

- The value is carried by position and fill alone. It has to be exposed as a number together with its minimum and maximum.
- Keyboard focus shows the selected colour on the fill and both thumbs, and the focused thumb also takes a ring, so in range mode it is clear which end the keys will move.
- Hover is answered by the hovered thumb growing while the track holds. Anyone not using a pointer gets no size change; the focus ring stands in for it.
- The step dots use foreground/inverse across the whole track, so their contrast differs either side of the value.
- In range mode two thumbs share one track. Each needs its own name and its own value, or the pair reads as a single control.
- Disabled is carried by colour on both the track and the thumb, with no change of size or shape to back it up.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed | 400 wide and 4 tall. The width is the track, and the thumb overhangs it above and below. |
| Radius | Per Shape | radius/xs on the base track when rounded and radius/none when sharp. The thumb takes radius/pill when rounded and square corners when sharp. The active fill is square-ended on both variants, so on a rounded slider its end meets the rounded base. |
| Track | Theming | The base is surface/track across the full width. The active fill is interactive/neutral/foreground/default, moving to interactive/ghost/foreground/default when selected and interactive/neutral/foreground/disabled when disabled. |
| Thumb | Per State | 16 square at rest. 20 only for the thumb under the pointer or being dragged, in any state. Centred on the track in every case. |
| Step indicators | Fixed | Dots of 2 by 2 in foreground/inverse, spaced evenly across the full track width with space/2xs held at each end. |
| Stacking | Fixed | Base track, active fill, step indicators, thumb, from back to front. The dots sit above both track layers and below the thumb. |
| Second thumb | Per Range | Matches the first thumb in colour and shape, and sits at the start of the active fill. It takes the larger size only when it is the one under the pointer. |

### Layer structure

- Slider (COMPONENT)
  - Slider/_Active Track (INSTANCE)

### Resolved tokens (default variant: Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Slider | fill[0] | #e0e3e9 | surface.track |
| Slider | cornerRadius | 2 | radius.xs |
| Slider | itemSpacing | 10 | — |
| Slider/_Active Track | itemSpacing | -4 | space.neg.md |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | sharp | Slider | cornerRadius | radius.none |

## Slider Input Field

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6154-5813&m=dev

### Layer structure

- Slider Input Field (COMPONENT)
  - Slider Input Field/Label (TEXT)
  - Slider Input Field/Frame 1 (FRAME)
    - Slider Input Field/Frame 1/Frame 1 (FRAME)
      - Slider Input Field/Frame 1/Frame 1/Slider (INSTANCE)
      - Slider Input Field/Frame 1/Frame 1/Frame 2 (FRAME)
        - Slider Input Field/Frame 1/Frame 1/Frame 2/0 (TEXT)
        - Slider Input Field/Frame 1/Frame 1/Frame 2/100 (TEXT)
    - Slider Input Field/Frame 1/Input Container (FRAME)
      - Slider Input Field/Frame 1/Input Container/50 (TEXT)

### Resolved tokens (default variant: Property 1=Default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Slider Input Field/Label | fill[0] | #000000 | — |
| Slider Input Field/Label | fontSize | 14 | label.medium.font size |
| Slider Input Field/Label | lineHeight | 20 | label.medium.line height |
| Slider Input Field/Label | letterSpacing | 0 | label.medium.letter spacing |
| Slider Input Field/Frame 1 | itemSpacing | 16 | space.gutter |
| Slider Input Field/Frame 1/Frame 1 | itemSpacing | 16 | space.lg |
| Slider Input Field/Frame 1/Frame 1 | padding.top | 8 | space.sm |
| Slider Input Field/Frame 1/Frame 1/Slider | fill[0] | #e0e3e9 | surface.track |
| Slider Input Field/Frame 1/Frame 1/Slider | cornerRadius | 2 | radius.xs |
| Slider Input Field/Frame 1/Frame 1/Slider | itemSpacing | 10 | — |
| Slider Input Field/Frame 1/Frame 1/Frame 2 | itemSpacing | 344 | — |
| Slider Input Field/Frame 1/Frame 1/Frame 2/0 | fill[0] | #545963 | foreground.secondary |
| Slider Input Field/Frame 1/Frame 1/Frame 2/0 | fontSize | 12 | indicator.medium.font size |
| Slider Input Field/Frame 1/Frame 1/Frame 2/0 | lineHeight | 14 | indicator.medium.line height |
| Slider Input Field/Frame 1/Frame 1/Frame 2/0 | letterSpacing | 0 | indicator.medium.letter spacing |
| Slider Input Field/Frame 1/Frame 1/Frame 2/100 | fill[0] | #545963 | foreground.secondary |
| Slider Input Field/Frame 1/Frame 1/Frame 2/100 | fontSize | 12 | indicator.medium.font size |
| Slider Input Field/Frame 1/Frame 1/Frame 2/100 | lineHeight | 14 | indicator.medium.line height |
| Slider Input Field/Frame 1/Frame 1/Frame 2/100 | letterSpacing | 0 | indicator.medium.letter spacing |
| Slider Input Field/Frame 1/Input Container | height | 40 | control.md |
| Slider Input Field/Frame 1/Input Container | fill[0] | #ffffff | interactive.neutral.background.default |
| Slider Input Field/Frame 1/Input Container | stroke[0] | #ced2db | interactive.neutral.border.default |
| Slider Input Field/Frame 1/Input Container | cornerRadius | 4 | radius.sm |
| Slider Input Field/Frame 1/Input Container | strokeWeight | 1 | stroke.thin |
| Slider Input Field/Frame 1/Input Container | padding.left | 12 | space.md |
| Slider Input Field/Frame 1/Input Container | padding.right | 12 | space.md |
| Slider Input Field/Frame 1/Input Container/50 | fill[0] | #0c0d0e | foreground.primary |
| Slider Input Field/Frame 1/Input Container/50 | fontSize | 16 | body.medium.font size |
| Slider Input Field/Frame 1/Input Container/50 | lineHeight | 24 | body.medium.line height |
| Slider Input Field/Frame 1/Input Container/50 | letterSpacing | 0 | body.medium.letter spacing |

## _Thumb

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6131-2467&m=dev

### Layer structure

- _Thumb (COMPONENT)
  - _Thumb/Thumb (RECTANGLE)
  - _Thumb/Focus Ring (RECTANGLE)

### Resolved tokens (default variant: State=default, Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Thumb | fill[0] | #ffffff | — |
| _Thumb/Thumb | height | 16 | control.icon-sm |
| _Thumb/Thumb | fill[0] | #0c0d0e | interactive.neutral.foreground.default |
| _Thumb/Thumb | cornerRadius | 9999 | radius.pill |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | selected | _Thumb/Thumb | height | control.icon-md |
| State | selected | _Thumb/Thumb | fill[0] | interactive.ghost.foreground.default |
| State | selected | _Thumb/Focus Ring | stroke[0] | border.focus |
| State | selected | _Thumb/Focus Ring | cornerRadius | radius.pill |
| State | selected | _Thumb/Focus Ring | strokeWeight | stroke.thick |
| State | disabled | _Thumb/Thumb | fill[0] | interactive.neutral.foreground.disabled |
| State | hover | _Thumb/Thumb | height | control.icon-md |
| Shape | sharp | _Thumb/Thumb | cornerRadius | — |

## _Active Track

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6132-2535&m=dev

### Layer structure

- _Active Track (COMPONENT)
  - _Active Track/Track (RECTANGLE)
  - _Active Track/Step Indicators (INSTANCE)
  - _Active Track/_Thumb (INSTANCE)
  - _Active Track/Start Thumb (INSTANCE)

### Resolved tokens (default variant: State=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Active Track | itemSpacing | -4 | space.neg.md |
| _Active Track/Track | fill[0] | #0c0d0e | interactive.neutral.foreground.default |
| _Active Track/Step Indicators | itemSpacing | 10 | — |
| _Active Track/_Thumb | fill[0] | #ffffff | — |
| _Active Track/Start Thumb | fill[0] | #ffffff | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | selected | _Active Track/Track | fill[0] | interactive.ghost.foreground.default |
| State | disabled | _Active Track/Track | fill[0] | interactive.neutral.foreground.disabled |
