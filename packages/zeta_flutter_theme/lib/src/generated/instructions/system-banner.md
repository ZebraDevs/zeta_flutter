# System Banner

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5255-2146&m=dev

## System Banner (Mobile)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5350-6261&m=dev

### Layer structure

- System Banner (Mobile) (COMPONENT)
  - System Banner (Mobile)/Status Bar (INSTANCE)
  - System Banner (Mobile)/Container (FRAME)
    - System Banner (Mobile)/Container/Status Icon (INSTANCE, icon: verified)
    - System Banner (Mobile)/Container/Content (FRAME)
      - System Banner (Mobile)/Container/Content/Text (FRAME)
        - System Banner (Mobile)/Container/Content/Text/Title (TEXT)
        - System Banner (Mobile)/Container/Content/Text/Description Container (FRAME)
          - System Banner (Mobile)/Container/Content/Text/Description Container/Description (TEXT)
      - System Banner (Mobile)/Container/Content/Action Slot (SLOT)
    - System Banner (Mobile)/Container/Dismiss (INSTANCE, icon: close)

### Resolved tokens (default variant: Status=Default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| System Banner (Mobile) | fill[0] | #00864f | feedback.success.background.strong |
| System Banner (Mobile)/Status Bar | itemSpacing | 67 | — |
| System Banner (Mobile)/Status Bar | padding.left | 16 | space.lg |
| System Banner (Mobile)/Status Bar | padding.right | 16 | space.lg |
| System Banner (Mobile)/Status Bar | padding.top | 16 | space.gutter |
| System Banner (Mobile)/Status Bar | padding.bottom | 16 | space.gutter |
| System Banner (Mobile)/Container | itemSpacing | 4 | space.xxs |
| System Banner (Mobile)/Container | padding.left | 8 | space.sm |
| System Banner (Mobile)/Container | padding.right | 8 | space.sm |
| System Banner (Mobile)/Container | padding.top | 8 | space.sm |
| System Banner (Mobile)/Container | padding.bottom | 8 | space.sm |
| System Banner (Mobile)/Container/Status Icon | height | 40 | control.target-min |
| System Banner (Mobile)/Container/Content | itemSpacing | 8 | space.sm |
| System Banner (Mobile)/Container/Content | padding.top | 8 | space.sm |
| System Banner (Mobile)/Container/Content | padding.bottom | 8 | space.sm |
| System Banner (Mobile)/Container/Content/Text/Title | fill[0] | #ffffff | foreground.primary |
| System Banner (Mobile)/Container/Content/Text/Title | fontSize | 16 | label.large.font size |
| System Banner (Mobile)/Container/Content/Text/Title | lineHeight | 24 | label.large.line height |
| System Banner (Mobile)/Container/Content/Text/Title | letterSpacing | 0 | label.large.letter spacing |
| System Banner (Mobile)/Container/Content/Text/Description Container | itemSpacing | 10 | — |
| System Banner (Mobile)/Container/Content/Text/Description Container | padding.top | 8 | space.sm |
| System Banner (Mobile)/Container/Content/Text/Description Container | padding.bottom | 8 | space.sm |
| System Banner (Mobile)/Container/Content/Text/Description Container/Description | fill[0] | #ffffff | foreground.primary |
| System Banner (Mobile)/Container/Content/Text/Description Container/Description | fontSize | 14 | body.small.font size |
| System Banner (Mobile)/Container/Content/Text/Description Container/Description | lineHeight | 18 | body.small.line height |
| System Banner (Mobile)/Container/Content/Text/Description Container/Description | letterSpacing | 0 | body.small.letter spacing |
| System Banner (Mobile)/Container/Content/Action Slot | itemSpacing | 8 | space.sm |
| System Banner (Mobile)/Container/Content/Action Slot | padding.top | 4 | space.xxs |
| System Banner (Mobile)/Container/Content/Action Slot | padding.bottom | 4 | space.xxs |
| System Banner (Mobile)/Container/Dismiss | height | 40 | control.target-min |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | negative | System Banner (Mobile) | fill[0] | feedback.error.background.strong |
| Status | negative | System Banner (Mobile)/Container/Dismiss | height | — |
| Status | warning | System Banner (Mobile) | fill[0] | feedback.warning.background.strong |
| Status | Info | System Banner (Mobile) | fill[0] | feedback.info.background.strong |

