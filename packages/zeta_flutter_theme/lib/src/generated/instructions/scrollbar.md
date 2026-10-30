# Scrollbar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6057-11947&m=dev

## Scrollbar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6068-12030&m=dev

### Layer structure

- Scrollbar (COMPONENT)
  - Scrollbar/Handle (RECTANGLE)
  - Scrollbar/Track (RECTANGLE)

### Resolved tokens (default variant: Orientation=vertical, State=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Scrollbar | padding.left | 4 | space.xxs |
| Scrollbar | padding.right | 4 | space.xxs |
| Scrollbar | padding.top | 4 | space.xxs |
| Scrollbar | padding.bottom | 4 | space.xxs |
| Scrollbar/Handle | fill[0] | #8d95a3 | foreground.disabled |
| Scrollbar/Handle | cornerRadius | 9999 | radius.pill |
| Scrollbar/Track | fill[0] | #0c0d0e00 | interactive.ghost.background.default |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Scrollbar/Handle | fill[0] | foreground.secondary |
| State | hover | Scrollbar/Track | fill[0] | interactive.ghost.background.hover |
