# Status Label

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5203-4059&m=dev

## Status Label

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5225-2556&m=dev

### Layer structure

- Status Label (COMPONENT)
  - Status Label/Leading icon (FRAME, icon: star)
    - Status Label/Leading icon/Status indicator (ELLIPSE)
  - Status Label/Label container (FRAME)
    - Status Label/Label container/Label (TEXT)

### Resolved tokens (default variant: Status=neutral, Leading=indicator, Rounded=false, hasIcon=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Status Label | fill[0] | #ffffff | interactive.neutral.background.default |
| Status Label | stroke[0] | #ced2db | border.default |
| Status Label | cornerRadius | 0 | radius.none |
| Status Label | strokeWeight | 1 | stroke.thin |
| Status Label | padding.left | 4 | space.xxs |
| Status Label | padding.right | 4 | space.xxs |
| Status Label | padding.top | 4 | space.xxs |
| Status Label | padding.bottom | 4 | space.xxs |
| Status Label/Leading icon | width | 16 | control.icon-sm |
| Status Label/Leading icon | height | 16 | control.icon-sm |
| Status Label/Leading icon | padding.left | 4 | space.xxs |
| Status Label/Leading icon | padding.right | 4 | space.xxs |
| Status Label/Leading icon | padding.top | 4 | space.xxs |
| Status Label/Leading icon | padding.bottom | 4 | space.xxs |
| Status Label/Leading icon/Status indicator | height | 8 | control.icon-xxs |
| Status Label/Leading icon/Status indicator | fill[0] | #0c0d0e | foreground.primary |
| Status Label/Label container | padding.left | 4 | space.xxs |
| Status Label/Label container | padding.right | 4 | space.xxs |
| Status Label/Label container/Label | fill[0] | #0c0d0e | foreground.primary |
| Status Label/Label container/Label | fontSize | 14 | body.small.font size |
| Status Label/Label container/Label | lineHeight | 18 | body.small.line height |
| Status Label/Label container/Label | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | success | Status Label | fill[0] | feedback.success.background.subtle |
| Status | success | Status Label | stroke[0] | border.success |
| Status | success | Status Label/Leading icon/Status indicator | fill[0] | foreground.success |
| Status | warning | Status Label | fill[0] | feedback.warning.background.subtle |
| Status | warning | Status Label | stroke[0] | border.warning |
| Status | warning | Status Label/Leading icon/Status indicator | fill[0] | foreground.warning |
| Status | error | Status Label | fill[0] | feedback.error.background.subtle |
| Status | error | Status Label | stroke[0] | border.error |
| Status | error | Status Label/Leading icon/Status indicator | fill[0] | foreground.error |
| Status | info | Status Label | fill[0] | feedback.info.background.subtle |
| Status | info | Status Label | stroke[0] | border.info |
| Status | info | Status Label/Leading icon/Status indicator | fill[0] | foreground.info |
| Leading | icon | Status Label/Leading icon | width | — |
| Leading | icon | Status Label/Leading icon | height | — |
| Leading | icon | Status Label/Leading icon | padding.left | — |
| Leading | icon | Status Label/Leading icon | padding.right | — |
| Leading | icon | Status Label/Leading icon | padding.top | — |
| Leading | icon | Status Label/Leading icon | padding.bottom | — |
| Leading | icon | Status Label/Leading icon/Status indicator | height | — |
| Leading | icon | Status Label/Leading icon/Status indicator | fill[0] | — |
| Rounded | true | Status Label | cornerRadius | radius.pill |