## System Banner (Desktop)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5406-9998&m=dev

### Layer structure

- System Banner (Desktop) (COMPONENT)
  - System Banner (Desktop)/Container (FRAME)
    - System Banner (Desktop)/Container/Icon Container (FRAME)
      - System Banner (Desktop)/Container/Icon Container/Status Icon (INSTANCE, icon: check_circle)
    - System Banner (Desktop)/Container/Content (FRAME)
      - System Banner (Desktop)/Container/Content/Text (FRAME)
        - System Banner (Desktop)/Container/Content/Text/Title (TEXT)
        - System Banner (Desktop)/Container/Content/Text/Description (TEXT)
      - System Banner (Desktop)/Container/Content/Action Slot (SLOT)
    - System Banner (Desktop)/Container/Dismiss (INSTANCE)

### Resolved tokens (default variant: Status=Default, Content Type=single line)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| System Banner (Desktop) | fill[0] | #00864f | feedback.success.background.strong |
| System Banner (Desktop) | itemSpacing | 8 | — |
| System Banner (Desktop)/Container | itemSpacing | 8 | — |
| System Banner (Desktop)/Container | padding.left | 16 | — |
| System Banner (Desktop)/Container | padding.right | 16 | — |
| System Banner (Desktop)/Container | padding.top | 16 | — |
| System Banner (Desktop)/Container | padding.bottom | 16 | — |
| System Banner (Desktop)/Container/Icon Container | width | 36 | control.sm |
| System Banner (Desktop)/Container/Icon Container | height | 36 | control.sm |
| System Banner (Desktop)/Container/Icon Container | itemSpacing | 10 | — |
| System Banner (Desktop)/Container/Content | itemSpacing | 16 | space.lg |
| System Banner (Desktop)/Container/Content/Text | itemSpacing | 12 | space.card |
| System Banner (Desktop)/Container/Content/Text | padding.top | 8 | space.sm |
| System Banner (Desktop)/Container/Content/Text | padding.bottom | 8 | space.sm |
| System Banner (Desktop)/Container/Content/Text/Title | fill[0] | #ffffff | foreground.primary |
| System Banner (Desktop)/Container/Content/Text/Title | fontSize | 14 | label.medium.font size |
| System Banner (Desktop)/Container/Content/Text/Title | lineHeight | 20 | label.medium.line height |
| System Banner (Desktop)/Container/Content/Text/Title | letterSpacing | 0 | label.medium.letter spacing |
| System Banner (Desktop)/Container/Content/Action Slot | itemSpacing | 8 | space.sm |
| System Banner (Desktop)/Container/Dismiss | width | 36 | control.sm |
| System Banner (Desktop)/Container/Dismiss | height | 36 | control.sm |
| System Banner (Desktop)/Container/Dismiss | fill[0] | #d6dce200 | interactive.ghost.background.default |
| System Banner (Desktop)/Container/Dismiss | stroke[0] | #545963 | interactive.neutral.border.default |
| System Banner (Desktop)/Container/Dismiss | cornerRadius | 0 | radius.none |
| System Banner (Desktop)/Container/Dismiss | strokeWeight | 0 | stroke.base |
| System Banner (Desktop)/Container/Dismiss | padding.left | 4 | space.xxs |
| System Banner (Desktop)/Container/Dismiss | padding.right | 4 | space.xxs |
| System Banner (Desktop)/Container/Dismiss | padding.top | 4 | space.xxs |
| System Banner (Desktop)/Container/Dismiss | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | negative | System Banner (Desktop) | fill[0] | feedback.error.background.strong |
| Status | negative | System Banner (Desktop)/Container/Dismiss | width | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | height | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | fill[0] | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | stroke[0] | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | cornerRadius | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | strokeWeight | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | padding.left | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | padding.right | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | padding.top | — |
| Status | negative | System Banner (Desktop)/Container/Dismiss | padding.bottom | — |
| Status | warning | System Banner (Desktop) | fill[0] | feedback.warning.background.strong |
| Status | warning | System Banner (Desktop) | itemSpacing | space.sm |
| Status | warning | System Banner (Desktop)/Container | itemSpacing | space.sm |
| Status | warning | System Banner (Desktop)/Container | padding.left | space.lg |
| Status | warning | System Banner (Desktop)/Container | padding.right | space.lg |
| Status | warning | System Banner (Desktop)/Container | padding.top | space.lg |
| Status | warning | System Banner (Desktop)/Container | padding.bottom | space.lg |
| Status | Info | System Banner (Desktop) | fill[0] | feedback.info.background.strong |
| Content Type | multiline | System Banner (Desktop)/Container/Content | padding.top | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content | padding.bottom | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text | itemSpacing | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text | padding.top | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text | padding.bottom | space.xxs |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text/Description | fill[0] | foreground.primary |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text/Description | fontSize | body.small.font size |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text/Description | lineHeight | body.small.line height |
| Content Type | multiline | System Banner (Desktop)/Container/Content/Text/Description | letterSpacing | body.small.letter spacing |

