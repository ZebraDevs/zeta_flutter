# Stepper Input

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5595-122&m=dev

## Stepper Input

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5643-2489&m=dev

### Overview

A numeric value with a button on either side to decrease or increase it. The value itself is fixed text rather than a property, the two buttons are locked step controls with no properties of their own reachable from here, and an optional line of hint text can sit below the whole control.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Size | medium | true | The default, for a step control sitting among other medium fields. The value and the gap around it stay the same at every size, only the two buttons grow. |
| Size | large | - | For a step control that needs to be easy to tap without precision. |
| Rounded | false | true | Square corners on the two step buttons, to match a square surrounding surface. |
| Rounded | true | - | Rounded corners on the two step buttons only, the value between them stays square either way. |
| Disabled | false | true | The control accepts input, and shows the hint text when Hint is on. |
| Disabled | true | - | The two step buttons switch to a primary fill, and the hint text is removed entirely rather than hidden. Turning Hint on has no effect while Disabled is on. |
| Hint | false | true | No hint text below the control. |
| Hint | true | - | Adds a line of hint text below the control. Only ever shows the hint message, never the error one this part also offers, and has no effect while Disabled is on. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined for the hint text appearing or disappearing, or for Disabled or Rounded changing. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Value | Static text, not a property | A plain number on the layer itself, not exposed as a text property. Changing it means editing the layer directly rather than through this component’s properties panel. |
| Remove button | Fixed Icon Button, Remove glyph | Locked to outline-subtle at rest, switching to primary when Disabled is on. None of Icon Button’s own properties are reachable from here. |
| Add button | Fixed Icon Button, Add glyph | The same fixed treatment as Remove, on the opposite side of the value. |
| Hint text | Fixed instance, hint message only | Shown or hidden as a whole by Hint, and only present at all when Disabled is off. |

### Anatomy

1. **Remove button** — A fixed Icon Button at the Remove glyph. Locked to outline-subtle, none of its own properties reachable from here.
2. **Value** — A plain number on the layer, not an exposed text property.
3. **Add button** — The same fixed treatment as Remove, with the Add glyph.
4. **Hint text** — Shown as a whole by Hint, and only present when Disabled is off. Always the hint message, never the error one.

### How to use

**Do:**
- Use Large on a touch surface where the buttons need to be easy to hit without precision.
- Turn Hint on to explain a constraint on the value, such as a minimum or a maximum.

**Don't:**
- Don't expect Hint to show anything while Disabled is on, there is no hint text node to toggle on a disabled instance.
- Don't expect the error version of the hint text from this component, every instance uses the hint message, the error one is never placed.

### Accessibility & Content Guidelines

- Nothing in this file marks the value as a live region or states how it is announced when it changes. Whether screen readers hear the new value, and how the two buttons are labelled, needs confirming outside Figma.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed per Size | 168px at medium, 184px at large. Grows by exactly the amount the two buttons grow, the value area stays the same width. |
| Height | Fixed per Size, hug for Hint | 40px at medium, 48px at large, plus 24px and an 8px gap when Hint is on. |
| Gap | Fixed | 8px between the step control and the hint text when both are present. |
| Value width | Fixed | 72px at both sizes, with 12px padding on the left and the top only. |
| Value type | Fixed | 16px IBM Plex Sans Regular, 24px line height. Unchanged between medium and large. |
| Button radius | Fixed per Rounded | 0 square for false, 4px for true. Set on the two step buttons only, not on the control’s outer edge. |

### Layer structure

- Stepper Input (COMPONENT)
  - Stepper Input/Stepper Input Container (FRAME)
    - Stepper Input/Stepper Input Container/Icon Button[1] (INSTANCE)
    - Stepper Input/Stepper Input Container/Input / Text (INSTANCE)
    - Stepper Input/Stepper Input Container/Icon Button[2] (INSTANCE)
  - Stepper Input/_Hint text (INSTANCE)

