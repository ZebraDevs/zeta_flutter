# Search

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2114-8976&m=dev

## Search

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2152-8811&m=dev

### Overview

A single-line input for typing a query, with a magnifier leading it and a trailing control that takes whatever icon and function the implementation passes. State covers the whole typing lifecycle from empty through focus to a committed query, and Flavour decides how much the field asserts itself against the surface behind it. Size and Shape match it to the controls around it.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Shape | sharp | true | Match the contour of the controls around the field. It is the only property that changes nothing but the corners. |
| Shape | rounded | - | The softened corner, for surfaces built from rounded controls. |
| Shape | full | - | A pill, for a field that should read as its own object sitting on a surface rather than as part of a form. |
| State | enabled | true | The resting empty field, showing its placeholder and waiting. |
| State | hover | - | Pointer over the field. The border is the only thing that answers. |
| State | focus | - | The field has keyboard focus and is ready for input. It carries the heaviest border in the set, which is what makes focus findable. |
| State | selected | - | Focus has settled and the cursor is placed. Lighter than focus, for a field being worked in rather than just arrived at. |
| State | typing | - | Text is being entered. This is the only state that offers a way to clear the field, so a flow that needs a clear control has to account for it arriving mid-typing. |
| State | filled | - | A committed query. The field is at rest again but the text stays at full strength, which is what separates it from the empty state. |
| State | disabled | - | The field cannot be used. Both the surface and the border drop away, so it reads as present but out of reach. |
| Size | large | true | The default, for a field that is the main thing on its surface. |
| Size | medium | - | For denser surfaces and toolbars where search sits alongside other controls. |
| Size | small | - | The tightest, and the only size that also reduces the text. |
| Flavour | default | true | A bordered field on a neutral surface, and the right choice inside a form. |
| Flavour | gradient | - | Used for a unique interaction highlight, such as an AI companion search input or a specific use-case callout. |
| Flavour | ghost | - | No visible border at rest, for a field sitting on a surface that already bounds it such as a header. The outline returns on focus as an optional implementation and can be turned off, giving the container the option to surface its own focus state, as in a message prompt input. |
| hasLeading | true | true | Show the magnifier. It is the fastest signal that tells a search field apart from a bare input. |
| hasLeading | false | - | Drop it where the surrounding context already says this is search and the width matters more. |
| hasTrailing | true | true | Show the trailing control. It takes whatever icon and function the implementation passes. The example ships voice input, which suits search well without being required, and while typing it becomes the group that also offers a clear. |
| hasTrailing | false | - | No trailing control, with the input taking the width back. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| enabled | — | — | The resting field. Border interactive/neutral/border/default, with the placeholder in foreground/disabled. |
| hover | Pointer over the field | — | The border moves to interactive/neutral/border/hover. Surface and text hold. |
| focus | Keyboard focus | — | The border becomes border/focus at double weight and the text moves to foreground/cursor. This is the heaviest border in the set. |
| selected | Focus settled, cursor placed | — | The border stays border/focus but returns to single weight, and the text keeps foreground/cursor. |
| typing | Text being entered | — | The text moves to foreground/primary and the trailing area changes from the single trailing control to a group carrying a clear control, a divider and that same control. |
| filled | A committed query | — | The border returns to interactive/neutral/border/default while the text stays at foreground/primary. |
| disabled | — | — | Surface and border both move to their disabled tokens and the text returns to foreground/disabled. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Each state is a swap of border, text colour and, at typing, the contents of the trailing area. |
| Typing lifecycle | The states run enabled, focus, selected, typing, filled. Only typing swaps the trailing area, so the clear control arrives once there is something to clear and is gone again once the query is committed. |
| Flavour and state | Flavour decides which border family a state draws from. Ghost holds its border at zero weight in every state, with the focus outline available but optional, so a container that surfaces its own focus can suppress it. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Input text | not parameterised | The query itself. It is not exposed as an input, so the placeholder and any value come from the implementation. |
| Leading icon | nested Icon, toggled by hasLeading | A magnifier at Size=medium. Its glyph is swappable through the Icon's own Name property. |
| Trailing area | nested, toggled by hasTrailing | Toggled by hasTrailing. It takes any icon and any function, defaulting to voice input because that suits search best without being a requirement. While typing it becomes a group holding a clear control, a divider and the trailing control. Both controls are real targets rather than decoration, so the pressable area runs past the glyph into the space around it. |
| Trailing group | nested set, three combinations | Carries hasIcon and hasCancel, giving icon only, clear only, or both. The combination with neither is not built, because hasTrailing already expresses an empty trailing area. The two controls are independently interactive, the clear control emptying the field and the trailing control running whatever function it was given, so each takes its own target rather than one target spanning the pair. |