## Status Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5255-2738&m=dev

### Layer structure

- Status Bar (COMPONENT)
  - Status Bar/Android/Time (FRAME)
    - Status Bar/Android/Time/clock (FRAME)
      - Status Bar/Android/Time/clock/Hours (TEXT)
      - Status Bar/Android/Time/clock/:[1] (TEXT)
      - Status Bar/Android/Time/clock/Minutes (TEXT)
      - Status Bar/Android/Time/clock/:[2] (TEXT)
      - Status Bar/Android/Time/clock/Seconds (TEXT)
    - Status Bar/Android/Time/PM (TEXT)
  - Status Bar/Icons (FRAME)
    - Status Bar/Icons/Android/Bluetooth (FRAME)
      - Status Bar/Icons/Android/Bluetooth/bluetooth (VECTOR)
    - Status Bar/Icons/Android/WiFi (FRAME)
      - Status Bar/Icons/Android/WiFi/Bar 1 (VECTOR)
      - Status Bar/Icons/Android/WiFi/Bar 2 (VECTOR)
      - Status Bar/Icons/Android/WiFi/Bar 3 (VECTOR)
      - Status Bar/Icons/Android/WiFi/Bar 4 (VECTOR)
    - Status Bar/Icons/Android/Cellular Signal (FRAME)
      - Status Bar/Icons/Android/Cellular Signal/5G (TEXT)
      - Status Bar/Icons/Android/Cellular Signal/bars (GROUP)
        - Status Bar/Icons/Android/Cellular Signal/bars/Bar 1 (VECTOR)
        - Status Bar/Icons/Android/Cellular Signal/bars/Bar 2 (VECTOR)
        - Status Bar/Icons/Android/Cellular Signal/bars/Bar 3 (VECTOR)
        - Status Bar/Icons/Android/Cellular Signal/bars/Bar 4 (VECTOR)
    - Status Bar/Icons/Android/Battery (FRAME)
      - Status Bar/Icons/Android/Battery/outline (VECTOR)
      - Status Bar/Icons/Android/Battery/indicator (RECTANGLE)
    - Status Bar/Icons/Cellular Signal (FRAME)
      - Status Bar/Icons/Cellular Signal/Bar 1 (VECTOR)
      - Status Bar/Icons/Cellular Signal/Bar 2 (VECTOR)
      - Status Bar/Icons/Cellular Signal/Bar 3 (VECTOR)
      - Status Bar/Icons/Cellular Signal/Bar 4 (VECTOR)
    - Status Bar/Icons/Wifi (FRAME)
      - Status Bar/Icons/Wifi/Bar 1 (VECTOR)
      - Status Bar/Icons/Wifi/Bar 2 (VECTOR)
      - Status Bar/Icons/Wifi/Bar 3 (VECTOR)
    - Status Bar/Icons/Battery (FRAME)
      - Status Bar/Icons/Battery/border (VECTOR)
      - Status Bar/Icons/Battery/indicator (RECTANGLE)
      - Status Bar/Icons/Battery/cap (VECTOR)
  - Status Bar/Time (FRAME)
    - Status Bar/Time/clock (FRAME)
      - Status Bar/Time/clock/Hours (TEXT)
      - Status Bar/Time/clock/: (TEXT)
      - Status Bar/Time/clock/Minutes (TEXT)
    - Status Bar/Time/location arrow (VECTOR)

