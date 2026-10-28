# Input

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6288-997&m=dev

## Input / Text

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6306-7940&m=dev

### Layer structure

- Input / Text (COMPONENT)
  - Input / Text/Leading-Icon (INSTANCE, icon: email)
  - Input / Text/Input Text (FRAME)
    - Input / Text/Input Text/Placeholder (TEXT)
    - Input / Text/Input Text/Cursor (TEXT)
    - Input / Text/Input Text/Value (TEXT)
  - Input / Text/Trailing-Icon (INSTANCE, icon: info)
  - Input / Text/Clear (INSTANCE, icon: cancel)

### Resolved tokens (default variant: Size=medium, Shape=rounded, State=enabled, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input / Text | height | 40 | control.md |
| Input / Text | fill[0] | #ffffff | interactive.neutral.background.default |
| Input / Text | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input / Text | cornerRadius | 4 | radius.sm |
| Input / Text | strokeWeight | 1 | stroke.thin |
| Input / Text | itemSpacing | 4 | space.xxs |
| Input / Text | padding.left | 12 | space.md |
| Input / Text | padding.right | 12 | space.md |
| Input / Text | padding.top | 8 | space.sm |
| Input / Text | padding.bottom | 8 | space.sm |
| Input / Text/Input Text | padding.left | 4 | space.xxs |
| Input / Text/Input Text | padding.right | 4 | space.xxs |
| Input / Text/Input Text/Placeholder | fill[0] | #8d95a3 | foreground.disabled |
| Input / Text/Input Text/Placeholder | fontSize | 16 | body.medium.font size |
| Input / Text/Input Text/Placeholder | lineHeight | 24 | body.medium.line height |
| Input / Text/Input Text/Placeholder | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Input / Text | height | control.lg |
| Size | small | Input / Text | height | control.sm |
| Size | small | Input / Text/Input Text/Placeholder | fontSize | body.small.font size |
| Size | small | Input / Text/Input Text/Placeholder | lineHeight | body.small.line height |
| Size | small | Input / Text/Input Text/Placeholder | letterSpacing | body.small.letter spacing |
| Shape | sharp | Input / Text | cornerRadius | radius.none |
| Shape | full | Input / Text | cornerRadius | radius.pill |
| State | hover | Input / Text | stroke[0] | interactive.neutral.border.hover |
| State | focus | Input / Text | stroke[0] | border.focus |
| State | focus | Input / Text | strokeWeight | stroke.thick |
| State | focus | Input / Text/Input Text/Cursor | fill[0] | foreground.cursor |
| State | focus | Input / Text/Input Text/Cursor | fontSize | body.medium.font size |
| State | focus | Input / Text/Input Text/Cursor | lineHeight | body.medium.line height |
| State | focus | Input / Text/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | selected | Input / Text | stroke[0] | border.focus |
| State | selected | Input / Text/Input Text/Cursor | fill[0] | foreground.cursor |
| State | selected | Input / Text/Input Text/Cursor | fontSize | body.medium.font size |
| State | selected | Input / Text/Input Text/Cursor | lineHeight | body.medium.line height |
| State | selected | Input / Text/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Text | stroke[0] | border.focus |
| State | typing | Input / Text/Input Text/Placeholder | fill[0] | — |
| State | typing | Input / Text/Input Text/Placeholder | fontSize | — |
| State | typing | Input / Text/Input Text/Placeholder | lineHeight | — |
| State | typing | Input / Text/Input Text/Placeholder | letterSpacing | — |
| State | typing | Input / Text/Input Text/Value | fill[0] | foreground.primary |
| State | typing | Input / Text/Input Text/Value | fontSize | body.medium.font size |
| State | typing | Input / Text/Input Text/Value | lineHeight | body.medium.line height |
| State | typing | Input / Text/Input Text/Value | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Text/Input Text/Cursor | fill[0] | foreground.cursor |
| State | typing | Input / Text/Input Text/Cursor | fontSize | body.medium.font size |
| State | typing | Input / Text/Input Text/Cursor | lineHeight | body.medium.line height |
| State | typing | Input / Text/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | filled | Input / Text/Input Text/Placeholder | fill[0] | — |
| State | filled | Input / Text/Input Text/Placeholder | fontSize | — |
| State | filled | Input / Text/Input Text/Placeholder | lineHeight | — |
| State | filled | Input / Text/Input Text/Placeholder | letterSpacing | — |
| State | filled | Input / Text/Input Text/Value | fill[0] | foreground.primary |
| State | filled | Input / Text/Input Text/Value | fontSize | body.medium.font size |
| State | filled | Input / Text/Input Text/Value | lineHeight | body.medium.line height |
| State | filled | Input / Text/Input Text/Value | letterSpacing | body.medium.letter spacing |
| State | invalid | Input / Text | stroke[0] | border.error |
| State | invalid | Input / Text/Input Text/Placeholder | fill[0] | — |
| State | invalid | Input / Text/Input Text/Placeholder | fontSize | — |
| State | invalid | Input / Text/Input Text/Placeholder | lineHeight | — |
| State | invalid | Input / Text/Input Text/Placeholder | letterSpacing | — |
| State | invalid | Input / Text/Input Text/Value | fill[0] | foreground.primary |
| State | invalid | Input / Text/Input Text/Value | fontSize | body.medium.font size |
| State | invalid | Input / Text/Input Text/Value | lineHeight | body.medium.line height |
| State | invalid | Input / Text/Input Text/Value | letterSpacing | body.medium.letter spacing |
| State | read-only | Input / Text | stroke[0] | border.subtle |
| State | read-only | Input / Text/Input Text/Placeholder | fill[0] | — |
| State | read-only | Input / Text/Input Text/Placeholder | fontSize | — |
| State | read-only | Input / Text/Input Text/Placeholder | lineHeight | — |
| State | read-only | Input / Text/Input Text/Placeholder | letterSpacing | — |
| State | read-only | Input / Text/Input Text/Value | fill[0] | foreground.primary |
| State | read-only | Input / Text/Input Text/Value | fontSize | body.medium.font size |
| State | read-only | Input / Text/Input Text/Value | lineHeight | body.medium.line height |
| State | read-only | Input / Text/Input Text/Value | letterSpacing | body.medium.letter spacing |
| State | disabled | Input / Text | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Input / Text | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Input / Text/Input Text/Placeholder | fill[0] | — |
| State | disabled | Input / Text/Input Text/Placeholder | fontSize | — |
| State | disabled | Input / Text/Input Text/Placeholder | lineHeight | — |
| State | disabled | Input / Text/Input Text/Placeholder | letterSpacing | — |
| State | disabled | Input / Text/Input Text/Value | fill[0] | foreground.disabled |
| State | disabled | Input / Text/Input Text/Value | fontSize | body.medium.font size |
| State | disabled | Input / Text/Input Text/Value | lineHeight | body.medium.line height |
| State | disabled | Input / Text/Input Text/Value | letterSpacing | body.medium.letter spacing |
| Flavour | gradient | Input / Text | stroke[0] | linear-gradient(90deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | ghost | Input / Text | fill[0] | — |
| Flavour | ghost | Input / Text | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Input / Text | strokeWeight | stroke.base |

## Input / Number

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6307-18854&m=dev

### Layer structure

- Input / Number (COMPONENT)
  - Input / Number/Leading-Icon (INSTANCE, icon: email)
  - Input / Number/Input Text (FRAME)
    - Input / Number/Input Text/0 (TEXT)
    - Input / Number/Input Text/Cursor (TEXT)
    - Input / Number/Input Text/3 (TEXT)
  - Input / Number/Trailing-Icon (INSTANCE, icon: dialpad)
  - Input / Number/Clear (INSTANCE, icon: cancel)

### Resolved tokens (default variant: Size=medium, Shape=rounded, State=enabled, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input / Number | height | 40 | control.md |
| Input / Number | fill[0] | #ffffff | interactive.neutral.background.default |
| Input / Number | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input / Number | cornerRadius | 4 | radius.sm |
| Input / Number | strokeWeight | 1 | stroke.thin |
| Input / Number | itemSpacing | 4 | space.xxs |
| Input / Number | padding.left | 12 | space.md |
| Input / Number | padding.right | 12 | space.md |
| Input / Number | padding.top | 8 | space.sm |
| Input / Number | padding.bottom | 8 | space.sm |
| Input / Number/Input Text | padding.left | 4 | space.xxs |
| Input / Number/Input Text | padding.right | 4 | space.xxs |
| Input / Number/Input Text/0 | fill[0] | #8d95a3 | foreground.disabled |
| Input / Number/Input Text/0 | fontSize | 16 | body.medium.font size |
| Input / Number/Input Text/0 | lineHeight | 24 | body.medium.line height |
| Input / Number/Input Text/0 | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Input / Number | height | control.lg |
| Size | small | Input / Number | height | control.sm |
| Size | small | Input / Number/Input Text/0 | fontSize | body.small.font size |
| Size | small | Input / Number/Input Text/0 | lineHeight | body.small.line height |
| Size | small | Input / Number/Input Text/0 | letterSpacing | body.small.letter spacing |
| Shape | sharp | Input / Number | cornerRadius | radius.none |
| Shape | full | Input / Number | cornerRadius | radius.pill |
| State | hover | Input / Number | stroke[0] | interactive.neutral.border.hover |
| State | focus | Input / Number | stroke[0] | border.focus |
| State | focus | Input / Number | strokeWeight | stroke.thick |
| State | focus | Input / Number/Input Text/Cursor | fill[0] | foreground.cursor |
| State | focus | Input / Number/Input Text/Cursor | fontSize | body.medium.font size |
| State | focus | Input / Number/Input Text/Cursor | lineHeight | body.medium.line height |
| State | focus | Input / Number/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | selected | Input / Number | stroke[0] | border.focus |
| State | selected | Input / Number/Input Text/Cursor | fill[0] | foreground.cursor |
| State | selected | Input / Number/Input Text/Cursor | fontSize | body.medium.font size |
| State | selected | Input / Number/Input Text/Cursor | lineHeight | body.medium.line height |
| State | selected | Input / Number/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Number | stroke[0] | border.focus |
| State | typing | Input / Number/Input Text/0 | fill[0] | — |
| State | typing | Input / Number/Input Text/0 | fontSize | — |
| State | typing | Input / Number/Input Text/0 | lineHeight | — |
| State | typing | Input / Number/Input Text/0 | letterSpacing | — |
| State | typing | Input / Number/Input Text/3 | fill[0] | foreground.primary |
| State | typing | Input / Number/Input Text/3 | fontSize | body.medium.font size |
| State | typing | Input / Number/Input Text/3 | lineHeight | body.medium.line height |
| State | typing | Input / Number/Input Text/3 | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Number/Input Text/Cursor | fill[0] | foreground.cursor |
| State | typing | Input / Number/Input Text/Cursor | fontSize | body.medium.font size |
| State | typing | Input / Number/Input Text/Cursor | lineHeight | body.medium.line height |
| State | typing | Input / Number/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | filled | Input / Number/Input Text/0 | fill[0] | — |
| State | filled | Input / Number/Input Text/0 | fontSize | — |
| State | filled | Input / Number/Input Text/0 | lineHeight | — |
| State | filled | Input / Number/Input Text/0 | letterSpacing | — |
| State | filled | Input / Number/Input Text/3 | fill[0] | foreground.primary |
| State | filled | Input / Number/Input Text/3 | fontSize | body.medium.font size |
| State | filled | Input / Number/Input Text/3 | lineHeight | body.medium.line height |
| State | filled | Input / Number/Input Text/3 | letterSpacing | body.medium.letter spacing |
| State | invalid | Input / Number | stroke[0] | border.error |
| State | invalid | Input / Number/Input Text/0 | fill[0] | — |
| State | invalid | Input / Number/Input Text/0 | fontSize | — |
| State | invalid | Input / Number/Input Text/0 | lineHeight | — |
| State | invalid | Input / Number/Input Text/0 | letterSpacing | — |
| State | invalid | Input / Number/Input Text/3 | fill[0] | foreground.primary |
| State | invalid | Input / Number/Input Text/3 | fontSize | body.medium.font size |
| State | invalid | Input / Number/Input Text/3 | lineHeight | body.medium.line height |
| State | invalid | Input / Number/Input Text/3 | letterSpacing | body.medium.letter spacing |
| State | read-only | Input / Number | stroke[0] | border.subtle |
| State | read-only | Input / Number/Input Text/0 | fill[0] | — |
| State | read-only | Input / Number/Input Text/0 | fontSize | — |
| State | read-only | Input / Number/Input Text/0 | lineHeight | — |
| State | read-only | Input / Number/Input Text/0 | letterSpacing | — |
| State | read-only | Input / Number/Input Text/3 | fill[0] | foreground.primary |
| State | read-only | Input / Number/Input Text/3 | fontSize | body.medium.font size |
| State | read-only | Input / Number/Input Text/3 | lineHeight | body.medium.line height |
| State | read-only | Input / Number/Input Text/3 | letterSpacing | body.medium.letter spacing |
| State | disabled | Input / Number | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Input / Number | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Input / Number/Input Text/0 | fill[0] | — |
| State | disabled | Input / Number/Input Text/0 | fontSize | — |
| State | disabled | Input / Number/Input Text/0 | lineHeight | — |
| State | disabled | Input / Number/Input Text/0 | letterSpacing | — |
| State | disabled | Input / Number/Input Text/3 | fill[0] | foreground.disabled |
| State | disabled | Input / Number/Input Text/3 | fontSize | body.medium.font size |
| State | disabled | Input / Number/Input Text/3 | lineHeight | body.medium.line height |
| State | disabled | Input / Number/Input Text/3 | letterSpacing | body.medium.letter spacing |
| Flavour | gradient | Input / Number | stroke[0] | linear-gradient(90deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | ghost | Input / Number | fill[0] | — |
| Flavour | ghost | Input / Number | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Input / Number | strokeWeight | stroke.base |

## Input / Password

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6307-22538&m=dev

### Layer structure

- Input / Password (COMPONENT)
  - Input / Password/Leading-Icon (INSTANCE, icon: email)
  - Input / Password/Input Text (FRAME)
    - Input / Password/Input Text/Password (TEXT)
    - Input / Password/Input Text/Cursor (TEXT)
    - Input / Password/Input Text/•••••••• (TEXT)
  - Input / Password/Reveal (INSTANCE, icon: visibility)
  - Input / Password/Trailing (FRAME)
    - Input / Password/Trailing/Clear (INSTANCE, icon: cancel)
    - Input / Password/Trailing/Divider (INSTANCE)
    - Input / Password/Trailing/Reveal (INSTANCE, icon: visibility)

### Resolved tokens (default variant: Size=medium, Shape=rounded, State=enabled, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input / Password | height | 40 | control.md |
| Input / Password | fill[0] | #ffffff | interactive.neutral.background.default |
| Input / Password | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input / Password | cornerRadius | 4 | radius.sm |
| Input / Password | strokeWeight | 1 | stroke.thin |
| Input / Password | itemSpacing | 4 | space.xxs |
| Input / Password | padding.left | 12 | space.md |
| Input / Password | padding.right | 12 | space.md |
| Input / Password | padding.top | 8 | space.sm |
| Input / Password | padding.bottom | 8 | space.sm |
| Input / Password/Input Text | padding.left | 4 | space.xxs |
| Input / Password/Input Text | padding.right | 4 | space.xxs |
| Input / Password/Input Text/Password | fill[0] | #8d95a3 | foreground.disabled |
| Input / Password/Input Text/Password | fontSize | 16 | body.medium.font size |
| Input / Password/Input Text/Password | lineHeight | 24 | body.medium.line height |
| Input / Password/Input Text/Password | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Input / Password | height | control.lg |
| Size | small | Input / Password | height | control.sm |
| Size | small | Input / Password/Input Text/Password | fontSize | body.small.font size |
| Size | small | Input / Password/Input Text/Password | lineHeight | body.small.line height |
| Size | small | Input / Password/Input Text/Password | letterSpacing | body.small.letter spacing |
| Shape | sharp | Input / Password | cornerRadius | radius.none |
| Shape | full | Input / Password | cornerRadius | radius.pill |
| State | hover | Input / Password | stroke[0] | interactive.neutral.border.hover |
| State | focus | Input / Password | stroke[0] | border.focus |
| State | focus | Input / Password | strokeWeight | stroke.thick |
| State | focus | Input / Password/Input Text/Cursor | fill[0] | foreground.cursor |
| State | focus | Input / Password/Input Text/Cursor | fontSize | body.medium.font size |
| State | focus | Input / Password/Input Text/Cursor | lineHeight | body.medium.line height |
| State | focus | Input / Password/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | selected | Input / Password | stroke[0] | border.focus |
| State | selected | Input / Password/Input Text/Cursor | fill[0] | foreground.cursor |
| State | selected | Input / Password/Input Text/Cursor | fontSize | body.medium.font size |
| State | selected | Input / Password/Input Text/Cursor | lineHeight | body.medium.line height |
| State | selected | Input / Password/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Password | stroke[0] | border.focus |
| State | typing | Input / Password/Input Text/Password | fill[0] | — |
| State | typing | Input / Password/Input Text/Password | fontSize | — |
| State | typing | Input / Password/Input Text/Password | lineHeight | — |
| State | typing | Input / Password/Input Text/Password | letterSpacing | — |
| State | typing | Input / Password/Input Text/•••••••• | fill[0] | foreground.primary |
| State | typing | Input / Password/Input Text/•••••••• | fontSize | body.medium.font size |
| State | typing | Input / Password/Input Text/•••••••• | lineHeight | body.medium.line height |
| State | typing | Input / Password/Input Text/•••••••• | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Password/Input Text/Cursor | fill[0] | foreground.cursor |
| State | typing | Input / Password/Input Text/Cursor | fontSize | body.medium.font size |
| State | typing | Input / Password/Input Text/Cursor | lineHeight | body.medium.line height |
| State | typing | Input / Password/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Password/Trailing | itemSpacing | space.sm |
| State | typing | Input / Password/Trailing/Divider | width | stroke.thin |
| State | typing | Input / Password/Trailing/Divider | height | control.icon-md |
| State | typing | Input / Password/Trailing/Divider | cornerRadius | radius.none |
| State | filled | Input / Password/Input Text/Password | fill[0] | — |
| State | filled | Input / Password/Input Text/Password | fontSize | — |
| State | filled | Input / Password/Input Text/Password | lineHeight | — |
| State | filled | Input / Password/Input Text/Password | letterSpacing | — |
| State | filled | Input / Password/Input Text/•••••••• | fill[0] | foreground.primary |
| State | filled | Input / Password/Input Text/•••••••• | fontSize | body.medium.font size |
| State | filled | Input / Password/Input Text/•••••••• | lineHeight | body.medium.line height |
| State | filled | Input / Password/Input Text/•••••••• | letterSpacing | body.medium.letter spacing |
| State | invalid | Input / Password | stroke[0] | border.error |
| State | invalid | Input / Password/Input Text/Password | fill[0] | — |
| State | invalid | Input / Password/Input Text/Password | fontSize | — |
| State | invalid | Input / Password/Input Text/Password | lineHeight | — |
| State | invalid | Input / Password/Input Text/Password | letterSpacing | — |
| State | invalid | Input / Password/Input Text/•••••••• | fill[0] | foreground.primary |
| State | invalid | Input / Password/Input Text/•••••••• | fontSize | body.medium.font size |
| State | invalid | Input / Password/Input Text/•••••••• | lineHeight | body.medium.line height |
| State | invalid | Input / Password/Input Text/•••••••• | letterSpacing | body.medium.letter spacing |
| State | read-only | Input / Password | stroke[0] | border.subtle |
| State | read-only | Input / Password/Input Text/Password | fill[0] | — |
| State | read-only | Input / Password/Input Text/Password | fontSize | — |
| State | read-only | Input / Password/Input Text/Password | lineHeight | — |
| State | read-only | Input / Password/Input Text/Password | letterSpacing | — |
| State | read-only | Input / Password/Input Text/•••••••• | fill[0] | foreground.primary |
| State | read-only | Input / Password/Input Text/•••••••• | fontSize | body.medium.font size |
| State | read-only | Input / Password/Input Text/•••••••• | lineHeight | body.medium.line height |
| State | read-only | Input / Password/Input Text/•••••••• | letterSpacing | body.medium.letter spacing |
| State | disabled | Input / Password | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Input / Password | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Input / Password/Input Text/Password | fill[0] | — |
| State | disabled | Input / Password/Input Text/Password | fontSize | — |
| State | disabled | Input / Password/Input Text/Password | lineHeight | — |
| State | disabled | Input / Password/Input Text/Password | letterSpacing | — |
| State | disabled | Input / Password/Input Text/•••••••• | fill[0] | foreground.disabled |
| State | disabled | Input / Password/Input Text/•••••••• | fontSize | body.medium.font size |
| State | disabled | Input / Password/Input Text/•••••••• | lineHeight | body.medium.line height |
| State | disabled | Input / Password/Input Text/•••••••• | letterSpacing | body.medium.letter spacing |
| Flavour | gradient | Input / Password | stroke[0] | linear-gradient(90deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | ghost | Input / Password | fill[0] | — |
| Flavour | ghost | Input / Password | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Input / Password | strokeWeight | stroke.base |

## Input / Date

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6294-1996&m=dev

### Layer structure

- Input / Date (COMPONENT)
  - Input / Date/Input Text (FRAME)
    - Input / Date/Input Text/mm/dd/yyyy (TEXT)
    - Input / Date/Input Text/Cursor (TEXT)
    - Input / Date/Input Text/10/14/2026 (TEXT)
  - Input / Date/Picker (INSTANCE, icon: calendar_3_day)
  - Input / Date/Trailing (FRAME)
    - Input / Date/Trailing/Clear (INSTANCE, icon: cancel)
    - Input / Date/Trailing/Divider (INSTANCE)
    - Input / Date/Trailing/Picker (INSTANCE, icon: calendar_3_day)

### Resolved tokens (default variant: Size=medium, Shape=rounded, State=enabled, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input / Date | height | 40 | control.md |
| Input / Date | fill[0] | #ffffff | interactive.neutral.background.default |
| Input / Date | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input / Date | cornerRadius | 4 | radius.sm |
| Input / Date | strokeWeight | 1 | stroke.thin |
| Input / Date | itemSpacing | 4 | space.xxs |
| Input / Date | padding.left | 12 | space.md |
| Input / Date | padding.right | 12 | space.md |
| Input / Date | padding.top | 8 | space.sm |
| Input / Date | padding.bottom | 8 | space.sm |
| Input / Date/Input Text | padding.left | 4 | space.xxs |
| Input / Date/Input Text | padding.right | 4 | space.xxs |
| Input / Date/Input Text/mm/dd/yyyy | fill[0] | #8d95a3 | foreground.disabled |
| Input / Date/Input Text/mm/dd/yyyy | fontSize | 16 | body.medium.font size |
| Input / Date/Input Text/mm/dd/yyyy | lineHeight | 24 | body.medium.line height |
| Input / Date/Input Text/mm/dd/yyyy | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Input / Date | height | control.lg |
| Size | small | Input / Date | height | control.sm |
| Size | small | Input / Date/Input Text/mm/dd/yyyy | fontSize | body.small.font size |
| Size | small | Input / Date/Input Text/mm/dd/yyyy | lineHeight | body.small.line height |
| Size | small | Input / Date/Input Text/mm/dd/yyyy | letterSpacing | body.small.letter spacing |
| Shape | sharp | Input / Date | cornerRadius | radius.none |
| Shape | full | Input / Date | cornerRadius | radius.pill |
| State | hover | Input / Date | stroke[0] | interactive.neutral.border.hover |
| State | focus | Input / Date | stroke[0] | border.focus |
| State | focus | Input / Date | strokeWeight | stroke.thick |
| State | focus | Input / Date/Input Text/Cursor | fill[0] | foreground.cursor |
| State | focus | Input / Date/Input Text/Cursor | fontSize | body.medium.font size |
| State | focus | Input / Date/Input Text/Cursor | lineHeight | body.medium.line height |
| State | focus | Input / Date/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | selected | Input / Date | stroke[0] | border.focus |
| State | selected | Input / Date/Input Text/Cursor | fill[0] | foreground.cursor |
| State | selected | Input / Date/Input Text/Cursor | fontSize | body.medium.font size |
| State | selected | Input / Date/Input Text/Cursor | lineHeight | body.medium.line height |
| State | selected | Input / Date/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Date | stroke[0] | border.focus |
| State | typing | Input / Date/Input Text/mm/dd/yyyy | fill[0] | — |
| State | typing | Input / Date/Input Text/mm/dd/yyyy | fontSize | — |
| State | typing | Input / Date/Input Text/mm/dd/yyyy | lineHeight | — |
| State | typing | Input / Date/Input Text/mm/dd/yyyy | letterSpacing | — |
| State | typing | Input / Date/Input Text/10/14/2026 | fill[0] | foreground.primary |
| State | typing | Input / Date/Input Text/10/14/2026 | fontSize | body.medium.font size |
| State | typing | Input / Date/Input Text/10/14/2026 | lineHeight | body.medium.line height |
| State | typing | Input / Date/Input Text/10/14/2026 | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Date/Input Text/Cursor | fill[0] | foreground.cursor |
| State | typing | Input / Date/Input Text/Cursor | fontSize | body.medium.font size |
| State | typing | Input / Date/Input Text/Cursor | lineHeight | body.medium.line height |
| State | typing | Input / Date/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Date/Trailing | itemSpacing | space.sm |
| State | typing | Input / Date/Trailing/Divider | width | stroke.thin |
| State | typing | Input / Date/Trailing/Divider | height | control.icon-md |
| State | typing | Input / Date/Trailing/Divider | cornerRadius | radius.none |
| State | filled | Input / Date/Input Text/mm/dd/yyyy | fill[0] | — |
| State | filled | Input / Date/Input Text/mm/dd/yyyy | fontSize | — |
| State | filled | Input / Date/Input Text/mm/dd/yyyy | lineHeight | — |
| State | filled | Input / Date/Input Text/mm/dd/yyyy | letterSpacing | — |
| State | filled | Input / Date/Input Text/10/14/2026 | fill[0] | foreground.primary |
| State | filled | Input / Date/Input Text/10/14/2026 | fontSize | body.medium.font size |
| State | filled | Input / Date/Input Text/10/14/2026 | lineHeight | body.medium.line height |
| State | filled | Input / Date/Input Text/10/14/2026 | letterSpacing | body.medium.letter spacing |
| State | invalid | Input / Date | stroke[0] | border.error |
| State | invalid | Input / Date/Input Text/mm/dd/yyyy | fill[0] | — |
| State | invalid | Input / Date/Input Text/mm/dd/yyyy | fontSize | — |
| State | invalid | Input / Date/Input Text/mm/dd/yyyy | lineHeight | — |
| State | invalid | Input / Date/Input Text/mm/dd/yyyy | letterSpacing | — |
| State | invalid | Input / Date/Input Text/10/14/2026 | fill[0] | foreground.primary |
| State | invalid | Input / Date/Input Text/10/14/2026 | fontSize | body.medium.font size |
| State | invalid | Input / Date/Input Text/10/14/2026 | lineHeight | body.medium.line height |
| State | invalid | Input / Date/Input Text/10/14/2026 | letterSpacing | body.medium.letter spacing |
| State | read-only | Input / Date | stroke[0] | border.subtle |
| State | read-only | Input / Date/Input Text/mm/dd/yyyy | fill[0] | — |
| State | read-only | Input / Date/Input Text/mm/dd/yyyy | fontSize | — |
| State | read-only | Input / Date/Input Text/mm/dd/yyyy | lineHeight | — |
| State | read-only | Input / Date/Input Text/mm/dd/yyyy | letterSpacing | — |
| State | read-only | Input / Date/Input Text/10/14/2026 | fill[0] | foreground.primary |
| State | read-only | Input / Date/Input Text/10/14/2026 | fontSize | body.medium.font size |
| State | read-only | Input / Date/Input Text/10/14/2026 | lineHeight | body.medium.line height |
| State | read-only | Input / Date/Input Text/10/14/2026 | letterSpacing | body.medium.letter spacing |
| State | disabled | Input / Date | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Input / Date | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Input / Date/Input Text/mm/dd/yyyy | fill[0] | — |
| State | disabled | Input / Date/Input Text/mm/dd/yyyy | fontSize | — |
| State | disabled | Input / Date/Input Text/mm/dd/yyyy | lineHeight | — |
| State | disabled | Input / Date/Input Text/mm/dd/yyyy | letterSpacing | — |
| State | disabled | Input / Date/Input Text/10/14/2026 | fill[0] | foreground.disabled |
| State | disabled | Input / Date/Input Text/10/14/2026 | fontSize | body.medium.font size |
| State | disabled | Input / Date/Input Text/10/14/2026 | lineHeight | body.medium.line height |
| State | disabled | Input / Date/Input Text/10/14/2026 | letterSpacing | body.medium.letter spacing |
| Flavour | gradient | Input / Date | stroke[0] | linear-gradient(90deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | ghost | Input / Date | fill[0] | — |
| Flavour | ghost | Input / Date | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Input / Date | strokeWeight | stroke.base |

## Input / Time

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6295-2185&m=dev

### Layer structure

- Input / Time (COMPONENT)
  - Input / Time/Input Text (FRAME)
    - Input / Time/Input Text/--:-- -- (TEXT)
    - Input / Time/Input Text/Cursor (TEXT)
    - Input / Time/Input Text/09:30 AM (TEXT)
  - Input / Time/Picker (INSTANCE, icon: clock_outline)
  - Input / Time/Trailing (FRAME)
    - Input / Time/Trailing/Clear (INSTANCE, icon: cancel)
    - Input / Time/Trailing/Divider (INSTANCE)
    - Input / Time/Trailing/Picker (INSTANCE, icon: clock_outline)

### Resolved tokens (default variant: Size=medium, Shape=rounded, State=enabled, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input / Time | height | 40 | control.md |
| Input / Time | fill[0] | #ffffff | interactive.neutral.background.default |
| Input / Time | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input / Time | cornerRadius | 4 | radius.sm |
| Input / Time | strokeWeight | 1 | stroke.thin |
| Input / Time | itemSpacing | 4 | space.xxs |
| Input / Time | padding.left | 12 | space.md |
| Input / Time | padding.right | 12 | space.md |
| Input / Time | padding.top | 8 | space.sm |
| Input / Time | padding.bottom | 8 | space.sm |
| Input / Time/Input Text | padding.left | 4 | space.xxs |
| Input / Time/Input Text | padding.right | 4 | space.xxs |
| Input / Time/Input Text/--:-- -- | fill[0] | #8d95a3 | foreground.disabled |
| Input / Time/Input Text/--:-- -- | fontSize | 16 | body.medium.font size |
| Input / Time/Input Text/--:-- -- | lineHeight | 24 | body.medium.line height |
| Input / Time/Input Text/--:-- -- | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Input / Time | height | control.lg |
| Size | small | Input / Time | height | control.sm |
| Size | small | Input / Time/Input Text/--:-- -- | fontSize | body.small.font size |
| Size | small | Input / Time/Input Text/--:-- -- | lineHeight | body.small.line height |
| Size | small | Input / Time/Input Text/--:-- -- | letterSpacing | body.small.letter spacing |
| Shape | sharp | Input / Time | cornerRadius | radius.none |
| Shape | full | Input / Time | cornerRadius | radius.pill |
| State | hover | Input / Time | stroke[0] | interactive.neutral.border.hover |
| State | focus | Input / Time | stroke[0] | border.focus |
| State | focus | Input / Time | strokeWeight | stroke.thick |
| State | focus | Input / Time/Input Text/Cursor | fill[0] | foreground.cursor |
| State | focus | Input / Time/Input Text/Cursor | fontSize | body.medium.font size |
| State | focus | Input / Time/Input Text/Cursor | lineHeight | body.medium.line height |
| State | focus | Input / Time/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | selected | Input / Time | stroke[0] | border.focus |
| State | selected | Input / Time/Input Text/Cursor | fill[0] | foreground.cursor |
| State | selected | Input / Time/Input Text/Cursor | fontSize | body.medium.font size |
| State | selected | Input / Time/Input Text/Cursor | lineHeight | body.medium.line height |
| State | selected | Input / Time/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Time | stroke[0] | border.focus |
| State | typing | Input / Time/Input Text/--:-- -- | fill[0] | — |
| State | typing | Input / Time/Input Text/--:-- -- | fontSize | — |
| State | typing | Input / Time/Input Text/--:-- -- | lineHeight | — |
| State | typing | Input / Time/Input Text/--:-- -- | letterSpacing | — |
| State | typing | Input / Time/Input Text/09:30 AM | fill[0] | foreground.primary |
| State | typing | Input / Time/Input Text/09:30 AM | fontSize | body.medium.font size |
| State | typing | Input / Time/Input Text/09:30 AM | lineHeight | body.medium.line height |
| State | typing | Input / Time/Input Text/09:30 AM | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Time/Input Text/Cursor | fill[0] | foreground.cursor |
| State | typing | Input / Time/Input Text/Cursor | fontSize | body.medium.font size |
| State | typing | Input / Time/Input Text/Cursor | lineHeight | body.medium.line height |
| State | typing | Input / Time/Input Text/Cursor | letterSpacing | body.medium.letter spacing |
| State | typing | Input / Time/Trailing | itemSpacing | space.sm |
| State | typing | Input / Time/Trailing/Divider | width | stroke.thin |
| State | typing | Input / Time/Trailing/Divider | height | control.icon-md |
| State | typing | Input / Time/Trailing/Divider | cornerRadius | radius.none |
| State | filled | Input / Time/Input Text/--:-- -- | fill[0] | — |
| State | filled | Input / Time/Input Text/--:-- -- | fontSize | — |
| State | filled | Input / Time/Input Text/--:-- -- | lineHeight | — |
| State | filled | Input / Time/Input Text/--:-- -- | letterSpacing | — |
| State | filled | Input / Time/Input Text/09:30 AM | fill[0] | foreground.primary |
| State | filled | Input / Time/Input Text/09:30 AM | fontSize | body.medium.font size |
| State | filled | Input / Time/Input Text/09:30 AM | lineHeight | body.medium.line height |
| State | filled | Input / Time/Input Text/09:30 AM | letterSpacing | body.medium.letter spacing |
| State | invalid | Input / Time | stroke[0] | border.error |
| State | invalid | Input / Time/Input Text/--:-- -- | fill[0] | — |
| State | invalid | Input / Time/Input Text/--:-- -- | fontSize | — |
| State | invalid | Input / Time/Input Text/--:-- -- | lineHeight | — |
| State | invalid | Input / Time/Input Text/--:-- -- | letterSpacing | — |
| State | invalid | Input / Time/Input Text/09:30 AM | fill[0] | foreground.primary |
| State | invalid | Input / Time/Input Text/09:30 AM | fontSize | body.medium.font size |
| State | invalid | Input / Time/Input Text/09:30 AM | lineHeight | body.medium.line height |
| State | invalid | Input / Time/Input Text/09:30 AM | letterSpacing | body.medium.letter spacing |
| State | read-only | Input / Time | stroke[0] | border.subtle |
| State | read-only | Input / Time/Input Text/--:-- -- | fill[0] | — |
| State | read-only | Input / Time/Input Text/--:-- -- | fontSize | — |
| State | read-only | Input / Time/Input Text/--:-- -- | lineHeight | — |
| State | read-only | Input / Time/Input Text/--:-- -- | letterSpacing | — |
| State | read-only | Input / Time/Input Text/09:30 AM | fill[0] | foreground.primary |
| State | read-only | Input / Time/Input Text/09:30 AM | fontSize | body.medium.font size |
| State | read-only | Input / Time/Input Text/09:30 AM | lineHeight | body.medium.line height |
| State | read-only | Input / Time/Input Text/09:30 AM | letterSpacing | body.medium.letter spacing |
| State | disabled | Input / Time | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Input / Time | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Input / Time/Input Text/--:-- -- | fill[0] | — |
| State | disabled | Input / Time/Input Text/--:-- -- | fontSize | — |
| State | disabled | Input / Time/Input Text/--:-- -- | lineHeight | — |
| State | disabled | Input / Time/Input Text/--:-- -- | letterSpacing | — |
| State | disabled | Input / Time/Input Text/09:30 AM | fill[0] | foreground.disabled |
| State | disabled | Input / Time/Input Text/09:30 AM | fontSize | body.medium.font size |
| State | disabled | Input / Time/Input Text/09:30 AM | lineHeight | body.medium.line height |
| State | disabled | Input / Time/Input Text/09:30 AM | letterSpacing | body.medium.letter spacing |
| Flavour | gradient | Input / Time | stroke[0] | linear-gradient(90deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | ghost | Input / Time | fill[0] | — |
| Flavour | ghost | Input / Time | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Input / Time | strokeWeight | stroke.base |

## Input

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6331-31902&m=dev

### Overview

The full field assembly, a label above, the field itself and a hint below, stacked and spaced as one unit. Type chooses which of the five field types sits in the middle, and the label and the hint can each be turned off. Reach for it wherever a field needs a name or supporting text, and reach for Input Field on its own where it needs neither.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Type | Input / Text | true | Chooses which field fills the middle of the stack, from text, number, password, date and time. The choice brings its own placeholder and its own trailing control, so picking the type is most of the work of configuring the field. Input Field Metadata covers what each one carries. |
| Show Label | true | true | The label sits above the field and names it. Keep it on, because the field carries no name of its own and the placeholder is gone as soon as someone types. |
| Show Label | false | - | Drops the label from the stack. Only safe where something else nearby already names the field, and the name still has to reach assistive technology some other way. |
| Show Hint | true | true | Keeps the supporting line below the field. This is where a validation message lands, so leaving it on reserves the space before it is needed. |
| Show Hint | false | - | Drops the line and shortens the stack. A field that can fail validation then has nowhere to put the reason, and turning the line back on later moves everything below it. |
| Label / Type | default | true | The plain name with nothing after it. |
| Label / Type | optional | - | Reach for it where most of the form is required, so the exception is the thing being marked. |
| Label / Type | required | - | Adds an asterisk after the name. Reach for it only where submission genuinely fails without a value. |
| Label / Disabled | false | true | The name at full strength. |
| Label / Disabled | true | - | Dims the name to sit with a disabled field. It does not disable anything, so it has to be set alongside the field's own State rather than instead of it. |
| Label / Show Information | false | true | No information icon, which is what an Input arrives with. |
| Label / Show Information | true | - | Adds an information icon after the name, for an explanation the label itself has no room for. |
| Hint / Type | default | true | The resting supporting line, for guidance about what to enter. |
| Hint / Type | error | - | The validation message that says what went wrong. The field's border carries the signal and this carries the reason, so neither works alone. |
| Hint / Type | disabled | - | Dims the line to sit with a disabled field. |
| Hint / Show Icon | true | true | Keeps an icon ahead of the message, which is what makes an error read as an error before the words are read. |
| Hint / Show Icon | false | - | Message only. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| disabled | Set on the assembly | — | The assembly, should handle the disabled state across the components. |
| invalid | Set on the assembly | — | The same split. The field's State goes to invalid and the hint's Type goes to error. One supplies the signal and the other the message, and neither implies the other. |
| read-only | Set on the field | — | Only the field carries this. The label stays at full strength, which is right, because the name of a value worth reading is still worth reading. |
| hover, focus, typing | Set on the field | — | The field runs these on its own and nothing above or below it changes. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined on the assembly. Each part swaps its own tokens. |
| Composition | Three parts stacked vertically, with the height hugging them. Turning off the label or the hint removes its height rather than leaving a gap, so the stack shortens and whatever sits below it moves up. |
| State coordination | The assembly own general states which it’s children inherits (Invalid, disabled). Anything that reads as one state across the label, the field and the hint is three independent settings held in agreement by the assembly. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Label | Input Label, toggled by Show Label | The field's name, with an optional required or optional marker and an information icon. The assembly exposes only whether it shows, so the marker, the dimming and the icon are all set on the label. |
| Field | Input Field, chosen by Type | The control itself. An Input arrives with it at Size=medium and Shape=rounded, and everything it offers, Size, Shape, State and Flavour, is set on the field rather than surfaced by the assembly. A column of these does not share one size unless every field is set to match. |
| Hint | Input Hint, toggled by Show Hint | The supporting line under the field, carrying guidance at rest and the validation message when its Type is error. Its icon is a separate toggle on the hint. |
| Text content | not parameterised | The name, the hint and the message are not exposed as inputs on the assembly, so all three come from the implementation. |

### Anatomy

1. **Label** — The field's name, turned on by Show Label. It carries the required or optional marker and the information icon.
2. **Field** — The control, chosen by Type. Its own Size, Shape, State and Flavour are set here rather than on the assembly.
3. **Hint** — The supporting line, turned on by Show Hint. Guidance at rest, and the validation message when its Type is error.

### How to use

**Do:**
- Keep Show Label on. The field has no name of its own, and the placeholder that might stand in for one disappears the moment someone starts typing.
- Move the field to invalid and the hint to error together. One carries the signal and the other carries the reason, and either on its own is half a message.

**Don't:**
- Don't turn Show Hint off on a field that can fail validation. The message has nowhere to land, and adding the line later pushes everything below it down.
- Don't leave the parts on different states. A full strength label over a disabled field reads as a mistake rather than a style, and nothing in the assembly prevents it.

### Accessibility & Content Guidelines

- The label is the field's name. Show Label controls only whether it is visible, so a field without a visible label still needs its name to reach assistive technology.
- The required marker is an asterisk and a colour, and neither is readable on its own. The requirement has to be carried in the field's semantics as well as shown.
- (optional) is a word rather than a symbol, so it reads where the asterisk does not. Mark whichever of required or optional is the exception in the form, not both.
- A validation message in the hint has to be associated with the field, or it is announced as loose text with nothing tying it to what failed.
- The information icon on the label has no text. Where it opens an explanation it is a control, so it needs a name and a target of its own.
- The three parts dim independently. Check the whole stack at one state, because a disabled field under a full strength label is a contrast mismatch that neither part shows on its own.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 280 wide, with the height hugging whatever is turned on. At the default that is a 20 label, a 40 field and a 16 hint, coming to 84. |
| Gap | Fixed | space/xs between all three parts. That is the same 4 the field uses internally between its icons and its text, so the stack and its contents share one rhythm. |
| Label | Hug | 20 tall and hugging its text, with a space/xs gap between the name, any marker and the information icon. |
| Hint | Hug | 16 tall, body/xsmall at 12px, with a space/xs gap after a 16 square icon. Smaller than the field's own text, which keeps the value the loudest thing in the stack. |
| Field | Fill | The field fills the width of the stack while the label and the hint hug their own content, so only the field tracks the container. |
| Colour | Theming | Each part draws its own tokens. The label runs foreground/primary and drops to foreground/disabled, the required marker holds foreground/error either way, and the hint text moves between foreground/secondary, foreground/error and foreground/disabled. |

### Layer structure

- Input (COMPONENT)
  - Input/Label (INSTANCE)
  - Input/Input / Text (INSTANCE)
  - Input/Hint (INSTANCE)

### Resolved tokens (default variant: Input)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input | itemSpacing | 4 | space.xxs |
| Input/Label | itemSpacing | 4 | space.xxs |
| Input/Input / Text | height | 40 | control.md |
| Input/Input / Text | fill[0] | #ffffff | interactive.neutral.background.default |
| Input/Input / Text | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input/Input / Text | cornerRadius | 4 | radius.sm |
| Input/Input / Text | strokeWeight | 1 | stroke.thin |
| Input/Input / Text | itemSpacing | 4 | space.xxs |
| Input/Input / Text | padding.left | 12 | space.md |
| Input/Input / Text | padding.right | 12 | space.md |
| Input/Input / Text | padding.top | 8 | space.sm |
| Input/Input / Text | padding.bottom | 8 | space.sm |
| Input/Hint | itemSpacing | 4 | space.xxs |

## Input Label

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6329-31743&m=dev

### Layer structure

- Input Label (COMPONENT)
  - Input Label/Field name (TEXT)
  - Input Label/Icon (INSTANCE, icon: info)
  - Input Label/* (TEXT)
  - Input Label/(optional) (TEXT)

### Resolved tokens (default variant: Type=default, Disabled=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input Label | itemSpacing | 4 | space.xxs |
| Input Label/Field name | fill[0] | #0c0d0e | foreground.primary |
| Input Label/Field name | fontSize | 14 | label.medium.font size |
| Input Label/Field name | lineHeight | 20 | label.medium.line height |
| Input Label/Field name | letterSpacing | 0 | label.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | required | Input Label/* | fill[0] | foreground.error |
| Type | required | Input Label/* | fontSize | label.medium.font size |
| Type | required | Input Label/* | lineHeight | label.medium.line height |
| Type | required | Input Label/* | letterSpacing | label.medium.letter spacing |
| Type | optional | Input Label/(optional) | fill[0] | foreground.secondary |
| Type | optional | Input Label/(optional) | fontSize | body.small.font size |
| Type | optional | Input Label/(optional) | lineHeight | body.small.line height |
| Type | optional | Input Label/(optional) | letterSpacing | body.small.letter spacing |
| Disabled | true | Input Label/Field name | fill[0] | foreground.disabled |

## Input Hint

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6329-31836&m=dev

### Layer structure

- Input Hint (COMPONENT)
  - Input Hint/Icon (INSTANCE, icon: info)
  - Input Hint/Default hint message (TEXT)

### Resolved tokens (default variant: Type=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input Hint | itemSpacing | 4 | space.xxs |
| Input Hint/Default hint message | fill[0] | #545963 | foreground.secondary |
| Input Hint/Default hint message | fontSize | 12 | body.xsmall.font size |
| Input Hint/Default hint message | lineHeight | 16 | body.xsmall.line height |
| Input Hint/Default hint message | letterSpacing | 0 | body.xsmall.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | error | Input Hint/Default hint message | fill[0] | foreground.error |
| Type | disabled | Input Hint/Default hint message | fill[0] | foreground.disabled |

## Input Field (documentation only)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6288-997&m=dev

### Overview

The text entry control on its own, without a label or hint around it. One model covers five input types, Text, Number, Password, Date and Time, which share the same Size, Shape, State and Flavour and differ only in their placeholder and in the control sitting at the trailing edge. Reach for it directly when a field needs no label or supporting text, and reach for Input when it does.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Type | text | true | The general case, a free text value with nothing in the trailing position until one is asked for. |
| Type | number | - | A numeric value only input. |
| Type | password | - | A concealed value with a reveal control that cannot be turned off. |
| Type | date | - | A date, with a calendar control and the expected format in the placeholder. |
| Type | time | - | A time, with a clock control. Same reasoning as date, the placeholder carries the shape of the value. |
| Shape | rounded | true | The default softened corners, matching surrounding rounded controls. |
| Shape | sharp | - | Square corners, for surfaces built from sharp-edged controls. |
| Shape | full | - | A pill, for a field that reads as its own object on a surface rather than one row of a form. |
| State | enabled | true | The resting empty field, showing its placeholder and waiting. |
| State | hover | - | Pointer over the field. The border is the only thing that answers. |
| State | focus | - | The field has keyboard focus and is ready for input. It carries the heaviest border in the set, so it stays findable where several fields sit together. |
| State | selected | - | Focus has settled and the cursor is placed. Lighter than focus, for a field already being worked in. |
| State | typing | - | A value is being entered. This is the only state that offers a way to clear the field, so it is not interchangeable with filled. |
| State | filled | - | A committed value. The field is at rest again but the text stays at full strength, which is what separates it from enabled. |
| State | invalid | - | The value failed validation. The border carries the signal and nothing else does, so pairing it with a Hint set to error is what makes the problem readable. |
| State | read-only | - | The value is shown but cannot be changed. Reach for it where a person still needs to read or copy the value, and reach for disabled where they do not. |
| State | disabled | - | The field cannot be used and is out of the tab order. Both the surface and the border drop away, so it reads as out of play rather than merely empty. |
| Size | medium | true | The default, for surfaces and toolbars where the field sits alongside other controls. |
| Size | large | - | For a field that is the main thing on its surface. |
| Size | small | - | The tightest, and the only size that also reduces the text. |
| Flavour | default | true | A bordered field on a neutral surface, and the right choice inside a form. |
| Flavour | gradient | - | For a unique interaction highlight, such as an AI companion field. It marks the field as special, so using it on an ordinary field spends that signal for nothing. |
| Flavour | ghost | - | No visible border at rest, for a field sitting on a surface that already bounds it. On an unbounded surface it stops reading as a field at all. |
| hasLeading | false | true | No leading icon, which is where the field starts. The text begins at the padding edge and takes the full width. |
| hasLeading | true | - | Adds an icon ahead of the text. Reach for it where the icon says something the placeholder cannot, and leave it off where it would only repeat the label above. |
| hasTrailing | false | true | No optional trailing control. The types that define themselves by a control, password, date and time, carry it intrinsically and expose no toggle at all. |
| hasTrailing | true | - | Adds a trailing control to text or number, the two types that leave the position open. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| enabled | — | — | The resting empty field. interactive/neutral/border/default at 1px on an interactive/neutral/background/default surface, with the placeholder at foreground/disabled. |
| hover | Pointer over the field | — | The border moves to interactive/neutral/border/hover. Surface and text hold. |
| focus | Keyboard focus | — | The border becomes border/focus at 2px, double its resting weight. The field is ready for input but the placeholder still reads as a placeholder. |
| selected | Focus settled, cursor placed | — | The border stays border/focus and returns to 1px. Lighter than focus, for a field already being worked in. |
| typing | Text being entered | — | The text becomes a real value at foreground/primary and a clear control appears at the trailing edge. The border holds border/focus. |
| filled | A committed value | — | The border returns to interactive/neutral/border/default while the text stays at foreground/primary. The clear control goes. |
| invalid | Validation failed | — | The border moves to border/error. The text stays at foreground/primary, so the border carries the whole signal and the Hint beneath it carries the reason. |
| read-only | Presented but not editable | — | The border drops to border/subtle and the value stays at foreground/primary. Still legible and still selectable, which is what separates it from disabled. |
| disabled | — | — | Surface and border move to interactive/neutral/background/disabled and interactive/neutral/border/disabled, and the text and every icon drop to foreground/disabled. The whole control recedes. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Each state is a swap of border colour, border weight, text colour and, at typing, the presence of the clear control. |
| Typing lifecycle | The run is enabled, focus, selected, typing, filled. Only typing carries the clear control, so emptying the field from inside it is available while a value is being entered and not after it is committed. |
| Validation and lock | invalid and read-only sit outside that run. The surrounding form sets them rather than the field reaching them by interaction, and invalid pairs with the Hint set to error, which carries the reason. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Input text | not parameterised | The value and the placeholder. Neither is exposed as an input on the field, so both come from the implementation. The placeholder is what distinguishes the types, Placeholder for text, 0 for number, Password, mm/dd/yyyy and --:-- --. |
| Leading icon | nested Icon, toggled by hasLeading | Off by default. When on it takes an Icon at Size=medium, 20 square, and the glyph is swappable through the Icon's own Name property. |
| Trailing control | per type | Text leaves the trailing position empty and exposes hasTrailing to fill it. Number exposes the same toggle but arrives with a stepper already in place. Password, Date and Time carry a control that defines the type, a reveal, a calendar and a clock, so none of them expose a toggle for it. |
| Clear control | typing only | Appears at the trailing position while typing and is the only way to empty the field from within it. Where the type already carries its own control the two sit together in a 57 wide group rather than one replacing the other. |

### Anatomy

1. **Leading icon** — Off by default, and an Icon at 20 square when hasLeading turns it on.
2. **Input** — The placeholder, and then the value once one is entered. It fills whatever width the icons leave.
3. **Trailing position** — Empty on text until hasTrailing fills it, and occupied from the start on number, password, date and time by the control that defines the type. While typing a clear control joins whatever is already there.

### How to use

**Do:**
- Pick the type that matches the value. The placeholder and the trailing control arrive with it, and together they tell a person what is expected before they type anything.
- Pair invalid with a Hint set to error. The border colour is the only thing invalid changes, so on its own it says something is wrong without saying what.

**Don't:**
- Don't reach for disabled where a person still needs to read the value. read-only keeps it legible and selectable, disabled puts it out of reach and out of the tab order.
- Don't lean on the placeholder as the label. It clears the moment typing starts, so whatever it was carrying disappears exactly when it is needed.

### Accessibility & Content Guidelines

- The field carries no label of its own. Input pairs it with Input Label, and a field used on its own still needs a name from the implementation.
- A placeholder is not a label. It clears the moment a value is entered, so anything a reader has to keep is not safe there.
- invalid changes the border colour and nothing else. The reason belongs in the Hint set to error, and the field has to be associated with it for the message to be announced.
- read-only and disabled look alike and behave differently. read-only keeps the value reachable and selectable, disabled takes the control out of the tab order.
- The leading icon, the clear control and any type control are glyphs with no text. Each needs a name, and the clear control needs one that says what it clears.
- At small the text drops to 14px and the control to 36 tall. Check the trailing control still offers a large enough target at that height.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed | 280 wide and fixed, so the container sets the width rather than the content. Height is bound per size, control/lg at large for 48, control/md at medium for 40 and control/sm at small for 36. |
| Padding and gap | Fixed | space/sm top and bottom, space/md left and right, with a space/xs gap between the leading icon, the text and the trailing control. Padding holds across all three sizes, so height alone carries the density. |
| Radius | Per Shape | radius/none when sharp, radius/sm when rounded and radius/pill when full. The four corners are bound individually rather than as a single value. |
| Surface | Per Flavour | interactive/neutral/background/default on default and gradient, moving to interactive/neutral/background/disabled when disabled. Ghost carries no surface of its own, so whatever sits behind it shows through. |
| Border | Per Flavour | Default draws at 1px and rises to 2px on focus. Gradient keeps those weights and draws its border from the gradient tokens: a foreground/gradient/start to foreground/gradient/end gradient at rest and when filled, border/gradient/end on hover and border/gradient/start when selected or typing. Focus, invalid, read-only and disabled use the same tokens as default. Ghost holds a bound border at zero weight, which is a theming hook rather than an absent border, so a high contrast variable set can give it a hard outline. |
| Text | Theming | body/medium at 16px for large and medium, body/small at 14px for small. The colour changes with state, which States and Triggers sets out. |
| Icons and controls | Fixed | Every icon is Size=medium at 20 square at large and medium, and Size=small at 16 square at small, and the inner text frame fills whatever width they leave. At large one icon costs 24 including its gap, taking the text from 254 to 230, and two take it to 206. Every icon and control, leading, trailing, the type control and clear, draws foreground/primary like the value, and foreground/disabled when the field is disabled. |
