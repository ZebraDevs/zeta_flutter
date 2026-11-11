# Phone Input

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7682-19850&m=dev

## Phone Input

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7687-1493&m=dev

### Overview

Takes a phone number, with a country picker joined to its start. The picker sets the flag and dial code, and the field groups digits as they are typed. The whole number is available in E.164.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | default | true | One state across the label, country control, number and hint. |
| State | invalid | - | Marks the number, with the reason in the hint. The error stays on while a person corrects it. |
| State | disabled | - | Dims every part and takes the country control and number out of the tab order. |
| Size | medium | true | Fits the field to its surface. Heights are control/md, control/sm and control/lg. |
| Size | small | - | The tightest, and the only size that also reduces the text. |
| Size | large | - | For a field that is the main thing on its surface. |
| Shape | rounded | true | The softened corner, shared by the country control's start and the number's end. |
| Shape | sharp | - | Matches square surfaces. |
| Shape | full | - | A pill, for a field that reads as its own object. |
| Flavour | default | true | A bordered field, and the right choice inside a form. |
| Flavour | gradient | - | A distinct interaction. The country control takes foreground/gradient/start, where the number's border starts. |
| Flavour | ghost | - | No surface or visible border, for a surface that already bounds it. |
| Flag | emoji | true | Code's default: the country's system emoji flag. Windows shows letters such as US instead. |
| Flag | artwork | - | Real flag artwork, set with flag on a country. It replaces the emoji everywhere, on every platform. |
| Flag | icon | - | Figma's default: the flag glyph, a placeholder. Swap the exposed Flag instance for a flag component. |
| Open | false | true | The country menu is closed. Figma only: derived from the menu, not a prop. |
| Open | true | - | Shows the country menu below the control. |
| value | string | - | National digits, without the dial code. |
| onValueChange | function | - | Called on every edit and country change, with the digits, the country and the E.164 number. |
| country | string | - | The selected country's ISO code. defaultCountry sets the first one. |
| countries | array | - | The countries offered. Each takes code, name, dialCode, format and flag. |
| countryLabel | string | - | Accessible name of the country control. The selected country follows it. |
| name | string | - | Submits the number in E.164 under this name. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | — | — | Label and hint at rest, with the number in its own state. |
| hover, focus, typing | The number's own states | — | Hover, focus and typing belong to the number. Typing adds a clear control. Filled, typing and selected are derived from focus and value. |
| invalid | Set on the assembly | — | The number takes feedback/error/background/subtle and a stroke/thick border/error. The hint becomes the error. |
| disabled | Set on the assembly | — | Every part dims, and the country control and number leave the tab order. |
| Country control | Pointer or keyboard | — | Hover, pressed and focus are CSS states. Open comes from the menu. |
| Open | Activating the country control | — | Opens the country menu. The control reports itself as expanded. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. |
| Grouping | Digits group by the country's format as they are typed, and the caret stays with its digit. Grouping is visual: it does not check that a number exists. |
| Length | Digits stop at the format's length. Without a format they stop at the E.164 limit. |
| Country | Picking a country changes the dial code and format, and keeps the digits. Extra digits are dropped. |
| Value | value is the national digits. onValueChange also gives the E.164 number, and name submits it. |
| Dropdown | The country control is the Template/Dropdown trigger. The menu opens below it, left aligned, space/sm away, with one row per country. It scrolls past eight rows. |
| Keyboard | Enter or Space opens the menu. Arrow keys move through the rows. Escape closes it and returns focus to the control. |
| Flags | Code uses the system's emoji flag unless a country passes flag. Pass artwork where flags must show everywhere, because Windows has no emoji flags. Artwork replaces the emoji in the control and every row. |
| Portal | Figma only: the menu is drawn inside the component. In code it mounts in a portal and is positioned against the control, with collision handling. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | Input Label, parent owned | The field's name. It marks required or optional, like Input. |
| Country control | _Phone Country, parent owned | The flag and a chevron, joined to the number. It has no visible text, so countryLabel names it. |
| Flag | Flag instance, exposed | Takes real flag artwork. Figma only: the default is the flag glyph as a placeholder, so swap in a flag component wherever the real flag matters. In code, pass flag on a country. |
| Number | Input / Phone, parent owned | The dial code and digits. Dial Code is fixed text that reads with the value. |
| Hint | Input Hint, parent owned | The supporting line, and the reason when invalid. |
| Country menu | Dropdown Menu, parent owned | One Menu Item per country, with its flag and dial code. The selected country takes the selected row. |
| Sample digits | Figma only | The number, dial code and two menu rows are sample content, not API. |