### Anatomy

1. **Leading icon** — The magnifier, present unless hasLeading is off.
2. **Input** — The query text, taking the width left between the two icons.
3. **Trailing area** — The trailing control, defaulting to voice input and open to any icon and function. While typing it becomes a group with a clear control and a divider. Both are pressable, and each claims a target wider than its glyph so the surrounding space counts as part of the control.

### How to use

**Do:**
- Keep hasLeading on unless the surrounding context already says this is search. The magnifier is the fastest signal the field gives.
- Use ghost on a surface that already bounds the field, such as a header, and default inside a form.

**Don't:**
- Don't reach for gradient on an ordinary search field. It marks a distinct interaction such as an AI companion, and spreading it across a view drains the meaning it carries.
- Don't treat typing as a style. It is the only state carrying a clear control, so choosing it changes what the field offers.

### Accessibility & Content Guidelines

- The field carries no label of its own. A placeholder is not a label, so one has to be supplied alongside it.
- Focus is the heaviest border in the set and is what keyboard users depend on. On ghost the outline is optional, so wherever it is suppressed the container has to show focus in its place.
- The magnifier and the trailing control are icons with no text. Each needs a name, and whatever function the trailing control carries is a real action rather than decoration.
- The clear control appears only while typing. Its arrival and departure change what is reachable, so that change has to be announced.
- Placeholder text uses foreground/disabled, the lowest-contrast text in the field. Check it against the surface before relying on it to carry meaning.
- At small the text drops to 14px and the field to 36 tall. Check the target still works for touch.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed | 280 wide at every size. 48 tall at large, 40 at medium and 36 at small. |
| Padding and gap | Fixed | space/sm top and bottom, space/md left and right, with a space/xs gap between the icons and the input. These hold at every size. |
| Radius | Per Shape | radius/none when sharp, radius/sm when rounded and radius/pill when full. |
| Surface | Per Flavour | interactive/neutral/background/default on default and gradient, interactive/ghost/background/default on ghost. Disabled moves each to its own disabled token. |
| Border | Per Flavour | Default draws at 1px and focus at 2px. Gradient keeps those weights with foreground/gradient/start. Ghost holds every weight at zero, and its focus outline is optional so the container can carry focus instead. |
| Text | Theming | 16px at large and medium, 14px at small. The colour changes with state, which States and Triggers sets out. |
| Icons and trailing group | Fixed | Icons at Size=medium, 20 square. The trailing group hugs both controls or one, separated by a divider. Each control takes a target of roughly 36 square, the 20 glyph plus about 8 all round, which the 8 gap either side of the divider already leaves room for without the two targets meeting. |

### Layer structure

- Search (COMPONENT)
  - Search/Search-Icon (INSTANCE, icon: search)
  - Search/Input Text (FRAME)
    - Search/Input Text/Text (TEXT)
    - Search/Input Text/Cursor (TEXT)
  - Search/Trailing-Icon (INSTANCE, icon: microphone)
  - Search/Trailing (INSTANCE)