### Resolved tokens (default variant: Platform=ios)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Status Bar | itemSpacing | 67 | — |
| Status Bar | padding.left | 16 | space.lg |
| Status Bar | padding.right | 16 | space.lg |
| Status Bar | padding.top | 16 | space.gutter |
| Status Bar | padding.bottom | 16 | space.gutter |
| Status Bar/Time | itemSpacing | 4 | — |
| Status Bar/Time/clock | fill[0] | #ffffff | — |
| Status Bar/Time/clock/Hours | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Time/clock/Hours | fontSize | 14 | — |
| Status Bar/Time/clock/Hours | lineHeight | 16.70703125 | — |
| Status Bar/Time/clock/Hours | letterSpacing | 0 | — |
| Status Bar/Time/clock/: | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Time/clock/: | fontSize | 14 | — |
| Status Bar/Time/clock/: | lineHeight | 16.70703125 | — |
| Status Bar/Time/clock/: | letterSpacing | 0 | — |
| Status Bar/Time/clock/Minutes | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Time/clock/Minutes | fontSize | 14 | — |
| Status Bar/Time/clock/Minutes | lineHeight | 16.70703125 | — |
| Status Bar/Time/clock/Minutes | letterSpacing | 0 | — |
| Status Bar/Time/location arrow | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons | itemSpacing | 8.5 | — |
| Status Bar/Icons/Cellular Signal/Bar 1 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Cellular Signal/Bar 2 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Cellular Signal/Bar 3 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Cellular Signal/Bar 4 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Wifi | fill[0] | #ffffff | — |
| Status Bar/Icons/Wifi/Bar 1 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Wifi/Bar 2 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Wifi/Bar 3 | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Battery | fill[0] | #ffffff | — |
| Status Bar/Icons/Battery/border | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Battery/indicator | fill[0] | #0c0d0e | foreground.primary |
| Status Bar/Icons/Battery/indicator | cornerRadius | 1 | — |
| Status Bar/Icons/Battery/cap | fill[0] | #0c0d0e | foreground.primary |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Platform | android | Status Bar | padding.left | space.page |
| Platform | android | Status Bar | padding.right | space.page |
| Platform | android | Status Bar | padding.top | space.sm |
| Platform | android | Status Bar | padding.bottom | space.sm |
| Platform | android | Status Bar/Time/clock/Hours | fill[0] | — |
| Platform | android | Status Bar/Time/clock/: | fill[0] | — |
| Platform | android | Status Bar/Time/clock/Minutes | fill[0] | — |
| Platform | android | Status Bar/Time/location arrow | fill[0] | — |
| Platform | android | Status Bar/Icons/Cellular Signal/Bar 1 | fill[0] | — |
| Platform | android | Status Bar/Icons/Cellular Signal/Bar 2 | fill[0] | — |
| Platform | android | Status Bar/Icons/Cellular Signal/Bar 3 | fill[0] | — |
| Platform | android | Status Bar/Icons/Cellular Signal/Bar 4 | fill[0] | — |
| Platform | android | Status Bar/Icons/Wifi/Bar 1 | fill[0] | — |
| Platform | android | Status Bar/Icons/Wifi/Bar 2 | fill[0] | — |
| Platform | android | Status Bar/Icons/Wifi/Bar 3 | fill[0] | — |
| Platform | android | Status Bar/Icons/Battery/border | fill[0] | — |
| Platform | android | Status Bar/Icons/Battery/indicator | fill[0] | — |
| Platform | android | Status Bar/Icons/Battery/cap | fill[0] | — |
| Platform | android | Status Bar/Android/Time/clock/Hours | fill[0] | foreground.primary |
| Platform | android | Status Bar/Android/Time/clock/:[1] | fill[0] | foreground.primary |
| Platform | android | Status Bar/Android/Time/clock/Minutes | fill[0] | foreground.primary |
| Platform | android | Status Bar/Android/Time/PM | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Bluetooth/bluetooth | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/WiFi/Bar 1 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/WiFi/Bar 2 | stroke[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/WiFi/Bar 3 | stroke[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/WiFi/Bar 4 | stroke[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/5G | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/bars/Bar 1 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/bars/Bar 2 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/bars/Bar 3 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Cellular Signal/bars/Bar 4 | fill[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Battery/outline | stroke[0] | foreground.primary |
| Platform | android | Status Bar/Icons/Android/Battery/indicator | fill[0] | foreground.primary |