### Anatomy

1. **Label** — The field's name.
2. **Country control** — The flag and chevron. Opens the country menu.
3. **Number** — The dial code and digits, grouped as they are typed.
4. **Hint** — The supporting line, and the reason when invalid.

### How to use

**Do:**
- Use real flag artwork in the product. Pass flag on each country, or swap the exposed Flag instance in a design.
- Pair it with validation, and set invalid with the reason in the hint. Grouping alone does not prove a number exists.

**Don't:**
- Don't ship the flag glyph as the real thing. It is a placeholder, and it says nothing about the country.
- Don't use the flag as the only sign of the country. The dial code and the country's name in the menu carry it too.

### Accessibility & Content Guidelines

- The label names the number, and the hint is tied to it. The country control has no visible text, so countryLabel names it, with the selected country and dial code following. Flags are decorative and hidden from assistive tech, whether emoji or artwork. Opening the menu moves focus into it, and Escape returns it to the control. The number uses a tel input mode and tel-national autocomplete. Invalid is not colour alone, because the hint gives the reason.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Start width, hug height | Starts 280 wide and narrows to fit its container, and block fills it. Height follows size through control/sm, control/md and control/lg. |
| Join | No gap | The country control and number sit edge to edge. The control has no end border, and only the outer corners take the radius. |
| Country control | Hug | space/sm at the sides, with space/2xs between flag and chevron. interactive/neutral backgrounds, as the number. |
| Flag | Set to medium | control/icon-md wide, emoji or artwork. Artwork keeps its own ratio. |
| Number | Fill | space/sm at the start, with space/2xs between the dial code and the digits. |
| Gradient | Theming | The control's border is foreground/gradient/start, so it runs into the number's. It goes neutral when invalid. |
| Ghost | Theming | No surface, and a stroke/base border. Hover, pressed and open use interactive/ghost backgrounds. |

### Layer structure

- Phone Input (COMPONENT)
  - Phone Input/Label (INSTANCE)
  - Phone Input/Control (FRAME)
    - Phone Input/Control/_Phone Country (INSTANCE)
    - Phone Input/Control/Input / Phone (INSTANCE)
  - Phone Input/Hint (INSTANCE)
  - Phone Input/Dropdown Menu (INSTANCE)

