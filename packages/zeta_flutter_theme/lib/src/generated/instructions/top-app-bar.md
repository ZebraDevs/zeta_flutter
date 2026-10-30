# Top App Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3108-191&m=dev

## Top App Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3116-1217&m=dev

### Layer structure

- Top App Bar (COMPONENT)
  - Top App Bar/Main (FRAME)
    - Top App Bar/Main/Frame 2 (FRAME)
      - Top App Bar/Main/Frame 2/Icon Button (INSTANCE)
      - Top App Bar/Main/Frame 2/Page Header (FRAME)
        - Top App Bar/Main/Frame 2/Page Header/Avatar (INSTANCE)
        - Top App Bar/Main/Frame 2/Page Header/Page Title (FRAME)
          - Top App Bar/Main/Frame 2/Page Header/Page Title/Title (TEXT)
    - Top App Bar/Main/Trailing Slot (SLOT)
    - Top App Bar/Main/Trailing (FRAME)
      - Top App Bar/Main/Trailing/Icon Button (INSTANCE)
    - Top App Bar/Main/Frame 3 (FRAME)
      - Top App Bar/Main/Frame 3/Icon Button (INSTANCE)
      - Top App Bar/Main/Frame 3/Contextual Details (FRAME)
        - Top App Bar/Main/Frame 3/Contextual Details/Count (FRAME)
          - Top App Bar/Main/Frame 3/Contextual Details/Count/2 Items (TEXT)
      - Top App Bar/Main/Frame 3/Button (INSTANCE)
    - Top App Bar/Main/Contextual Control Slot (SLOT)
    - Top App Bar/Main/Icon Button (INSTANCE)
    - Top App Bar/Main/Search (INSTANCE)
  - Top App Bar/Page Title (FRAME)
    - Top App Bar/Page Title/Title (TEXT)