### Resolved tokens (default variant: Shape=sharp, State=enabled, Size=large, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Search | fill[0] | #ffffff | interactive.neutral.background.default |
| Search | stroke[0] | #ced2db | interactive.neutral.border.default |
| Search | cornerRadius | 0 | radius.none |
| Search | strokeWeight | 1 | stroke.thin |
| Search | itemSpacing | 4 | space.xxs |
| Search | padding.left | 12 | space.md |
| Search | padding.right | 12 | space.md |
| Search | padding.top | 8 | space.sm |
| Search | padding.bottom | 8 | space.sm |
| Search/Input Text | itemSpacing | 2 | space.2xs |
| Search/Input Text | padding.left | 4 | space.xxs |
| Search/Input Text | padding.right | 4 | space.xxs |
| Search/Input Text/Text | fill[0] | #8d95a3 | foreground.disabled |
| Search/Input Text/Text | fontSize | 16 | body.medium.font size |
| Search/Input Text/Text | lineHeight | 24 | body.medium.line height |
| Search/Input Text/Text | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Shape | rounded | Search | cornerRadius | radius.sm |
| Shape | rounded | Search | height | control.lg |
| Shape | full | Search | cornerRadius | radius.pill |
| Shape | full | Search | height | control.lg |
| State | focus | Search | stroke[0] | border.focus |
| State | focus | Search | strokeWeight | stroke.thick |
| State | focus | Search | height | control.lg |
| State | focus | Search/Input Text/Cursor | fill[0] | foreground.cursor |
| State | focus | Search/Input Text/Cursor | fontSize | body.medium.font size |
| State | focus | Search/Input Text/Cursor | lineHeight | body.medium.line height |
| State | focus | Search/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | hover | Search | stroke[0] | interactive.neutral.border.hover |
| State | hover | Search | height | control.lg |
| State | selected | Search | stroke[0] | border.focus |
| State | selected | Search | height | control.lg |
| State | selected | Search/Input Text/Cursor | fill[0] | foreground.cursor |
| State | selected | Search/Input Text/Cursor | fontSize | body.medium.font size |
| State | selected | Search/Input Text/Cursor | lineHeight | body.medium.line height |
| State | selected | Search/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Search | stroke[0] | border.focus |
| State | typing | Search | height | control.lg |
| State | typing | Search/Input Text/Text | fill[0] | foreground.primary |
| State | typing | Search/Input Text/Cursor | fill[0] | foreground.cursor |
| State | typing | Search/Input Text/Cursor | fontSize | body.medium.font size |
| State | typing | Search/Input Text/Cursor | lineHeight | body.medium.line height |
| State | typing | Search/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Search/Trailing | itemSpacing | space.sm |
| State | filled | Search | height | control.lg |
| State | filled | Search/Input Text/Text | fill[0] | foreground.primary |
| State | disabled | Search | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Search | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Search | height | control.lg |
| Size | medium | Search | height | control.md |
| Size | small | Search | height | control.sm |
| Size | small | Search/Input Text/Text | fontSize | body.small.font size |
| Size | small | Search/Input Text/Text | lineHeight | body.small.line height |
| Size | small | Search/Input Text/Text | letterSpacing | body.small.letter spacing |
| Flavour | gradient | Search | stroke[0] | linear-gradient(129deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | gradient | Search | height | control.lg |
| Flavour | ghost | Search | fill[0] | interactive.ghost.background.default |
| Flavour | ghost | Search | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Search | strokeWeight | stroke.base |
| Flavour | ghost | Search | height | control.lg |

## Trailing

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2183-20055&m=dev

### Layer structure

- Trailing (COMPONENT)
  - Trailing/Cancel-Icon (INSTANCE, icon: cancel)
  - Trailing/Divider (INSTANCE)
  - Trailing/Trailing-Icon (INSTANCE, icon: microphone)

### Resolved tokens (default variant: hasIcon=true, hasCancel=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Trailing | itemSpacing | 8 | space.sm |
| Trailing/Divider | width | 1 | stroke.thin |
| Trailing/Divider | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| hasIcon | false | Trailing | itemSpacing | — |
| hasIcon | false | Trailing/Divider | width | — |
| hasIcon | false | Trailing/Divider | cornerRadius | — |
| hasCancel | false | Trailing | itemSpacing | — |
| hasCancel | false | Trailing/Divider | width | — |
| hasCancel | false | Trailing/Divider | cornerRadius | — |