### Resolved tokens (default variant: Size=medium, Rounded=false, Disabled=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Stepper Input | itemSpacing | 8 | space.sm |
| Stepper Input/Stepper Input Container | itemSpacing | 8 | space.sm |
| Stepper Input/Stepper Input Container/Icon Button[1] | width | 40 | control.md |
| Stepper Input/Stepper Input Container/Icon Button[1] | height | 40 | control.md |
| Stepper Input/Stepper Input Container/Icon Button[1] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Stepper Input/Stepper Input Container/Icon Button[1] | stroke[0] | #ced2db | interactive.neutral.border.default |
| Stepper Input/Stepper Input Container/Icon Button[1] | cornerRadius | 0 | radius.none |
| Stepper Input/Stepper Input Container/Icon Button[1] | strokeWeight | 1 | stroke.thin |
| Stepper Input/Stepper Input Container/Icon Button[1] | padding.left | 4 | space.xxs |
| Stepper Input/Stepper Input Container/Icon Button[1] | padding.right | 4 | space.xxs |
| Stepper Input/Stepper Input Container/Icon Button[1] | padding.top | 4 | space.xxs |
| Stepper Input/Stepper Input Container/Icon Button[1] | padding.bottom | 4 | space.xxs |
| Stepper Input/Stepper Input Container/Input / Text | height | 40 | control.md |
| Stepper Input/Stepper Input Container/Input / Text | fill[0] | #ffffff | interactive.neutral.background.default |
| Stepper Input/Stepper Input Container/Input / Text | stroke[0] | #ced2db | interactive.neutral.border.default |
| Stepper Input/Stepper Input Container/Input / Text | cornerRadius | 0 | radius.none |
| Stepper Input/Stepper Input Container/Input / Text | strokeWeight | 1 | stroke.thin |
| Stepper Input/Stepper Input Container/Input / Text | itemSpacing | 4 | space.xxs |
| Stepper Input/Stepper Input Container/Input / Text | padding.left | 12 | space.md |
| Stepper Input/Stepper Input Container/Input / Text | padding.right | 12 | space.md |
| Stepper Input/Stepper Input Container/Input / Text | padding.top | 8 | space.sm |
| Stepper Input/Stepper Input Container/Input / Text | padding.bottom | 8 | space.sm |
| Stepper Input/Stepper Input Container/Icon Button[2] | width | 40 | control.md |
| Stepper Input/Stepper Input Container/Icon Button[2] | height | 40 | control.md |
| Stepper Input/Stepper Input Container/Icon Button[2] | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Stepper Input/Stepper Input Container/Icon Button[2] | stroke[0] | #ced2db | interactive.neutral.border.default |
| Stepper Input/Stepper Input Container/Icon Button[2] | cornerRadius | 0 | radius.none |
| Stepper Input/Stepper Input Container/Icon Button[2] | strokeWeight | 1 | stroke.thin |
| Stepper Input/Stepper Input Container/Icon Button[2] | padding.left | 4 | space.xxs |
| Stepper Input/Stepper Input Container/Icon Button[2] | padding.right | 4 | space.xxs |
| Stepper Input/Stepper Input Container/Icon Button[2] | padding.top | 4 | space.xxs |
| Stepper Input/Stepper Input Container/Icon Button[2] | padding.bottom | 4 | space.xxs |
| Stepper Input/_Hint text | itemSpacing | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Stepper Input/Stepper Input Container/Icon Button[1] | width | control.lg |
| Size | large | Stepper Input/Stepper Input Container/Icon Button[1] | height | control.lg |
| Size | large | Stepper Input/Stepper Input Container/Input / Text | height | control.lg |
| Size | large | Stepper Input/Stepper Input Container/Icon Button[2] | width | control.lg |
| Size | large | Stepper Input/Stepper Input Container/Icon Button[2] | height | control.lg |
| Rounded | true | Stepper Input/Stepper Input Container/Icon Button[1] | cornerRadius | radius.element-sm |
| Rounded | true | Stepper Input/Stepper Input Container/Input / Text | cornerRadius | radius.sm |
| Rounded | true | Stepper Input/Stepper Input Container/Icon Button[2] | cornerRadius | radius.element-sm |
| Disabled | true | Stepper Input/Stepper Input Container/Icon Button[1] | fill[0] | interactive.primary.background.disabled |
| Disabled | true | Stepper Input/Stepper Input Container/Icon Button[1] | stroke[0] | interactive.primary.border.disabled |
| Disabled | true | Stepper Input/Stepper Input Container/Icon Button[1] | strokeWeight | stroke.base |
| Disabled | true | Stepper Input/Stepper Input Container/Input / Text | fill[0] | interactive.neutral.background.disabled |
| Disabled | true | Stepper Input/Stepper Input Container/Input / Text | stroke[0] | interactive.neutral.border.disabled |
| Disabled | true | Stepper Input/Stepper Input Container/Icon Button[2] | fill[0] | interactive.primary.background.disabled |
| Disabled | true | Stepper Input/Stepper Input Container/Icon Button[2] | stroke[0] | interactive.primary.border.disabled |
| Disabled | true | Stepper Input/Stepper Input Container/Icon Button[2] | strokeWeight | stroke.base |
| Disabled | true | Stepper Input/_Hint text | itemSpacing | — |

## _Hint text

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5643-2473&m=dev

### Layer structure

- _Hint text (COMPONENT)
  - _Hint text/Icon (INSTANCE, icon: info)
  - _Hint text/Hint text (TEXT)
  - _Hint text/Error text (TEXT)

### Resolved tokens (default variant: Message=hint)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Hint text | itemSpacing | 4 | space.xxs |
| _Hint text/Hint text | fill[0] | #545963 | foreground.secondary |
| _Hint text/Hint text | fontSize | 12 | body.xsmall.font size |
| _Hint text/Hint text | lineHeight | 16 | body.xsmall.line height |
| _Hint text/Hint text | letterSpacing | 0 | body.xsmall.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Message | error | _Hint text/Hint text | fill[0] | — |
| Message | error | _Hint text/Hint text | fontSize | — |
| Message | error | _Hint text/Hint text | lineHeight | — |
| Message | error | _Hint text/Hint text | letterSpacing | — |
| Message | error | _Hint text/Error text | fill[0] | foreground.error |
| Message | error | _Hint text/Error text | fontSize | body.xsmall.font size |
| Message | error | _Hint text/Error text | lineHeight | body.xsmall.line height |
| Message | error | _Hint text/Error text | letterSpacing | body.xsmall.letter spacing |