### Resolved tokens (default variant: Type=default, Shape=sharp)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Top App Bar | fill[0] | #ffffff | surface.section |
| Top App Bar | itemSpacing | 8 | space.sm |
| Top App Bar | padding.left | 8 | space.sm |
| Top App Bar | padding.right | 8 | space.sm |
| Top App Bar | padding.top | 12 | space.md |
| Top App Bar | padding.bottom | 12 | space.md |
| Top App Bar/Main/Frame 2 | itemSpacing | 12 | space.md |
| Top App Bar/Main/Frame 2/Icon Button | width | 36 | control.sm |
| Top App Bar/Main/Frame 2/Icon Button | height | 36 | control.sm |
| Top App Bar/Main/Frame 2/Icon Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Top App Bar/Main/Frame 2/Icon Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| Top App Bar/Main/Frame 2/Icon Button | cornerRadius | 4 | radius.element-sm |
| Top App Bar/Main/Frame 2/Icon Button | strokeWeight | 0 | stroke.base |
| Top App Bar/Main/Frame 2/Icon Button | padding.left | 4 | space.xxs |
| Top App Bar/Main/Frame 2/Icon Button | padding.right | 4 | space.xxs |
| Top App Bar/Main/Frame 2/Icon Button | padding.top | 4 | space.xxs |
| Top App Bar/Main/Frame 2/Icon Button | padding.bottom | 4 | space.xxs |
| Top App Bar/Main/Frame 2/Page Header | itemSpacing | 8 | space.sm |
| Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | 8 | space.sm |
| Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fill[0] | #000000 | — |
| Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | 16 | label.large.font size |
| Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | 24 | label.large.line height |
| Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | 0 | label.large.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | centered | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | label.medium.font size |
| Type | centered | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | label.medium.line height |
| Type | centered | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | label.medium.letter spacing |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | width | control.sm |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | height | control.sm |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | fill[0] | interactive.ghost.background.default |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | stroke[0] | interactive.neutral.border.default |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | cornerRadius | radius.element-sm |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | strokeWeight | stroke.base |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | padding.left | space.xxs |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | padding.right | space.xxs |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | padding.top | space.xxs |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | padding.bottom | space.xxs |
| Type | contextual | Top App Bar/Main/Frame 2 | itemSpacing | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | width | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | height | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | fill[0] | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | stroke[0] | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | cornerRadius | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | strokeWeight | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | padding.left | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | padding.right | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | padding.top | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | padding.bottom | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header | itemSpacing | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | — |
| Type | contextual | Top App Bar/Main/Frame 3 | itemSpacing | space.md |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | width | control.sm |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | height | control.sm |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | fill[0] | interactive.ghost.background.default |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | stroke[0] | interactive.neutral.border.default |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | cornerRadius | radius.element-sm |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | strokeWeight | stroke.base |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | padding.left | space.xxs |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | padding.right | space.xxs |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | padding.top | space.xxs |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | padding.bottom | space.xxs |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details | itemSpacing | space.sm |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details/Count | itemSpacing | space.sm |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details/Count/2 Items | fontSize | label.medium.font size |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details/Count/2 Items | lineHeight | label.medium.line height |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details/Count/2 Items | letterSpacing | label.medium.letter spacing |
| Type | contextual alt | Top App Bar/Main/Frame 2 | itemSpacing | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | width | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | height | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | fill[0] | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | stroke[0] | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | cornerRadius | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | strokeWeight | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | padding.left | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | padding.right | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | padding.top | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | padding.bottom | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header | itemSpacing | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | — |
| Type | contextual alt | Top App Bar/Main/Frame 3 | itemSpacing | space.md |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | height | control.sm |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | fill[0] | interactive.ghost.background.default |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | stroke[0] | interactive.neutral.border.default |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | cornerRadius | radius.element-sm |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | strokeWeight | stroke.base |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | padding.left | space.md |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | padding.right | space.md |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | padding.top | space.xxs |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | padding.bottom | space.xxs |
| Type | search | Top App Bar/Main | itemSpacing | space.md |
| Type | search | Top App Bar/Main/Frame 2 | itemSpacing | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | width | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | height | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | fill[0] | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | stroke[0] | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | cornerRadius | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | strokeWeight | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | padding.left | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | padding.right | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | padding.top | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | padding.bottom | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header | itemSpacing | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | — |
| Type | search | Top App Bar/Main/Icon Button | width | control.sm |
| Type | search | Top App Bar/Main/Icon Button | height | control.sm |
| Type | search | Top App Bar/Main/Icon Button | fill[0] | interactive.ghost.background.default |
| Type | search | Top App Bar/Main/Icon Button | stroke[0] | interactive.neutral.border.default |
| Type | search | Top App Bar/Main/Icon Button | cornerRadius | radius.element-sm |
| Type | search | Top App Bar/Main/Icon Button | strokeWeight | stroke.base |
| Type | search | Top App Bar/Main/Icon Button | padding.left | space.xxs |
| Type | search | Top App Bar/Main/Icon Button | padding.right | space.xxs |
| Type | search | Top App Bar/Main/Icon Button | padding.top | space.xxs |
| Type | search | Top App Bar/Main/Icon Button | padding.bottom | space.xxs |
| Type | search | Top App Bar/Main/Search | height | control.sm |
| Type | search | Top App Bar/Main/Search | fill[0] | interactive.ghost.background.default |
| Type | search | Top App Bar/Main/Search | stroke[0] | border.focus |
| Type | search | Top App Bar/Main/Search | cornerRadius | radius.element-sm |
| Type | search | Top App Bar/Main/Search | strokeWeight | stroke.base |
| Type | search | Top App Bar/Main/Search | itemSpacing | space.xxs |
| Type | search | Top App Bar/Main/Search | padding.left | space.md |
| Type | search | Top App Bar/Main/Search | padding.right | space.md |
| Type | search | Top App Bar/Main/Search | padding.top | space.sm |
| Type | search | Top App Bar/Main/Search | padding.bottom | space.sm |
| Type | extended | Top App Bar | itemSpacing | space.lg |
| Type | extended | Top App Bar/Main/Frame 2/Page Header | itemSpacing | — |
| Type | extended | Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | — |
| Type | extended | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | — |
| Type | extended | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | — |
| Type | extended | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | — |
| Type | extended | Top App Bar/Page Title | itemSpacing | space.sm |
| Type | extended | Top App Bar/Page Title | padding.left | space.sm |
| Type | extended | Top App Bar/Page Title | padding.right | space.sm |
| Type | extended | Top App Bar/Page Title/Title | fontSize | label.large.font size |
| Type | extended | Top App Bar/Page Title/Title | lineHeight | label.large.line height |
| Type | extended | Top App Bar/Page Title/Title | letterSpacing | label.large.letter spacing |
| Shape | rounded | Top App Bar | cornerRadius | radius.element-sm |