### Resolved tokens (default variant: State=default, Size=medium, Shape=rounded, Open=false, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Phone Input | itemSpacing | 4 | space.2xs |
| Phone Input/Label | itemSpacing | 6 | space.xs |
| Phone Input/Control/_Phone Country | height | 40 | control.md |
| Phone Input/Control/_Phone Country | fill[0] | #ffffff | interactive.neutral.background.default |
| Phone Input/Control/_Phone Country | stroke[0] | #ced2db | interactive.neutral.border.default |
| Phone Input/Control/_Phone Country | cornerRadius | 0 | radius.sm |
| Phone Input/Control/_Phone Country | strokeWeight | 1 | stroke.thin |
| Phone Input/Control/_Phone Country | itemSpacing | 4 | space.2xs |
| Phone Input/Control/_Phone Country | padding.left | 8 | space.sm |
| Phone Input/Control/_Phone Country | padding.right | 8 | space.sm |
| Phone Input/Control/Input / Phone | height | 40 | control.md |
| Phone Input/Control/Input / Phone | fill[0] | #ffffff | interactive.neutral.background.default |
| Phone Input/Control/Input / Phone | stroke[0] | #ced2db | interactive.neutral.border.default |
| Phone Input/Control/Input / Phone | cornerRadius | 0 | radius.none |
| Phone Input/Control/Input / Phone | strokeWeight | 1 | stroke.thin |
| Phone Input/Control/Input / Phone | itemSpacing | 4 | space.2xs |
| Phone Input/Control/Input / Phone | padding.left | 8 | space.sm |
| Phone Input/Control/Input / Phone | padding.right | 12 | space.md |
| Phone Input/Control/Input / Phone | padding.top | 8 | space.sm |
| Phone Input/Control/Input / Phone | padding.bottom | 8 | space.sm |
| Phone Input/Hint | itemSpacing | 4 | space.2xs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | invalid | Phone Input/Control/Input / Phone | fill[0] | feedback.error.background.subtle |
| State | invalid | Phone Input/Control/Input / Phone | stroke[0] | border.error |
| State | invalid | Phone Input/Control/Input / Phone | strokeWeight | stroke.thick |
| State | disabled | Phone Input/Control/_Phone Country | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Phone Input/Control/_Phone Country | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Phone Input/Control/Input / Phone | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Phone Input/Control/Input / Phone | stroke[0] | interactive.neutral.border.disabled |
| Size | small | Phone Input/Control/_Phone Country | height | control.sm |
| Size | small | Phone Input/Control/Input / Phone | height | control.sm |
| Size | large | Phone Input/Control/_Phone Country | height | control.lg |
| Size | large | Phone Input/Control/Input / Phone | height | control.lg |
| Shape | sharp | Phone Input/Control/_Phone Country | cornerRadius | radius.none |
| Shape | full | Phone Input/Control/_Phone Country | cornerRadius | radius.pill |
| Open | true | Phone Input/Control/_Phone Country | fill[0] | interactive.neutral.background.selected |
| Open | true | Phone Input/Dropdown Menu | fill[0] | surface.overlay |
| Open | true | Phone Input/Dropdown Menu | cornerRadius | radius.element-md |
| Open | true | Phone Input/Dropdown Menu | itemSpacing | space.3xs |
| Open | true | Phone Input/Dropdown Menu | padding.left | space.card |
| Open | true | Phone Input/Dropdown Menu | padding.right | space.card |
| Open | true | Phone Input/Dropdown Menu | padding.top | space.card |
| Open | true | Phone Input/Dropdown Menu | padding.bottom | space.card |
| Flavour | gradient | Phone Input/Control/_Phone Country | stroke[0] | foreground.gradient.start |
| Flavour | gradient | Phone Input/Control/Input / Phone | stroke[0] | linear-gradient(129deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | ghost | Phone Input/Control/_Phone Country | fill[0] | — |
| Flavour | ghost | Phone Input/Control/_Phone Country | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Phone Input/Control/_Phone Country | strokeWeight | stroke.base |
| Flavour | ghost | Phone Input/Control/Input / Phone | fill[0] | — |
| Flavour | ghost | Phone Input/Control/Input / Phone | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Phone Input/Control/Input / Phone | strokeWeight | stroke.base |

## Input / Phone

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7682-19934&m=dev

### Layer structure

- Input / Phone (COMPONENT)
  - Input / Phone/Input Text (FRAME)
    - Input / Phone/Input Text/Dial Code (TEXT)
    - Input / Phone/Input Text/Number (TEXT)
    - Input / Phone/Input Text/Value (FRAME)
      - Input / Phone/Input Text/Value/Number (TEXT)
      - Input / Phone/Input Text/Value/Cursor (TEXT)
  - Input / Phone/Trailing (FRAME)
    - Input / Phone/Trailing/Clear (INSTANCE, icon: cancel)

### Resolved tokens (default variant: Size=medium, Shape=rounded, State=enabled, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input / Phone | height | 40 | control.md |
| Input / Phone | fill[0] | #ffffff | interactive.neutral.background.default |
| Input / Phone | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input / Phone | cornerRadius | 0 | radius.none |
| Input / Phone | strokeWeight | 1 | stroke.thin |
| Input / Phone | itemSpacing | 4 | space.2xs |
| Input / Phone | padding.left | 8 | space.sm |
| Input / Phone | padding.right | 12 | space.md |
| Input / Phone | padding.top | 8 | space.sm |
| Input / Phone | padding.bottom | 8 | space.sm |
| Input / Phone/Input Text | itemSpacing | 4 | space.2xs |
| Input / Phone/Input Text | padding.left | 4 | space.2xs |
| Input / Phone/Input Text | padding.right | 4 | space.2xs |
| Input / Phone/Input Text/Dial Code | fill[0] | #0c0d0e | foreground.primary |
| Input / Phone/Input Text/Dial Code | fontSize | 16 | body.medium.font size |
| Input / Phone/Input Text/Dial Code | lineHeight | 24 | body.medium.line height |
| Input / Phone/Input Text/Dial Code | letterSpacing | 0 | body.medium.letter spacing |
| Input / Phone/Input Text/Number | fill[0] | #8d95a3 | foreground.disabled |
| Input / Phone/Input Text/Number | fontSize | 16 | body.medium.font size |
| Input / Phone/Input Text/Number | lineHeight | 24 | body.medium.line height |
| Input / Phone/Input Text/Number | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Input / Phone | height | control.lg |
| Size | small | Input / Phone | height | control.sm |
| Size | small | Input / Phone/Input Text/Dial Code | fontSize | body.small.font size |
| Size | small | Input / Phone/Input Text/Dial Code | lineHeight | body.small.line height |
| Size | small | Input / Phone/Input Text/Dial Code | letterSpacing | body.small.letter spacing |
| Size | small | Input / Phone/Input Text/Number | fontSize | body.small.font size |
| Size | small | Input / Phone/Input Text/Number | lineHeight | body.small.line height |
| Size | small | Input / Phone/Input Text/Number | letterSpacing | body.small.letter spacing |
| State | hover | Input / Phone | stroke[0] | interactive.neutral.border.hover |
| State | focus | Input / Phone | stroke[0] | border.focus |
| State | focus | Input / Phone | strokeWeight | stroke.thick |
| State | focus | Input / Phone/Input Text/Number | fill[0] | — |
| State | focus | Input / Phone/Input Text/Number | fontSize | — |
| State | focus | Input / Phone/Input Text/Number | lineHeight | — |
| State | focus | Input / Phone/Input Text/Number | letterSpacing | — |
| State | focus | Input / Phone/Input Text/Value/Number | fill[0] | foreground.disabled |
| State | focus | Input / Phone/Input Text/Value/Number | fontSize | body.medium.font size |
| State | focus | Input / Phone/Input Text/Value/Number | lineHeight | body.medium.line height |
| State | focus | Input / Phone/Input Text/Value/Number | letterSpacing | body.medium.letter spacing |
| State | focus | Input / Phone/Input Text/Value/Cursor | fill[0] | foreground.cursor |
| State | focus | Input / Phone/Input Text/Value/Cursor | fontSize | body.medium.font size |
| State | focus | Input / Phone/Input Text/Value/Cursor | lineHeight | body.medium.line height |
| State | focus | Input / Phone/Input Text/Value/Cursor | letterSpacing | body.medium.letter spacing |
| State | selected | Input / Phone | stroke[0] | border.focus |
| State | selected | Input / Phone/Input Text/Number | fill[0] | — |
| State | selected | Input / Phone/Input Text/Number | fontSize | — |
| State | selected | Input / Phone/Input Text/Number | lineHeight | — |
| State | selected | Input / Phone/Input Text/Number | letterSpacing | — |
| State | selected | Input / Phone/Input Text/Value/Number | fill[0] | foreground.disabled |
| State | selected | Input / Phone/Input Text/Value/Number | fontSize | body.medium.font size |
| State | selected | Input / Phone/Input Text/Value/Number | lineHeight | body.medium.line height |
| State | selected | Input / Phone/Input Text/Value/Number | letterSpacing | body.medium.letter spacing |
| State | selected | Input / Phone/Input Text/Value/Cursor | fill[0] | foreground.cursor |
| State | selected | Input / Phone/Input Text/Value/Cursor | fontSize | body.medium.font size |
| State | selected | Input / Phone/Input Text/Value/Cursor | lineHeight | body.medium.line height |
| State | selected | Input / Phone/Input Text/Value/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Phone | stroke[0] | border.focus |
| State | typing | Input / Phone/Input Text/Number | fill[0] | — |
| State | typing | Input / Phone/Input Text/Number | fontSize | — |
| State | typing | Input / Phone/Input Text/Number | lineHeight | — |
| State | typing | Input / Phone/Input Text/Number | letterSpacing | — |
| State | typing | Input / Phone/Input Text/Value/Number | fill[0] | foreground.primary |
| State | typing | Input / Phone/Input Text/Value/Number | fontSize | body.medium.font size |
| State | typing | Input / Phone/Input Text/Value/Number | lineHeight | body.medium.line height |
| State | typing | Input / Phone/Input Text/Value/Number | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Phone/Input Text/Value/Cursor | fill[0] | foreground.cursor |
| State | typing | Input / Phone/Input Text/Value/Cursor | fontSize | body.medium.font size |
| State | typing | Input / Phone/Input Text/Value/Cursor | lineHeight | body.medium.line height |
| State | typing | Input / Phone/Input Text/Value/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Phone/Trailing | itemSpacing | space.sm |
| State | filled | Input / Phone/Input Text/Number | fill[0] | foreground.primary |
| State | invalid | Input / Phone | fill[0] | feedback.error.background.subtle |
| State | invalid | Input / Phone | stroke[0] | border.error |
| State | invalid | Input / Phone | strokeWeight | stroke.thick |
| State | invalid | Input / Phone/Input Text/Number | fill[0] | foreground.primary |
| State | read-only | Input / Phone | stroke[0] | border.subtle |
| State | read-only | Input / Phone/Input Text/Number | fill[0] | foreground.primary |
| State | disabled | Input / Phone | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Input / Phone | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Input / Phone/Input Text/Dial Code | fill[0] | foreground.disabled |
| Flavour | gradient | Input / Phone | stroke[0] | linear-gradient(129deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | ghost | Input / Phone | fill[0] | — |
| Flavour | ghost | Input / Phone | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Input / Phone | strokeWeight | stroke.base |

## _Phone Country

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7687-639&m=dev

### Layer structure

- _Phone Country (COMPONENT)
  - _Phone Country/Flag (INSTANCE, icon: flag)
  - _Phone Country/Chevron (INSTANCE, icon: expand_more)

### Resolved tokens (default variant: Size=large, Shape=sharp, State=default, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Phone Country | height | 48 | control.lg |
| _Phone Country | fill[0] | #ffffff | interactive.neutral.background.default |
| _Phone Country | stroke[0] | #ced2db | interactive.neutral.border.default |
| _Phone Country | cornerRadius | 0 | radius.none |
| _Phone Country | strokeWeight | 1 | stroke.thin |
| _Phone Country | itemSpacing | 4 | space.2xs |
| _Phone Country | padding.left | 8 | space.sm |
| _Phone Country | padding.right | 8 | space.sm |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | medium | _Phone Country | height | control.md |
| Size | small | _Phone Country | height | control.sm |
| Shape | rounded | _Phone Country | cornerRadius | radius.sm |
| Shape | full | _Phone Country | cornerRadius | radius.pill |
| State | hover | _Phone Country | fill[0] | interactive.neutral.background.hover |
| State | pressed | _Phone Country | fill[0] | interactive.neutral.background.pressed |
| State | focus | _Phone Country | stroke[0] | border.focus |
| State | focus | _Phone Country | strokeWeight | stroke.thick |
| State | open | _Phone Country | fill[0] | interactive.neutral.background.selected |
| State | disabled | _Phone Country | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _Phone Country | stroke[0] | interactive.neutral.border.disabled |
| Flavour | gradient | _Phone Country | stroke[0] | foreground.gradient.start |
| Flavour | ghost | _Phone Country | fill[0] | — |
| Flavour | ghost | _Phone Country | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | _Phone Country | strokeWeight | stroke.base |
