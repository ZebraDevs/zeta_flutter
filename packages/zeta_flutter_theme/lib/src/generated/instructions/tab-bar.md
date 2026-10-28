# Tab Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3607-237&m=dev

## Navigation Rail Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3635-1151&m=dev

### Layer structure

- Navigation Rail Item (COMPONENT)
  - Navigation Rail Item/Icon (INSTANCE, icon: star)
  - Navigation Rail Item/Tab Item (TEXT)
  - Navigation Rail Item/Notification Indicator (INSTANCE)

### Resolved tokens (default variant: State=default, Disabled=false, Selected=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Navigation Rail Item | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Navigation Rail Item | stroke[0] | #0c0d0e00 | border.transparent |
| Navigation Rail Item | cornerRadius | 0 | radius.none |
| Navigation Rail Item | strokeWeight | 1 | — |
| Navigation Rail Item | itemSpacing | 8 | space.sm |
| Navigation Rail Item | padding.left | 16 | space.gutter |
| Navigation Rail Item | padding.right | 16 | space.gutter |
| Navigation Rail Item | padding.top | 12 | space.md |
| Navigation Rail Item | padding.bottom | 12 | space.md |
| Navigation Rail Item/Tab Item | fill[0] | #545963 | foreground.secondary |
| Navigation Rail Item/Tab Item | fontSize | 14 | — |
| Navigation Rail Item/Tab Item | lineHeight | 20 | — |
| Navigation Rail Item/Tab Item | letterSpacing | 0 | — |
| Navigation Rail Item/Notification Indicator | fill[0] | #d70015 | interactive.destructive.background.default |
| Navigation Rail Item/Notification Indicator | stroke[0] | #ffffff | border.inverse |
| Navigation Rail Item/Notification Indicator | cornerRadius | 9999 | radius.pill |
| Navigation Rail Item/Notification Indicator | strokeWeight | 0 | stroke.base |
| Navigation Rail Item/Notification Indicator | padding.left | 4 | space.xxs |
| Navigation Rail Item/Notification Indicator | padding.right | 4 | space.xxs |
| Navigation Rail Item/Notification Indicator | padding.top | 3 | — |
| Navigation Rail Item/Notification Indicator | padding.bottom | 3 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | Navigation Rail Item | fill[0] | interactive.ghost.background.hover |
| State | hover | Navigation Rail Item/Tab Item | fontSize | label.medium.font size |
| State | hover | Navigation Rail Item/Tab Item | lineHeight | label.medium.line height |
| State | hover | Navigation Rail Item/Tab Item | letterSpacing | label.medium.letter spacing |

## Tab Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3640-2127&m=dev

### Layer structure

- Tab Bar (COMPONENT)
  - Tab Bar/ Tab Slot (SLOT)

### Resolved tokens (default variant: Flavour=full width)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Tab Bar | fill[0] | #ffffff | surface.section |
